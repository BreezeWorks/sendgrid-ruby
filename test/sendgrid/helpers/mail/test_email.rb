require_relative '../../../../lib/sendgrid/helpers/mail/send_grid_email'
require 'minitest/autorun'

class TestEmail < Minitest::Test
  include SendGrid

  def test_split_email_full_email
    @email = SendGridEmail.new(email: 'Example User <test1@example.com>')
    expected_json = {
      'email' => 'test1@example.com',
      'name' => 'Example User'
    }
    assert_equal @email.to_json, expected_json
  end

  def test_split_email_only_email
    @email = SendGridEmail.new(email: 'test1@example.com')
    expected_json = {
      'email' => 'test1@example.com'
    }
    assert_equal @email.to_json, expected_json
  end

  def test_split_email_name_and_email
    @email = SendGridEmail.new(name: 'Example User', email: 'test1@example.com')
    expected_json = {
      'email' => 'test1@example.com',
      'name' => 'Example User'
    }
    assert_equal @email.to_json, expected_json
  end

  def test_mandatory_email_missing
    assert_raises(ArgumentError) { SendGridEmail.new(email: nil) }
    assert_raises(ArgumentError) { SendGridEmail.new(email: "") }
  end

  def test_invalid_email
    assert_raises(ArgumentError) { SendGridEmail.new(email: "some-invalid-string") }
  end
end
