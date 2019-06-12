class TweetsController < ApplicationController
  before_action :move_to_index , except: [:index]
  #アクションが実行する前にメソッドを使うことができる

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end
  #@tweetsはindex.html.erbに渡される。Tweet model からuserテーブルの情報と一緒に呼び出し、5つずつ降順に表示している
  #？？？？params[:page] のキーってどこで定義されてるのか@kaminari

  def new
  end

  def creat
    Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
  end
  #Tweetmodelに以下のデータを保存、tweet_paramsはハッシュ形式の変数。（左：ツイートモデルのカラム名、右：[:●●]はキーでユーザー入力項目がバリュー）
  #（左,右）左は変数名、右はその値。右のうち、tweet_paramsは#newのviewファイル内のname属性でキーを定義している。

  def destroy
    tweet = Tweet.find(params[:id]) #変数tweet＝Tweetmodelからidに対応したツイートを取り出してくる
    tweet.destroy if tweet.user_id == current_user.id #取り出してきたツイートを削除する（条件：そのツイートのidが今ログイン中のidなら）
  end

  def edit
    @tweet = Tweet.find(params[:id]) #@tweetはTweetmodelからpathのidに対応したツイートを取り出す
  end

  def update
    tweet = Tweet.find(params[:id]) #変数tweet＝Tweetmodelからpathのidに対応したツイートを取り出す
    if tweet.user_id == current_user.id #条件：そのツイートのidが今ログイン中のidなら
      tweet.update(tweet_params) #後ろのカッコって取り出したツイートを更新し、DBに保存する
    end
  end

  def show#詳細(コメント)ページに遷移する
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user) #変数comments=取り出したツイートのコメントたち(変数ではない)、ついでにユーザーモデルからもデータを引っ張り出してくる
  end

  private
  def tweet_params #strongparameterでparamsに入れるものを厳選している
    params.permit(:image,:text)
  end

  def move_to_index#？？？indexアクションを発火するというメソッド
    redirect_to root_path unless user_signed_in?#redirect_to（URL、パス）メソッドで、Prefix path(tweets#index発火させたいときのpath)に移動。条件：サインインしていない場合
  end

end