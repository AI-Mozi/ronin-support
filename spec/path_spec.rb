require 'ronin/path'

require 'spec_helper'

describe Path do
  before(:all) do
    @n = 7
    @range = (7..10)
    @sub_path = File.join('one','two')
    @sub_directory = 'three'
  end

  it "should inherit from Pathname" do
    Path.superclass.should == Pathname
  end

  it "should be able to traverse up 0 directories" do
    Path.up(0).should == File::SEPARATOR
  end

  it "should raise an ArgumentError on negative number of directories" do
    lambda {
      Path.up(-1)
    }.should raise_error(ArgumentError)
  end

  it "should create directory-escaping paths" do
    Path.up(@n).to_s.should == (['..'] * @n).join(File::SEPARATOR)
  end

  it "should create a range of directory-escaping paths" do
    Path.up(@range).should == @range.map { |i| Path.up(i) }
  end

  it "should join with sub-paths" do
    Path.up(@n).join(@sub_path).to_s.should == [
      Path.up(@n),
      @sub_path
    ].join(File::SEPARATOR)
  end

  it "should join with a sub-directory" do
    (Path.up(@n) / @sub_directory).to_s.should == [
      Path.up(@n),
      @sub_directory
    ].join(File::SEPARATOR)
  end

  it "should allow using custom path separators" do
    Path.up(@n,'\\').to_s.should == (['..'] * @n).join("\\")
  end
end
