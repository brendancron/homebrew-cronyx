class Cronyx < Formula
  desc "Cronyx programming language compiler/interpreter"
  homepage "https://github.com/brendancron/CronyxLang"
  version "0.1.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.3/cronyx-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "b9e1e723f3da95fd4b66a310c4863c0cc6d43904e00a3d2907cd8bb4e3d3aa43"
    else
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.3/cronyx-v0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "3fa359a7dafcdbf033097f40be017cd171fd4847d14f7ebb6afe0e3f67c1caab"
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
