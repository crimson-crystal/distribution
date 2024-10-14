class Crimson < Formula
    desc "A Crystal Version Manager"
    homepage "https://github.com/crimson-crystal/crimson#readme"
    license "MPL-2.0"
    url "https://github.com/crimson-crystal/crimson/archive/refs/tags/1.0.1.tar.gz"
    sha256 "3c7022ddfbba3f5a829621a799d87b34790bfcbf6e80263559bc3334abf5f0b3"
    version '1.0.1'

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
