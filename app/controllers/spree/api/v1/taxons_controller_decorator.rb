Spree::Api::TaxonsController.class_eval do
  def products
    taxon = Spree::Taxon.find(params[:id])
    @products = taxon.products.ransack(params[:q]).result
    @products = @products.reorder(available_on: :asc) if params[:sort_by] == 'date_asc'
    @products = @products.page(params[:page]).per(params[:per_page] || 500)
    render "spree/api/products/index"
  end
end
