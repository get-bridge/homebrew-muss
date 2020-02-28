# rubocop: disable all

class Muss < Formula
  def self.go_os
    OS.mac? ? :darwin : :linux
  end

  def self.go_arch
    arch = OS.mac? ? ::MacOS.preferred_arch.to_s : `arch`.chomp
    case arch
    when "x86_64"
      "amd64"
    when "i386"
      "386"
    else
      arch
    end
  end

  def self.basename
    "muss-#{go_os}-#{go_arch}.zip"
  end

  desc "For when your docker-compose project is a mess"
  homepage "https://github.com/instructure/muss"
  version "v0.7"
  url "https://github.com/instructure/muss/releases/download/#{version}/#{basename}"
  sha256({
    "muss-darwin-386.zip" => "d2aedc82e2e81c888544f622d4efaaf42c5b09a94f1dbee2395b31f39f476d08",
    "muss-darwin-amd64.zip" => "2d880502bdb0152d821f47c5eef90da591db80ce77171e5c810eee8f396e72a0",
    "muss-linux-386.zip" => "560b548f041a4acb404d8a44cf2eb1a14e7d42b2af9124607bf638c49966a6d3",
    "muss-linux-amd64.zip" => "4af010fdabb8b901d81cf3aa3b87a3c1c6624c04df658bbd5d32c37e53646feb",
  }[basename])

  def install
    bin.install "muss"
  end

  test do
    system bin/"muss", "help"
  end
end
