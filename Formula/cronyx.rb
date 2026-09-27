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
      version "0.0.15"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.15/cronyx-v0.0.15-aarch64-apple-darwin.tar.gz"
      sha256 "b196e12431d7b7e61a0d980b724ba8b97baebbd289066aa959f7d9b900382300"
    end

    on_intel do
      version "0.0.16"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.16/cronyx-v0.0.16-x86_64-apple-darwin.tar.gz"
      sha256 "fe25b3a6d174e42e8f565864d569a8492dfb4b6719a8dae9134709eb0821f9eb"
    end
  end

  on_linux do
    on_arm do
      version "0.0.15"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.15/cronyx-v0.0.15-aarch64-unknown-linux-musl.tar.gz"
      sha256 "dcc52fdcaa83caa3f7327c4c22e402f94464462a7b02420041fba1f25e347ec6"
    end

    on_intel do
      version "0.0.15"
      url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.15/cronyx-v0.0.15-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f694fc304d224a435f4106d19285e37e949bfdd401155d6cfaaf763e6d69bc98"
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
