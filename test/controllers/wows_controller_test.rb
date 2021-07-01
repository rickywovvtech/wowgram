require 'test_helper'

class WowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wow = wows(:one)
  end

  test "should get index" do
    get wows_url
    assert_response :success
  end

  test "should get new" do
    get new_wow_url
    assert_response :success
  end

  test "should create wow" do
    assert_difference('Wow.count') do
      post wows_url, params: { wow: { description: @wow.description } }
    end

    assert_redirected_to wow_url(Wow.last)
  end

  test "should show wow" do
    get wow_url(@wow)
    assert_response :success
  end

  test "should get edit" do
    get edit_wow_url(@wow)
    assert_response :success
  end

  test "should update wow" do
    patch wow_url(@wow), params: { wow: { description: @wow.description } }
    assert_redirected_to wow_url(@wow)
  end

  test "should destroy wow" do
    assert_difference('Wow.count', -1) do
      delete wow_url(@wow)
    end

    assert_redirected_to wows_url
  end
end
