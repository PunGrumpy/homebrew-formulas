class Goblin < Formula
  desc "Command-line tool for hashing and reversing hashes using Jenkins' one time hash"
  homepage "https://github.com/PunGrumpy/goblin"
  version "0.2.2"

  if OS.mac?
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-darwin-amd64"
    sha256 "9a4d7c52973efde3f95ab10a68de272a4bfffdba2ce5a74ba583652083f1ca9d"
  else
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-linux-amd64"
    sha256 "e8d1bd6830029c7516b9fa9e4af88434a29337fc75793450416d02fa9cb69dd5"
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
