require 'spec_helper'

describe "domains/new.html.erb" do
  before(:each) do
    assign(:domain, stub_model(Domain,
      :name => "MyString",
      :uses_hsts => false,
      :uses_https => false,
      :mixed_content => false,
      :all_https => false,
      :all_identifying => false,
      :secure_cookies => false,
      :ssl_valid => false,
      :key_strength => "MyString",
      :notes => "MyString"
    ).as_new_record)
  end

  it "renders new domain form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => domains_path, :method => "post" do
      assert_select "input#domain_name", :name => "domain[name]"
      assert_select "input#domain_uses_hsts", :name => "domain[uses_hsts]"
      assert_select "input#domain_uses_https", :name => "domain[uses_https]"
      assert_select "input#domain_mixed_content", :name => "domain[mixed_content]"
      assert_select "input#domain_all_https", :name => "domain[all_https]"
      assert_select "input#domain_all_identifying", :name => "domain[all_identifying]"
      assert_select "input#domain_secure_cookies", :name => "domain[secure_cookies]"
      assert_select "input#domain_ssl_valid", :name => "domain[ssl_valid]"
      assert_select "input#domain_key_strength", :name => "domain[key_strength]"
      assert_select "input#domain_notes", :name => "domain[notes]"
    end
  end
end
