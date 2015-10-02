require_relative 'evento'

class EventoCambioBrusco < Evento

  def initialize(costo)
    super

    # Esta velocidad no es parametro, por que solo queremos tener una instancia
    # de cambio brusco.
    @velocidad_limite_de_cambio = Velocidad.new(20)
  end

  def generar_ocurrencias(medicion_del_mes)
    ocurrencias = []

    medicion_del_mes.mediciones.each_cons(2) do |mediciones|
      velocidad1, velocidad2 = mediciones.map(&:velocidad)

      #TODO: Comparar y restar objetos
      if (velocidad1.valor - velocidad2.valor).abs >= @velocidad_limite_de_cambio.valor
        ocurrencias << OcurrenciaDeEvento.new(self)
      end
    end

    ocurrencias
  end
end
