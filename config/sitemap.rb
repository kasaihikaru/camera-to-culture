# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.camera-to-culture.com/"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #          :lastmod => Time.now, :host => default_host


  # Add '/articles'
    # add articles_path, :priority => 0.7, :changefreq => 'daily'

  # Add all articles:
    # Article.find_each do |article|
    #   add article_path(article), :lastmod => article.updated_at
    # end


  # Client.active.consent.registerd.intro_present.find_each do |cl|
  #   add '/clients/' + cl.id.to_s, :priority => 0.3
  # end

  # Client.active.consent.registerd.intro_present.find_each do |cl|
  #   add client_path(cl.client_id), :priority => 0.3
  # end




  add('/', :priority => 1.0, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw',
      :lang => 'zh-TW' }
  ])

  add('/home', :priority => 1.0, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/home',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/home',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/home',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/home',
      :lang => 'zh-TW' }
  ])

  add('/clients', :priority => 0.5, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/clients',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/clients',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/clients',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/clients',
      :lang => 'zh-TW' }
  ])

  Client.active.consent.registerd.intro_present.find_each do |cl|
    add('/clients/' + cl.id.to_s, :priority => 0.5, :alternate => [
      { :href => 'https://www.camera-to-culture.com/ja/clients/'+ cl.id.to_s,
        :lang => 'ja' },
      { :href => 'https://www.camera-to-culture.com/en/clients/'+ cl.id.to_s,
        :lang => 'en' },
      { :href => 'https://www.camera-to-culture.com/zh/clients/'+ cl.id.to_s,
        :lang => 'zh' },
      { :href => 'https://www.camera-to-culture.com/tw/clients/'+ cl.id.to_s,
        :lang => 'zh-TW' }
    ])
  end

  add('/about', :priority => 1.0, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/about',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/about',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/about',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/about',
      :lang => 'zh-TW' }
  ])

  add('/about/how_to_use', :priority => 0.3, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/about/how_to_use',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/about/how_to_use',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/about/how_to_use',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/about/how_to_use',
      :lang => 'zh-TW' }
  ])

  add('/about/use_with_phone', :priority => 0.0, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/about/use_with_phone',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/about/use_with_phone',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/about/use_with_phone',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/about/use_with_phone',
      :lang => 'zh-TW' }
  ])

  add('/about/contact_us', :priority => 0.0, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/about/contact_us',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/about/contact_us',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/about/contact_us',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/about/contact_us',
      :lang => 'zh-TW' }
  ])

  add('/about/terms_of_service_cs', :priority => 0.0, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/about/terms_of_service_cs',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/about/terms_of_service_cs',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/about/terms_of_service_cs',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/about/terms_of_service_cs',
      :lang => 'zh-TW' }
  ])

  add('/about/terms_of_service_cl', :priority => 0.0, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/about/terms_of_service_cl',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/about/terms_of_service_cl',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/about/terms_of_service_cl',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/about/terms_of_service_cl',
      :lang => 'zh-TW' }
  ])

  add('/about/to_be_a_cameraman', :priority => 0.7, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/about/to_be_a_cameraman',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/about/to_be_a_cameraman',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/about/to_be_a_cameraman',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/about/to_be_a_cameraman',
      :lang => 'zh-TW' }
  ])

  add('/categories/traveling', :priority => 0.9, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/categories/traveling',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/categories/traveling',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/categories/traveling',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/categories/traveling',
      :lang => 'zh-TW' }
  ])

  add('/categories/profile', :priority => 0.9, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/categories/profile',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/categories/profile',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/categories/profile',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/categories/profile',
      :lang => 'zh-TW' }
  ])

  add('/categories/wedding', :priority => 0.9, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/categories/wedding',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/categories/wedding',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/categories/wedding',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/categories/wedding',
      :lang => 'zh-TW' }
  ])

  add('/categories/daily_life', :priority => 0.9, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/categories/daily_life',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/categories/daily_life',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/categories/daily_life',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/categories/daily_life',
      :lang => 'zh-TW' }
  ])

  add('/categories/id_photo', :priority => 0.9, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/categories/id_photo',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/categories/id_photo',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/categories/id_photo',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/categories/id_photo',
      :lang => 'zh-TW' }
  ])

  add('/categories/seven_five_three', :priority => 0.9, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/categories/seven_five_three',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/categories/seven_five_three',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/categories/seven_five_three',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/categories/seven_five_three',
      :lang => 'zh-TW' }
  ])

  add('/categories/coming_of_age', :priority => 0.9, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/categories/coming_of_age',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/categories/coming_of_age',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/categories/coming_of_age',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/categories/coming_of_age',
      :lang => 'zh-TW' }
  ])

  add('/categories/maternity', :priority => 0.9, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/categories/maternity',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/categories/maternity',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/categories/maternity',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/categories/maternity',
      :lang => 'zh-TW' }
  ])

  add('/categories/new_born', :priority => 0.9, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/categories/new_born',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/categories/new_born',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/categories/new_born',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/categories/new_born',
      :lang => 'zh-TW' }
  ])

  add('/categories/commodities', :priority => 0.9, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/categories/commodities',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/categories/commodities',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/categories/commodities',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/categories/commodities',
      :lang => 'zh-TW' }
  ])

  add('/categories/event', :priority => 0.9, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/categories/event',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/categories/event',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/categories/event',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/categories/event',
      :lang => 'zh-TW' }
  ])

  add('/categories/pet', :priority => 0.9, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/categories/pet',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/categories/pet',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/categories/pet',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/categories/pet',
      :lang => 'zh-TW' }
  ])


  add('/users/sign_in', :priority => 0.0, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/users/sign_in',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/users/sign_in',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/users/sign_in',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/users/sign_in',
      :lang => 'zh-TW' }
  ])

  add('/users/sign_up', :priority => 0.0, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/users/sign_up',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/users/sign_up',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/users/sign_up',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/users/sign_up',
      :lang => 'zh-TW' }
  ])

  add('/users/password/new', :priority => 0.0, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/users/password/new',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/users/password/new',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/users/password/new',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/users/password/new',
      :lang => 'zh-TW' }
  ])

  add('/users/confirmation/new', :priority => 0.0, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/users/confirmation/new',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/users/confirmation/new',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/users/confirmation/new',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/users/confirmation/new',
      :lang => 'zh-TW' }
  ])

  add('/users/unlock/new', :priority => 0.0, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/users/unlock/new',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/users/unlock/new',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/users/unlock/new',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/users/unlock/new',
      :lang => 'zh-TW' }
  ])

  add('/helps/to_receive_email', :priority => 0.0, :alternate => [
    { :href => 'https://www.camera-to-culture.com/ja/helps/to_receive_email',
      :lang => 'ja' },
    { :href => 'https://www.camera-to-culture.com/en/helps/to_receive_email',
      :lang => 'en' },
    { :href => 'https://www.camera-to-culture.com/zh/helps/to_receive_email',
      :lang => 'zh' },
    { :href => 'https://www.camera-to-culture.com/tw/helps/to_receive_email',
      :lang => 'zh-TW' }
  ])



  # add root_path, :priority => 1.0
  # add home_path, :priority => 1.0
  # add new_user_session_path, :priority => 0.1
  # add new_user_password_path, :priority => 0.1
  # add new_user_registration_path, :priority => 0.1
  # add new_user_confirmation_path, :priority => 0.1
  # add new_user_unlock_path, :priority => 0.1
  # add clients_path, :priority => 0.7
  # add terms_of_service_cl_about_path, :priority => 0.0
  # add terms_of_service_cs_about_path, :priority => 0.0
  # add to_be_a_cameraman_about_path, :priority => 0.7
  # add how_to_use_about_path, :priority => 0.1
  # add use_with_phone_about_path, :priority => 0.1
  # add contact_us_about_path, :priority => 0.0
  # add about_path, :priority => 0.7
  # add to_receive_email_helps_path, :priority => 0.0
  # add profile_categories_path, :priority => 0.7
  # add id_photo_categories_path, :priority => 0.7
  # add wedding_categories_path, :priority => 0.7
  # add traveling_categories_path, :priority => 0.7
  # add daily_life_categories_path, :priority => 0.7
  # add seven_five_three_categories_path, :priority => 0.7
  # add coming_of_age_categories_path, :priority => 0.7
  # add maternity_categories_path, :priority => 0.7
  # add new_born_categories_path, :priority => 0.7
  # add commodities_categories_path, :priority => 0.7
  # add event_categories_path, :priority => 0.7
  # add pet_categories_path, :priority => 0.7


    # Users.clients.new_user_message, :priority => 0.1


  # group(:sitemaps_path => 'ja/') do

  #   Client.active.consent.registerd.intro_present.find_each do |cl|
  #     add '/clients/' + cl.id.to_s, :priority => 0.3
  #   end

  #   add root_path, :priority => 1.0
  #   add home_path, :priority => 1.0
  #   add new_user_session_path, :priority => 0.1
  #   add new_user_password_path, :priority => 0.1
  #   add new_user_registration_path, :priority => 0.1
  #   add new_user_confirmation_path, :priority => 0.1
  #   add new_user_unlock_path, :priority => 0.1
  #   add clients_path, :priority => 0.7
  #   add terms_of_service_cl_about_path, :priority => 0.0
  #   add terms_of_service_cs_about_path, :priority => 0.0
  #   add to_be_a_cameraman_about_path, :priority => 0.7
  #   add how_to_use_about_path, :priority => 0.1
  #   add use_with_phone_about_path, :priority => 0.1
  #   add contact_us_about_path, :priority => 0.0
  #   add about_path, :priority => 0.7
  #   add to_receive_email_helps_path, :priority => 0.0
  #   add profile_categories_path, :priority => 0.7
  #   add id_photo_categories_path, :priority => 0.7
  #   add wedding_categories_path, :priority => 0.7
  #   add traveling_categories_path, :priority => 0.7
  #   add daily_life_categories_path, :priority => 0.7
  #   add seven_five_three_categories_path, :priority => 0.7
  #   add coming_of_age_categories_path, :priority => 0.7
  #   add maternity_categories_path, :priority => 0.7
  #   add new_born_categories_path, :priority => 0.7
  #   add commodities_categories_path, :priority => 0.7
  #   add event_categories_path, :priority => 0.7
  # end

end
