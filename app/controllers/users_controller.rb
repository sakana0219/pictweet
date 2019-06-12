class UsersController < ApplicationController#マイページでツイート一覧表示
  def show
    user = User.find(params[:id])#変数user＝ユーザーモデルからidに対応したユーザー情報／[:id]はハッシュのキー、ユーザー情報がバリュー
    @nickname = user.nickname#インスタンス変数@nickname＝取り出したユーザー情報のニックネーム
    @tweets = user.tweets.page(params[:page]).per(5)#インスタンス変数@tweets＝ユーザーのツイートを５つずつページ表示
  end
end