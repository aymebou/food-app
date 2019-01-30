class MealPlannerController < ApplicationController
  max_calories = 500
  
  def find_meals
    max_calories = 500
    meals = []
    starters = select_foods_with_calories_under(max_calories, 1)
    meals = embedd_each_inside_array(sarters)

  end

  private
  def add_dish_type_to_meal(max_calories, meals, dish_type)
    next_dish = select_foods_with_calories_under(max_calories - lowest_cal_meal(meals)[:cal], dish_type)

  end
  def lowest_cal_meal(meals)
    return meals.min {|a,b| a[:cal] <=> b[:cal] }
  end
  def dump_largest_meals(meals, max_calories)
    meals.each do |meal|
      if meal_is_more_cals_than(meal, max_calories)
        meals.delete(meal)
      end
    end
  end
  def embedd_each_inside_array(array)
    return array.collect {|element| {cal: element.cal, first_dish: Array(element)} }
  end
  def select_foods_with_calories_under(calorie, foodtype)
    food = Food.all.select(:name, :cal).where("type_id = ? ", foodtype).where("cal < ? ", calorie)
    return food.to_a
  end
  def meal_is_more_cals_than(meal, max_calories)
    total = 0
    meal.each do |dish|
      total = total + dish.cal
    end
    return total < calorie
  end
end
