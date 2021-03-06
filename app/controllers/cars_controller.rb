class CarsController < ApplicationController
  require 'csv'
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  def index
    @cars = Car.all
  end

  def show
  end

  def new
    @car = Car.new
  end

  def edit
  end

  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def generate_pdf
    @all_cars = Car.all
    file_name = "Cars"
    render :pdf => file_name,
     show_as_html: params.key?('debug'),
     :margin => { :top => 15 },
     :template => "cars/show_cars_data.html.erb",
     page_size: 'A3',
     disposition: 'attachment',
     orientation:'Landscape',
     footer: {    left: "#{Time.now.strftime("%m/%d/%Y")}",
                  center: "#{file_name}",
                  right: '[page] of [topage]',
                  font_size: 10
             }
  end

  def generate_excel
    file = "Cars.csv"
    all_cars = Car.all
    CSV.open( file, 'w' ) do |writer|
         writer << ['Make','Model','Year', 'Comments' ]
          all_cars.each do |each_car|
            writer << [
                  each_car.make,
                  each_car.model,
                  each_car.year,
                  each_car.comments.map{|e_comment| e_comment.commnet_body}.join(", "),
                  ]
            end
    end
      send_file(file)
  end

  private
    def set_car
      @car = Car.find(params[:id])
    end

    def car_params
      params.require(:car).permit(:model, :make, :year)
    end
end
