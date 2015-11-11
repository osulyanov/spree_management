Spree::Admin::UsersController.class_eval do
  def collection
    return @collection if @collection.present?
    if request.xhr? && params[:q].present?
      @collection = Spree.user_class.includes(:bill_address, :ship_address)
                        .where("spree_users.email #{LIKE} :search
                                     OR (spree_addresses.firstname #{LIKE} :search AND spree_addresses.id = spree_users.bill_address_id)
                                     OR (spree_addresses.lastname  #{LIKE} :search AND spree_addresses.id = spree_users.bill_address_id)
                                     OR (spree_addresses.firstname #{LIKE} :search AND spree_addresses.id = spree_users.ship_address_id)
                                     OR (spree_addresses.lastname  #{LIKE} :search AND spree_addresses.id = spree_users.ship_address_id)",
                               { :search => "#{params[:q].strip}%" })
                        .limit(params[:limit] || 100)
    else
      @search = Spree.user_class.ransack(params[:q])
      @search_results = @search.result
      if params[:by_role].present?
        @search_results = @search_results.where(id: Spree::Role.find(params[:by_role]).user_ids).page(params[:page]).per(Spree::Config[:admin_products_per_page])
      end
      @collection = @search_results.page(params[:page]).per(Spree::Config[:admin_products_per_page])
    end
  end
end
