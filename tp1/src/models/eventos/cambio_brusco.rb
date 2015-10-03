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

      velocidad_diferencia = OperadorDeVelocidades.restar(velocidad1, velocidad2)
      if OperadorDeVelocidades.mayor_o_igual(velocidad_diferencia, @velocidad_limite_de_cambio)
        ocurrencias << OcurrenciaDeEvento.new(self)
      end
    end

    ocurrencias
  end
end
