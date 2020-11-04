require 'test_helper'

class CopyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get copy_index_url
    assert_response :success
  end

end
