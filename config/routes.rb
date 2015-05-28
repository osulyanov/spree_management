Spree::Core::Engine.add_routes do
  get '/admin/reports/catalogue' => 'admin/reports#catalogue', format: :csv, as: 'catalogue_admin_reports'
  # patch '/admin/products/bulk_unassign_taxons' => 'admin/products#bulk_unassign_taxons', as: 'products_bulk_unassign_taxons'

  namespace :api, defaults: { format: 'json' } do
    resources :products do
      patch :bulk_unassign_taxons
    end
  end
end
