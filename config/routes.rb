Rails.application.routes.draw do
  # ここはdeviseのルーティング
  # 会員用
  # URL /customers/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # ここからは通常のルーティング
  root to: 'public/homes#top'
  get 'public/homes/about' => 'public/homes#about', as: 'about'

  get 'public/infos/hogo', as: :hogo
  get 'public/infos/nora', as: :nora
  # 仮ルーティングMAP用
  get 'public/posts/map'

  # 管理者側
  namespace :admin do
      resources :homes, only: [:top]
      resources :posts
      #genresのnew,showを除くルーティング自動生成
      resources :genres, except: [:new, :show]
      resources :users, only: [:index, :show, :edit, :update]
    end

  # 会員側
    namespace :public do
      resources :homes, only: [:top, :about]
      resources :posts do
        # 見た、かわいいボタン用
        resources :looks, only: [:create, :destroy]
        resources :cutes, only: [:create, :destroy]
        # コメント用
        resources :comments, only: [:create, :destroy]
    end
      resources :users, except: [:index, :show]
      get  'users' => 'users#show', as: 'show'
      # 退会確認画面
      # get '/users/:id/confirm' => 'users#confirm', as: 'confirm'
      # 論理削除用のルーティング
      # patch '/users/:id/decline' => 'users#decline', as: 'decline'
      # post 'users/confirm'
    end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
