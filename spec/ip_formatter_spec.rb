require 'spec_helper'

describe IpFormatter do
  context "when valid text file is uploaded" do
    before do
      allow(File).to receive(:open).with('sample_file1', 'rb').and_return("1.2.3.5:25,7,8\n1.2.3.5:25,7,8,8,1\n1.2.3.6:10\n1.2.3.6:10,1\n1.2.4.6:10,1,12,\n1.2.3.6:10,1,12,1,1,11\n1.2.4.6:10,1,5,3")
      allow(File).to receive(:open).with('sample_file2', 'rb').and_return("1.2.3.5:25,7,8\n1.2.3.5:25,7,8,8,1\n1.2.3.6:10,1,12,1,1,14,2,1,9,5,7")
    end
    it "should return the array of appropriate result" do
      formatter = IpFormatter.new('sample_file1')     
      expect(formatter.get_result.count).to  eq 3
      expect(formatter.get_result).to eq(["1.2.3.5:1,7,8,25", "1.2.3.6:1,10,11,12", "1.2.4.6:1,3,5,10,12"])
    end

    it "should return a sorted subaddress" do
      formatter = IpFormatter.new('sample_file2')
      expect(formatter.get_result.count).to  eq 2
      expect(formatter.get_result.first.split(":").last).to eq "1,7,8,25"
      expect(formatter.get_result.last.split(":").last).to eq "1,2,5,7,9,10,12,14"
    end
  end

  context "when an invalid text file is uploaded" do
    before do
      allow(File).to receive(:open).with('empty_file', 'rb').and_return("")
    end
    it "should return an empty array for an empty file" do
      formatter = IpFormatter.new('empty_file')
      expect(formatter.get_result).to  eq []
    end
  end
end