#!/usr/bin/env ruby

require './creditcard'

puts "INPUT IS #{ARGV[0]}"
cc = CreditCard.new(ARGV[0])

puts "#{cc.type}: #{cc.numbers}\t #{cc.valid? ? '(valid)' : '(invalid)'}"
