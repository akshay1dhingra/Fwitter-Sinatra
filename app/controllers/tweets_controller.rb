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

  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect to '/tweets/new'
      else
        @tweet = current_user.tweets.build(content: params[:content])
        @tweet.save
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect '/tweets/new'
        end
      end
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect to '/login'
    end
  end

end
