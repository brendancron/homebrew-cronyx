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
      version "0.0.13"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.13/cronyx-v0.0.13-aarch64-apple-darwin.tar.gz"
      sha256 "61a21028636d58d05c16d16bc07622f63eeb82f7790c4610e76af4a37e9c3c63"
    end

    on_intel do
      version "0.0.14"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.14/cronyx-v0.0.14-x86_64-apple-darwin.tar.gz"
      sha256 "eec61a02e40243aec853e7155f02d636a79912e2f277a99216faa150b20130e2"
    end
  end

  on_linux do
    on_arm do
      version "0.0.13"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.13/cronyx-v0.0.13-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fba4da1a052a281652c195976605354b9b2c9620c374ecd0a4aea7127317b78e"
    end

    on_intel do
      version "0.0.13"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.13/cronyx-v0.0.13-x86_64-unknown-linux-musl.tar.gz"
      sha256 "18e03f94902166d2c9dea8373f54a6622ff1060c5e3af94fd99b5e6420069188"
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
