class Crimson < Formula
    desc "A Crystal Version Manager"
    homepage "https://github.com/crimson-crystal/crimson#readme"
    license "MPL-2.0"
    # url "https://github.com/crimson-crystal/crimson/archive/0.1.0.tar.gz"
    url "https://github.com/crimson-crystal/crimson/archive/refs/heads/main.zip"
    sha256 "17ed776dc4109ec29353527fbb89d18b5b13e2ebf94ccdf8dd3ab295c2018fc1"
    version '0.1.0'

    depends_on "crystal" => :build
    depends_on "git" => :build

    def install
        hash = `git ls-remote https://github.com/crimson-crystal/crimson`.lines[0][0...8]
        ENV["CRIMSON_HASH"] = hash
        system "shards", "build", "--no-debug", "--production", "--release"
        bin.install "./bin/crimson"
    end

    def test
        assert_match "0.1.0", shell_output("#{bin}/crimson version").split(' ')[2]
    end
end
