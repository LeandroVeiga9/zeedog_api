json.skus @skus, partial: "skus/sku", as: :sku

json.pagination do
  json.total_pages @skus.total_pages
  json.current_page @skus.current_page
  json.next_page @skus.next_page
  json.prev_page @skus.prev_page
end
