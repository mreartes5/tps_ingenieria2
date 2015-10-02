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
