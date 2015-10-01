require_relative 'measure'

class Evento
  attr_reader :costo

  def initialize(costo)
    @costo = costo
  end

  def generar_ocurrencias(medicion_del_mes)
    fail "Subclass responsability"
  end
end

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
        velocidad_maxima.dame_una_nueva_velocidad_incrementada_por @porcentaje_limite

      # TODO: Comparar objetos
      if medicion.velocidad.valor >= velocidad_limite.valor
        ocurrencias << OcurrenciaDeEvento.new(self)
      end
    end

    ocurrencias
  end
end

class EventoZonaInsegura < Evento
  def generar_ocurrencias(medicion_del_mes)
    ocurrencias = []

    medicion_del_mes.mediciones.each do |medicion|
      if MapaAPI.es_zona_insegura? medicion.coordenada, medicion.fecha
        ocurrencias << OcurrenciaDeEvento.new(self)
      end
    end

    ocurrencias
  end
end

class EventoCambioBrusco < Evento

  def initialize(costo)
    super

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

class Porcentaje
  def initialize(valor)
    @valor = valor
  end

  def aplicar_a(numero)
     numero * @valor / 100.0
  end
end

class MapaAPI
  class <<self
    def velocidad_maxima(coordenada)
      Velocidad.new 60
    end

    def es_zona_insegura?(coordenada, timestamp)
      coordenada.longitud > 10
    end
  end
end
