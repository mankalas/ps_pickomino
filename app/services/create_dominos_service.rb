class CreateDominosService
  def call
    (21..36).each { |value| Domino.create(value: value, nb_worms: nb_worms(value)) }
  end

  private

  def nb_worms(value)
    if value.between?(21, 24)
      1
    elsif value.between?(25, 28)
      2
    elsif value.between?(29, 32)
      3
    else
      4
    end
  end
end
