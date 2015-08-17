Deface::Override.new(:virtual_path  => "spree/admin/taxons/index",
                     :replace_contents => "span#sorting_explanation",
                     :partial       => "spree/admin/shared/bulk_buttons",
                     :name          => "bulk_buttons")