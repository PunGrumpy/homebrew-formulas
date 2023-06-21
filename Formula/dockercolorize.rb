class Dockercolorize < Formula
  desc "Enhancing Docker output with vibrant colors"
  homepage "https://github.com/PunGrumpy/dockercolorize"
  version "2.5.2"

  if OS.mac?
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-darwin-amd64"
    sha256 "d348bf5efc1824529683f295792066c1ba4caf9c6053a75c13fcb0f66763b2dc"
  else
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-linux-amd64"
    sha256 "68ea964537167548917895f42dbcd8c5d4ffdd380515046c8418ce8ce64d5261"
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
