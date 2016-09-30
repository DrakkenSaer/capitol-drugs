Deface::Override.new(
  virtual_path: 'spree/products/_cart_form',
  name: 'add_rating_to_product_price',
  insert_bottom: '[data-hook="product_price"]',
  text: %q(
    <% stars = @product.stars %>
    <div id="product-stars" class="col-xs-6">
      <span title="<%= txt_stars(stars) %>">
        <%= render "spree/reviews/stars", stars: stars %>
      </span>
    </div>
  )
)