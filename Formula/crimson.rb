class Crimson < Formula
    desc "A Crystal Version Manager"
    homepage "https://github.com/crimson-crystal/crimson#readme"
    license "MPL-2.0"
    url "https://github.com/crimson-crystal/crimson/archive/nightly.tar.gz"
    sha256 "17ed776dc4109ec29353527fbb89d18b5b13e2ebf94ccdf8dd3ab295c2018fc1"

    depends_on "crystal" => :build
    conflicts_with "crystal", because: "homebrew install overrides crimson installs"

    def install
        system "shards", "build", "--no-debug", "--production", "--release"
        bin.install "./bin/crimson"
    end

    def test
        assert_match version.to_s, shell_output("#{bin}/crimson version").split(' ')[2]
    end
end
