class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


###########deviseの設定###########
  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :deleted_at, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :deleted_at, :image, :mail_refused])
  end

###########全ページ用の読み込み###########
  def import_current_user
    if user_signed_in?
      @user = current_user
      @cl = @user.client
      @cs = @user.customer
    end
  end

###########カテゴリページのcl検索###########
  def cate_cl_search(category_id)
    @cls = Client.active.consent.registerd.intro_present.includes(:user, :client_primary_prices, :client_portfolios).fits_categpory_id_in(category_id)
  end

  def area_cl_search
    @cls_kanto = @cls.fits_prefecture_id_in([8..15]).uniq
    @cls_kansai = @cls.fits_prefecture_id_in([25..30]).uniq
  end



###########多言語の設定###########
  before_action :set_locale

  private
  # I18n.locale をセットする
  def set_locale
    I18n.locale = locale_in_params || locale_in_accept_language || I18n.default_locale
  end

  def locale_in_params
    if params[:locale].present?
      params[:locale].to_sym.presence_in(I18n::available_locales) || I18n.default_locale
    else
      nil
    end
  end

  # 環境変数 HTTP_ACCEPT_LANGUAGE を順に検証し、最初に一致した有効な locale を返す
  def locale_in_accept_language
    request.env['HTTP_ACCEPT_LANGUAGE']
      .to_s # nil 対策
      .split(',')
      .map{ |_| _[0..1].to_sym }
      .select { |_| I18n::available_locales.include?(_) }
      .first
  end

  # 全リンクに locale 情報をセットする
  def default_url_options(options = {})
   options.merge(locale: I18n.locale)
  end
end