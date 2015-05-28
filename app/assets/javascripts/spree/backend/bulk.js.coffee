$ ->
  $('#admin_bulk_unassign_taxon').on "click", (e) ->
    e.preventDefault()
    # TODO: Send ajax to unassign taxons
    $.ajax
      url: Spree.routes.api_product_bulk_unassign_taxons,
      data:
        id: taxon_id,
        token: Spree.api_key
      success: (data) ->
        el.empty();
        if data.products.length == 0
          $('#taxon_products').html("<div class='alert alert-info'>" + Spree.translations.no_results + "</div>")
        else
          for product in data.products
            if product.master.images[0] != undefined && product.master.images[0].small_url != undefined
              product.image = product.master.images[0].small_url
            el.append(productTemplate({ product: product }))

    all_taxons = confirm 'Unassign from all Storefront Taxons?'
    update_products_list()


update_products_list = ->
  el = $('#taxon_products')
  taxon_id = $('#taxon_id').val()
  return unless taxon_id
  $.ajax
    url: Spree.routes.taxon_products_api,
    data:
      id: taxon_id,
      token: Spree.api_key
    success: (data) ->
      el.empty();
      if data.products.length == 0
        $('#taxon_products').html("<div class='alert alert-info'>" + Spree.translations.no_results + "</div>")
      else
        for product in data.products
          if product.master.images[0] != undefined && product.master.images[0].small_url != undefined
            product.image = product.master.images[0].small_url
          el.append(productTemplate({ product: product }))