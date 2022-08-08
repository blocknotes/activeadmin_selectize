module ActiveAdmin
  module Inputs
    module Filters
      class SelectizeInput < ::ActiveAdmin::Inputs::Filters::SelectInput
        def input_html_options
          super.merge('data-selectize-input': '1')
        end
      end
    end
  end
end
