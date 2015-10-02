class Coordenada
  attr_reader :longitud, :latitud

  def initialize(latitud, longitud)
    @latitud, @longitud = latitud, longitud
  end
end
