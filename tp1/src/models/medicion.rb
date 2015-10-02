class Medicion
  attr_reader :coordenada, :velocidad, :fecha

  def initialize(coordenada, velocidad, fecha)
    @coordenada, @velocidad, @fecha = coordenada, velocidad, fecha
  end
end
