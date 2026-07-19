class Passage < Formula
  desc "Fork of password-store that uses age as a backend instead of GnuPG"
  homepage "https://github.com/FiloSottile/passage"
  url "https://github.com/FiloSottile/passage/archive/refs/tags/1.7.4a0.tar.gz"
  sha256 "f3ab71234aef106954ccda7832322fe14f98395153c5fa690d0fe1d4e47807e4"
  license "GPL-2.0-or-later"

  depends_on "age"

  on_macos do
    depends_on "gnu-getopt"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    ENV["PASSAGE_IDENTITIES_FILE"] = testpath/"identities"
    system Formula["age"].opt_bin/"age-keygen", "-o", testpath/"identities"
    assert_match "age-backed password manager", shell_output("#{bin}/passage version")
  end
end
