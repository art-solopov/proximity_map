require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'should save the valid model' do
    v = buildings(:valid)
    assert v.valid?
    assert v.save?
  end
end
