Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :question

  get 'test' => 'answer#load_question'
  post 'answer/create' => 'answer#save_answer', as: "test/answer"
  get 'answer/result' => 'answer#result', as: "test/result"
        
end


