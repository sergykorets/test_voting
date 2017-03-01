class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :edit, :update, :destroy]
  before_action :define_organization



  # GET /invites/new
  def new
    if head_of_organization?(current_user) || admin?
      @invite = Invite.new
    else
      redirect_to :back
    end
  end

  # POST /invites
  # POST /invites.json
  def create
    if head_of_organization?(current_user) || admin?
      @invite = Invite.new(invite_params)
      @invite.head_id = current_user.id
      @invite.organization_id = @organization.id
      if User.find_by_email(@invite.email) != nil
        @invite.voter_id = (User.find_by_email(@invite.email)).id 
      end
      respond_to do |format|
        if @invite.save
          if @invite.voter_id != nil
            @invite.voter.organizations.push(@invite.organization)
            InviteMailer.existing_user_invite(@invite).deliver
          else
            InviteMailer.new_user_invite(@invite, invited_voters_new_url(:invite_token => @invite.token)).deliver
          end  
          format.html { redirect_to :back, notice: 'Invite sent' }
          format.json { render :show, status: :created, location: @invite }
        else
          format.html { render :new }
          format.json { render json: @invite.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :back
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def invite_params
      params.require(:invite).permit(:email)
    end
end
