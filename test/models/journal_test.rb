require 'test_helper'

class JournalTest < ActiveSupport::TestCase
  
   # Make sure user id is a valid user in Test db
  def setup
    @journal = Journal.new(summary: "Test Summary", entry: "Test Body", user_id: 1)
  end
  
  test "should be valid" do
    assert @journal.valid?
  end
  
  test "summary should be present" do
    @journal.summary = " "
    assert_not @journal.valid?
  end
  
  test "entry should be present" do
    @journal.entry = " "
    assert_not @journal.valid?
  end
  
  test "user should be present" do
    @journal.user_id = " "
    assert_not @journal.valid?
  end
  
end
