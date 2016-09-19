require 'test_helper'

class LedgerTransactionTest < ActiveSupport::TestCase
  
  # Make sure user id is a valid user in Test db
  def setup
    @transaction = LedgerTransaction.new(transaction_id: 1, user_id: 14035331,
      transaction_date: "2016-09-07 11:52:00", description: "test", 
      amount: 10, running_balance: 0)
  end
  
  test "should be valid" do
    assert @transaction.valid?
  end
  
  test "id should be present" do
    @transaction.transaction_id = " "
    assert_not @transaction.valid?
  end
  
  test "id should be numeric integer" do
    @transaction.transaction_id =  "a"
    assert_not @transaction.valid?
  end
  
  test "amount should be present" do
    @transaction.amount = " "
    assert_not @transaction.valid?
  end
  
  test "amount should be numeric" do
    @transaction.amount =  "a"
    assert_not @transaction.valid?
  end
  
end
