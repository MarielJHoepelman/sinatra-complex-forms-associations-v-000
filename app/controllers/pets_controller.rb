class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])

    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    if !params[:pets].keys.include?("owner_id")
    params[:owner]["pet_ids"] = []
    end

    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])

    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end

    redirect to "pets/#{@pet.id}"
  end
end
