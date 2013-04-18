require 'rspec'
require_relative '../../lib/ress'

describe ActionView::Base do

  describe '#ress_annotation_tags' do

    let(:view) { ActionView::Base.new }
    let(:request) { stub('request', :protocol => 'http://', :host_with_port => 'x.foo.com', :fullpath => '/bar', :subdomain => 'x') }
    let(:category) { Ress::AlternateVersion.new('m', 'stuff') }

    before do
      view.stub(
        :request => request,
        :javascript_include_tag => '<script src="/assets/ress_modernizr_build.js" type="text/javascript"></script>'.html_safe
      )
    end

    context 'alternate request' do

      before { view.stub(:canonical_request? => false) }

      it 'returns the canonical link' do
        view.ress_annotation_tags.should == "<link href=\"http://foo.com/bar\" rel=\"canonical\" />"
      end

      it 'adds a script tag for Modernizr if required' do
        Ress.stub(:include_modernizr? => true)
        view.ress_annotation_tags.should ==
        "<link href=\"http://foo.com/bar\" rel=\"canonical\" /><script src=\"/assets/ress_modernizr_build.js\" type=\"text/javascript\"></script>"
      end

    end

    context 'canonical request' do

      let(:request) { stub('request', :protocol => 'http://', :host_with_port => 'foo.com', :fullpath => '/bar', :subdomain => '') }
      before { view.stub(:canonical_request? => true) }

      context 'with no alternate versions' do
        it 'returns an empty string' do
          view.ress_annotation_tags.should == ''
        end
      end

      context 'with one alternate version' do
        before(:all) { Ress.configure { |r| r.add_alternate :name => 'm', :media => 'stuff' } }

        it 'generates the link tags when there is one category' do
          view.ress_annotation_tags.should ==
            "<link href=\"http://m.foo.com/bar\" id=\"m\" media=\"stuff\" rel=\"alternate\" />"
        end

        it 'replaces the canonical subdomain when configured' do
          request.stub(:host_with_port => 'www.foo.com', :subdomain => 'www')
          Ress.stub(:replace_canonical_subdomain? => true )
          view.ress_annotation_tags.should ==
          "<link href=\"http://m.foo.com/bar\" id=\"m\" media=\"stuff\" rel=\"alternate\" />"
        end

      end

    end

    context 'with fullpath argument' do
      let(:request) { stub('request', :protocol => 'http://', :host_with_port => 'foo.com', :fullpath => '/bar', :subdomain => '') }
      before { view.stub(:canonical_request? => true) }

      it 'gerenates the link tags using the fullpath argument instead' do
        view.ress_annotation_tags(:fullpath => '/notbar').should ==
          "<link href=\"http://m.foo.com/notbar\" id=\"m\" media=\"stuff\" rel=\"alternate\" />"
      end
    end

  end

end