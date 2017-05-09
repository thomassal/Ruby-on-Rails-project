class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:index, :create, :update, :destroy]

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all
    render :json => @properties
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)

    #respond_to do |format|
      if @property.save
	@response = {:status => "201", :message => "Property successfully created."}
	render :json => @response
      else
	render :json => @user.errors
      end
    #end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    @property = Property.find(params[:id])
    #respond_to do |format|
      if @property.update_attributes(property_params)
        @response = { :message => "Property successfully updated." }
	render :json => @response
      else
        #format.html { render :edit }
        render :json => @property.errors
      end
    #end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    Property.find(params[:id]).destroy
    #respond_to do |format|
     #format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
     #format.json { head :no_content }
    #end
    @response = { :message => "Property successfully deleted." }
    render :json => @response
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.permit(:varable, :value)
    end
end
