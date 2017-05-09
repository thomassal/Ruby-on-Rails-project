class InstancesController < ApplicationController
  #before_action :set_instance, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:index, :create, :update, :destroy]
  # GET /instances
  # GET /instances.json
  def index
    @instances = Instance.all
    render :json => @instances
  end

  # GET /instances/1
  # GET /instances/1.json
  def show
    @instance = Instance.find(params[:id])
    render :json =>@instance
  end

  # GET /instances/new
  def new
    @instance = Instance.new
  end

  # GET /instances/1/edit
  def edit
  end

  # POST /instances
  # POST /instances.json
  def create
    @instance = Instance.new(instance_params)

    #respond_to do |format|
      if @instance.save
        #format.html { redirect_to @instance, notice: 'Instance was successfully created.' }
        #format.json { render :show, status: :created, location: @instance }
	@response = { :message => "Instance successfully created."}
	render :json => @response 
      else
        #format.html { render :new }
        render :json => @instance.errors
      end
    #end
  end

  # PATCH/PUT /instances/1
  # PATCH/PUT /instances/1.json
  def update
	@instance = Instance.find(params[:id])
    #respond_to do |format|
      if @instance.update_attributes(instance_params)
        #format.html { redirect_to @instance, notice: 'Instance was successfully updated.' }
        #format.json { render :show, status: :ok, location: @instance }
	@response = { :message => "Instance successfully updated."}
	render :json => @response
      else
        #format.html { render :edit }
        render :json => @instance.errors
      end
    #end
  end

  # DELETE /instances/1
  # DELETE /instances/1.json
  def destroy
    Instance.find(params[:id]).destroy
    #respond_to do |format|
      #format.html { redirect_to instances_url, notice: 'Instance was successfully destroyed.' }
      #format.json { head :no_content }
      @response = { :message =>"Instance successfully destroyed."}
      render :json => @response
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instance
      @instance = Instance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instance_params
      params.permit(:ip_address, :image, :launch_time, :status)
    end
end
