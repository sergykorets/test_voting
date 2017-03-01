class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :zerovote]
  before_action :define_organization
  # GET /polls
  # GET /polls.json
  def index
    @polls = @organization.polls
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
    if @organization.has_membership?(current_user) || head_of_organization?(current_user) || admin?
    else
      redirect_to :back
    end
  end

  # GET /polls/new
  def new
    if head_of_organization?(current_user) || admin?
      @poll = Poll.new
    else
      redirect_to :back
    end
  end

  # GET /polls/1/edit
  def edit
    if head_of_organization?(current_user) || admin?
      
    else
      redirect_to :back
    end
  end

  # POST /polls
  # POST /polls.json
  def create
    if head_of_organization?(current_user) || admin?
      @poll = Poll.new(poll_params)
      @poll.organization_id = @organization.id
      respond_to do |format|
        if @poll.save
          format.html { redirect_to organization_polls_path(@organization), notice: 'Poll was successfully created.' }
          format.json { render :show, status: :created, location: @poll }
        else
          format.html { render :new }
          format.json { render json: @poll.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :back
    end  
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    if head_of_organization?(current_user) || admin?
      respond_to do |format|
        if @poll.update(poll_params)
          format.html { redirect_to organization_poll_path(@organization, @poll), notice: 'Poll was successfully updated.' }
          format.json { render :show, status: :ok, location: @poll }
        else
          format.html { render :edit }
          format.json { render json: @poll.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :back
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    if head_of_organization?(current_user) || admin?
      @poll.destroy
      respond_to do |format|
        format.html { redirect_to organization_polls_url(@organization), notice: 'Poll was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to :back
    end      
  end

  def upvote
    if @organization.has_membership?(current_user)
      @vote = Vote.new
      @vote.kind = 1
      @vote.voter_id = current_user.id
      @vote.poll_id = @poll.id
      if @vote.save
        @poll.yes_votes += 1
        @poll.save
        redirect_to organization_polls_path(@organization)
      else
        redirect_to :back
      end
    else
       redirect_to :back
    end
  end

  def downvote
    if @organization.has_membership?(current_user)
      @vote = Vote.new
      @vote.kind = -1
      @vote.voter_id = current_user.id
      @vote.poll_id = @poll.id
      if @vote.save
        @poll.no_votes += 1
        @poll.save
        redirect_to organization_polls_path(@organization)
      else
        redirect_to :back  
      end
    else
      redirect_to :back
    end
  end

  def zerovote
    if @organization.has_membership?(current_user)
      @vote = Vote.new
      @vote.kind = 0
      @vote.voter_id = current_user.id
      @vote.poll_id = @poll.id
      if @vote.save
        @poll.undefined_votes += 1
        @poll.save
        redirect_to organization_polls_path(@organization)
      else
        redirect_to :back
      end
    else
      redirect_to :back
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:title)
    end
end
