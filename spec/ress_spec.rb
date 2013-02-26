require_relative '../lib/ress'

describe Ress do

  describe '.configure' do

    it 'yields the default category collection' do
      Ress.configure { |r| r.should be_a(Ress::Config) }
    end

  end

  describe '.canonical_version' do

    it 'returns a Ress::CanonicalVersion' do
      Ress.canonical_version.should be_a(Ress::CanonicalVersion)
    end

    it 'can be altered through Ress.configure' do
      Ress.configure { |r| r.set_canonical :subdomain => 'foo' }
      Ress.canonical_version.matches?('foo').should be_true
    end

  end

  describe '.alternate_versions' do

    it 'can be altered through Ress.configure' do
      expect {
        Ress.configure { |r| r.add_alternate :name => 'foo' }
      }.to change {
        Ress.alternate_versions.length
      }.by(1)
    end

  end

  describe '.include_modernizr?' do

    it 'defaults to false' do
      Ress.include_modernizr?.should be_false
    end

    it 'can be altered through Ress.configure' do
      Ress.configure { |r| r.include_modernizr = true }
      Ress.include_modernizr?.should be_true

      Ress.configure { |r| r.include_modernizr = false }
      Ress.include_modernizr?.should be_false
    end

  end

  describe '.replace_canonical_subdomain?' do

    it 'defaults to false' do
      Ress.replace_canonical_subdomain?.should be_false
    end

    it 'can be altered through Ress.configure' do
      Ress.configure { |r| r.replace_canonical_subdomain = true }
      Ress.replace_canonical_subdomain?.should be_true

      Ress.configure { |r| r.replace_canonical_subdomain = false }
      Ress.replace_canonical_subdomain?.should be_false
    end

  end

end