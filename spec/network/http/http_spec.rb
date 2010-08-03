require 'spec_helper'
require 'ronin/network/http'

describe Network::HTTP do
  describe "proxy" do
    it "should be disabled by default" do
      Network::HTTP.proxy.should_not be_enabled
    end
  end

  describe "proxy=" do
    after(:all) do
      Network::HTTP.proxy.disable!
    end

    it "should accept Network::HTTP::Proxy arguments" do
      Network::HTTP.proxy = Network::HTTP::Proxy.new(
        :host => 'www.example.com',
        :port => 9001
      )

      Network::HTTP.proxy[:host].should == 'www.example.com'
      Network::HTTP.proxy[:port].should == 9001
    end

    it "should accept Hash arguments" do
      Network::HTTP.proxy = {
        :host => 'www.example.com',
        :port => 9001
      }

      Network::HTTP.proxy[:host].should == 'www.example.com'
      Network::HTTP.proxy[:port].should == 9001
    end

    it "should accept String arguments" do
      Network::HTTP.proxy = 'www.example.com:9001'

      Network::HTTP.proxy[:host].should == 'www.example.com'
      Network::HTTP.proxy[:port].should == 9001
    end

    it "should raise a RuntimeError exception when given anything else" do
      lambda {
        Network::HTTP.proxy = 42
      }.should raise_error(RuntimeError)
    end
  end

  describe "expand_options" do
    it "should expand the :ssl option into a Hash" do
      options = {:ssl => true}
      expanded_options = Network::HTTP.expand_options(options)

      expanded_options[:ssl].should == {}
    end

    it "should added a default port and path" do
      options = {:host => 'example.com'}
      expanded_options = Network::HTTP.expand_options(options)

      expanded_options[:port].should == 80
      expanded_options[:path].should == '/'
    end

    it "should add the default proxy settings" do
      options = {:host => 'example.com'}
      expanded_options = Network::HTTP.expand_options(options)

      expanded_options[:proxy].should == Network::HTTP.proxy
    end

    it "should expand the :url option" do
      options = {:url => 'http://joe:secret@example.com:8080/bla?var'}
      expanded_options = Network::HTTP.expand_options(options)

      expanded_options[:url].should be_nil
      expanded_options[:host].should == 'example.com'
      expanded_options[:port].should == 8080
      expanded_options[:user].should == 'joe'
      expanded_options[:password].should == 'secret'
      expanded_options[:path].should == '/bla?var'
    end

    it "should add a default :path option for :url options" do
      options = {:url => 'http://example.com'}
      expanded_options = Network::HTTP.expand_options(options)

      expanded_options[:path].should == '/'
    end

    it "should set the :ssl option if the URI scheme is 'https'" do
      options = {:url => 'https://example.com'}
      expanded_options = Network::HTTP.expand_options(options)

      expanded_options[:ssl].should == {}
    end
  end

  describe "headers" do
    it "should convert Symbol options to HTTP Headers" do
      options = {:user_agent => 'bla', :location => 'test'}

      Network::HTTP.headers(options).should == {
        'User-Agent' => 'bla',
        'Location' => 'test'
      }
    end

    it "should convert String options to HTTP Headers" do
      options = {'user_agent' => 'bla', 'x-powered-by' => 'PHP'}

      Network::HTTP.headers(options).should == {
        'User-Agent' => 'bla',
        'X-Powered-By' => 'PHP'
      }
    end

    it "should convert all values to Strings" do
      mtime = Time.now.to_i
      options = {:modified_by => mtime, :x_accept => :gzip}

      Network::HTTP.headers(options).should == {
        'Modified-By' => mtime.to_s,
        'X-Accept' => 'gzip'
      }
    end
  end

  describe "request" do
    it "should handle Symbol names" do
      Network::HTTP.request(
        :method => :get, :path => '/'
      ).class.should == Net::HTTP::Get
    end

    it "should handle String names" do
      Network::HTTP.request(
        :method => 'GET', :path => '/'
      ).class.should == Net::HTTP::Get
    end

    it "should raise an UnknownRequest exception for invalid names" do
      lambda {
        Network::HTTP.request(:method => :bla)
      }.should raise_error(Network::HTTP::UnknownRequest)
    end

    it "should use a default path" do
      lambda {
        Network::HTTP.request(:method => :get)
      }.should_not raise_error(ArgumentError)
    end

    it "should accept the :user option for Basic-Auth" do
      req = Network::HTTP.request(:method => :get, :user => 'joe')

      req['authorization'].should == "Basic am9lOg=="
    end

    it "should accept the :user and :password options for Basic-Auth" do
      req = Network::HTTP.request(
        :method => :get,
        :user => 'joe',
        :password => 'secret'
      )

      req['authorization'].should == "Basic am9lOnNlY3JldA=="
    end

    it "should create HTTP Copy requests" do
      req = Network::HTTP.request(:method => :copy)

      req.class.should == Net::HTTP::Copy
    end

    it "should create HTTP Delete requests" do
      req = Network::HTTP.request(:method => :delete)

      req.class.should == Net::HTTP::Delete
    end

    it "should create HTTP Get requests" do
      req = Network::HTTP.request(:method => :get)

      req.class.should == Net::HTTP::Get
    end

    it "should create HTTP Head requests" do
      req = Network::HTTP.request(:method => :head)

      req.class.should == Net::HTTP::Head
    end

    it "should create HTTP Lock requests" do
      req = Network::HTTP.request(:method => :lock)

      req.class.should == Net::HTTP::Lock
    end

    it "should create HTTP Mkcol requests" do
      req = Network::HTTP.request(:method => :mkcol)

      req.class.should == Net::HTTP::Mkcol
    end

    it "should create HTTP Move requests" do
      req = Network::HTTP.request(:method => :move)

      req.class.should == Net::HTTP::Move
    end

    it "should create HTTP Options requests" do
      req = Network::HTTP.request(:method => :options)

      req.class.should == Net::HTTP::Options
    end

    it "should create HTTP Post requests" do
      req = Network::HTTP.request(:method => :post)

      req.class.should == Net::HTTP::Post
    end

    it "should create HTTP Propfind requests" do
      req = Network::HTTP.request(:method => :propfind)

      req.class.should == Net::HTTP::Propfind
    end

    it "should create HTTP Proppatch requests" do
      req = Network::HTTP.request(:method => :proppatch)

      req.class.should == Net::HTTP::Proppatch
    end

    it "should create HTTP Trace requests" do
      req = Network::HTTP.request(:method => :trace)

      req.class.should == Net::HTTP::Trace
    end

    it "should create HTTP Unlock requests" do
      req = Network::HTTP.request(:method => :unlock)

      req.class.should == Net::HTTP::Unlock
    end

    it "should raise an ArgumentError when :method is not specified" do
      lambda {
        Network::HTTP.request()
      }.should raise_error(ArgumentError)
    end
  end
end
