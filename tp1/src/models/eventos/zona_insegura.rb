require_relative 'evento'

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
