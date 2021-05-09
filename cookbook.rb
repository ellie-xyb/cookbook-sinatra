require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(file)
    @recipes = []
    @file = file
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_to_csv
  end

  def mark_as_read(ind)
    @recipes[ind].mark_as_read!
    save_to_csv
    @recipes[ind]
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@file, csv_options) do |row|
      @recipes << Recipe.new(row)
    end
  end

  def save_to_csv
    CSV.open(@file, 'wb') do |csv|
      csv << %w[name description rating prep_time done]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?]
      end
    end
  end
end
