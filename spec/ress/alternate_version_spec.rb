require_relative '../../lib/ress/alternate_version'

describe Ress::AlternateVersion do

  describe '#subdomain' do

    it 'defaults to the name of the category' do
      category = Ress::AlternateVersion.new('mobile', 'some media query')
      category.subdomain.should == 'mobile'
    end

    it 'can be overridden by an optional parameter' do
      category = Ress::AlternateVersion.new('mobile', 'some media query', :subdomain => 'foo')
      category.subdomain.should == 'foo'
    end

  end

  describe '#view_path' do

    it 'defaults to app/[NAME]_views' do
      category = Ress::AlternateVersion.new('mobile', 'some media query')
      category.view_path.should == 'app/mobile_views'
    end

    it 'can be overridden by an optional parameter' do
      category = Ress::AlternateVersion.new('mobile', 'some media query', :view_path => 'foo')
      category.view_path.should == 'foo'
    end

  end

  describe '#matches?' do

    let(:category) { Ress::AlternateVersion.new('mobile', 'some media query', :subdomain => 'foo') }

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

  describe '#link_tag' do

    let(:category) { Ress::AlternateVersion.new('mobile', 'some media query') }
    let(:view) { stub('view') }

    def link_tag(base_url, protocol, view)
      view.tag :link, :rel => 'alternate', :href => href(base_url, protocol), :id => id, :media => media_query
    end

    it 'passes args to the view tag helper' do
      view.should_receive(:tag).with(:link, {
        :rel   => "alternate",
        :href  => "http://mobile.foo.com",
        :id    => "mobile",
        :media => "some media query"
      }).and_return('<link>')
      category.link_tag('http://', 'foo.com', view).should == '<link>'
    end

  end

end