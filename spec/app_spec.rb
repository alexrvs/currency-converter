# spec/app_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__

describe "Currency Converter Application" do
  it "should allow accessing the home page" do
    get "/"

    expect(last_response.body).to eq("")
    expect(last_response.status).to eq 200

  end

  it "should re"
end



