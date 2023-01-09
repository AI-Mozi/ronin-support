require 'spec_helper'
require 'ronin/support/core_ext/kernel'

describe Kernel do
  it "must provide Kernel#try" do
    expect(Kernel).to respond_to('try')
  end

  describe "#try" do
    it "must return the result of the block if nothing is raised" do
      expect(try { 2 + 2 }).to eq(4)
    end

    it "must return nil if an exception is raised" do
      expect(try { 2 + 'a' }).to be_nil
    end

    it "must rescue RuntimeError exceptions" do
      expect {
        try { raise(RuntimeError,"something happened",caller) }
      }.not_to raise_error
    end

    it "must rescue StandardError exceptions" do
      expect {
        try { raise(StandardError,"not allowed to do that",caller) }
      }.not_to raise_error
    end
  end
end