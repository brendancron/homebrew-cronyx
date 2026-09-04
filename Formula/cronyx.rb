class Cronyx < Formula
  desc "Cronyx toolchain: the cx package manager and the compiler it links"
  homepage "https://github.com/brendancron/CronyxLang"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.0/cronyx-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "REPLACE_WITH_THE_SHA_RELEASE_SH_PRINTS"
    else
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.0/cronyx-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "REPLACE_WITH_THE_SHA_RELEASE_SH_PRINTS"
    end
  end

  on_linux do
    url "https://github.com/brendancron/CronyxLang/releases/download/v0.1.0/cronyx-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "REPLACE_WITH_THE_SHA_RELEASE_SH_PRINTS"
  end

  def install
    # One complete toolchain, not a launcher for one: `cx` links the compiler
    # rather than shelling out to it, and the standard library ships with the
    # toolchain rather than being fetched. `cx` resolves `import "std/…"` at
    # ../lib/cronyx/stdlib, relative to the binary and not to the working
    # directory, so the two have to move together.
    bin.install "bin/cx"
    (lib/"cronyx").install "lib/cronyx/stdlib"

    # The bare compiler driver: one file, no packages. Kept for debugging and
    # deliberately not on the PATH, since `cx` is the tool.
    libexec.install "bin/cronyxc"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cx version")

    (testpath/"cronyx.toml").write <<~TOML
      [package]
      name    = "smoke"
      version = "0.1.0"
      cronyx  = "#{version}"
    TOML
    (testpath/"src").mkpath
    (testpath/"src/main.cx").write <<~CRONYX
      import "std/lang/Math";

      print(Math.abs(0 - 7));
    CRONYX

    # Reaching the standard library is the half that a bare `--version` misses.
    assert_equal "7\n", shell_output("#{bin}/cx run")
  end
end
