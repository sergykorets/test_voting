class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.all
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    if @organization.has_membership?(current_user) || head_of_organization?(current_user) || admin?

    else
      redirect_to root_path
    end
  end

  # GET /organizations/new
  def new
    if admin?
      @organization = Organization.new
    else
      redirect_to root_path, notice: 'You are not allowed to create organizations'
    end
  end

  # GET /organizations/1/edit
  def edit
    if admin? || head_of_organization?(current_user)
    else
      redirect_to root_path, notice: 'You are not allowed to create organizations'
    end
  end

  # POST /organizations
  # POST /organizations.json
  def create
    if admin?
      @organization = Organization.new(organization_params)
      respond_to do |format|
        if @organization.save
          format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
          format.json { render :show, status: :created, location: @organization }
        else
          format.html { render :new }
          format.json { render json: @organization.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, notice: 'You are not allowed to create organizations'
    end  
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    if admin? || head_of_organization?(current_user)
      respond_to do |format|
        if @organization.update(organization_params)
          format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
          format.json { render :show, status: :ok, location: @organization }
        else
          format.html { render :edit }
          format.json { render json: @organization.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, notice: 'You are not allowed to create organizations'
    end      
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    if admin?
      @organization.destroy
      respond_to do |format|
        format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, notice: 'You are not allowed to create organizations'
    end    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :head_id, :avatar)
    end
end
