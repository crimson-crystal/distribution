class Crimson < Formula
    desc "A Crystal Version Manager"
    homepage "https://github.com/crimson-crystal/crimson#readme"
    license "MPL-2.0"
    url "https://github.com/crimson-crystal/crimson/archive/refs/tags/nightly.tar.gz"
    sha256 "b0c6cd72e02100f5bc7f450e7a6876cb8b3e9a46b8a8cd1b1dd4ed90e0a23106"
    version '0.1.0'

    depends_on "crystal" => :build
    depends_on "git" => :build

    def install
        hash = `git ls-remote https://github.com/crimson-crystal/crimson`.lines[0][0...8]
        ENV["CRIMSON_HASH"] = hash
        system "shards", "build", "--no-debug", "--production", "--release"
        bin.install "./bin/crimson"
    end
end
