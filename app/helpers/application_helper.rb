module ApplicationHelper
  def get_categories
    {
			"Jet Ski / Watercraft" => 1,
			"ATV / UTV" => 2,
			"RV / Trailer" => 3,
			"Snow Mobile" => 4,
			"Canoe / Kayak" => 5,
			"Golf Cart" => 6,
			"Scooter / Dirt Bike" => 7,
			"Light Weight Boat" => 8 }
  end
  
  def get_reverse_categories
    idx = {}
    get_categories.each do |k, v|
      idx[v] = k
    end
    return idx
  end
  
end
