class UsersController < Clearance::UsersController
  if respond_to?(:before_action)
    before_action :redirect_signed_in_users, only: [:create, :new]
  end

  def index
    @users = User.all
  end

  def new
    @user = user_from_params
    render template: " users/new"
  end

  def create
    @user = user_from_params
    if @user.save
      sign_in @user
      redirect_to welcome_index_path
    else
      render template: "users/new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params.permit!)
      redirect_to welcome_index_path
    else
      render 'edit'
    end
  end

  private

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    age = user_params.delete(:age)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.first_name = first_name
      user.last_name = last_name
      user.age = age
    end
  end

  def user_params
    params[Clearance.configuration.user_parameter] || Hash.new
  end
end
