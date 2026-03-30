class Cronyx < Formula
  desc "Cronyx programming language compiler/interpreter"
  homepage "https://github.com/brendancron/CronyxLang"
  version "0.1.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.1/cronyx-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "e9ce9e65c4567d260927a7546e483c716869df1024e34cf7ec9b562bd163e7a5"
    else
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.1/cronyx-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "bda3cb89604d6cc87c5f500fe0d221ae37aeeaaebd22868e3103a55a1e869bfc"
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
