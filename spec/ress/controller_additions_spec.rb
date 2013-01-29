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

    it 'prepends view paths of matching alternate_versions' do
      category = stub('category', :matches? => true, :view_path => 'foo/bar')
      Ress.stub(:alternate_versions => [category])

      controller.should_receive(:prepend_view_path).with('foo/bar')
      controller.prepend_category_view_path
    end

    it 'does not prepend view paths of alternate_versions that dont match' do
      category = stub('category', :matches? => false, :view_path => 'foo/bar')
      Ress.stub(:alternate_versions => [category])

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
      Ress.canonical_version.stub(:matches? => true)
      controller.canonical_request?.should be_true
    end

  end

  describe '#force_canonical_url' do

    let(:controller) { ActionControllerStub.new }

    before do
      @request = stub({
        :subdomain => 'foo',
        :host_with_port => 'foo.bar.com',
        :protocol => 'http://'
      })
      controller.stub(:request => @request)
    end

    it 'appends params to the current url properly if there are no GET params' do
      @request.stub(:fullpath => '/some_place')
      controller.force_canonical_url.should == 'http://bar.com/some_place?force=1'
    end

    it 'appends params to the current url properly when there are GET params' do
      @request.stub(:fullpath => '/some_place?param=something')
      controller.force_canonical_url.should == 'http://bar.com/some_place?param=something&force=1'
    end

  end

end