require_relative '../../lib/ress/controller_additions'

class ActionControllerStub

  attr_accessor :request

  def self.before_filter(action)
    @@action = action
  end

  def self.action
    @@action
  end

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

end