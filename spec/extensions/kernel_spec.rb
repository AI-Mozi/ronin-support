require 'ronin/extensions/kernel'

require 'spec_helper'

describe Kernel do
  it "should provide Kernel#attempt" do
    Kernel.should respond_to('attempt')
  end

  describe "attempt" do
    it "should return the result of the block if nothing is raised" do
      attempt { 2 + 2 }.should == 4
    end

    it "should return nil if an exception is raised" do
      attempt { 2 + 'a' }.should be_nil
    end

    it "should rescue RuntimeError exceptions" do
      lambda {
        attempt { raise(RuntimeError,"something happened",caller) }
      }.should_not raise_error(RuntimeError)
    end

    it "should rescue StandardError exceptions" do
      lambda {
        attempt { raise(StandardError,"not allowed to do that",caller) }
      }.should_not raise_error(StandardError)
    end
  end

  describe "catch_all" do
    it "should run a block" do
      var = 1

      catch_all { var += 1 }

      var.should == 2
    end

    it "should catch SyntaxError exceptions" do
      lambda {
        catch_all(false) { raise(SyntaxError,"horrible code",caller) }
      }.should_not raise_error(SyntaxError)
    end

    it "should catch RuntimeError exceptions" do
      lambda {
        catch_all(false) { raise(RuntimeError,"something happened",caller) }
      }.should_not raise_error(RuntimeError)
    end

    it "should catch StandardError exceptions" do
      lambda {
        catch_all(false) { raise(StandardError,"not allowed to do that",caller) }
      }.should_not raise_error(StandardError)
    end
  end
end
