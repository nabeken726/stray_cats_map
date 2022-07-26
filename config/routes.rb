Rails.application.routes.draw do
  namespace :public do
    get 'genres/show'
  end
  # ここはdeviseのルーティング
  # 会員用
  # URL /customers/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions",
  }

  # ゲストログイン用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # ここからは通常のルーティング
  root to: 'public/homes#top'
  get 'public/homes/about' => 'public/homes#about', as: 'about'

  get 'public/infos/hogo', as: :hogo
  get 'public/infos/nora', as: :nora

  # 退会確認画面
  get 'public/users/:id/unsubscribe' => 'public/users#unsubscribe', as: 'unsubscribe'
  # 論理削除用のルーティング
  patch 'public/users/:id/withdrawal' => 'public/users#withdrawal', as: 'withdrawal'

  #MAP用
  get 'admin/posts/map'
  get 'public/posts/map'
  get 'public/posts/my_index'

  # 管理者側
  namespace :admin do
    resources :homes, only: [:top]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
    # genresのnew,showを除くルーティング自動生成
    resources :genres, except: [:new, :show]
    resources :users, only: [:index, :show, :edit, :update]
  end

  # 会員側
  namespace :public do
    resources :homes, only: [:top, :about] # %i(top about)
    resources :genres, only: [:index]
    resources :posts do
      # 見た、かわいいボタン用
      resources :looks, only: [:create, :destroy]
      resources :cutes, only: [:create, :destroy]
      member do
        get :cutes
        get :looks
      end
      # コメント用
      resources :comments, only: [:create, :destroy]
    end
    resources :users, except: [:index, :show]
    # 検索用
    get "search" => "searches#search_result"

    get 'users' => 'users#show', as: 'show'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
