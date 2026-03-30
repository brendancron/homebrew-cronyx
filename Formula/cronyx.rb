class Cronyx < Formula
  desc "Cronyx programming language compiler/interpreter"
  homepage "https://github.com/brendancron/CronyxLang"
  version "0.1.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.2/cronyx-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "f2106d93600875d50e77a632b7239162d1b8d22d85febb6352158d2f39feb002"
    else
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.2/cronyx-v0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "47a5a04e3cbf094d74a02b2b9c3221bde654b490e543a7413c817979eaec3619"
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
