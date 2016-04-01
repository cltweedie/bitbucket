require 'spec_helper'

describe BitBucket::Repos::Downloads do
  subject { described_class.new }

  describe '#list' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_user/mock_repo/downloads',
        {},
        {}
      ).and_return({values: ['download1', 'download2', 'download3']})
    end

    context 'without a block' do
      it 'makes a GET request for all download links from the repo' do
        subject.list('mock_user', 'mock_repo')
      end
    end

    context 'with a block' do
      it 'makes a GET request for all download links from the repo' do
        subject.list('mock_user', 'mock_repo') { |download| download }
      end
    end
  end

  describe '#get' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_user/mock_repo/downloads/mock_file.txt',
        {},
        {}
      )
    end

    it 'makes a GET request for a specific file' do
      subject.get('mock_user', 'mock_repo', 'mock_file.txt')
    end
  end
end
