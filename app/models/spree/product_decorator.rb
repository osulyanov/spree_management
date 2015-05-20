Spree::Product.class_eval do
  def self.to_csv_report(options = {})
    CSV.generate(options) do |csv|
      csv << csv_column_names
      all.each do |p|
        csv << [p.sku, p.name, p.description,
                p.taxons.map(&:name).join(', '), p.full_url, (p.total_on_hand > 0 ? 'in stock' : 'out of stock'),
                p.price.to_s, p.shipping_category.try(:name), p.property(:Selleralias),
                p.property(:Sellerusername), p.property(:ListingId),
                (p.available_on ? p.available_on.strftime('%D') : '')]
      end
    end
  end

  def self.csv_column_names
    %w(ID title description categories link availability price shipping_category
       selleralias sellerusername listingID available_on)
  end

  def full_url
    Spree::Core::Engine.routes.url_helpers.product_url(self, host: Rails.application.routes.default_url_options[:host])
  end
end
