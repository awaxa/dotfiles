#!/usr/bin/env ruby

pmset = `pmset -g ps`

if pmset =~ /'(.*)'/
  case $~[1]
  when 'AC Power'
    print "\u{26A1}  "
  when 'Battery Power'
    print "\u{1F50B}  "
  end
end

print "#{$~[1]} " if pmset =~ /(\d{1,3}%);/

if pmset =~ /(\d+:\d+)/
  print $~[1] unless $~[1] == '0:00'
else
  print "\u{1F551} "
end
