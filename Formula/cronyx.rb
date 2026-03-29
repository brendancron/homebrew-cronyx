class Cronyx < Formula
  desc "Cronyx programming language compiler/interpreter"
  homepage "https://github.com/brendancron/CronyxLang"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.0/cronyx-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "bd60b970ce7f1782d357686b8a47570ef5e25e72c8086c2a1b8008b1b55e3973"
    else
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.0/cronyx-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "9a0fa5b80dd3bcb5bdc1f817b0251b1cc5810bb2e4b51c14d6e12e52176bb9df"
    end
  end

  def install
    bin.install "cronyx"
  end

  test do
    (testpath/"hello.cx").write('print("hello");')
    assert_match "hello", shell_output("#{bin}/cronyx hello.cx")
  end
end
