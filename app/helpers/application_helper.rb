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
end
