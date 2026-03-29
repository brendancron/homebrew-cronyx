class Cronyx < Formula
  desc "Cronyx programming language compiler/interpreter"
  homepage "https://github.com/brendancron/CronyxLang"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.0/cronyx-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "f98e94680d991d70230e868acc8408f25f645465d9b1a0738493bed7a5e9746a"
    else
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.0/cronyx-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "acc9019dae156a40c620b7e59bd86116445ffda1da861a98a77d8924a428094b"
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
