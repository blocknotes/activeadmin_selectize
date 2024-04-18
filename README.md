# PROJECT UNMAINTAINED

> *This project is not maintained anymore*
>
> *If you like it or continue to use it fork it please.*

---

# ActiveAdmin Selectize
[![gem version](https://badge.fury.io/rb/activeadmin_selectize.svg)](https://badge.fury.io/rb/activeadmin_selectize) [![gem downloads](https://badgen.net/rubygems/dt/activeadmin_selectize)](https://rubygems.org/gems/activeadmin_selectize) [![linters](https://github.com/blocknotes/activeadmin_selectize/actions/workflows/linters.yml/badge.svg)](https://github.com/blocknotes/activeadmin_selectize/actions/workflows/linters.yml) [![specs](https://github.com/blocknotes/activeadmin_selectize/actions/workflows/specs.yml/badge.svg)](https://github.com/blocknotes/activeadmin_selectize/actions/workflows/specs.yml)

An Active Admin plugin to use [Selectize.js](http://selectize.github.io/selectize.js) (jQuery required).

Features:
- nice select inputs;
- items search;
- AJAX content loading;
- improve many-to-many / one-to-many selection.

## Install

- Add to your Gemfile:
`gem 'activeadmin_selectize'`
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

## Examples

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

Example 2: using selectize in filters:

```ruby
# Without remote items (no AJAX):
filter :name_eq, as: :selectize, collection: Author.all.pluck( :name, :name )
# With remote items:
filter :tags_id_eq, as: :selectize, collection: [], input_html: { 'data-opt-remote': '/admin/tags.json', 'data-opt-text': 'name', 'data-opt-value': 'id', 'data-opts': '{"dropdownParent":"body"}', placeholder: 'Search a tag...' }
```

## Notes

- In ActiveAdmin json routes should be enabled by default, this behavior is controlled by *download_links* option for index action. Example:

```rb
index download_links: [:csv, :json] do
  # ...
end
```

You can customize the JSON response overriding the *as_json* method of the model:

```rb
def as_json( options = nil )
  super({ only: [:id], methods: [:fullname] }.merge(options || {}))
end
```

- If the select items "gets cut" by the container try adding: `'data-opts': '{"dropdownParent":"body"}'`

- Alternative syntax to pass data attributes: `input_html: { data: { opts: '{}' } }`

- To use this plugins with ActiveAdmin 1.x please use the version 0.1.6

## Options

Pass the required options using `input_html`.

- **data-opt-remote**: URL used for AJAX search requests (method GET)
- **data-opt-text**: field to use as option label
- **data-opt-value**: field to use as select value
- **data-opt-NAME**: option _NAME_ passed directly to Selectize.js - see [options](https://github.com/selectize/selectize.js/blob/master/docs/usage.md#configuration)

Alternative syntax:

- **data-opts**: overrides Selectize options - example: `'data-opts': '{"highlight":true,"plugins":[]}'`

## Do you like it? Star it!

If you use this component just star it. A developer is more motivated to improve a project when there is some interest. My other [Active Admin components](https://github.com/blocknotes?utf8=✓&tab=repositories&q=activeadmin&type=source).

Or consider offering me a coffee, it's a small thing but it is greatly appreciated: [about me](https://www.blocknot.es/about-me).

## Contributors

- [Mattia Roccoberton](http://blocknot.es): author

## License

[MIT](LICENSE.txt)
