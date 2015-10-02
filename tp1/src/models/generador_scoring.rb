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
