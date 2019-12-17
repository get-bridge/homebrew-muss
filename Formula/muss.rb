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
  version "v0.1"
  url "https://github.com/instructure/muss/releases/download/#{version}/#{basename}"
  sha256({
    "muss-darwin-386.zip" => "fcc530d6b059cac43ea172f9aff83b92fd1f9858f35bf1e4b488708f7ede1677",
    "muss-darwin-amd64.zip" => "3185d43296b1b1126a7f80fee92c904bacdbbd620266980dc2973bfc0540a101",
    "muss-linux-386.zip" => "66c619b2abdb6bcfc78781e2d5c53a49672b0f61aafbb351114cd7ef9557f353",
    "muss-linux-amd64.zip" => "1f739da130bb7d2d29b3d26210c467438181814fb18980ececa429ef9679cbac",
  }[basename])

  def install
    bin.install "muss"
  end

  test do
    system bin/"muss", "help"
  end
end
