require_relative 'spec_helper'

describe "Rbpipe" do
  include Rbpipe

  it "|, >> and pipe should work" do
    ([1,2] >> concat).should eq("1, 2")
    (piped([1,2]) | concat).should eq("1, 2")
  end

  it "even, concat should work" do
    ([1, 2, 3, 4] >> even >> concat).should eq("2, 4")
  end

  it "first, take, as_list should work" do
    ([1,2,3] >> first(9) >> take(2) >> as_list).should eq([1,2])
  end

  it "as_dict should work" do
    ({:a=>"b"} | as_dict).should eq({:a=>"b"})
    ([[:a, 'b'], [:c, 'd']] >> as_dict).should eq({:a=>"b", :c=>"d"})
  end

  it "where, select, filter should work" do
    ([1,2,3,4,5] >> filter{|x| x > 0} >> select{|x| x < 4} >> where{|x| x > 1} >> as_list).should eq([2,3])
  end

  it "all?, any? should work" do
    ([1, 3] >> all? {|x| x > 0}).should be_true
    ([1, 3] >> all? {|x| x > 2}).should be_false
    ([1, 3] >> any? {|x| x > 2}).should be_true
    ([1, 3] >> any? {|x| x > 4}).should be_false
  end

  it "stdout should work" do
    (capture_stdout {[9,8,7] >> stdout}).should eq("[9, 8, 7]\n")
    (capture_stdout {piped(9) >> stdout}).should eq("9\n")
  end
end

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end
