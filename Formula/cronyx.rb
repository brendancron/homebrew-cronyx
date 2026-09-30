class Cronyx < Formula
  desc "Cronyx toolchain: the cx package manager and the compiler it links"
  homepage "https://github.com/brendancron/CronyxLang"

  # An OCaml binary is native, so each archive is built on a machine of the
  # architecture it is for and a release carries one per architecture. The
  # version is named per architecture too: an architecture a release does not
  # carry stays on the last one that did, rather than holding the other back or
  # pointing at a file that is not there.
  #
  # The Linux archives are linked statically against musl, so they do not care
  # which distribution -- or which libc -- they land on.
  on_macos do
    on_arm do
      version "0.0.18"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.18/cronyx-v0.0.18-aarch64-apple-darwin.tar.gz"
      sha256 "5e5cd3bfc8bb22a69286be47feab3efc2caf049632d65a8ea8d1d4736ca18cbe"
    end

    on_intel do
      version "0.0.18"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.18/cronyx-v0.0.18-x86_64-apple-darwin.tar.gz"
      sha256 "5b99b6073cc8359a15b6125c92595a1948d737a53792cd741e33345f26e40e7d"
    end
  end

  on_linux do
    on_arm do
      version "0.0.18"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.18/cronyx-v0.0.18-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2f46625338d56910d67b76eb1e44729cc725509672c403df0571a02764a88d37"
    end

    on_intel do
      version "0.0.19"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.19/cronyx-v0.0.19-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2aed0d2b810e166c4b7ad64654276c75970e2919bdb6da2f53ce35bb0fab2b9f"
    end
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
      version = "0.0.1"
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
