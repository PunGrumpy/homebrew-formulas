class Dockercolorize < Formula
  desc "Enhancing Docker output with vibrant colors"
  homepage "https://github.com/PunGrumpy/dockercolorize"
  version "2.4.7"

  if OS.mac?
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-darwin-amd64"
    sha256 "5da62d574a70072f4bc12e8f993cb95a09efc6aaa06568a98153a0eb6f81b5e1"
  else
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-linux-amd64"
    sha256 "d5a69fb99fc577a914c2897605a3b0cc563934ec6359ae268e40bc2d64acb72c"
  end

  def install
    if OS.mac?
      bin.install "dockercolorize-darwin-amd64" => "dockercolorize"
    else
      bin.install "dockercolorize-linux-amd64" => "dockercolorize"
    end
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/dockercolorize --help")
  end
end
