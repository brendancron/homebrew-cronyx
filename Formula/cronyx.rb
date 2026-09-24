class Cronyx < Formula
  desc "Cronyx toolchain: the cx package manager and the compiler it links"
  homepage "https://github.com/brendancron/CronyxLang"

  # An OCaml binary is native, so each archive is built on a machine of the
  # architecture it is for and a release carries one per architecture. The
  # version is named per architecture too: an architecture a release does not
  # carry stays on the last one that did, rather than holding the other back or
  # pointing at a file that is not there. Linux has an archive but no formula
  # yet.
  depends_on :macos

  on_arm do
    version "0.0.11"
    url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.11/cronyx-v0.0.11-aarch64-apple-darwin.tar.gz"
    sha256 "3df875776da0db2df411cee759298d575594cd94050fed3751a796e0c8f62635"
  end

  on_intel do
    version "0.0.12"
    url "https://github.com/brendancron/CronyxLang/releases/download/v0.0.12/cronyx-v0.0.12-x86_64-apple-darwin.tar.gz"
    sha256 "50626112c5b71a3ecc3fb9bec935c2ca9421911e477c00eb77bea28ddd9de9da"
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
