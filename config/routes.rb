Rails.application.routes.draw do


  # Это правило говорит: если пользователь заходит по адресу /,
  # направь его в контроллер users, действие index
  # Грубо говоря, на главной странице у нас список юзеров
  root 'users#index'

  # Эти две строчки добавляют ресурсы для пользователей и вопросов
  # Ресурс — это набор путей для управления соответствующей моделью
  # Посмотрите, что напишет команда rake routes

  # ресурс пользователей (экшен destroy не поддерживается)
  resources :users, except: [:destroy]

  # ресурс сессий (только три экшена :new, :create, :destroy)
  resource :session, only: [:new, :create, :destroy]

  # ресурс вопросов (кроме экшенов :show, :new, :index)
  resources :questions, except: [:show, :new, :index]

end
