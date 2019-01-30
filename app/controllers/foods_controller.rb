class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update, :destroy]

  require 'rest-client'
  # GET /foods
  # GET /foods.json
  def index
    if params[:type]
      type_id = (Type.where('name = ?', params[:type]))[0][:id]
      @foods  = Food.where('type_id = ?', type_id)
    else
      @foods = Food.all
    end
  end

  def get_food_json
    if params[:type]
      type_id = (Type.where('name = ?', params[:type]))[0][:id]
      foods  = Food.where('type_id = ?', type_id)
    else
      foods = Food.all
    end
    render json: foods, status: :ok
  end

  def update_all
    url = 'https://foodvisor.io/itw/food/list/'
    foodRaw = RestClient.get(url, {:params => {:foo => 'bar'}, :Authorization => 'Bearer iwn-31@!3pf(w]pmarewj236^in'})
    foods = JSON.parse(foodRaw)
    Food.destroy_all
    if is_type_table_empty
      init_types
    end
    p foods
    foods.each do |food|
      food["type_id"] = Type.where(:name => food["type"])[0].id
      food["name"] = food["display_name"]
      food.delete("display_name")
      food.delete("type")
      Food.new(food).save
    end
    foods = Type.all.includes(:food)
    foods.each do |food|
      p food
    end
    render json: foods, status: :ok
  end

  # GET /foods/1
  # GET /foods/1.json
  def show
  end

  def is_type_table_empty
    return Type.first == nil
  end

  def init_types
    Type.new({:id => 0, :name => 'starter'}).save
    Type.new({:id => 1, :name => 'dish'}).save
    Type.new({:id => 2, :name => 'desert'}).save
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit
  end

  # POST /foods
  # POST /foods.json
  def create
    @food = Food.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: 'Food was successfully created.' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1
  # PATCH/PUT /foods/1.json
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to @food, notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1
  # DELETE /foods/1.json
  def destroy
    @food.destroy
    respond_to do |format|
      format.html { redirect_to foods_url, notice: 'Food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    def food_params
      params.require(:food).permit(:name, :carbs, :fibers, :proteins, :lipids, :cal, :imgUrl, :type_id)
    end

end
