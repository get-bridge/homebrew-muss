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
  version "v0.4"
  url "https://github.com/instructure/muss/releases/download/#{version}/#{basename}"
  sha256({
    "muss-darwin-386.zip" => "d0668d674c4cfc0c3d0b566e6d4f6cfe6fa032985a5a80bfe659d10d8a79823c",
    "muss-darwin-amd64.zip" => "87febe0713cf672280f75e2d51f2b4d757878561c85841b86b1b8d825d0d2c21",
    "muss-linux-386.zip" => "02fbd863b1c2193b3465c66b9fda43c24981ab3a777cf6b2919f6ece0fde0b2c",
    "muss-linux-amd64.zip" => "76edad215f50273fa6771451e2ee1403726bfae65a235f1296c57e4cdf6314ed",
  }[basename])

  def install
    bin.install "muss"
  end

  test do
    system bin/"muss", "help"
  end
end
