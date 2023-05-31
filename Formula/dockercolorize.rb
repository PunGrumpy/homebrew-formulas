class Dockercolorize < Formula
    include Language::Go::GOPATH_OPTIONAL

    desc "Enhancing Docker output with vibrant colors"
    homepage "https://github.com/PunGrumpy/dockercolorize"
    url "https://github.com/PunGrumpy/dockercolorize/archive/refs/tags/2.4.7.tar.gz"
    sha256 "1d7538e7b801a537cba28babe5c67f07d7515bcd"

    depends_on "go" => :build

    def install
        if OS.mac?
            ENV["CGO_ENABLED"] = "1"
            ENV["GOOS"] = "darwin"
            ENV["GOARCH"] = "amd64"
        else
            ENV["CGO_ENABLED"] = "0"
            ENV["GOOS"] = "linux"
            ENV["GOARCH"] = "amd64"
        end

        ENV["GOPATH"] = buildpath
        ENV["GO111MODULE"] = "auto"
        ENV["GOFLAGS"] = "-mod=vendor"
        system "go", "build", "-o", bin/"dockercolorize", "cmd/cli/main.go"
        prefix.install_metafiles
    end

    test do
        assert_match "dockercolorize version", shell_output("#{bin}/dockercolorize --version")
    end
end