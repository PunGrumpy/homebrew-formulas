class Dockercolorize < Formula
  desc "Enhancing Docker output with vibrant colors"
  homepage "https://github.com/PunGrumpy/dockercolorize"
  version "2.6.0"

  depends_on "docker"

  if OS.mac?
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-darwin-amd64"
    sha256 "5087dd1ae398ff659ab4671d47024a192834d5fa6c51aefcb7fa1490a6f744d5"
  else
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-linux-amd64"
    sha256 "9858767c9e558a88dff1cb9fc15b4cb5d7ee6ec487ba4e3e407acc9ecaccc7bd"
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
