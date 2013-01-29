# Use this file to configure alternate versions of your application. Be sure to
# restart your server whenever you make changes.
Ress.configure do |config|


  # == Canonical Subdomain
  #
  # If the cannonical version of your application is served under a subdomain
  # you must set it here:
  #
  # config.set_canonical :subdomain => "subdomain"


  # == Modernizr
  #
  # There are a couple of Modernizr features that must be included in order for
  # Ress's javascript feature detection to function. If you are not already
  # using Modernizr in your app you can automatically include a build that has
  # been packaged with the gem by setting the below flag to true. If you include
  # your own build (recommended), ensure that you include "Touch Events" and
  # "Media Queries", eg:
  #
  # http://modernizr.com/download/#-touch-mq-teststyles-prefixes
  #
  # config.include_modernizr = false


  # == Adding Alternate Site Versions
  #
  # You can register multiple alternate versions of your app by making calls to
  # "config.add_alternate". For example:
  #
  # The following will add an alternate version served under
  # "mobile.your_domain.com" and redirect devices with screens smaller than
  # 640px wide to that version. On the server, it will prepend
  # "app/mobile_views" to the view_paths, so templates there will take
  # precedence over those in "app/views" and add `mobile_request?` controller /
  # helper method to your application.
  #
  # config.add_alternate({
  #  :name  => 'mobile',
  #  :media => 'only screen and (max-width: 640px)'
  # })
  #
  # You can configure the subdomain of a version by passing the ":subdomain"
  # option to "add_alternate". For example, the below will serve the mobile
  # version under "m.your_domain.com" but will still call the controller /
  # helper method `mobile_request?` and prepend "app/mobile_views" to the
  # view_paths
  #
  # config.add_alternate({
  #  :name      => 'mobile',
  #  :media     => 'only screen and (max-width: 640px)',
  #  :subdomain => 'm'
  # })
  #
  # By default the view_path added for a version is generated from the version
  # name "app/#{name}_views". You may change this path by passing the
  # ":view_path" option, eg:
  #
  # config.add_alternate({
  #  :name      => 'mobile',
  #  :media     => 'only screen and (max-width: 640px)',
  #  :view_path => Rails.root.join('lib', 'mobile_views')
  # })

end