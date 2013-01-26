require 'rspec'
require_relative '../../lib/ress'

describe ActionView::Base do

  describe '#ress_category_tag' do

    let(:view) { ActionView::Base.new }
    let(:request) { stub('request', :protocol => 'http://') }
    let(:category) { Ress::DeviceCategory.new('m', 'stuff') }

    before do
      view.stub(:request => request)
    end

    it 'generates the href from the category' do
      view.ress_category_tag(category, 'foo/bar').should ==
        "<link href=\"http://m.foo/bar\" id=\"m\" media=\"stuff\" rel=\"alternate\" />"
    end

  end

end