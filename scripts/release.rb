require "json"
require "digest"
require "net/http"

version = ARGV[0]
name = ARGV[1]
if version.nil? || name.nil?
    abort "Usage: ruby scripts/release.rb <version> <name>"
else
    version = version.gsub(/[a-z-]*/i, "")
    name = name.gsub(/[^a-z-]/i, "")
end

puts "🏷️ Releasing #{name} on Homebrew version #{version}"

url = "https://api.github.com/repos/PunGrumpy/#{name}/releases/#{version}"
response = Net::HTTP.get_response(URI(url))
unless response.is_a?(Net::HTTPSuccess)
    abort "❌ Didn't find release #{version} for #{name} 🌐 status code: #{response.code}"
end

release = JSON.parse(response.body)
puts "📦 Found release #{release["name"]} for #{name}"

assets = {}
for asset in release["assets"]
    filename = asset["name"]
    if !filename.end_with?(".zip") || filename.include?("-profile")
        puts "📦 Skipping asset #{filename}"
        next
    end

    url = asset["browser_download_url"]
    begin
        response = Net::HTTP.get_response(URI(url))
        url = response["location"]
    end while response.is_a?(Net::HTTPRedirection)

    unless response.is_a?(Net::HTTPSuccess)
        abort "❌ Didn't find asset #{filename} for #{name} 🌐 status code: #{response.code}"
    end

    sha256 = Digest::SHA256.hexdigest(response.body)
    puts "📦 Found asset #{filename} with SHA256 #{sha256}"

    assets[filename] = sha256
end

formula = ""
File.open("Formula/#{name}.rb", "r") do |file|
    file.each_line do |line|
        query = line.strip

        new_line = if query.start_with?("version")
            line.gsub(/"[0-9\.]{1,}"/, "\"#{version}\"")
        elsif query.start_with?("sha256")
            asset = query[(query.index("#") + 2)..-1].strip
            sha256 = assets[asset]
            if sha256.nil?
                abort "❌ Didn't find asset #{asset} for #{name}"
            end
            line.gsub(/"[A-Fa-f0-9]{1,}"/, "\"#{sha256}\"")
        else
            line
        end

        formula += new_line
    end
end

versioned_class = "class #{name.capitalize} < Formula"
versioned_formula = formula.gsub(/class [A-Za-z]{1,} < Formula/, versioned_class)
File.write("Formula/#{name}.rb", versioned_formula)
puts "📦 Updated formula #{name} to version #{version}"

puts "🍭 Done!"