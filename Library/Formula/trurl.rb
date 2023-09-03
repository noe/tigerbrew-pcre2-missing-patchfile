class Trurl < Formula
  desc "Command-line tool for URL parsing and manipulation"
  homepage "https://curl.se/trurl/"
  url "https://github.com/curl/trurl/archive/refs/tags/trurl-0.8.tar.gz"
  sha256 "7baccde1620062cf8c670121125480269b41bdc81bd4015b7aabe33debb022c6"
  license "curl"
  head "https://github.com/curl/trurl.git", branch: "master"

  bottle do
    cellar :any
    sha256 "530bf6eaed6152126a07113e3b412d3da0ec1329acd5a82e65f5d2b7b82a1fc7" => :tiger_altivec
  end

  depends_on "curl" # require libcurl

  def install
    # GCC 4.x defaults to c89 and fails to build
    ENV.append_to_cflags "-std=gnu99"
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_equal "https 443 /hello.html",
      shell_output("#{bin}/trurl https://example.com/hello.html --get '{scheme} {default:port} {path}'").chomp
  end
end