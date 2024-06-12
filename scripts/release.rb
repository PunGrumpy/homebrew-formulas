require 'json'
require 'digest'
require 'net/http'

def prompt_usage
  puts 'Usage: ruby scripts/release.rb <version> <name>'
  exit(1)
end

def sanitize_input(version, name)
  sanitized_version = version.gsub(/[^0-9.]/, '')
  sanitized_name = name.gsub(/[^a-z-]/i, '')
  [sanitized_version, sanitized_name]
end

def fetch_release_data(version, name)
  url = "https://api.github.com/repos/PunGrumpy/#{name}/releases/tags/#{version}"
  response = Net::HTTP.get_response(URI(url))
  unless response.is_a?(Net::HTTPSuccess)
    puts "❌ Didn't find release #{version} for #{name} 🌐 status code: #{response.code}"
    exit(1)
  end
  JSON.parse(response.body)
end

def fetch_asset_data(url)
  uri = URI(url)
  response = Net::HTTP.get_response(uri)
  while response.is_a?(Net::HTTPRedirection)
    uri = URI(response['location'])
    response = Net::HTTP.get_response(uri)
  end
  unless response.is_a?(Net::HTTPSuccess)
    puts "❌ Failed to download asset 🌐 status code: #{response.code}"
    exit(1)
  end
  response.body
end

def update_formula(version, assets, name)
  formula_path = "Formula/#{name}.rb"
  formula = File.read(formula_path)

  formula.gsub!(/version\s+".*"/, "version \"#{version}\"")
  assets.each do |filename, sha256|
    formula.gsub!(/sha256\s+"[A-Fa-f0-9]*"\s+#\s+#{Regexp.quote(filename)}/, "sha256 \"#{sha256}\" # #{filename}")
  end

  File.write(formula_path, formula)
end

# Main script execution starts here
version, name = ARGV[0], ARGV[1]
prompt_usage if version.nil? || name.nil?

version, name = sanitize_input(version, name)

puts "🏷️ Releasing #{name} on Homebrew version #{version}"

release = fetch_release_data(version, name)
puts "📦 Found release #{release['name']} for #{name}"

assets = {}

release['assets'].each do |asset|
  filename = asset['name']

  next if !filename.end_with?('.zip') || filename.include?('-profile')

  puts "📦 Processing asset #{filename}"

  asset_data = fetch_asset_data(asset['browser_download_url'])
  sha256 = Digest::SHA256.hexdigest(asset_data)
  puts "📦 Found asset #{filename} with SHA256 #{sha256}"

  assets[filename] = sha256
end

update_formula(version, assets, name)
puts "📦 Updated formula #{name} to version #{version}"

puts '🍭 Done!'

