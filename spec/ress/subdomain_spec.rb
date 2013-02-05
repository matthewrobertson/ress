require_relative '../../lib/ress/subdomain'

describe Ress::Subdomain do

  describe '.create' do

    it 'returns a NilSubdomain when the subdomain is nil' do
      Ress::Subdomain.create(nil).should be_a(Ress::Subdomain::NilSubdomain)
    end

    it 'returns a StringSubdomain when the subdomain is a String' do
      Ress::Subdomain.create('foo').should be_a(Ress::Subdomain::StringSubdomain)
    end

    it 'returns a RegexpSubdomain when the subdomain is a Regex' do
      Ress::Subdomain.create(/foo/).should be_a(Ress::Subdomain::RegexpSubdomain)
    end

  end

  describe Ress::Subdomain::NilSubdomain do

    let(:subdomain) { Ress::Subdomain::NilSubdomain.new }

    describe '#matches?' do
      it 'matches the empty string' do
        subdomain.matches?('').should be_true
        subdomain.matches?('s').should be_false
      end
    end

    describe '#url' do
      it 'strips urls from the fullpath if there is one' do
        subdomain.url('http://', 'foo.bar.com/some/stuff', 'foo').should ==
          'http://bar.com/some/stuff'
      end

      it 'concatenates the protocol and fullpath together if there is no subdomain' do
        subdomain.url('http://', 'bar.com/some/stuff', '').should ==
          'http://bar.com/some/stuff'
      end
    end
  end

  describe Ress::Subdomain::StringSubdomain do

    let(:subdomain) { Ress::Subdomain::StringSubdomain.new('foo') }

    describe '#matches?' do

      it 'returns true if the url is exact match of that passed to the ctor' do
        subdomain.matches?('foo').should be_true
      end

      it 'returns false if the url is not an exact match of that passed to the ctor' do
        subdomain.matches?('boo').should be_false
      end
    end

    describe '#url' do

      it 'strips off extra subdomains from the fullpath' do
        subdomain.url('http://', 'm.foo.bar.com/some/stuff', 'm.foo').should ==
        'http://foo.bar.com/some/stuff'
      end

      it 'handles cannonical fullpaths' do
        subdomain.url('http://', 'foo.bar.com/some/stuff', 'foo').should ==
        'http://foo.bar.com/some/stuff'
      end

    end
  end

  describe Ress::Subdomain::RegexpSubdomain do
    describe '#matches?' do
      let(:subdomain) { Ress::Subdomain::RegexpSubdomain.new(/[fb]oo/) }

      it 'returns true if the subdomain matches regex that passed to the ctor' do
        subdomain.matches?('foo').should be_true
        subdomain.matches?('boo').should be_true
      end

      it 'returns false if the subdomain doesnt matches regex that is passed to the ctor' do
        subdomain.matches?('baz').should be_false
      end

      it 'can handle the xip.io format' do
        subdomain = Ress::Subdomain::RegexpSubdomain.new(/^([0-9]+\.){3}([0-9]+)/)
        subdomain.matches?('172.30.251.3').should be_true

        subdomain.matches?('mobile.172.30.251.3').should be_false
      end
    end

    describe '#url' do

      let(:subdomain) { Ress::Subdomain::RegexpSubdomain.new(/^[fb]oo/) }

      it 'echos back the url for cannonical requests' do
        subdomain.url('http://', 'foo.bar.com/some/stuff', 'foo').should ==
        'http://foo.bar.com/some/stuff'
      end

      it 'strips off prepended subdomains that dont matche the regex' do
        subdomain.url('http://', 'm.a.foo.bar.com/some/stuff', 'm.a.foo').should ==
        'http://foo.bar.com/some/stuff'
      end

      it 'can handle empty subdomains' do
        subdomain = Ress::Subdomain::RegexpSubdomain.new(/^(?!(m|tablet)).*$/)
        subdomain.matches?('').should be_true
        subdomain.url('http://', 'somewhere.com/some/stuff', '').should eq 'http://somewhere.com/some/stuff'
        subdomain.url('http://', 'm.somewhere.com/some/stuff', 'm').should eq 'http://somewhere.com/some/stuff'
      end

    end
  end
end