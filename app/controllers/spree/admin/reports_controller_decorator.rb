Spree::Admin::ReportsController.class_eval do
  before_filter :add_catalogue_report

  def catalogue
    @products = Spree::Product.all.order(created_at: :desc)

    csv_string = CSV.generate do |csv|
      csv << %w(ID title description
                categories
                link
                availability
                price shipping_category selleralias
                sellerusername listingID available_on)

      @products.each do |p|
        csv << [p.sku, p.name, p.description,
                p.taxons.map(&:name).join(', '),
                Spree::Core::Engine.routes.url_helpers.product_url(p, host: Rails.application.routes.default_url_options[:host]),
                '',
                '', '', '',
                '', '', '']
      end

    end
    send_data(csv_string, type: 'text/csv; charset=utf-8; header=present', filename: catalogue_report_name)
  end

  private
  def add_catalogue_report
    Spree::Admin::ReportsController.add_available_report!(:catalogue)
  end

  def catalogue_report_name
    "#{Spree::Config[:site_name].gsub(/\s/, '_')}_Catalogue_Report_#{DateTime.now.strftime "%Y-%m-%dT%H%M"}.csv"
  end
end

