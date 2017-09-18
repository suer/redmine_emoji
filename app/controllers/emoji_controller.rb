class EmojiController < ActionController::Base
  def index
    filename = "#{params[:name]}.png"
    send_file(File.join(Emoji.images_path, "emoji/#{filename}"), :filename => filename)
  end
end
