UID_REGEX = /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/

Rails.application.routes.draw do
  scope module: :client do
    root 'home#index'

    # メールアドレス ~ 会員登録・認証
    get    '/signup',  to: "auth/registrations#new"
    post   '/signup',  to: "auth/registrations#create"

    # メールアドレス ~ ログイン・ログアウト
    get    '/login',   to: "auth/sessions#new"
    post   '/login',   to: "auth/sessions#create"

    # OAuth ~ 会員登録・認証
    post 'oauth/callback', to: 'auth/oauths#callback'
    get 'oauth/callback', to: 'auth/oauths#callback'
    get 'oauth/:provider', to: 'auth/oauths#oauth', as: :auth_at_provider

    # ログアウト
    delete '/logout',  to: "auth/sessions#destroy"

    namespace :account do
      resource :billing, only: [:show]
      resource :usage, only: [:show]
      resource :notification, only: [:show]
      resource :email_change, only: [:show]
      resource :password_change, only: [:show]
    end
  end
end
