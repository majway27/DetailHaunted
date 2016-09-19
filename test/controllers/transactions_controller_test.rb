require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @entry1 = ledger_transactions(:one)
    @entry2 = ledger_transactions(:two)
    @current_user = users(:admin)
    @other_user = users(:archer)
  end
  
  # Create/New
  test "should get new" do
    log_in_as(@current_user)
    get new_transaction_path
    assert_response :success
  end
  
  # Update/Edit
  test "should redirect edit when not logged in" do
    get edit_transaction_path(@entry1)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch transaction_path(@entry1), params: { transaction: { user_id: 1,
                                              transaction_id: 1, amount: 1 } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_transaction_path(@entry1)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch transaction_path(@entry1), params: { transaction: { user_id: 1,
                                              transaction_id: 1, amount: 1 } }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  # Read/Show/Index
  test "should redirect index when not logged in" do
    get transactions_path
    assert_redirected_to login_url
  end
  
  # Delete
  test "should redirect destroy when not logged in" do
    assert_no_difference 'LedgerTransaction.count' do
      delete transaction_path(@entry1)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as an other user" do
    log_in_as(@other_user)
    assert_no_difference 'LedgerTransaction.count' do
      delete user_path(@entry1)
    end
    assert_redirected_to root_url
  end
  
end
