# Esto es una implementacion ad-hoc de la API que sirve solo para testing
#
class MapaAPI
  class <<self
    def velocidad_maxima(coordenada)
      Velocidad.new 50
    end

    def es_zona_insegura?(coordenada, timestamp)
      coordenada.longitud > 10
    end
  end
end
