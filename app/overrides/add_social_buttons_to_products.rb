Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'add_social_buttons_to_products_show',
  insert_after: '[data-hook="cart_form"]',
)