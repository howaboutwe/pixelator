Pixelator
=======

Pixelator is a Ruby on Rails plugin that allows you to easily and
asyncronously add tracking pixels (and other bits of html) to your code.


## Prerequisites

* requires jquery-rails
* requires underscore.js

## Usage

### Install the gem

`gem 'pixelator', :git => git@github.com:howaboutwe/pixelator.git`

### Run the generator

`rails g pixelator`

The generator will create 2 files for you:
* config/initializers/pixelator.rb
* config/pixels.yml
It will also add pixelator_core to your application.js file:

`//= require 'pixelator_core'`

### Add to you code

#### config/pixels.yml

pixels.yml contains a hash with the top level keys being types of
pixels, such as 'all', 'landing','sign_up', etc.

You define the keys.

Each key, has an array of pixels, which specify:

* name - name of pixel for auditing purposes
* type - img, js, iframe
* snippet - snippet of html that will be run through an underscore template

For example, a google analytics snippet that is to be shown on all pages
 and uses the google_analytics key in Pixelator.context to set the GA account number
 would look like:
```
all:
  - name: google_analytics
    type: javascript
    snippet: |
      <script type="text/javascript">
      try {
        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', '<%= google_analytics %>']);
        _gaq.push(['_trackPageview']);

        (function() {
         var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
         ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
         var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
         })();
      } catch(err) {}
      </script>
```
optionally, you can include a 'partner'


#### Layout/Views
In the head of your layout, add:

```
    = javascript_include_tag "/pixelator/data"
    = render partial: 'shared/pixelator_head'
```

In the bottom of your layout, add:

`= render partial: 'shared/pixelator', pixel_types: ['all']`

To add the Pixelator to different page, such as landing, do:

`= render partial: 'shared/pixelator', pixel_types: ['landing']`
If using the partial, you could also set the pixel types in the
controller with
`@pixel_types = ['stuff']`
*Note: this will **always** add 'all' to the array
or
```
    var pixelator = new Pixelator(PIXEL_DATA, '#{@scope}');
    _.each(#{@pixel_types}, function(p) {
    pixelator.run(p);
    });
```

## TODO

* Expand example of how to set pixel context in controller and use in pixels.yml with ERB syntax.
* Add documentation about head pixels
* JS Pixel data - should not include head and should be on Pixelator obj
* JS flag for turning on/off
* Turn off but still log each pixel that would be run
* run can take an array

* change partner to scope
* explain partner/scope
* Add Travis CI
* Add documentation about context

## Maintainers

Created by the HowAboutWe.com dev team.

* [How About We](http://www.howaboutwe.com)

* [Rebecca Miller-Webster](http://www.github.com/rmw), HowAboutWe.com
* [Marco Carag](http://www.github.com/jazzcrazed), HowAboutWe.com
* [Brendan Barr](http://www.github.com/bbarr), HowAboutWe.com

Copyright (c) 2008-2012 This Life, Inc. This software is licensed under
the MIT License
