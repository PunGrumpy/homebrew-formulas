class Dockercolorize < Formula
  desc "Enhancing Docker output with vibrant colors"
  homepage "https://github.com/PunGrumpy/dockercolorize"
  version "3.0.0"

  if OS.mac?
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-darwin-amd64"
    sha256 "1f7a4dd3ca79c265c0ae26e22e8cf64f593a466980e95a49e8cc716851a12af9"
  else
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-linux-amd64"
    sha256 "f87b17bab795f92afe36805544935dac759fab663d34211df9485022f86f2caa"
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
