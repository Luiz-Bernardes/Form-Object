class UsersController < ApplicationController
  before_action :user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @form = UserForm.new(user: User.new)
  end

  def edit
    @form = UserForm.new(user: user)
  end

  def create
    # @user = User.new(user_params)
    @form = UserForm.new(user_params.merge(user: User.new))

    if @form.save
      flash[:success] = "Usuário criado com sucesso"
      redirect_to users_path
    else
      flash[:error] = "Não foi possível salvar o usuário, favor verificar os erros"
      render :new
    end
  end

  def update
    # @user.update(user_params)
    @form = UserForm.new(user_params.merge(user: user))

    if @form.save
      flash[:success] = 'Usuário alterado com sucesso'
      redirect_to users_path
    else
      flash[:error] = 'Não foi possível salvar o usuário, favor verificar os errors'
      render :edit
    end
  end

  def destroy
    user.destroy
    flash[:success] = 'Usuário excluído com sucesso'
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user_form).permit(:name, :phone, :email)
  end

  def user
    @user ||= User.find(params[:id])
  end

end
