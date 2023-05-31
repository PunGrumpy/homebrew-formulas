class Dockercolorize < Formula
    desc "Enhancing Docker output with vibrant colors"
    homepage "https://github.com/PunGrumpy/dockercolorize"
    version "2.4.7"
  
    if OS.mac?
        url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-darwin-amd64"
        sha256 "548dc26e485a53deeaa27fe8780620f64bc6ef022eaea7525f55c32b943d7127"
    else
        url "https://github.com/PunGrumpy/dockercolorize/releases/download/#{version}/dockercolorize-linux-amd64"
        sha256 "3367974eb0b587b7b4a7fe364c2aebcabc7976f70d7ae89286dc3131c17b8ac2"
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
  