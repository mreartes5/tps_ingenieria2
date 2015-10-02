class Scoring
  def initialize(ocurrencias_de_eventos)
    @ocurrencias_de_eventos = ocurrencias_de_eventos
  end

  def puntaje
    @ocurrencias_de_eventos.map(&:costo).reduce(:+) || 0
  end

  # TODO: Definir si es un nombre valido o no.
  # Ya sea para cambiar el metodo o la clase OcurrenciaDeEvento
  def infracciones
    @ocurrencias_de_eventos
  end
end
