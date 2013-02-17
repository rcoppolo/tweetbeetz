require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Client do
  it 'has an api key' do
    Client.new('123abc').api_key.should == '123abc'
  end

  context 'with valid api key' do
    subject { Client.new(Freesound.config.api_key) }

    describe '#get_sound' do
      it 'returns a Sound' do
        subject.get_sound(10).should be_a(Sound)
      end

      it 'returns a Response corresponding to the given id' do
        subject.get_sound(10).id.should == 10
      end

      it 'adds to @requests' do
        expect { subject.get_sound(10) }.to change(subject.requests, :size).by(1)
      end

      it 'adds to @responses' do
        expect { subject.get_sound(10) }.to change(subject.responses, :size).by(1)
      end
    end

    describe '#search_sounds' do
      before do
      end

      it 'returns an array of properly parsed sounds' do
        result = subject.search_sounds("badass")
        result.should be_a(Array)
        result.first.should be_a(Sound)
        result.first.id.should == 80449
      end

      it 'adds to @requests' do
        expect { subject.search_sounds("badass") }.to change(subject.requests, :size).by(1)
      end

      it 'adds to @responses' do
        expect { subject.search_sounds("badass") }.to change(subject.responses, :size).by(1)
      end
    end
  end
end
