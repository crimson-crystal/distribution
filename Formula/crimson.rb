class Crimson < Formula
    desc "A Crystal Version Manager"
    homepage "https://github.com/crimson-crystal/crimson#readme"
    license "MPL-2.0"
    url "https://github.com/crimson-crystal/crimson/archive/refs/tags/1.0.0.tar.gz"
    sha256 "170b05f7ff288cdbabeab9aa7d225fc0f0536cb76c1c890d4c380d91441478e8"
    version '1.0.0'

    depends_on "crystal" => :build
    depends_on "git" => :build

    def install
        hash = `git ls-remote https://github.com/crimson-crystal/crimson`.lines[0][0...8]
        ENV["CRIMSON_HASH"] = hash
        system "shards", "build", "--no-debug", "--production", "--release"
        bin.install "./bin/crimson"

        opoo "Remember to run `brew uninstall crystal` before using Crimson!"
    end
end
