Spree::Api::TaxonsController.class_eval do
  def products
    taxon = Spree::Taxon.find(params[:id])
    @products = taxon.products.ransack(params[:q]).result
    @products = @products.reorder(available_on: :asc) if params[:sort_by] == 'date_asc'
    if params[:filter_by_seller].present?
      property = Spree::Property.find_by(name: 'Selleralias')
      product_ids = Spree::ProductProperty.where(property: property, value: params[:filter_by_seller]).pluck :product_id
      @products = @products.where id: product_ids
    end
    @products = @products.page(params[:page]).per(params[:per_page] || 500)
    render "spree/api/products/index"
  end
end
