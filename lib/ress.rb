require "action_view"

require "ress/version"
require "ress/alternate_version"
require "ress/canonical_version"
require "ress/category_collection"
require "ress/controller_additions"
require "ress/view_helpers"

if defined? Rails
  require "ress/engine"
end

module Ress
  extend self

  def category_collection
    @categories ||= CategoryCollection.new
  end

  def canonical_version
    category_collection.canonical_version
  end

  def alternate_versions
    category_collection.alternate_versions
  end

  def configure
    yield(category_collection)
  end

end
