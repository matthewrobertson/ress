require "action_view"

require "ress/version"
require "ress/subdomain"
require "ress/alternate_version"
require "ress/canonical_version"
require "ress/config"
require "ress/controller_additions"
require "ress/view_helpers"

if defined? Rails
  require "ress/engine"
end

module Ress
  extend self

  def config
    @categories ||= Config.new
  end

  def canonical_version
    config.canonical_version
  end

  def alternate_versions
    config.alternate_versions
  end

  def include_modernizr?
    config.include_modernizr
  end

  def configure
    yield(config)
  end

end
