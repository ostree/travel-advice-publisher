require 'spec_helper'
require 'country'

describe Country do
  before do
    Country.data_path = File.join(Rails.root, "spec", "fixtures", "data", "countries.yml")
  end
  describe "Country.all" do
    it "should return a list of Countries" do
      Country.all.size.should == 14
      Country.all.first.name.should == "Afghanistan"
      Country.all.first.slug.should == "afghanistan"
      Country.all.find{ |c| c.slug == "argentina" }.name.should == "Argentina"
    end
  end
end
