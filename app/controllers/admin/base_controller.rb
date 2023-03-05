class Admin::BaseController < ApplicationController
  before_action :check_admin
  #↓layout宣言
  layout 'admin/layouts/application'

  private

  def not_authenticated
    redirect_to admin_login_path, warning: "ログインしてください"
  end

  #↓管理者権限を持っているか確認する
  def check_admin
    redirect_to root_path, warning: "管理者権限を持っていません" unless current_user.admin?
  end
end
