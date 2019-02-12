# Open Essential Content

Open Essential Content is a fully featured CMS with pages, contents, images and more. It has a blog complete with archives, categories, tags and related products. base for many content related extensions for Open. It also provides an asset-upload interface.

This is a fork of the excellent [spree_essential_content][1] gem by @FineLineAutomation. The changes to the gem are:
* Add translations.
* Add ActiveStorage support.
* Use rspec and open's native test_app rake task instead of Test:Unit and dummier
* No longer including the markdown editor. It's easier to use the spree_editor gem and set up a rich text editor like TinyMCE.
* We have merged all the spree_essential gems into this one. Since many people actually install all 3 gems to begin with, there is no need to continue to keep them seperate. This decision was made in the interest of maintainability.

------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------

If you don't already have an existing Open site, [click here](https://github.com/99cm/open) then come back later.

Open Essential Content can be installed by itself by adding the following to your Gemfile:

```ruby
gem 'open_essential_content', github: '99cm/open_essential_content'
```

Then run:

```bash
bundle install
```

Once that's complete, run the migration generator and migrate your database:

Now run the generator to install the extension.

```bash
rails g open_essential_content:install
```

Then migrate your database:

```bash
rake db:migrate
```

If that all went smoothly, you should be ready to boot the server with:

```bash
rails s
```

Now login to the admin and click on the 'Content' tab!

------------------------------------------------------------------------------
Notes
------------------------------------------------------------------------------

Open Essential Content is under constant development... Development is being done on OSX with Ruby 2.5.3 and usually the latest version of Open.

Please let me know if you find any bugs or have feature requests you'd like to see.

------------------------------------------------------------------------------
Testing
------------------------------------------------------------------------------

In order for you to test, you need to have FireFox installed on your computer.  If you don't you will get an error on all of the tests that require javascript support.

The test suite can be run like so:

```bash
git clone git://github.com/99cm/open_essential_content.git
cd open_essential_content
bundle install
bundle exec rake test_app
bundle exec rspec
```

------------------------------------------------------------------------------
To Do
------------------------------------------------------------------------------

* better documentation (you know you want to help!)

------------------------------------------------------------------------------
License
------------------------------------------------------------------------------

Copyright (c) 2019 [Leo Wang][2], and other [contributors][3], released under the [New BSD License][4]. All rights reserved.

[1]: https://github.com/FineLineAutomation/spree_essential_content
[2]: https://github.com/99cm
[3]: https://github.com/99cm/open_essential_content/graphs/contributors
[4]: https://github.com/99cm/open_essential_content/blob/master/LICENSE