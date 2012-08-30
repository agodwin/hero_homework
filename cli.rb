#!/usr/bin/env ruby

require 'optparse'
require './creditcard'

def write cc
  printf("%s: %-18.18s\t%s\n", cc.type, cc.numbers, "#{cc.valid? ? '(valid)' : '(invalid)'}")
end

options = {}

optparse = OptionParser.new do|opts|
  # Set a banner, displayed at the top of the help screen.
  opts.banner = "Usage:\n  #{__FILE__} [--cc CREDIT_CARD_NUMBER | --file FILE_PATH]"

  # add the HELP option
  opts.on( '-h', '--help', 'Display this screen' ) do
    puts "\n#{opts}\n\n"
    exit
  end

  # command needs to know a credit card number
  opts.on( '-c', '--cc CREDIT_CARD_NUMBER', String,
           'enter a single credit card number' ) do |cc_number|

    if options.has_key?(:cc) then
      puts "\nERROR: repeated option.\nPlease use the --cc CREDIT_CARD_NUMBER option only once.\n\n"
      puts opts
      exit
    else
      options[:cc] = cc_number
    end
  end

  opts.on( '-f', '--file FILE_NAME', String,
           'a file of credit card numbers (one per line)' ) do |file|

    if options.has_key?(:file) then
      puts "\nERROR: repeated option.\nPlease use the --file FILE_PATH option only once.\n\n"
      puts opts
      exit
    else
      options[:file] = file
    end
  end

  # must pass a value
  if ARGV.size == 0 then

    puts "\nERROR: no option given.\nPlease use one of the known options.\n\n"
    puts opts
    exit
  end
end


begin
  optparse.parse!
rescue OptionParser::MissingArgument => e
  puts "\nERROR: #{e.message}\nPlease add a value for the given option.\n\n"
  puts optparse
  exit
rescue OptionParser::InvalidOption => e
  puts "\nERROR: #{e.message}\nPlease use one of the known options.\n\n"
  puts optparse
  exit
end


if options.has_key?(:cc) then
  write CreditCard.new(options[:cc])
end

if options.has_key?(:file) then
  cc_list = []

  begin
    file = File.new(options[:file], "r")
    while (line = file.gets)
      cc_list << line.chomp
    end
  rescue => err
    puts "\nException: #{err}\n\n"
    puts optparse
    err
  ensure 
    file.close
  end

  cc_list.each do |cc|
  write CreditCard.new(cc)
  end        
end

