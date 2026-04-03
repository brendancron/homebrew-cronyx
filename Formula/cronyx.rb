class Cronyx < Formula
  desc "Cronyx language CLI and toolchain manager"
  homepage "https://github.com/brendancron/CronyxCli"
  version "0.0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxCli/releases/download/v0.0.1/cronyx-v0.0.1-macos-arm64.tar.gz"
      sha256 "02e7ce1baaa570ae2316d309474adccda93a6531cae7850140de82ce1ed0cc73"
    else
      url "https://github.com/brendancron/CronyxCli/releases/download/v0.0.1/cronyx-v0.0.1-macos-x86_64.tar.gz"
      sha256 "3c9810bff39508ebe4719c20f65ef0dbe4033971c15271d6cdff0054ca8b3208"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxCli/releases/download/v0.0.1/cronyx-v0.0.1-linux-arm64.tar.gz"
      sha256 "1c7a7ad932e621b5ed9f70313470114b398e1bf46186eadc5afb21e41ed4f422"
    else
      url "https://github.com/brendancron/CronyxCli/releases/download/v0.0.1/cronyx-v0.0.1-linux-x86_64.tar.gz"
      sha256 "a95b30b6606d5a68f7baae8d476cbfce12aa5a006fa94509de2d2a4cacf6e2b3"
    end
  end

  def install
    bin.install "cronyx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cronyx version")
  end
end
