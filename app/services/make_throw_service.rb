class MakeThrow
  def initialize(nb_dice)
    @nb_dice = nb_dice
  end

  def call
    @nb_dice.times.map { (rand(6) + 1).to_s }.join.gsub('6', 'W')
  end
end
