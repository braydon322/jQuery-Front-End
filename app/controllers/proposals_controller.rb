class ProposalsController < ApplicationController

  def index
    if current_admin
      @proposals = current_admin.proposals
      render json: @proposals, status: 200
    else
      @proposals = current_user.proposals
      render json: @proposals, status: 200
    end
  end

  def new
    if admin_signed_in?
      @proposal = Proposal.new
      3.times do
        @proposal.milestones.build
        @proposal.fees.build
      end
    else
      redirect_to root_path
      flash[:notice] = "You have to be logged in as a Freelancer to do create a Proposal."
    end
  end

  def create
    if any_blanks?
    else
      if User.find_by(:email => params[:proposal][:email])
        @user = User.find_by(:email => params[:proposal][:email])
        if current_admin.users.include?(@user)
          @user = current_admin.users.find_by(:email => params[:proposal][:email])
          if @user.save
            @proposal = @user.proposals.create(proposal_params)
          else
            flash[:notice] = "Invalid Proposal."
            redirect_to :back
          end
        else
          @user.admin = current_admin
          current_admin.users << @user
          @proposal = @user.proposals.create(proposal_params)
          current_admin.save
          @user.save
        end
        redirect_to crtv_path
      else
          @user = current_admin.users.create(:email => params[:proposal][:email], :password => "Password123", :password_confirmation => "Password123", :admin_id => current_admin.id)
        if @user.save
          @proposal = @user.proposals.create(proposal_params)
          if @proposal.save
            redirect_to crtv_path
          else
            flash[:notice] = "Invalid Proposal."
            redirect_to :back
          end
        else
          flash[:notice] = "Invalid Email."
          redirect_to :back
        end
      end
    end
  end

  def update
    if any_blanks?
    else
      @proposal = Proposal.find(params[:id])

      if @proposal.proposal_accepted
        flash[:notice] = "You cannot change the proposal after it has already been signed."
        if admin_signed_in?
          redirect_to crtv_path
        else
          redirect_to cmpny_path
        end
      else
        @proposal.update(proposal_params)
        if current_admin
          redirect_to crtv_path
        else
          redirect_to cmpny_path
        end
      end
    end
  end

  def show
    @proposal = Proposal.find(params[:id])
    if current_admin
      @proposals = current_admin.proposals
      render json: @proposal, status: 200
    else
      @proposals = current_user.proposals
      render json: @proposal, status: 200
    end
  end

  def sign
    @proposal = Proposal.find(params[:id])
    if current_admin
      @proposals = current_admin.proposals
    else
      @proposals = current_user.proposals
    end
  end

  def sign_check
    @proposal = Proposal.find(params[:id])
    @proposal.signer = params[:signer]
    @proposal.save
    if @proposal.save
      @proposal.proposal_accepted = true
      @proposal.save
      redirect_to @proposal
    end
  end

  def destroy
    @proposal = Proposal.find_by(:id => params[:id])
    @proposal.destroy
    redirect_to crtv_path
  end

  private

  def any_blanks?
    if params[:proposal][:email]== ""
      true
      redirect_to :back
      flash[:notice] = "Email cannot be blank."
    elsif params[:proposal][:title]== ""
      true
      redirect_to :back
      flash[:notice] = "Title cannot be blank."
    elsif params[:proposal][:budget]== ""
      true
      redirect_to :back
      flash[:notice] = "Budget cannot be blank."
    else
    end
  end

  def proposal_params
    params.require(:proposal).permit(:url, :user_id, :email, :title, :signer, :budget, :why_me, :milestones_attributes => [:id, :content, :due_date], :fees_attributes => [:id, :content, :price_breakdown])
  end

  def milestone_params
    params.require(:milestone).permit(:id, :content, :due_date)
  end
end
