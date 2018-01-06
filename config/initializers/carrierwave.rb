# S3を使用しているかを判定するためのメソッド。
# def use_s3?
#   ENV['S3_ACCESS_KEY'] && ENV['S3_SECRET_KEY'] && ENV['S3_REGION'] && ENV['S3_BUCKET']
# end

## CarrierWaveの設定
CarrierWave.configure do |config|
  # S3の設定
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET_KEY'],
      :region                 => ENV['S3_REGION'],
      # :host                   => '必要なら設定する'
      # :endpoint               => '必要なら設定する'
  }

  # S3のバケットを指定。
  case Rails.env
    when 'production'
        config.fog_directory  = ENV['S3_BUCKET']
    when 'staging'
        config.fog_directory  = ENV['S3_BUCKET']
    when 'development'
        config.fog_directory  = ENV['S3_BUCKET']
    when 'test'
        config.fog_directory  = ENV['S3_BUCKET']
  end

  # 一般公開させて無いS3の場合は以下の設定を行う。
  config.fog_public = true
  # 一般公開されていない場合は以下の設定をする事で60秒間有効なURLを発行してくれる。
  config.fog_authenticated_url_expiration = 60
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/


  # public配下にキャッシュができると参照されてしまうので、予め変えておく。
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end