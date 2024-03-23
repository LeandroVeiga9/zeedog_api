json.products @products, partial: "products/product", as: :product

json.pagination do
  json.total_pages @products.total_pages
  json.current_page @products.current_page
  json.next_page @products.next_page
  json.prev_page @products.prev_page
end

