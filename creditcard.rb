
class CreditCardType
  UNKNOWN='Unknown'
  VISA='VISA'
  AMEX='AMEX'
  DISCOVER='Discover'
  MASTERCARD='Mastercard'
end


class CreditCard

  def initialize str=''
     @cc_str = str.to_s.gsub(/ /, '')
     @cc_type = identify_cc_type
     @cc_valid = identify_cc_valid
  end

  def valid?
    @cc_valid
  end

  def type
    @cc_type
  end

  def numbers
    @cc_str.to_i
  end

private
  def identify_cc_type
    case @cc_str
      when /^6011/
        CreditCardType::DISCOVER

      when /^4/
        CreditCardType::VISA

      when /^5[12345]/
        CreditCardType::MASTERCARD

      when /^34/, /^37/
        CreditCardType::AMEX

      else
        CreditCardType::UNKNOWN
    end
  end

  def identify_cc_valid
    result = false

    case @cc_type
      when CreditCardType::VISA
        if (@cc_str.length == 13) || (@cc_str.length == 16) then
          result = lunh_function
        end

      when CreditCardType::DISCOVER, CreditCardType::MASTERCARD
        if (@cc_str.length == 16) then
          result = lunh_function
        end

      when CreditCardType::AMEX
        if (@cc_str.length == 15) then
          result = lunh_function
      end
    end

    result
  end

  def lunh_function
    true
# LOOK AT THIS
#
# irb(main):063:0> no_space_cc_num.split(//)
# => ["4", "5", "6", "7", "3", "3", "4", "2", "2", "1", "2", "2", "3", "4", "5", "5"]
#
  end
end

