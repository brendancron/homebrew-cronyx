class Cronyx < Formula
  desc "Cronyx language CLI and toolchain manager"
  homepage "https://github.com/brendancron/CronyxCli"
  version "0.0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxCli/releases/download/v0.0.1/cronyx-v0.0.1-macos-arm64.tar.gz"
      sha256 "0d5c3f79e40eacffdf7d44a4c81e1e5dd354539e3815a53d4a4702622838e4f0"
    else
      url "https://github.com/brendancron/CronyxCli/releases/download/v0.0.1/cronyx-v0.0.1-macos-x86_64.tar.gz"
      sha256 "e803b303bebd0e07702d0a47a715f3fc713975e28c092436d7bbdd3e4b52d11a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxCli/releases/download/v0.0.1/cronyx-v0.0.1-linux-arm64.tar.gz"
      sha256 "ed764cb9765d2f29c9158eb62166bfc5d841a8c69f794a75038d3027bcb74eef"
    else
      url "https://github.com/brendancron/CronyxCli/releases/download/v0.0.1/cronyx-v0.0.1-linux-x86_64.tar.gz"
      sha256 "08107d833e5a3b72f178b151e644ccee6861b69261088f91b1c9a5e339313c95"
    end
  end

  def install
    bin.install "cronyx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cronyx version")
  end
end
