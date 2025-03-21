# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Gitpower < Formula
  desc "GitPower CLI tool"
  homepage "https://github.com/PunGrumpy/gitpower"
  version "1.0.2"
  license "MIT"

  depends_on "git"
  depends_on :linux

  if Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://github.com/PunGrumpy/gitpower/releases/download/v1.0.2/gitpower_Linux_x86_64.tar.gz"
      sha256 "f6149df8d8ce1ee13fd9c3f6b28471c2d0e1b0f1429dbc095e44ccb7ccd2064d"

      def install
        bin.install "gitpower"
      end
    end
  end
  if Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://github.com/PunGrumpy/gitpower/releases/download/v1.0.2/gitpower_Linux_aarch64.tar.gz"
      sha256 "93dd8efbee6cce30c6154f74a18ec18c8c364fa5c53a212984308b379b877e56"

      def install
        bin.install "gitpower"
      end
    end
  end

  def caveats
    <<~EOS
      🚀 Thanks for installing GitPower!

      For usage information, run:
        gitpower --help
    EOS
  end

  test do
    system "#{bin}/gitpower --version"
  end
end
