require 'test_helper'

class JournalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @journal = journals(:one)
    @current_user = users(:admin)
    @other_user = users(:archer)
  end

  test "should get index" do
    log_in_as(@current_user)
    get journals_path
    assert_response :success
  end

  test "should get new" do
    log_in_as(@current_user)
    get new_journal_url
    assert_response :success
  end

  test "should create journal" do
    log_in_as(@current_user)
    assert_difference('Journal.count') do
      post journals_url, params: { journal: { entry: @journal.entry, summary: @journal.summary, user_id: @journal.user_id } }
    end

    assert_redirected_to journal_url(Journal.last)
  end

  test "should show journal" do
    log_in_as(@current_user)
    get journal_url(@journal)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@current_user)
    get edit_journal_url(@journal)
    assert_response :success
  end

  test "should update journal" do
    log_in_as(@current_user)
    patch journal_url(@journal), params: { journal: { entry: @journal.entry, summary: @journal.summary, user_id: @journal.user_id } }
    assert_redirected_to journal_url(@journal)
  end

  test "should destroy journal" do
    log_in_as(@current_user)
    assert_difference('Journal.count', -1) do
      delete journal_url(@journal)
    end

    assert_redirected_to journals_url
  end
end
