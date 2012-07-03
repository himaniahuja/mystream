module ItemsHelper
  def parse_category(category)
    if category == 1
      return "Car"
    elsif category == 2
      return "Boat"
    end
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
end
