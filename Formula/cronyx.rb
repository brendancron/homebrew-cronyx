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
      version "0.0.17"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.17/cronyx-v0.0.17-aarch64-apple-darwin.tar.gz"
      sha256 "39cd048f43e033a9b967a3824da30c58e54cea7b68dfe4f98e7cbb21c8ab0186"
    end

    on_intel do
      version "0.0.17"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.17/cronyx-v0.0.17-x86_64-apple-darwin.tar.gz"
      sha256 "e9b50f3273d60ad872de3a4112acd7098e62d3701cb660b9853467ecf850590b"
    end
  end

  on_linux do
    on_arm do
      version "0.0.17"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.17/cronyx-v0.0.17-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cdb32b6d2294c0bf4b41372d1272918463cec77eb1489b89bea29a29ecfe5d46"
    end

    on_intel do
      version "0.0.17"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.17/cronyx-v0.0.17-x86_64-unknown-linux-musl.tar.gz"
      sha256 "abb73979534bcf12db25f11f669dae029fce05c0c4acdaecb4069a3f4a6f1083"
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
