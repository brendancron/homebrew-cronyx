class Cronyx < Formula
  desc "Cronyx programming language compiler/interpreter"
  homepage "https://github.com/brendancron/CronyxLang"
  version "0.1.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.1/cronyx-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "fdd4f8c14facb83a1a9b201007c6e3c877af9bbc5ee4cad9629d1f588ad8174e"
    else
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.1/cronyx-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "244f3cc8c8c4ab8a5af2d8a14a24be1527f1bce94698522e3da2d99f010cbebe"
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
