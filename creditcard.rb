
class CreditCardType
  UNKNOWN='Unknown'
  VISA='VISA'
  AMEX='AMEX'
  DISCOVER='Discover'
  MASTERCARD='Mastercard'
end


class CreditCard

  def initialize input_str=''
    @cc = input_str.to_s.gsub(/ /, '')
    
    # at this time, credit cards must be digits
    # \D will match any non-digit character - we must not find any (match must return nil)
    if (@cc.match(/\D/) != nil) then
      @cc_type = CreditCardType::UNKNOWN
      @cc_valid = false
    else
      @cc_type = identify_cc_type
      @cc_valid = identify_cc_valid
    end
  end

  def valid?
    @cc_valid
  end

  def type
    @cc_type
  end

  def numbers
    @cc
  end

private
  def identify_cc_type
    case @cc
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
        if (@cc.length == 13) || (@cc.length == 16) then
          result = lunh_function
        end

      when CreditCardType::DISCOVER, CreditCardType::MASTERCARD
        if (@cc.length == 16) then
          result = lunh_function
        end

      when CreditCardType::AMEX
        if (@cc.length == 15) then
          result = lunh_function
      end
    end

    result
  end


  def lunh_function
    # Of all the implementations I reviewed, I found the lookup table solutiuon to be the clearest
    # implementation based on http://en.wikipedia.org/wiki/Luhn_formula
    # which contains a reference to https://gist.github.com/1182499

    # no need to compute the value for => a+b when (("ab".to_i)*2) >= 10 
    # we just create a map of the values and then do a look-up in the map
    sum_lookup = {'0' => 0, '1' => 2, '2' => 4, '3' => 6, '4' => 8, '5' => 1, '6' => 3, '7' => 5, '8' => 7, '9' => 9}

    number = @cc.reverse
    sum = 0 

    number.split('').each_with_index do |n, i|
      sum += (i % 2 == 0) ? n.to_i : sum_lookup[n]
    end 

    sum % 10 == 0
  end
end

