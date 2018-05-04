require 'test_helper'

class ClientConsentMailerTest < ActionMailer::TestCase
  test "first_new" do
    mail = ClientConsentMailer.first_new
    assert_equal "First new", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
