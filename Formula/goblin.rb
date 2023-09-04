class Goblin < Formula
  desc "Command-line tool for hashing and reversing hashes using Jenkins' one time hash"
  homepage "https://github.com/PunGrumpy/goblin"
  version "0.2.0"

  if OS.mac?
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-darwin-amd64"
    sha256 "720921e8df8f72edd179eea20d5788498f206702c4fa26d51ef20b767807cf41"
  else
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-linux-amd64"
    sha256 "4ee7ff6902bf616fa2562bced21826eb7101c37a1c427e51a9c54a1334325353"
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
