require_relative 'evento'

class Medicion
  attr_reader :coordenada, :velocidad, :fecha

  def initialize(coordenada, velocidad, fecha)
    @coordenada, @velocidad, @fecha = coordenada, velocidad, fecha
  end
end

class Coordenada
  attr_reader :longitud, :latitud

  def initialize(latitud, longitud)
    @latitud, @longitud = latitud, longitud
  end
end

class Velocidad
  attr_reader :valor

  def initialize(valor)
    @valor = valor
  end

  def dame_una_nueva_velocidad_incrementada_por(porcentaje)
    Velocidad.new porcentaje.aplicar_a(@valor) + @valor
  end
end

class MedidaDelMes
  attr_reader :mediciones, :poliza

  def initialize(mediciones, poliza)
    @mediciones, @poliza = mediciones, poliza
  end
end



class GeneradorDeScoring

  def initialize
    @eventos = []
    @eventos << EventoVelocidadMaxima.new(20, Porcentaje.new(10))
    @eventos << EventoZonaInsegura.new(15)
    @eventos << EventoCambioBrusco.new(83)
  end

  def generar_scoring(medicion_del_mes)
    ocurrencias = @eventos.map do |evento|
      evento.generar_ocurrencias medicion_del_mes
    end.flatten

    scoring = Scoring.new ocurrencias
  end
end

class Scoring
  def initialize(ocurrencias_de_eventos)
    @ocurrencias_de_eventos = ocurrencias_de_eventos
  end

  def puntaje
    @ocurrencias_de_eventos.map(&:costo).reduce(:+)
  end
end

class OcurrenciaDeEvento
  def initialize(evento)
    @evento = evento
  end

  def costo
    @evento.costo
  end
end

