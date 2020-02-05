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
  version "v0.6"
  url "https://github.com/instructure/muss/releases/download/#{version}/#{basename}"
  sha256({
    "muss-darwin-386.zip" => "bd2796b3e50f835f3f01edd7bd3568833a6e06c966a7dd87229b9421d76798e8",
    "muss-darwin-amd64.zip" => "c4230eeec118a5281dda38e3511d8df65c1f4255d8a0ed604678e77c3c47c879",
    "muss-linux-386.zip" => "f16ee42fb8477cdad06bfb99fe603bd8b01e23d695911da264b6038f2a10ae5c",
    "muss-linux-amd64.zip" => "30211e5f40bfdbb71dbd1f6ad400e21e0e4278c85753e0ac24992424a1d1c7d8",
  }[basename])

  def install
    bin.install "muss"
  end

  test do
    system bin/"muss", "help"
  end
end
