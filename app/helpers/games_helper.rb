module GamesHelper
  def show_actions
    render partial: @current_turn.lost? ? 'lost_turn' : 'actions'
  end

  def show_roll_form
    render partial: 'first_roll_form' unless @current_turn.rolls.present?
  end

  def show_pick_dice_form
    render partial: 'roll_form' if @current_turn.can_pick_dice?
  end

  def show_pick_domino_form
    render partial: 'pick_domino_form' if @current_turn.can_pick_domino?
  end

  def picked_dice
    hash = Hash.new
    @current_turn.rolls.collect do |roll|
      if roll.pick
        hash[roll.pick] = roll.outcome.chars.count(roll.pick)
      end
    end
    hash
  end

  def first_roll?
    @current_turn.rolls.present? if @current_turn
  end

  def show_picked_dice
    render partial: 'picked_dice' if @current_turn.rolls.present?
  end

  def show_roll_outcome
    render partial: 'roll_outcome' if @current_turn.rolls.present?
  end

  def show_available_dice_values
    @current_turn.available_dice_values
  end

  def show_available_dominos_values
    FetchAvailableDominos.new(@game).call.collect { |domino| domino.value }
  end
end
