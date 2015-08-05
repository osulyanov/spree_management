$ ->
  $('#admin_bulk_unassign_current_taxon').on "click", (e) ->
    e.preventDefault()
    taxon_id = $('#taxon_id').val()
    product_ids = $('#taxon_products :input').serializeObject()['products_bulk_action[]']
    return false unless product_ids
    products_count = if Array.isArray(product_ids) then product_ids.length else 1
    products_word = if products_count == 1 then 'product' else 'products'
    return false unless confirm "Are you sure you want to unassgin the #{products_count} selected #{products_word} from this taxon?"
    $.ajax
      url: "/api/products/bulk_unassign_taxons",
      method: 'PATCH'
      data:
        taxon_id: taxon_id
        token: Spree.api_key
        product_ids: product_ids
      success: (data) ->
        update_products_list()

  $('#admin_bulk_unassign_all_taxons').on "click", (e) ->
    e.preventDefault()
    product_ids = $('#taxon_products :input').serializeObject()['products_bulk_action[]']
    return false unless product_ids
    products_count = if Array.isArray(product_ids) then product_ids.length else 1
    products_word = if products_count == 1 then 'product' else 'products'
    return false unless confirm "Are you sure you want to unassgin the #{products_count} selected #{products_word} from all Storefront taxons?"
    $.ajax
      url: "/api/products/bulk_unassign_taxons",
      method: 'PATCH'
      data:
        token: Spree.api_key
        product_ids: product_ids
        all_taxons: true
      success: (data) ->
        update_products_list()

  $('#taxon_id').off 'change'
  .on 'change', ->
    $('.select2-search-choice .with-tip').powerTip({
      smartPlacement: true,
      fadeInTime: 50,
      fadeOutTime: 50
    })
    update_products_list()
    false

  $('#sort_by').on 'change', ->
    if $(@).val() == 'date_asc'
      $('#taxon_products').sortable "disable"
    else
      $('#taxon_products').sortable "enable"
    update_products_list()
    false

update_products_list = ->
  el = $('#taxon_products')
  taxon_id = $('#taxon_id').val()
  return unless taxon_id
  $('#sorting_explanation').hide()
  $.ajax
    url: Spree.routes.taxon_products_api,
    data:
      id: taxon_id,
      token: Spree.api_key
      sort_by: $('#sort_by').val()
    success: (data) ->
      el.empty();
      if data.products.length == 0
        $('#taxon_products').html("<div class='alert alert-info'>" + Spree.translations.no_results + "</div>")
      else
        for product in data.products
          if product.master.images[0] != undefined && product.master.images[0].small_url != undefined
            product.image = product.master.images[0].small_url
          el.append(productTemplate({ product: product }))
        $('#sorting_explanation').show()

$.fn.serializeObject = ->
  o = {}
  a = this.serializeArray()
  $.each(a, ->
    if (o[this.name])
      if !o[this.name].push
        o[this.name] = [o[this.name]]
      o[this.name].push(this.value || '')
    else
      o[this.name] = this.value || ''
  )
  return o;