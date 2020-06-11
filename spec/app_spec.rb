# spec/app_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__

describe "Currency Converter Application" do

  def app
    ApplicationController.new
  end

  context "with valid params" do

    it "simple test" do
      get '/test'
      expect(last_response).to be_ok
      expect(last_response.body).to eq('RSpec Test')
    end

    it "should allow accessing the home page" do
      get "/"
      expect(last_response).to be_ok
    end

  end

end


describe "POST convert" do

  def app
    ApplicationController.new
  end

  context 'with invalid params' do
    let(:body) { { :from => '5ee2658f16e32b08534414ae', :to => "", :sum => 200}.to_json }

    before do
      post '/convert', body, {:CONTENT_TYPE => 'application/x-www-form-urlencoded'}
    end
    subject { last_response }

    it "should return calculated sum based on input params" do
      JSON.parse(last_response.body)["data"]["result_sum"].should be_nil
    end

  end

  context 'with valid params' do
    let(:body) { { :from => '5ee2658f16e32b08534414ae', :to => "USD", :sum => 200} }

    before do
      post '/convert', body, {:CONTENT_TYPE => 'application/x-www-form-urlencoded'}
    end
    subject { last_response }

    it "should return calculated sum based on input params" do
      JSON.parse(last_response.body)["data"]["result_sum"].should_not be_nil
    end
  end

end

