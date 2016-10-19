Deface::Override.new(
  virtual_path: 'spree/checkout/registration',
  name: 'add_container_id_to_checkout_registration',
  insert_after: '[id="registration"]',
  text: %q(
    <% @container_id = "checkout-registration" %>
  )
)