module GamesHelper
  def show_actions
    render partial: @current_turn.lost? ? 'lost_turn' : 'actions'
  end

  def show_roll_form
    render partial: 'roll_form' if @current_turn.can_roll?
  end

  def show_pick_dice_form
    render partial: 'pick_dice_form' if @current_turn.can_pick_dice?
  end

  def show_pick_domino_form
    render partial: 'pick_domino_form' if @current_turn.can_pick_domino?
  end

  def show_picked_dice
    render partial: 'picked_dice' unless @current_turn.first_pick?
  end

  def show_roll_outcome
    show_roll = @current_turn.rolls.present? && @current_turn.rolls.last.pick.nil?
    render partial: 'roll_outcome' if show_roll
  end

  def player_dominos(player)
    player.in_game_dominos.collect { |domino| "[#{domino.value} | #{domino.nb_worms}]" }.join(', ')
  end

  def available_dice_values
    @current_turn.available_dice_values
  end

  def available_dominos_values
    FetchAvailableDominos.new(@game).call.collect { |domino| domino.value }
  end

  def lost_domino
    @game.dominos.max_by(&:value).value
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
end
