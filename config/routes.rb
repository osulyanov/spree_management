Spree::Core::Engine.add_routes do
  get '/admin/reports/catalogue' => 'admin/reports#catalogue', format: :csv, as: 'catalogue_admin_reports'

  namespace :api, defaults: { format: 'json' } do
    resources :products do
      collection do
        patch :bulk_unassign_taxons
      end
    end
  end
end
