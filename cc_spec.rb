require "./creditcard"

describe "a VISA credit card" do
  it "should start with a 4" do
    cc = CreditCard.new(4)
    cc.type.should == CreditCardType::VISA
  end

  it "should have 13 or 16 digits" do
    cc = CreditCard.new("4111 1111 1111 1111")
    cc.type.should == CreditCardType::VISA
    cc.valid?.should == true

    cc = CreditCard.new("4111 1111 1111 1")
    cc.type.should == CreditCardType::VISA
    cc.valid?.should == true

    cc = CreditCard.new(4)
    cc.type.should == CreditCardType::VISA
    cc.valid?.should == false

    cc = CreditCard.new("4111 ABCD 1111 1111")
    cc.type.should == CreditCardType::VISA
  #  cc.valid?.should == false
  end
end


describe "a DISCOVER credit card" do
  it "should start with 6011" do
    cc = CreditCard.new(6011)
    cc.type.should == CreditCardType::DISCOVER
  end

  it "should have 16 digits" do
    cc = CreditCard.new("6011 1111 1111 1111")
    cc.type.should == CreditCardType::DISCOVER
    cc.valid?.should == true

    cc = CreditCard.new("6011 1111 1111 1")
    cc.type.should == CreditCardType::DISCOVER
    cc.valid?.should == false

    cc = CreditCard.new(60111111111111111111111)
    cc.type.should == CreditCardType::DISCOVER
    cc.valid?.should == false

    cc = CreditCard.new("6011 ABCD 1111 1111")
    cc.type.should == CreditCardType::DISCOVER
  #  cc.valid?.should == false
  end
end


describe "an AMERICAN EXPRESS credit card" do
  it "should start with 34 or 37" do
    cc = CreditCard.new(34)
    cc.type.should == CreditCardType::AMEX

    cc = CreditCard.new(37)
    cc.type.should == CreditCardType::AMEX
  end

  it "should have 15 digits" do
    cc = CreditCard.new("341 1111 1111 1111")
    cc.type.should == CreditCardType::AMEX
    cc.valid?.should == true

    cc = CreditCard.new("3411 1111 1111 1111")
    cc.type.should == CreditCardType::AMEX
    cc.valid?.should == false

    cc = CreditCard.new(341111111)
    cc.type.should == CreditCardType::AMEX
    cc.valid?.should == false

    cc = CreditCard.new("371 1111 1111 1111")
    cc.type.should == CreditCardType::AMEX
    cc.valid?.should == true

    cc = CreditCard.new("3711 1111 1111 1111")
    cc.type.should == CreditCardType::AMEX
    cc.valid?.should == false

    cc = CreditCard.new("371 1111 BBBB 1111")
    cc.type.should == CreditCardType::AMEX
  #  cc.valid?.should == false
  end
end


describe "a MASTERCARD credit card" do
  it "should start with 51 thru 55" do
    cc = CreditCard.new(51)
    cc.type.should == CreditCardType::MASTERCARD
    cc = CreditCard.new(52)
    cc.type.should == CreditCardType::MASTERCARD
    cc = CreditCard.new("53")
    cc.type.should == CreditCardType::MASTERCARD
    cc = CreditCard.new(54)
    cc.type.should == CreditCardType::MASTERCARD
    cc = CreditCard.new("55")
    cc.type.should == CreditCardType::MASTERCARD
  end

  it "should have 16 digits" do
    cc = CreditCard.new("5111 1111 1111 1111")
    cc.type.should == CreditCardType::MASTERCARD
    cc.valid?.should == true
    cc = CreditCard.new("5211 1111 1111 1111")
    cc.type.should == CreditCardType::MASTERCARD
    cc.valid?.should == true

    cc = CreditCard.new("5111 1111 1111 1")
    cc.type.should == CreditCardType::MASTERCARD
    cc.valid?.should == false
    cc = CreditCard.new("5211 1111 1111 1")
    cc.type.should == CreditCardType::MASTERCARD
    cc.valid?.should == false

    cc = CreditCard.new(51222222222222222222222222222)
    cc.type.should == CreditCardType::MASTERCARD
    cc.valid?.should == false
    cc = CreditCard.new(52333333333333333333333333333)
    cc.type.should == CreditCardType::MASTERCARD
    cc.valid?.should == false

    cc = CreditCard.new("5111 ABCD 1111 1111")
    cc.type.should == CreditCardType::MASTERCARD
  #  cc.valid?.should == false
    cc = CreditCard.new("5211 ABCD 1111 1111")
    cc.type.should == CreditCardType::MASTERCARD
  #  cc.valid?.should == false
  end
end



describe "an UNKNOWN credit card" do
  it "starts with any other value and is not valid" do
    cc = CreditCard.new(601)
    cc.type.should == CreditCardType::UNKNOWN
    cc.valid?.should == false

    cc = CreditCard.new(58)
    cc.type.should == CreditCardType::UNKNOWN
    cc.valid?.should == false

    cc = CreditCard.new(31)
    cc.type.should == CreditCardType::UNKNOWN
    cc.valid?.should == false

    cc = CreditCard.new(943212)
    cc.type.should == CreditCardType::UNKNOWN
    cc.valid?.should == false

    cc = CreditCard.new("65GFE9")
    cc.type.should == CreditCardType::UNKNOWN
    cc.valid?.should == false

    cc = CreditCard.new(nil)
    cc.type.should == CreditCardType::UNKNOWN
    cc.valid?.should == false

    cc = CreditCard.new()
    cc.type.should == CreditCardType::UNKNOWN
    cc.valid?.should == false
  end
end
