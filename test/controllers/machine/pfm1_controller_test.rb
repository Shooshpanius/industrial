require 'test_helper'

class Machine::Pfm1ControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
