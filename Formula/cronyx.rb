class Cronyx < Formula
  desc "Cronyx programming language compiler/interpreter"
  homepage "https://github.com/brendancron/CronyxLang"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.0/cronyx-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "14a2a13b621164a761b09116e8c28a7e31ee17792a3bc580b267d46e7e47239d"
    else
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.0/cronyx-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "20c6e2b65abd925f497f4038ad5b40ce20f5771b5da986f6a72141ca5dab4ad7"
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
