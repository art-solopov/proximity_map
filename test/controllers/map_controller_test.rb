require 'test_helper'

class MapControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get search_within" do
    get :search_within
    assert_response :success
  end

end
