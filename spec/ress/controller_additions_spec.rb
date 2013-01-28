require_relative '../../lib/ress'

class ActionControllerStub

  attr_accessor :request

  def self.before_filter(action)
    @@action = action
  end

  def self.action
    @@action
  end

  def self.helper_method(*splat) ; end

end

ActionControllerStub.class_eval do
  include Ress::ControllerAdditions
end

describe Ress::ControllerAdditions do

  it 'adds a before_filter to all actions when it is included' do
    ActionControllerStub.action.should == :prepend_category_view_path
  end

  describe '#prepend_category_view_path' do

    let(:controller) { ActionControllerStub.new }

    before do
      request = stub('request', :subdomain => 'foo')
      controller.request = request
    end

    it 'prepends view paths of matching categories' do
      category = stub('category', :matches? => true, :view_path => 'foo/bar')
      Ress.stub(:categories => [category])

      controller.should_receive(:prepend_view_path).with('foo/bar')
      controller.prepend_category_view_path
    end

    it 'does not prepend view paths of categories that dont match' do
      category = stub('category', :matches? => false, :view_path => 'foo/bar')
      Ress.stub(:categories => [category])

      controller.should_not_receive(:prepend_view_path)
      controller.prepend_category_view_path
    end

  end

  describe '#canonical_request?' do

    let(:controller) { ActionControllerStub.new }

    before do
      request = stub(:subdomain => 'foo')
      controller.stub(:request => request)
    end

    it 'returns true if the request subdomain matches the canonical' do
      Ress.categories.canonical_version.stub(:matches? => true)
      controller.canonical_request?.should be_true
    end

  end

end