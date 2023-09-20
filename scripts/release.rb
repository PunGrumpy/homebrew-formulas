require 'json'
require 'digest'
require 'net/http'

def prompt_usage
  puts 'Usage: ruby scripts/release.rb <version> <name>'
  exit(1)
end

version, name = ARGV[0], ARGV[1]
prompt_usage if version.nil? || name.nil?

version = version.gsub(/[^0-9.]/, '')
name = name.gsub(/[^a-z-]/i, '')

puts "🏷️ Releasing #{name} on Homebrew version #{version}"

url = "https://api.github.com/repos/PunGrumpy/#{name}/releases/tags/#{version}"
response = Net::HTTP.get_response(URI(url))

unless response.is_a?(Net::HTTPSuccess)
  puts "❌ Didn't find release #{version} for #{name} 🌐 status code: #{response.code}"
  exit(1)
end

release = JSON.parse(response.body)
puts "📦 Found release #{release['name']} for #{name}"

assets = {}

for asset in release['assets']
  filename = asset['name']

  if !filename.end_with?('.zip') || filename.include?('-profile')
    puts "📦 Skipping asset #{filename}"
    next
  end

  url = asset['browser_download_url']

  begin
    response = Net::HTTP.get_response(URI(url))
    url = response['location']
  end while response.is_a?(Net::HTTPRedirection)

  unless response.is_a?(Net::HTTPSuccess)
    puts "❌ Didn't find asset #{filename} for #{name} 🌐 status code: #{response.code}"
    exit(1)
  end

  sha256 = Digest::SHA256.hexdigest(response.body)
  puts "📦 Found asset #{filename} with SHA256 #{sha256}"

  assets[filename] = sha256
end

formula = File.read("Formula/#{name}.rb")

formula = formula.gsub(/version\s+".*"/, "version \"#{version}\"")

assets.each do |filename, sha256|
    formula = formula.gsub(/sha256\s+"[A-Fa-f0-9]*"\s+#\s+#{Regexp.quote(filename)}/, "sha256 \"#{sha256}\" # #{filename}")
    puts "📦 Updated asset #{filename} with SHA256 #{sha256}"
end

File.write("Formula/#{name}.rb", formula)
puts "📦 Updated formula #{name} to version #{version}"

puts '🍭 Done!'
