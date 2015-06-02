Deface::Override.new(:virtual_path  => "spree/admin/taxons/index",
                     :insert_before => "ul#taxon_products",
                     :partial       => "spree/admin/shared/bulk_buttons",
                     :name          => "bulk_buttons")