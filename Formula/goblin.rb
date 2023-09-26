class Goblin < Formula
  desc "Command-line tool for hashing and reversing hashes using Jenkins' one-time hash"
  homepage "https://github.com/PunGrumpy/goblin"
  version "0.2.5"

  if OS.mac?
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-darwin-amd64"
    sha256 "d514f3818843ebb94ae6d5c1ca38b3bb1d133070b736988deae9ada6bbecb0cd"
  else
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-linux-amd64"
    sha256 "64f01e7f7a6c7afbae40d71462cc4ab3eb25bf5ef281230eb988d7d9634e91d9"
  end

  def install
    if OS.mac?
      bin.install "goblin-darwin-amd64" => "goblin"
    else
      bin.install "goblin-linux-amd64" => "goblin"
    end

    bash_completion.install "completion/goblin-completion.bash" => "goblin"
    zsh_completion.install "completion/goblin-completion.zsh" => "_goblin"
    fish_completion.install "completion/goblin.fish"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/goblin --help")
  end
end
