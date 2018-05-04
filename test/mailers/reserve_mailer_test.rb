require 'test_helper'

class ReserveMailerTest < ActionMailer::TestCase
  test "cs_requested" do
    mail = ReserveMailer.cs_requested
    assert_equal "Cs requested", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
