module ApplicationHelper

  def profile_img(user)
    # binding.pry
    # carrierwaveでアップロードした画像を表示させる
    return image_tag(user.avatar, alt: user.name, class:"profile") if user.avatar?

    unless user.provider.blank? #snsから取得した画像があるかどうか
      img_url = user.image_url #ある場合はユーザーテーブルのimage_urlカラムを引っ張ってくる
    else
      img_url = 'no_image.png' #ない場合は適当な画像を割り当てる

      # binding.pry
    end

    # user.avatar = img_url
    #アップロードした画像の表示
    image_tag(img_url,alt:user.name,class:"profile")
  end

end

module ActionView
  module Helpers
    module FormHelper
      def error_messages!(object_name, options = {})
        resource = self.instance_variable_get("@#{object_name}")
        return '' if !resource || resource.errors.empty?

        messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

        html = <<-HTML
          <div class="alert alert-danger">
            <ul>#{messages}</ul>
          </div>
        HTML

        html.html_safe
      end

      def error_css(object_name, method, options = {})
        resource = self.instance_variable_get("@#{object_name}")
        return '' if resource.errors.empty?

        resource.errors.include?(method) ? 'has-error' : ''
      end
    end

    class FormBuilder
      def error_messages!(options = {})
        @template.error_messages!(@object_name, options.merge(object: @object))
      end

      def error_css(method, options = {})
        @template.error_css(@object_name, method, options.merge(object: @object))
      end
    end
  end
end
