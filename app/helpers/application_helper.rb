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
        when :notice then "bg-red-500"
        when :alert  then "bg-red-500"
        when :error  then "bg-yellow-500"
        else "bg-gray-500"
        end
      end  

      def flash_color(type)
        case type
        when "notice"
          "success"  # 成功: 緑色
        when "alert"
          "error"    # エラー: 赤色
        else
          "info"     # その他の情報: 青色
        end
      end

      def flash_class(type)
        case type
        when "notice"
          "info"  # 青色
        when "alert"
          "error" # 赤色
        else
          "info"  # デフォルトは青色
        end
      end

      
end
