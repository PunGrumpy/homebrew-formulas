class Goblin < Formula
  desc "Command-line tool for hashing and reversing hashes using Jenkins' one-time hash"
  homepage "https://github.com/PunGrumpy/goblin"
  version "0.2.8"

  if OS.mac?
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-darwin-amd64"
    sha256 "e0257e89045340576a945e3a2573dc71bac392960380be6188f554b4cd9f55c4"
  else
    url "https://github.com/PunGrumpy/goblin/releases/download/#{version}/goblin-linux-amd64"
    sha256 "b4cf90c04559cba9c4067b40299fb07c5f6b9334a326b9e89c7d03f5d1e196b4"
  end

  def install
    if OS.mac?
      bin.install "goblin-darwin-amd64" => "goblin"
    else
      bin.install "goblin-linux-amd64" => "goblin"
    end
  end

  def caveats
    <<~EOS
      🧙 To use goblin completions, please add the following by:
        #{shell_format("Auto detected shell:", :bold)}
          #{shell_format("goblin completions", :green)}
        #{shell_format("Bash:", :bold)}
          #{shell_format("goblin completions bash > $(brew --prefix)/etc/bash_completion.d/goblin", :green)}
        #{shell_format("Zsh:", :bold)}
          #{shell_format("goblin completions zsh > $(brew --prefix)/share/zsh/site-functions/_goblin", :green)}
        #{shell_format("Fish:", :bold)}
          #{shell_format("goblin completions fish > ~/.config/fish/completions/goblin.fish", :green)}
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/goblin --help")
  end

  private

  def shell_format(text, *effects)
    effects.each do |effect|
      case effect
      when :bold
        text = "\e[1m#{text}\e[0m"
      when :green
        text = "\e[32m#{text}\e[0m"
      end
    end
    text
  end
end
