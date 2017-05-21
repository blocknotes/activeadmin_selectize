# ActiveAdmin Selectize [![Gem Version](https://badge.fury.io/rb/activeadmin_selectize.svg)](https://badge.fury.io/rb/activeadmin_selectize)

An Active Admin plugin to use [Selectize.js](http://selectize.github.io/selectize.js) (jQuery required).

Features:
- nice select inputs
- items search
- AJAX content loading
- improve many-to-many / one-to-many selection

## Install

- Add to your Gemfile:
`gem 'activeadmin_selectize'`
- Add _jquery-rails_ gem or include jQuery manually
- Execute bundle
- Add at the end of your ActiveAdmin styles (_app/assets/stylesheets/active_admin.scss_):
`@import 'activeadmin/selectize_input';`
- Add at the end of your ActiveAdmin javascripts (_app/assets/javascripts/active_admin.js_):
```css
//= require activeadmin/selectize/selectize
//= require activeadmin/selectize_input
```
- Use the input with `as: :selectize` in Active Admin model conf

Why 2 separated scripts? In this way you can include a different version of Selectize.js if you like.

## Example

Example 1: an Article model with a many-to-many relation with Tag model:

```ruby
class Article < ApplicationRecord
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags
end
```

```ruby
# ActiveAdmin article form conf:
  form do |f|
    f.inputs 'Article' do
      f.input :title
      f.input :description
      f.input :published
      f.input :tags, as: :selectize, collection: f.object.tags, input_html: { 'data-opt-remote': admin_tags_path( format: :json ), 'data-opt-text': 'name', 'data-opt-value': 'id', 'data-opt-highlight': 'true', placeholder: 'Search a tag...' }
    end
    f.actions
  end
```

## Options

Pass the required options using `input_html`.

- **data-opt-remote**: URL used for AJAX search requests (method GET)
- **data-opt-text**: field to use as option label
- **data-opt-value**: field to use as select value
- **data-opt-NAME**: option _NAME_ passed directly to Selectize.js - see [options](https://github.com/selectize/selectize.js/blob/master/docs/usage.md#configuration)

## Contributors

- [Mattia Roccoberton](http://blocknot.es) - creator, maintainer

## License

[MIT](LICENSE.txt)
