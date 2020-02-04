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
  version "v0.5"
  url "https://github.com/instructure/muss/releases/download/#{version}/#{basename}"
  sha256({
    "muss-darwin-386.zip" => "26b73f5a86d2f31b731b2bd45f5399cdc07abb0cfc4dcc6fb2344a7c4b9cd0c4",
    "muss-darwin-amd64.zip" => "5e93850635e7a1680e6eebc1ce474ac71ee1d814517a41a8ecf47bdd3918507e",
    "muss-linux-386.zip" => "ac0a4dae70278fef7123e8d676eee41381da70bafeec7e80853fe6a07ba62cd2",
    "muss-linux-amd64.zip" => "a0d4bf2b9494333938e5d2ad0f9efcb06ad2294381cae4c882e398f0f0eff446",
  }[basename])

  def install
    bin.install "muss"
  end

  test do
    system bin/"muss", "help"
  end
end
