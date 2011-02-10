require 'spec_helper'

describe "domains/index.html.erb" do
  before(:each) do
    assign(:domains, [
      stub_model(Domain,
        :name => "Name",
        :uses_hsts => false,
        :uses_https => false,
        :mixed_content => false,
        :all_https => false,
        :all_identifying => false,
        :secure_cookies => false,
        :ssl_valid => false,
        :key_strength => "Key Strength",
        :notes => "Notes"
      ),
      stub_model(Domain,
        :name => "Name",
        :uses_hsts => false,
        :uses_https => false,
        :mixed_content => false,
        :all_https => false,
        :all_identifying => false,
        :secure_cookies => false,
        :ssl_valid => false,
        :key_strength => "Key Strength",
        :notes => "Notes"
      )
    ])
  end

  it "renders a list of domains" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Key Strength".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
  end
end
