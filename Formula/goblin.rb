class Goblin < Formula
  desc "Command-line tool for hashing and reversing hashes using Jenkins' one time hash"
  homepage "https://github.com/PunGrumpy/goblin"
  version "0.2.0"

  if OS.mac?
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-darwin-amd64"
    sha256 "1823116ebd34ed6a1d57a764deedbda059f6d3ac53973a2cd585b8d210920a39"
  else
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-linux-amd64"
    sha256 "b4514777280577ea8f8a768db89d3bcf5ea7a59d211d5eda8eb9b32a7c977305"
  end

  def install
    if OS.mac?
      bin.install "goblin-darwin-amd64" => "goblin"
    else
      bin.install "goblin-linux-amd64" => "goblin"
    end
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/goblin --help")
  end
end
