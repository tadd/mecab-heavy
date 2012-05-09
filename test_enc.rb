# coding: utf-8
require 'MeCab'

puts MeCab::VERSION
tagger = MeCab::Tagger.new(ARGV.join(" "))

node = tagger.parseToNode("にぎり")
while node
  puts "#{node.surface} : #{node.surface.encoding}"
  node = node.next
end

result = tagger.parseNBest(1, '寿司とすき焼きを食べた。')
puts "#{result} : #{result.encoding}"