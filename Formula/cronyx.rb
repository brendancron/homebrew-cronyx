class Cronyx < Formula
  desc "Cronyx programming language compiler/interpreter"
  homepage "https://github.com/brendancron/CronyxLang"
  version "0.1.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.4/cronyx-v0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "43e0e37de4737e75f83bcdb7f5ea2fff0e52dc5a842b512e0fbb1f7e8b2f8cb1"
    else
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.4/cronyx-v0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "a77e688ed3bad36601b7953e95881a413738644f8d311db1ceca67668136f66e"
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
