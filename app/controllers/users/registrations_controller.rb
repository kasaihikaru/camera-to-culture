class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    # super
    my_build_resource({})
    self.resource.user_languages.build
    yield resource if block_given?
    respond_with resource
  end

  # POST /resource
  def create
    # super
    user = my_build_resource(sign_up_params)
    resource.save

    #CL,CS発番
    customer = Customer.create(user_id: user.id)
    client = Client.create(user_id: user.id)

    #User_languageではダメ
    #マスターテーブルが空だと保存できない
    unless user_language_params == nil
      language_ids = user_language_params
      language_ids.each do |id|
        UserLanguage.create(user_id: user.id, language_id: id.to_i)
      end
    end

    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)

        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end

  end

  # GET /resource/edit
  def edit
    # super

    # menu用
    @user = current_user
    @cl = @user.clients.active.first
    @cs = @user.customers.active.first

    # content用
    user_languages = current_user.user_languages
    @lang_ids = []
    for user_language in user_languages
      @lang_ids << user_language.language_id
    end
  end

  # PUT /resource
  def update
    #super

    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)


    #User_languageの更新
    unless user_language_params == nil
      #元のlangを取得
      pre_user_languages = current_user.user_languages
      pre_lang_ids = []
      for user_language in pre_user_languages
        pre_lang_ids << user_language.language_id
      end

      #変更するlangと照らし合わせて更新
      language_ids = user_language_params
      language_ids.each do |id|
        unless pre_lang_ids.include?(id.to_i)
          UserLanguage.create(user_id: current_user.id, language_id: id.to_i)
        end
      end
      pre_lang_ids.each do |pre_id|
        unless language_ids.include?(pre_id.to_s)
          UserLanguage.where(user_id: current_user.id, language_id: pre_id.to_i).destroy_all
        end
      end
    end
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: user_path(resource)
      # respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
  def my_build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end

  def user_language_params
    params[:language_id]
  end

  def as_who_params
    params[:as_who]
  end

  #user編集の際にパスワード入力をなくす
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end