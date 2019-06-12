class CommentsController < ApplicationController
  def create#コメント保存！！
    @comment = Comment.create(text: comment_params[:text], tweet_id: comment_params[:tweet_id], user_id: current_user.id)
    redirect_to tweet_path(@comment.tweet)
     #@commentのインスタンス変数（name属性はtweetsのshow.html.erb)＝コメントモデルにテキストとidを保存（カラム名：変数）
  end#redirect_to（パス+[:id]の言い換え）tweets#show発火させる為のtweet_pathを指定

  private
  def comment_params
    params.permit(:text, :tweet_id)
  end
end