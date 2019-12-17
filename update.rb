#!/usr/bin/env ruby
# rubocop: disable all

def usage
  puts "#{$0} version path_to_shasums"
  exit 1
end

version = ARGV.shift or usage
sums = ARGV.shift or usage

subs = {
  "version" => version
}

(sums == "-" ? STDIN.readlines : File.readlines(sums)).map(&:chomp).each do |line|
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
