require 'test_helper'

class CanvasesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get canvases_show_url
    assert_response :success
  end

end
