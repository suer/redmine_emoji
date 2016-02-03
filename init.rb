require 'emoji_filter'

Redmine::Plugin.register :redmine_emoji_filter do
  name 'Redmine Emoji Filter plugin'
  author 'suer'
  description 'This is a plugin for Redmine to add emoji'
  version '0.0.1'
  url 'https://github.com/suer/redmine_emoji_filter'
  author_url 'https://d.hatena.ne.jp/suer'
end

Rails.configuration.to_prepare do
  Rails.configuration.assets.paths << Emoji.images_path
  Redmine::WikiFormatting.format_names.each do |format_name|
    formatter = Redmine::WikiFormatting.formatter_for(format_name)
    formatter.send(:include, EmojiFilter::Patch) unless formatter.included_modules.include? EmojiFilter::Patch
  end
end
