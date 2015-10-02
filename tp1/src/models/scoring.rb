class Scoring
  def initialize(ocurrencias_de_eventos)
    @ocurrencias_de_eventos = ocurrencias_de_eventos
  end

  def puntaje
    @ocurrencias_de_eventos.map(&:costo).reduce(:+)
  end
end
