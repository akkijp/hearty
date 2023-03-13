Rails.application.routes.draw do
  scope module: :api do
    resource :stripe do
      post :webhook
    end
  end
end
