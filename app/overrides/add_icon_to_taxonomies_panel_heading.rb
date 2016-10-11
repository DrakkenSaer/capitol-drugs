Deface::Override.new(
  virtual_path: 'spree/shared/_taxonomies',
  name: 'add_icon_to_taxonomies_panel_heading',
  insert_bottom: '.taxonomy-root',
  text: %q(
    <span class="glyphicon glyphicon-chevron-up toggle-chevron"></span>
  )
)