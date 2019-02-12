Deface::Override.new(
  virtual_path: 'spree/shared/_footer',
  name: 'pages_in_footer',
  insert_bottom: '#footer-right',
  partial: 'spree/pages/content_footer'
)