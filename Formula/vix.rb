class Vix < Formula
  desc "A fast, vim-inspired visual terminal multiplexer"
  homepage "https://github.com/justamapping/vix"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/justamapping/vix/releases/download/v0.1.1/vix-aarch64-apple-darwin.tar.xz"
      sha256 "d2aac59e1876a0854cf30383a4b5e9091737439cf526af7a494cae40899062a6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/justamapping/vix/releases/download/v0.1.1/vix-x86_64-apple-darwin.tar.xz"
      sha256 "5800c0287f8ef1ab8c0e9250e9e531568d314528fecf171dedf3582132aa18ac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/justamapping/vix/releases/download/v0.1.1/vix-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "13d289bb4d987883ce2cf2227c3ae8cd609a481a5b636fdecc6f44ac93b2684a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/justamapping/vix/releases/download/v0.1.1/vix-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e11c2c6c39447decb3f00298204118d120936786fa7ce30a33741c786fb6505d"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "vix"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "vix"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "vix"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "vix"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
