class Dockercolorize < Formula
  desc "Enhancing Docker output with vibrant colors"
  homepage "https://github.com/PunGrumpy/dockercolorize"
  version "2.6.0"

  depends_on "docker"

  if OS.mac?
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-darwin-amd64"
    sha256 "d6402f0f6568a13e17504515fb420371b35293c5048337fa205e5a642d9af299"
  else
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-linux-amd64"
    sha256 "42f995c9ae0fd0ac39a3f03978a82c8372ea47a7bab4305cb52635f529c61afd"
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
