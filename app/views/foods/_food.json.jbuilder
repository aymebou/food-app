json.extract! food, :id, :name, :carbs, :fibers, :proteins, :lipids, :cal, :imgUrl, :types_id :created_at, :updated_at
json.url food_url(food, format: :json)
