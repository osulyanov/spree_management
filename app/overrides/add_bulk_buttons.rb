Deface::Override.new(:virtual_path  => "spree/admin/shared/_table_filter",
                     :insert_bottom => "div#table-filter",
                     :partial       => "spree/admin/shared/bulk_buttons",
                     :name          => "bulk_buttons")