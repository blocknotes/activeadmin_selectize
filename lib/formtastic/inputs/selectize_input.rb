# frozen_string_literal: true

module Formtastic
  module Inputs
    class SelectizeInput < Formtastic::Inputs::SelectInput
      include Formtastic::Inputs::Base

      def input_html_options
        super.merge('data-selectize-input': '1')
      end
    end
  end
end
