module ApplicationHelper
    def drug_class(drug)
        case drug.category
        when 'high'
          'text-red-600 hover:text-red-900'
        when 'medium'
          'text-yellow-600 hover:text-yellow-900'
        when 'low'
          'text-green-600 hover:text-green-900'
        else
          'text-indigo-600 hover:text-indigo-900'
        end
      end

      def flash_background_color(type)
        case type.to_sym
        when :notice then "bg-green-500"
        when :alert  then "bg-red-500"
        when :error  then "bg-yellow-500"
        else "bg-gray-500"
        end
      end

      
end
