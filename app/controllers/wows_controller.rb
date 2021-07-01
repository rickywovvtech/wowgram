class WowsController < ApplicationController
  before_action :set_wow, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  layout 'dashboard'

  # GET /wows or /wows.json
  def index
    @wows = Wow.all.where(:user_id =>current_user.id)
  end

  def home
    follow = Follow.where(:sessionuser=>current_user.id)
    if follow.present?
      @wows = (Wow.where(:user_id=>follow.pluck(:user_id)) + Wow.where(:user_id=>current_user.id)).uniq
    else 
      @wows = Wow.where(:user_id=>current_user.id)
    end
  end

  def all_post
    if params[:q].present?
      user = User.where('name LIKE ?',"#{params[:q]}%")
      @wows = Wow.all.where(:user_id=>user.pluck(:id))
   else
      @wows = Wow.all
   end
  end

  def userpost
    @user_id = params[:format]
    @wows = Wow.where(:user_id=>@user_id)
  end

  def follow
    p 33333333333333333333333333333333333333333333333333333
    user_id = params[:format]
    Follow.create(:user_id=>user_id,:sessionuser=>current_user.id)
    # respond_to do |format|
    #   format.html { redirect_to userpost_wows_url(:format=>user_id), notice: "Wow was successfly followed" }
    #   format.json { head :no_content }
    # end
    redirect_to userpost_wows_url(:format=>user_id), notice: "Wow was successfly followed" 
  end

  def unfollow
    user_id = params[:format]
    follow =Follow.find_by(:user_id=>user_id,:sessionuser=>current_user.id)
    follow.destroy
    # respond_to do |format|
    #   format.html { redirect_to userpost_wows_url(:format=>user_id), notice: "Wow was successfly unfollowed" }
    #   format.json { head :no_content }
    # end
    redirect_to userpost_wows_url(:format=>user_id), notice: "Wow was successfly unfollowed"
  end

  def comment
    @wow_id = params[:format]
    @wow = Wow.find(@wow_id) 
    @comment = Comment.where(:wow_id=>@wow_id)
  end

  def submit_comment
    comment = params[:uname]
    wow_id = params[:id]
    Comment.create(:user_id=>current_user.id,:wow_id=>wow_id,:comment=>comment)
    respond_to do |format|
      format.html { redirect_to comment_wows_url(:format=>wow_id), notice: "Wow was successfully commented." }
      format.json { head :no_content }
    end
  end

  # GET /wows/1 or /wows/1.json
  def show
  end

  # GET /wows/new
  def new
    @wow = Wow.new
  end

  # GET /wows/1/edit
  def edit
  end

  # POST /wows or /wows.json
  def create
    @wow = Wow.new(wow_params)
    @wow.user_id  = current_user.id

    respond_to do |format|
      if @wow.save
        format.html { redirect_to @wow, notice: "Wow was successfully created." }
        format.json { render :show, status: :created, location: @wow }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wows/1 or /wows/1.json
  def update
    respond_to do |format|
      if @wow.update(wow_params)
        format.html { redirect_to @wow, notice: "Wow was successfully updated." }
        format.json { render :show, status: :ok, location: @wow }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wows/1 or /wows/1.json
  def destroy
    @wow.destroy
    respond_to do |format|
      format.html { redirect_to wows_url, notice: "Wow was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wow
      @wow = Wow.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wow_params
      params.require(:wow).permit(:description,:picture)
    end
end
