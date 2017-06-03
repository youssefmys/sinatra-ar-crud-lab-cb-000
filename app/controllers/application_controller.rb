require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    redirect '/posts'
  end

  get '/posts/new' do
    erb :new 
  end

  get '/posts' do
    erb :index
  end

  post '/posts' do    
    Post.create(name: params[:name], content: params[:content])
    erb :index
  end


  get '/posts/:id' do
    @post = Post.find_by(id: params[:id])
    erb :show
  end


  get '/posts/:id/edit' do
    @post = Post.find_by(id: params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    if post = Post.find_by(id: params[:id])
      post.update(name: params[:name], content: params[:content])
      redirect "/posts/#{params[:id]}"
    end
  end

  delete '/posts/:id/delete' do
    @post_name = Post.find(params[:id]).name
    Post.delete(params[:id])
    erb :delete
  end
  
  
end
