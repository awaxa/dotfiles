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

if pmset =~ /(\d+:\d+)/
  out += $~[1] unless $~[1] == '0:00'
else
  out += "\u{1F551} "
end

puts out
