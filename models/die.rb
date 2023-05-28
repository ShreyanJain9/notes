# frozen_string_literal: true

class Die
  attr_reader :face

  def roll
    @face = 1 + rand(6)
  end

  def show
    @face
  end

  def cheat(facenumber)
    if facenumber < 7 && facenumber > 0
      @face = facenumber
    else
      throw "Invalid face number"
    end
  end
end
