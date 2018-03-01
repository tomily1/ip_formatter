require 'spec_helper'

describe IpFormatter do
  context 'when valid text file is uploaded' do
    before do
      allow(File).to receive(:open).with('sample_file1', 'rb').and_return("1.2.3.5:25,7,8\n1.2.3.5:25,7,8,8,1\n1.2.3.6:10\n1.2.3.6:10,1\n1.2.4.6:10,1,12,\n1.2.3.6:10,1,12,1,1,11\n1.2.4.6:10,1,5,3")
      allow(File).to receive(:open).with('sample_file2', 'rb').and_return("1.2.3.5:25,7,8\n1.2.3.5:25,7,8,8,1\n1.2.3.6:10,1,12,1,1,14,2,1,9,5,7")
      allow(File).to receive(:exists?).and_return(true)
    end
    it 'should return the array of appropriate result' do
      formatter = IpFormatter.new('sample_file1')
      expect(formatter.display_result.count).to  eq 3
      expect(formatter.display_result).to eq(['1.2.3.5:1,7,8,25', '1.2.3.6:1,10,11,12', '1.2.4.6:1,3,5,10,12'])
    end

    it 'should return a sorted subaddress' do
      formatter = IpFormatter.new('sample_file2')
      expect(formatter.display_result.count).to eq 2
      expect(formatter.display_result.first.split(':').last).to eq '1,7,8,25'
      expect(formatter.display_result.last.split(':').last).to eq '1,2,5,7,9,10,12,14'
    end
  end

  context 'when an invalid text file is uploaded' do
    before do
      allow(File).to receive(:open).with('empty_file', 'rb').and_return('')
      allow(File).to receive(:exists?).and_return(true)
    end
    it 'should return an empty array for an empty file' do
      formatter = IpFormatter.new('empty_file')
      expect(formatter.display_result).to eq []
    end
  end

  context 'File does not exist' do
    it 'should return file does not exist error' do
      formatter = IpFormatter.new('non_existent_file')
      expect(formatter.display_result).to eq ['File does not exist']
    end
  end

  context "File has invalid format" do
    before do
      allow(File).to receive(:open).with('invalid_data', 'rb').and_return('1.sasds2.3.5:25,7,8\n1.2.3.5:25,7,8,8,1\n1.2.3.6:10,1,12,1,1,14,2,1,9,5,7')
      allow(File).to receive(:exists?).and_return(true)
    end
    it 'should return invalid format error' do
      formatter = IpFormatter.new('invalid_data')
      expect(formatter.display_result).to eq ["Invalid File format"]
    end
  end
end