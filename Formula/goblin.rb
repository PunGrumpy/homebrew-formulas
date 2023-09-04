class Goblin < Formula
  desc "Command-line tool for hashing and reversing hashes using Jenkins' one time hash"
  homepage "https://github.com/PunGrumpy/goblin"
  version "0.2.1"

  if OS.mac?
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-darwin-amd64"
    sha256 "7ca7b38cfd152bf2f7fe9bd63ef01d4cdb0064829e9086dbd9da80db37f0697c"
  else
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-linux-amd64"
    sha256 "6aaf8a848f119505a0dbd11b4c6dba5794d8125a023b68b4f5ba68eb8c1f0008"
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
