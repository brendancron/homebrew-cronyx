class Cronyx < Formula
  desc "Cronyx language CLI and toolchain manager"
  homepage "https://github.com/brendancron/CronyxCli"
  version "0.0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxCli/releases/download/v0.0.1/cronyx-v0.0.1-macos-arm64.tar.gz"
      sha256 "978fcd5a074de1c31560f069b244f94d69aae69434e4a28e01a1e36b344b4e2e"
    else
      url "https://github.com/brendancron/CronyxCli/releases/download/v0.0.1/cronyx-v0.0.1-macos-x86_64.tar.gz"
      sha256 "93beeff6a6bae5c95441dea697a226cfbd57e75d8f7d51928464d23ab1c70943"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxCli/releases/download/v0.0.1/cronyx-v0.0.1-linux-arm64.tar.gz"
      sha256 "235139fb591057361e8601489c9a200b1b6445e4c01b1ffff1c1972eadad0c67"
    else
      url "https://github.com/brendancron/CronyxCli/releases/download/v0.0.1/cronyx-v0.0.1-linux-x86_64.tar.gz"
      sha256 "e5546f2421462f1f33c86ef05e6cf964597f67df5595529e8a5915e71b952edc"
    end
  end

  def install
    bin.install "cronyx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cronyx version")
  end
end
