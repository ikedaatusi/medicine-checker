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

      def default_meta_tags
        {
          site: 'medicine-checker',
          title: '服用管理サービス',
          reverse: true,
          charset: 'utf-8',
          description: '大切な家族の服用記録をすることができる。',
          keywords: '福祉,介護',
          canonical: request.original_url,
          separator: '|',
          og: {
            site_name: :site,
            title: :title,
            description: :description,
            type: 'website',
            url: request.original_url,
            image: image_url('mdc.png'), # 配置するパスやファイル名によって変更すること
            local: 'ja-JP'
          },
          # Twitter用の設定を個別で設定する
          twitter: {
            card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
            site: '@', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
            image: image_url('mdc.png') # 配置するパスやファイル名によって変更すること
          }
        }
      end
end
