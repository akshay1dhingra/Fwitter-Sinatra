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
        erb :'tweets/new'
      else
        # @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
        @tweet = current_user.tweets.build(content: params[:content])
        @tweet.save
        # binding.pry
        if @tweet.save
          # redirect 'tweets/tweets'
          redirect to "/tweets/#{@tweet.id}"
          # erb :'tweets/show'
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
      # @tweet = Tweet.find(id: params[:id])
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    end
  end

end
