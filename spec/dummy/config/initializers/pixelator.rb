Pixelator.configure do |c|
  c.config_file = Rails.root.join('config/pixels.yml')
  #c.run_envs << 'test'
end

#add contextual data that the pixelator might need
#  such as google analytics ...
#reference in pixels.yml snippet with
#  <%= google_analytics %>
Pixelator.context[:google_analytics] = 'GA_ACCOUNT'
