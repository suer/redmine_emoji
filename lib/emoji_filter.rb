module EmojiFilter
  module Patch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        include ActionView::Helpers::AssetUrlHelper
        alias_method_chain :to_html, :emoji
      end
    end

    module InstanceMethods
      def to_html_with_emoji
        html = to_html_without_emoji
        html.gsub(/:([^:\s]+):/) do |match|
          icon = $1
          if Emoji.names.include?(icon)
            %(<img src="#{image_url("emoji/#{icon}.png")}" style="width:16px" title="#{icon}" alt="#{icon}"/>)
          else
            match
          end
        end
      end
    end
  end
end
