require 'rspec'
require_relative '../../lib/ress'

describe ActionView::Base do

  describe '#ress_category_tag' do

    let(:view) { ActionView::Base.new }
    let(:request) { stub('request', :protocol => 'http://') }
    let(:category) { stub('category', :id => 'm', :media_query => 'stuff') }

    before do
      view.stub(:request => request)
    end

    it 'generates the href from the category' do
      category.should_receive(:add_subdomain).and_return('m.foo/bar')
      view.ress_category_tag(category, 'foo/bar').should ==
        "<link href=\"http://m.foo/bar\" id=\"m\" media=\"stuff\" rel=\"alternate\" />"
    end

  end

end