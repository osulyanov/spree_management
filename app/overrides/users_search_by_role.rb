Deface::Override.new(virtual_path: "spree/admin/users/index",
                     name: 'add-search_by_role',
                     insert_after: "[data-hook='admin_users_index_search_buttons']",
                     partial: 'spree/admin/users/search_by_role',
                     :original => '57fa0ad07b7627308a6f607581e0599ad66ec8a0'
)
