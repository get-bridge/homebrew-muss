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
  version "v0.3"
  url "https://github.com/instructure/muss/releases/download/#{version}/#{basename}"
  sha256({
    "muss-darwin-386.zip" => "64eeea29cf1f000f0d5833def2ba546a3967ba09ad23bbde4d88d2d3c3fd5cde",
    "muss-darwin-amd64.zip" => "ea02d5d1aad84a543d1eeae7a1841a129edbf4bbad01d31086d82548758a0436",
    "muss-linux-386.zip" => "8bd99e722ca724f27bcab65468cba46193a5dd4fa6845c96f71b87b5ad8efe26",
    "muss-linux-amd64.zip" => "56516716522ce620f41ace0fcbf393855e3d92b5c3f87abf5ea87486428ddd41",
  }[basename])

  def install
    bin.install "muss"
  end

  test do
    system bin/"muss", "help"
  end
end
