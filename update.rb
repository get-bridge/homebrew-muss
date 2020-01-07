#!/usr/bin/env ruby
# rubocop: disable all

def usage
  puts "#{$0} version [path_to_shasums]"
  exit 1
end

$version = ARGV.shift or usage

def sums
  if ARGV.empty?
    `curl -fLSs https://github.com/instructure/muss/releases/download/#{$version}/SHA256SUMS`.tap do |s|
      raise s if $? != 0
    end.split("\n")
  else
    path = ARGV.first
    if path == "-"
      STDIN.readlines
    else
      File.readlines(path)
    end
  end.map(&:chomp)
end

subs = {
  "version" => $version
}

sums.each do |line|
  sha, name = line.split(/ +/)
  subs[%("#{name}")] = sha
end

formula = File.join(__dir__, "Formula", "muss.rb")
lines = File.readlines(formula)
lines.map! do |line|
  if match = line.match(/^((?:\s*)(\S+)(?:.+?"))(?:[^"]+)(",?)$/)
    key = match[2]
    if subs.key?(key)
      [match[1], subs[key], match[3], "\n"].join("")
    else
      line
    end
  else
    line
  end
end
File.write(formula, lines.join(""))
