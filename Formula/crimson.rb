class Crimson < Formula
    desc "A Crystal Version Manager"
    homepage "https://github.com/crimson-crystal/crimson#readme"
    license "MPL-2.0"
    # url "https://github.com/crimson-crystal/crimson/archive/0.1.0.tar.gz"
    url "https://github.com/crimson-crystal/crimson/archive/refs/heads/main.zip"
    sha256 "4c2a17c2fe4962a850781eeb7fae3c82dd2d6cc8a6260f6973500e55f54527f8"
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
