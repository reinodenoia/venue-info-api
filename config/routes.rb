Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :venues, only: %i[show update] do
      scope module: 'venues' do
        resources :platforms, only: %i[index show]
      end
    end
  end

  get '*unmatched_route', to: 'application#routing_error'
end
