class OcurrenciaDeEvento
  attr_reader :evento

  def initialize(evento)
    @evento = evento
  end

  def costo
    @evento.costo
  end
end
