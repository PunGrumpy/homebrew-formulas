class Goblin < Formula
  desc "Command-line tool for hashing and reversing hashes using Jenkins"
  homepage "https://github.com/PunGrumpy/goblin"
  version "0.1.4"

  if OS.mac?
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-darwin-amd64"
    sha256 "306706f1531e600cf065104936dadd53595f9c6dd4e285c1b15bc1f1c1df0a9c"
  else
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-linux-amd64"
    sha256 "f65dc8e77804696c6961731868f286d0d71d360534cb907c8f4658cce78ec187"
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
