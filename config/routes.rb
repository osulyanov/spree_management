Spree::Core::Engine.add_routes do
  get '/admin/reports/catalogue' => 'admin/reports#catalogue', format: :csv, as: 'catalogue_admin_reports'
end
