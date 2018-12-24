class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def search
    
    # where in array
    # params[:query] = "taro jiro"
    # query = params[:query].split(" ")
    # @users = User.where(name: query)
    
    # or
    # @users = User.where(name: 'taro').or(User.where(name: 'jiro'))
    
    # like
    # @users = User.where("name LIKE ?", "ta%").or(User.where("name LIKE ?", "ji%"))
    #
    # @users = User.where('(name = ?) OR (name = ?)', 'taro', 'jiro')
    #
    # @users = User.where('(name LIKE ?) OR (name LIKE ?)', 'ta%', 'ji%')
    #
    # @users = User.where('(name LIKE ?)' , 'ta%',)

    @query = (params[:search][:query].blank? == true ? '' : params[:search][:query])
    
    ##
    # SQL インジェクション サンプル
    # https://railsguides.jp/security.html#sql%E3%82%A4%E3%83%B3%E3%82%B8%E3%82%A7%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3
    # 「' OR '1'='1」
    
    # SQLインジェクションが発生してしまう記述方法
    @users = User.where("name = '#{@query}'")

    # SQLインジェクションが防げる記述方法
    @users = User.where('(name = ?)', "#{@query}")

    ##
    # あいまい検索
    # @users = User.where('(name LIKE ?)', "%#{@query}%")
    
    render :index
  end
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    # @users = User.where("name = ''")
    # @users = User.find(id: 1)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name)
    end
  
end
