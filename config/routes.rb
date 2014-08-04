QuentManager::Application.routes.draw do
  resources :acompanhamentos

  resources :empresas

  resources :cardapios

  devise_for :usuarios, :controllers => { :registrations => "registrations"}
  
  #match "/produtos/atualizar/:id" => "produtos#atualizar", via: [:get, :post]
  resources :produtos do
    member do
      post :atualizar
      post :atualizar_estoque
    end
  end

  resources :pedidos

  resources :clientes do
    member do
      get :bloquear
      get :confirmar_bloqueio
      get :desbloquear
      get :confirmar_desbloqueio
    end
  end

    get "home/relatorio_produtos"

  resources :home

  root to: "home#index"

  # The priority is based upon pedido of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'produtos/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: produto.id)
  #   get 'produtos/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :produtos

  # Example resource route with options:
  #   resources :produtos do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :produtos do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :produtos do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/produtos/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :produtos
  #   end
end
