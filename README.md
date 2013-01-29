# Ress

A system for building mobile optimized Rails applications using semantic,
media query-based device detection and server side progressive enhancement.

## Background

Ress is an extension of the [devicejs](https://github.com/borismus/device.js)
library written by [Boris Smus](http://smus.com/). It adds a back end for
adapting server responses based on client side feature detection. Ress allows
you to specify alternate versions of your website, along with media queries
for which devices should be redirected to which version.

## How it Works

### HTML Annotations

When you register alternate mobile versions of your website, Ress adds annotations
to the `<head>` of your document that describes where these pages are located and
which devices should be redirected to them.

For example, a typical alternate version for a mobile site might include a tag
like this:

```html
<link rel="alternate" media="only screen and (max-width: 640px)" href="http://m.example.com/page-1" >
```

The mobile version of the page would then have a link pointing back the canonical
version:

```html
<link rel="canonical" href="http://www.example.com/page-1" >
```

These annotations conform to SEO best practices for mobile optimized websites
as documented by Google
[here](https://developers.google.com/webmasters/smartphone-sites/details).

### Feature Detection

Device.js will read all of the version links in your markup, and
redirect you to the appropriate URL that serves the correct version of
your webapp.

When a request comes into your site, ress runs a some javascript to determine
if there is an alternate version available that matches the client. If there
is, the user is redirected to the url for that version.

### Server Side Components

Ress allows you to customize how your Rails application responds to requests in
two ways:

1. It adds controller and helper methods to detect which version of your site has
been requested. This is useful for small tweeks in html or behaviour, eg:

```erb
<% if mobile_request? %>
  <%= image_tag 'low-res.png' %>
<% else %>
  <%= image_tag 'high-res.png' %>
<% end %>
```

2. It prepends a view path for each alternate version of your site, so that you can
override which templates or partials are rendered for certain requests. For example if
you want to render a different html form for creating users on the mobile version of your
site you could create `app/mobile_views/users/_form.html.erb` and Ress would have Rails
select that template over `app/views/users/_form.html.erb` when a request comes in to the
mobile version.


## Installation

Add this line to your application's Gemfile:

    gem 'ress'

And then execute:

    $ bundle install

Run the installation generator:

    $ rails g ress:install

## Usage

### Version override

You can manually override the detector and load a particular version of
the site by passing in the `device` GET parameter with the ID of the
version you'd like to load. This will look up the `link` tag based on
the specified ID and load that version. For example, if you are on
desktop but want the tablet version, visiting
`http://foo.com/?version=tablet` will redirect to the tablet version at
`http://tablet.foo.com`.

Relatedly, you can prevent redirection completely, by specifying the
`force=1` GET parameter. For example, if you are on desktop and know the
URL of the tablet site, you can load `http://tablet.foo.com/?force=1`.

```html
<!-- Include a way to manually switch between device types -->
<footer>
  <ul>
    <li><a href="?device=desktop">Desktop</a></li>
    <li><a href="?device=tablet">Tablet</a></li>
    <li><a href="?device=phone">Phone</a></li>
  </ul>
</footer>
```

### Dependencies

TODO: Document Modernizr Dependency

## Performance considerations

The javascript included by Ress does some checks and will use client-side
redirection to point users to the right version of your webapp. Client-side
redirection can have a performance overhead (though I haven't measured it).
If you find this is true, you can keep your DOM the same, still using the
SEO-friendly `<link rel="alternate">` tags, but simply remove the
ress.js script and do your own server-side UA-based pushing.

## Browser support

Device.js should work in all browsers that support
`document.querySelectorAll`. Notably, this excludes IE7. If you want it
to work in IE7 and below, please include a [polyfill](https://gist.github.com/2724353).

## Contributing

Given how many browsers and devices we have these days, there are bound
to be bugs. If you find them, please report them and (ideally) fix them
in a pull request.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request