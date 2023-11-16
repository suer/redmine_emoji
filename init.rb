Redmine::Plugin.register :redmine_emoji do
  name 'Redmine Emoji plugin'
  author 'suer'
  description 'This is a plugin for Redmine to add emoji'
  version '0.0.2'
  url 'https://github.com/suer/redmine_emoji'
  author_url 'https://d.hatena.ne.jp/suer'
end

Rails.configuration.to_prepare do
  Rails.configuration.assets.paths << Emoji.images_path
  Redmine::WikiFormatting.format_names.each do |format_name|
    formatter = Redmine::WikiFormatting.formatter_for(format_name)
    formatter.prepend(EmojiPlugin::FormatterWithEmoji)
  end
end
