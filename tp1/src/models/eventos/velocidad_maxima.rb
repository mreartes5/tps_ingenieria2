require_relative 'evento'

class EventoVelocidadMaxima < Evento
  def initialize(costo, porcentaje_limite)
    super(costo)

    @porcentaje_limite = porcentaje_limite
  end

  def generar_ocurrencias(medicion_del_mes)
    ocurrencias = []

    medicion_del_mes.mediciones.each do |medicion|
      velocidad_maxima = MapaAPI.velocidad_maxima medicion.coordenada
      velocidad_limite =
        velocidad_maxima.nueva_velocidad_incrementada_por @porcentaje_limite

      if medicion.velocidad >= velocidad_limite
        ocurrencias << OcurrenciaDeEvento.new(self)
      end
    end

    ocurrencias
  end
end
