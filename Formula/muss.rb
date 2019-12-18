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
  version "v0.2"
  url "https://github.com/instructure/muss/releases/download/#{version}/#{basename}"
  sha256({
    "muss-darwin-386.zip" => "e32194b3481a69877e3141524d75590efac16752b22f9ff381b924d79c1b322c",
    "muss-darwin-amd64.zip" => "ce6c89d50d1c26ff981425c1f902134e966d91a394f28b88f309d7f6e71c9b74",
    "muss-linux-386.zip" => "2521a2c8d7b8847e61ab41168990c10a7c7c9dd67036d9ba95fe0e3d02206964",
    "muss-linux-amd64.zip" => "fb11323b1b6433ac50222f9d9b9c22d203d43ac9b34ceefba37d5500d58cecc5",
  }[basename])

  def install
    bin.install "muss"
  end

  test do
    system bin/"muss", "help"
  end
end
