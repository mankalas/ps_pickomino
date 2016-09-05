module GamesHelper
  def show_roll_form
    if @game.first_roll?
      render partial: 'first_roll_form'
    elsif available_values.empty?
      render partial: 'lost_turn'
    else
      render partial: 'roll_form'
    end
  end

  def available_values
    picked_values = @game.current_turn.rolls.collect { |roll| roll.pick }
    rolled_values = @game.last_roll_outcome.chars.uniq
    rolled_values - picked_values
  end

  def show_picked_dice
    Hash[@game.current_turn.rolls.collect do |roll|
               [roll.pick, roll.outcome.chars.count(roll.pick)] if roll.pick
         end]
  end
end
