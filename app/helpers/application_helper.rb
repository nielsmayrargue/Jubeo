require 'cgi'

module ApplicationHelper

	#def embeded_video(url, options = {})
	#	params = CGI::parse(URI.parse(url).query)
	#	id = params["v"].first
	#	embeded_url = "//www.youtube.com/embed/#{id}"
	#	content_tag :iframe, nil, options.merge(src: embeded_url)
	#end

  def embed_video(video_url, options = {})
    if video_url.include?("youtube")
      begin
        embeded_video = OEmbed::Providers::Youtube.get(video_url).html
        embeded_video = embeded_video.sub!(/width=\"\d{1,}/, "width=\"#{options[:width]}")
        embeded_video = embeded_video.sub!(/height=\"\d{1,}/, "height=\"#{options[:height]}")
        embeded_video = embeded_video.html_safe
      rescue Exception => exc
        "Désolé, Aucune vidéo n'a été trouvée !"
      end
    elsif video_url.include?("vimeo")
      begin
        embeded_video = OEmbed::Providers::Vimeo.get(video_url).html
        embeded_video = embeded_video.sub!(/width=\"\d{1,}/, "width=\"#{options[:width]}")
        embeded_video = embeded_video.sub!(/height=\"\d{1,}/, "height=\"#{options[:height]}")
        embeded_video = embeded_video.html_safe
      rescue Exception => exc
        "Désolé, Aucune vidéo n'a été trouvée !"
      end
    end
  end

  def video_thumbnail(video_url)
    if video_url.include?("youtube")
      begin
        video_resource = OEmbed::Providers::Youtube.get(video_url)
        video_resource.thumbnail_url
      rescue Exception => exc
        "mind.svg"
      end
    elsif video_url.include?("vimeo")
      begin
        video_resource = OEmbed::Providers::Vimeo.get(video_url)
        video_resource.thumbnail_url
      rescue Exception => exc
        "mind.svg"
      end
    end
  end

	def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end


