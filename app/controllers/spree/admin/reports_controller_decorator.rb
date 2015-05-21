Spree::Admin::ReportsController.class_eval do
  before_filter :add_catalogue_report

  def catalogue
    @products = Spree::Product.order(created_at: :desc)
    send_data(@products.to_csv_report, type: 'text/csv; charset=utf-8; header=present', filename: catalogue_report_name)
  end

  private
  def add_catalogue_report
    Spree::Admin::ReportsController.add_available_report!(:catalogue)
  end

  def catalogue_report_name
    "#{Spree::Config[:site_name].gsub(/\s/, '_')}_Catalogue_Report_#{DateTime.now.strftime "%Y-%m-%dT%H%M"}.xls"
  end
end
