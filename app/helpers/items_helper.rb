module ItemsHelper
  def parse_category(category)
    return get_reverse_categories[category]
  end
  
  def parse_condition(condition)
    if condition == 1
      return "Excellent"
    elsif condition == 2
      return "Great"
    elsif condition == 3
      return "Good"
    end
  end
  
  def get_search_categories
    c = {"Search by categories" => 0}
    get_categories.each do |k, v|
      c[k] = v
    end
    return c
  end
  
end
