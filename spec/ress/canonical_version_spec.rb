require_relative '../../lib/ress'

describe Ress::CanonicalVersion do

  describe '#matches?' do

    context 'with no canonical subdomain' do
      let(:version) { Ress::CanonicalVersion.new }

      it 'returns true if there is no subdomain' do
        version.matches?('').should be_true
      end

      it 'returns false if there is a subdomain' do
        version.matches?('blah').should be_false
      end

    end

    context 'with a canonical subdomain' do

      let(:version) { Ress::CanonicalVersion.new(:subdomain => 'foo') }

      it 'returns true if the subdomain matches the configured' do
        version.matches?('foo').should be_true
      end

      it 'returns false if the subdomain does not match' do
        version.matches?('bar').should be_false
      end

    end

  end

  describe '#link_tag' do

    let(:view) { stub('view') }


    it 'constructs the correct url when there is no canonical subdomain ' do
      version = Ress::CanonicalVersion.new
      view.should_receive(:tag).with(:link, {
        :rel   => "canonical",
        :href  => "http://foo.com"
      }).and_return('<link>')
      version.link_tag('http://', 'm.foo.com', 'm', view).should == '<link>'
    end

    it 'constructs the correct url when there is a canonical subdomain ' do
      version = Ress::CanonicalVersion.new(:subdomain => 'secure')
      view.should_receive(:tag).with(:link, {
        :rel   => "canonical",
        :href  => "http://secure.foo.com"
      }).and_return('<link>')
      version.link_tag('http://', 'm.secure.foo.com', 'm.secure', view).should == '<link>'
    end

  end

end