# (c) 2014 Солопов Артемий Ильич / Artemiy Solopov

require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'should save the valid model' do
    v = buildings(:valid)
    assert v.valid?
    assert v.save
  end

  %w{name address latitude longtitude}.each do |field|
    test "should not save the model with no #{field}" do
      v = buildings("no_#{field}".to_sym)
      assert v.invalid?
      assert !v.save
    end
  end

  test 'should calculate the distances' do
    right = %w{moscow_kremlin war_museum}.map{|e| buildings(e.to_sym)}
    wrong = %w{big_ben}.map{|e| buildings(e.to_sym)}
    lat, lon = [55.75326, 37.61873]
    blds = Building.within(lat, lon, 4000)
    right.each{|e| assert(blds.include?(e), "point #{e} should be within 4000 m")}
    wrong.each{|e| assert(! blds.include?(e), "point #{e} shouldn't be within 4000 m")}
  end

end
