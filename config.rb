activate :cdn do |cdn|
  cdn.cloudflare = {
    client_api_key: ENV['CLOUDFLARE_CLIENT_API_KEY'],
    email: ENV['CLOUDFLARE_EMAIL'],
    zone: 'supergood.work',
    base_urls: [
      'http://supergood.work',
      'https://supergood.work',
    ]
  }
  cdn.filter            = /.*/
  cdn.after_build       = false 
end

configure :development do
  set :debug_assets, true
end

configure :build do
  activate :minify_css
  activate :asset_hash
end
