require 'test_helper'

class TransactionFlowsTest < ActionDispatch::IntegrationTest
  
  def setup
    @entry1 = ledger_transactions(:one)
    @entry2 = ledger_transactions(:two)
    @current_user = users(:admin)
    @other_user = users(:archer)
  end
  
  test "transaction as current_user" do
    log_in_as(@current_user)
    get transactions_path
    assert_template 'transactions/index'
    assert_select "a[href=?]", new_transaction_path
    get new_transaction_path
    assert_template 'transactions/new'
    assert_difference 'LedgerTransaction.count', +1 do
      post transactions_path, params: { ledger_transaction: { transaction_id: 1, user_id: 1, transaction_date: "1979-01-01 01:01:01", description: "Test", amount: 2 } }
    end
  end
  
end