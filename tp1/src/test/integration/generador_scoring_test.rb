require_relative '../helper'

class GeneradorScoringTest < Test::Unit::TestCase

  def setup
    @generador = GeneradorDeScoring.new
    @coord_1_1 = Coordenada.new 1, 1
    @coord_2_2 = Coordenada.new 2, 2
    @coord_1_2 = Coordenada.new 1, 2
    @coord_23_13 = Coordenada.new 23, 13

    @velocidad_40 = Velocidad.new 40
    @velocidad_60 = Velocidad.new 60
    @velocidad_100 = Velocidad.new 100
    @velocidad_130 = Velocidad.new 130
    @velocidad_150 = Velocidad.new 150

    @poliza = Poliza.new
  end


  def test_medicion_vacia_tiene_cero_puntos
    del_mes = MedicionDeMes.new [], @poliza

    scoring = @generador.generar_scoring del_mes

    assert_equal 0, scoring.puntaje
    assert scoring.infracciones.empty?
  end

  def test_buen_conductor_no_recibe_puntos
    mediciones = [
      Medicion.new(@coord_1_1, @velocidad_40, Time.now),
      Medicion.new(@coord_1_2, @velocidad_40, Time.now),
      Medicion.new(@coord_2_2, @velocidad_40, Time.now),
    ]

    del_mes = MedicionDeMes.new mediciones, @poliza
    scoring = @generador.generar_scoring del_mes

    assert_equal 0, scoring.puntaje
    assert scoring.infracciones.empty?
  end

  def test_excede_velocidad_por_mas_del_35_porciento
    mediciones = [
      Medicion.new(@coord_1_1, @velocidad_150, Time.now),
    ]

    del_mes = MedicionDeMes.new mediciones, @poliza
    scoring = @generador.generar_scoring del_mes
    infracciones = scoring.infracciones.map(&:evento).map(&:class)

    assert_equal 20, scoring.puntaje
    assert_equal 1, scoring.infracciones.size
    assert infracciones.include?(EventoVelocidadMaxima)
  end

  def test_excede_velocidad_por_menos_del_35_porciento
    mediciones = [
      Medicion.new(@coord_1_1, @velocidad_60, Time.now),
    ]

    del_mes = MedicionDeMes.new mediciones, @poliza
    scoring = @generador.generar_scoring del_mes

    assert_equal 0, scoring.puntaje
    assert scoring.infracciones.empty?
  end

  def test_infraccion_zona_insegura_y_alta_velocidad
    mediciones = [
      Medicion.new(@coord_23_13, @velocidad_150, Time.now),
    ]

    del_mes = MedicionDeMes.new mediciones, @poliza
    scoring = @generador.generar_scoring del_mes
    infracciones = scoring.infracciones.map(&:evento).map(&:class)

    assert_equal 35, scoring.puntaje
    assert_equal 2, scoring.infracciones.size
    assert infracciones.include?(EventoVelocidadMaxima)
    assert infracciones.include?(EventoZonaInsegura)
  end

  def test_alejandro_al_volante
    velocidad_mataloni = Velocidad.new 230
    mediciones = [
      Medicion.new(@coord_1_1, @velocidad_60, Time.now),
      Medicion.new(@coord_2_2, @velocidad_150, Time.now),
      Medicion.new(@coord_1_2, @velocidad_100, Time.now),
      Medicion.new(@coord_23_13, velocidad_mataloni, Time.now),
    ]

    del_mes = MedicionDeMes.new mediciones, @poliza
    scoring = @generador.generar_scoring del_mes
    infracciones = scoring.infracciones.map(&:evento).map(&:class)

    puntaje_esperado =
      3 * 20 + # Velocidad Maxima
      1 * 15 + # Zona Insegura
      3 * 83   # Cambio Brusco

    assert_equal puntaje_esperado, scoring.puntaje
    assert_equal 7, scoring.infracciones.size
    assert_equal 3, infracciones.select{|e| e == EventoVelocidadMaxima }.count
    assert_equal 1, infracciones.select{|e| e == EventoZonaInsegura }.count
    assert_equal 3, infracciones.select{|e| e == EventoCambioBruscoDeVelocidad }.count
  end
end
