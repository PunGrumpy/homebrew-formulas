class Dockercolorize < Formula
  desc "Enhancing Docker output with vibrant colors"
  homepage "https://github.com/PunGrumpy/dockercolorize"
  version "2.7.1"

  depends_on "docker"

  if OS.mac?
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-darwin-amd64"
    sha256 "9312aab132986414b51f475b131ba86f3a8553e794761c47b0037a68567ee969" # dockercolorize-darwin-amd64
  else
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-linux-amd64"
    sha256 "5ffa11049758ef08a593dbb1719bd4caf0452697c5c7779561d6ac777c8a66b4" # dockercolorize-linux-amd64
  end

  def install
    if OS.mac?
      bin.install "dockercolorize-darwin-amd64" => "dockercolorize"
    else
      bin.install "dockercolorize-linux-amd64" => "dockercolorize"
    end
  end

  def caveats
    <<~EOS
      🐳🌈 To use dockercolorize, please add the following line to your bash, zsh or fish config:
              #{shell_format("bash/zsh:", :bold)}
                #{shell_format("alias dps=\"docker ps | dockercolorize\"", :green)}
                #{shell_format("alias dcps=\"docker compose ps | dockercolorize\"", :green)}
                #{shell_format("alias di=\"docker images | dockercolorize\"", :green)}
                #{shell_format("alias dstats=\"docker stats --no-stream | dockercolorize\"", :green)}
              #{shell_format("fish:", :bold)}
                #{shell_format("alias dps \"docker ps | dockercolorize\"", :green)}
                #{shell_format("alias dcps \"docker compose ps | dockercolorize\"", :green)}
                #{shell_format("alias di \"docker images | dockercolorize\"", :green)}
                #{shell_format("alias dstats \"docker stats --no-stream | dockercolorize\"", :green)}
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/dockercolorize --help")
  end

  private

  def shell_format(text, *effects)
    effects.each do |effect|
      case effect
      when :bold
        text = "\e[1m#{text}\e[0m"
      when :green
        text = "\e[32m#{text}\e[0m"
      end
    end
    text
  end
end
