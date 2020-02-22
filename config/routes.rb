Rails.application.routes.draw do

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope '/api/v1' do
    resources :users

    # Verb          URL                          Handler                             Alias
    post            '/login',                    to: 'auth#login',                   as: 'login'
    post            '/register',                 to: 'auth#register',                as: 'register'
    post            '/users/delete/:id',         to: 'users#delete',                 as: 'user_delete'
  end

end
