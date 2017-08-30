require 'pry'

class FiguresController < ApplicationController

    get '/figures' do
      @figures = Figure.all
      erb :'figures/index'
    end

    get '/figures/new' do
      erb :'figures/new'
    end

    post '/figures' do
      #binding.pry
      @figure = Figure.create(params[:figure])
      @figure.titles << Title.create(params[:title])
      @figure.landmarks << Landmark.create(params[:landmark])
      @figure.save
      redirect to "/figures/#{@figure.id}"
    end

    get '/figures/:id' do
     @figure = Figure.find_by_id(params[:id])
     erb :'/figures/show'
   end

   post '/figures/:id' do
     @figure = Figure.find_by_id(params[:id])
     @figure.name = params[:figure][:name]
     @figure.save
     @figure.landmarks << Landmark.find_or_create_by(name: params[:figure][:landmark])
     @figure.save
     redirect to "/figures/#{@figure.id}"
   end


   get '/figures/:id/edit' do
     @figure = Figure.find_by_id(params[:id])
     erb :'/figures/edit'
   end

   patch 'figures/:id/edit' do
     binding.pry
     @figure = Figure.find(params[:id])
     @figure.name = params[:landmark][:name]
     @landmark.year_completed = params[:landmark][:year_completed]
     @landmark.save
     erb :"/landmarks/#{@landmark.id}"
   end


end
