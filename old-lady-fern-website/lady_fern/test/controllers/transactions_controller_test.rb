require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get transactions_new_url
    assert_response :success
  end

  test "should get paypal" do
    get transactions_paypal_url
    assert_response :success
  end

  test "should get cash" do
    get transactions_cash_url
    assert_response :success
  end

  test "should get card" do
    get transactions_card_url
    assert_response :success
  end

end
