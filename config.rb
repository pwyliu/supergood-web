# Middleman config
activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'supergood.work'
  s3_sync.region                     = 'us-east-1'
  s3_sync.aws_access_key_id          = ENV['AWS_ACCESS_KEY_ID']
  s3_sync.aws_secret_access_key      = ENV['AWS_SECRET_ACCESS_KEY']
  s3_sync.delete                     = true
  s3_sync.after_build                = false
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = true
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
  s3_sync.prefix                     = ''
  s3_sync.version_bucket             = false
  s3_sync.index_document             = 'index.html'
  s3_sync.error_document             = 'index.html' # there's no error page right now
end

caching_policy 'text/html', max_age: 0, must_revalidate: true

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
  cdn.filter            = /\.html/i
  cdn.after_build       = false 
end

configure :development do
  set :debug_assets, true
end

configure :build do
  activate :minify_css
  activate :asset_hash
end

after_s3_sync do |files_by_status|
  cdn_invalidate(files_by_status[:updated])
end
