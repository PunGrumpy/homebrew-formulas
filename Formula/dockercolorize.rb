class Dockercolorize < Formula
  desc "Enhancing Docker output with vibrant colors"
  homepage "https://github.com/PunGrumpy/dockercolorize"
  version "2.6.2"

  depends_on "docker"

  if OS.mac?
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-darwin-amd64"
    sha256 "ebf2265f6ca2f25f97239a442e4918c2781b30f3366e272d17589557f41c06f3" # dockercolorize-darwin-amd64
  else
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-linux-amd64"
    sha256 "781a1699138e8cfa1d9ff78c6ef2756d3258f9ff2cbc02f5079f2fca3bc84e49" # dockercolorize-linux-amd64
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
