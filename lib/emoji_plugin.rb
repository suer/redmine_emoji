module EmojiPlugin
  module Patch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method_chain :to_html, :emoji
      end
    end

    module InstanceMethods
      def to_html_with_emoji
        html = to_html_without_emoji
        html.gsub(/:([^:\s]+):/) do |match|
          icon = $1
          if Emoji.names.include?(icon)
            %(<img src="#{ Rails.application.routes.url_helpers.url_for(:controller => :emoji, :action => :index, :name => icon, :only_path => true)}" style="width:16px" title="#{icon}" alt="#{icon}"/>)
          else
            match
          end
        end
      end
    end
  end

  class Listener < Redmine::Hook::ViewListener
    render_on :view_layouts_base_content, :partial=> 'hooks/emoji_view_layouts_base_content'
  end
end
