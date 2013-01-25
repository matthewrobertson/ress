require_relative '../../lib/ress/device_category'

describe Ress::DeviceCategory do

  describe '#subdomain' do

    it 'defaults to the name of the category' do
      category = Ress::DeviceCategory.new('mobile', 'some media query')
      category.subdomain.should == 'mobile'
    end

    it 'can be overridden by an optional parameter' do
      category = Ress::DeviceCategory.new('mobile', 'some media query', :subdomain => 'foo')
      category.subdomain.should == 'foo'
    end

  end

  describe '#view_path' do

    it 'defaults to something' do
      category = Ress::DeviceCategory.new('mobile', 'some media query')
      category.view_path.should == 'app/mobile_views'
    end

    it 'can be overridden by an optional parameter' do
      category = Ress::DeviceCategory.new('mobile', 'some media query', :view_path => 'foo')
      category.view_path.should == 'foo'
    end

  end

  describe '#matches?' do

    let(:category) { Ress::DeviceCategory.new('mobile', 'some media query', :subdomain => 'foo') }

    it 'returns true if the subdomain matches' do
      category.matches?('foo').should be_true
    end

    it 'returns false if the subdomain does not match' do
      category.matches?('bar').should be_false
    end

    context 'when there are multiple subdomains' do

      it 'returns true if the first subdomain matches' do
        category.matches?('foo.bar').should be_true
      end

      it 'returns false if the first subdomain does not match' do
        category.matches?('bar.baz').should be_false
      end

    end

  end

  describe '#add_subdomain' do

    let(:category) { Ress::DeviceCategory.new('mobile', 'some media query', :subdomain => 'foo') }

    it 'prepends the subdomain to the url' do
      category.add_subdomain('bar.com').should == 'foo.bar.com'
    end
  end

end