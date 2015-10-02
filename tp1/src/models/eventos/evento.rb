class Evento
  attr_reader :costo

  def initialize(costo)
    @costo = costo
  end

  def generar_ocurrencias(medicion_del_mes)
    fail "Subclass responsability"
  end
end
