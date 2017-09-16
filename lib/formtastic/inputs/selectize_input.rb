module Formtastic
  module Inputs
    class SelectizeInput < Formtastic::Inputs::SelectInput
      include Formtastic::Inputs::Base

      def input_html_options
        opts = super
        opts[:class] = opts[:class].blank? ? 'selectized' : ( opts[:class] + ' selectized' )
        opts
      end

      # def collection
      #   if !options[:collection] && column
      #     object.send( column.name ).map { |row| [ row.respond_to?( :name ) ? row.name : row.to_s, row.id ] }
      #   else
      #     super
      #   end
      # end
    end
  end
end
