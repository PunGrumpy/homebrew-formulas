class Goblin < Formula
  desc "Command-line tool for hashing and reversing hashes using Jenkins' one-time hash"
  homepage "https://github.com/PunGrumpy/goblin"
  version "0.2.7"

  if OS.mac?
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-darwin-amd64"
    sha256 "7443c46dd24e4d102df3110d3650324f5ab9523d570b25424b8cf867cbc5ffd2"
  else
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-linux-amd64"
    sha256 "cd959f416740e7de4c94f5f4507682fcf52e9e82a23fa2c24155fec9a830e0fe"
  end

  def install
    if OS.mac?
      bin.install "goblin-darwin-amd64" => "goblin"
    else
      bin.install "goblin-linux-amd64" => "goblin"
    end

    generate_completions_from_executable("#{bin}/goblin", "completion")
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/goblin --help")
  end
end
