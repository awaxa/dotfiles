#!/usr/bin/env ruby

out = ''

pmset = `pmset -g ps`

if pmset =~ /'(.*)'/
  case $~[1]
  when 'AC Power'
    out += "\u{26A1}  "
  when 'Battery Power'
    out += "\u{1F50B}  "
  end
end

out += "#{$~[1]} " if pmset =~ /(\d{1,3}%);/

out += $~[1] if pmset =~ /(\d+:\d+)/

puts out
