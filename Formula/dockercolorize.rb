class Dockercolorize < Formula
  desc "Enhancing Docker output with vibrant colors"
  homepage "https://github.com/PunGrumpy/dockercolorize"
  version "2.4.7"

  if OS.mac?
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-darwin-amd64"
    sha256 "2df82524b7d7e90b1c2df7656537c7fe61f4746f4d4c2620d92d897421da9c80"
  else
    url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-linux-amd64"
    sha256 "a310669597d812fdc6f2f20066e166bc309e921b2bc7011d13585789ff1c979b"
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
