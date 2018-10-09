class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
      @tweets = Tweet.all
      erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :"tweets/new"
    end
  end

  post '/tweets/new' do
    @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
      @tweets = Tweet.all
      erb :tweets
  end

end
