Deface::Override.new(
  virtual_path: 'spree/checkout/_address',
  name: 'add_container_id_to_checkout_address',
  insert_after: '[class="row"]',
  text: %q(
    <% @container_id = "checkout-address" %>
  )
)