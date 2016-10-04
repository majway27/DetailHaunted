require 'test_helper'

class JournalFlowTestTest < ActionDispatch::IntegrationTest
  
  def setup
    @current_user = users(:admin)
  end
  
  test "transaction as current_user" do
    log_in_as(@current_user)
    get journals_path
    assert_template 'journals/index'
    assert_select "a[href=?]", new_journal_path
    get new_journal_path
    assert_template 'journals/new'
    assert_difference 'Journal.count', +1 do
      post journals_path, params: { journal: { summary: "Test Journal Entry", entry: "Test Journal Entry", user_id: 1 } }
    end
  end
  
end
