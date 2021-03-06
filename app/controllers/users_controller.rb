# (c) goodprogrammer.ru
#
# Контроллер, управляющий пользователями
# Должен уметь:
#   1. Показывать страницу пользователя
#   2. Создавать новых пользователей
#   3. Позволять пользователю редактировать свою страницу
#
class UsersController < ApplicationController

  before_action :load_user, except: [:index, :new, :create]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  # Это действие отзывается, когда пользователь заходит по адресу
  # /users
  def index
    @user = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if @current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if @current_user.present?
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render 'edit'
    end
  end

  # Это действие отзывается, когда пользователь заходит по адресу
  # /users/:id, например /users/1
  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  # DELETE /user/
  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Ваш аккаунт был удален (('
  end


  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :color)
  end

  def load_user
    @user = User.find(params[:id])
  end

  def authorize_user
    reject_user unless @user == current_user
  end
end