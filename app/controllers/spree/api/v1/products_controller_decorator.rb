Spree::Api::ProductsController.class_eval do
  def bulk_unassign_taxons
    taxon_id = params[:taxon_id]
    all_taxons = params[:all_taxons]

    Spree::Product.where(id: params[:product_ids]).includes(:taxons).each do |product|
      if all_taxons
        new_taxons = []
        product.taxons.includes(:taxonomy).each do |taxon|
          new_taxons << taxon.id unless taxon.taxonomy.name == 'Storefront Categories'
        end
        product.taxon_ids = new_taxons
      else
        product.taxon_ids = product.taxon_ids - [taxon_id.to_i]
      end
    end

    render json: true
  end
end
