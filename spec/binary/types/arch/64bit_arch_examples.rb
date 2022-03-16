require 'rspec'

shared_examples_for "64bit Arch examples" do
  describe "TYPES" do
    subject { described_class::TYPES }

    describe ":long" do
      it "must be an alias to :int64" do
        expect(subject[:long]).to be(subject[:int64])
      end
    end

    describe ":ulong" do
      it "must be an alias to :uint64" do
        expect(subject[:ulong]).to be(subject[:uint64])
      end
    end
  end
end
