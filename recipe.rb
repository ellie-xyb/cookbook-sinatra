class Recipe
  attr_reader :name, :description, :rating, :prep_time

  def initialize(attr = {})
    @name = attr[:name]
    @description = attr[:description]
    @rating = attr[:rating]
    @done = attr[:done] == 'true'
    @prep_time = attr[:prep_time]
  end

  def done?
    @done
  end

  def mark_as_read!
    @done = true
  end
end
