class Dockercolorize < Formula
  desc "Enhancing Docker output with vibrant colors"
  homepage "https://github.com/PunGrumpy/dockercolorize"
  version "2.4.7"

  if OS.mac?
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-darwin-amd64"
    sha256 "abf8e264340f8a1bb677efb4f88391d4e724a698449251777394128229ef68da"
  else
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-linux-amd64"
    sha256 "53a1147433c412bdafdcea0a32a14618f9f15b47dd107c89a0af76e18713c936"
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
