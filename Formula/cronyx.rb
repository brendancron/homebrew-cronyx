class Cronyx < Formula
  desc "Cronyx programming language compiler/interpreter"
  homepage "https://github.com/brendancron/CronyxLang"
  version "0.1.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.3/cronyx-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "2d62d87527570d2522b6c4addcb3d3f1855e7068f0b7cb9d6c831e391f88709f"
    else
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.3/cronyx-v0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "5581f47b1b1894155dde3e5c7c9bf644a3442d0e85c66e806a9415dfece6191c"
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
