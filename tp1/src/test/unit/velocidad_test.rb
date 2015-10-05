require_relative '../helper'

class VelocidadTest < Test::Unit::TestCase

  def test_representa_una_velocidad_de_60
    velocidad = Velocidad.new 60

    assert_equal 60, velocidad.valor
  end

  def test_incrementa_velocidad_es_inmutable
    velocidad = Velocidad.new 100
    _20_porciento = Porcentaje.new 20

    assert_equal 100, velocidad.valor

    velocidad.nueva_velocidad_incrementada_por _20_porciento

    assert_equal 100, velocidad.valor
  end

  def test_incrementa_velocidad_en_20_porciento
    velocidad = Velocidad.new 100
    _20_porciento = Porcentaje.new 20

    assert_equal 100, velocidad.valor

    velocidad = velocidad.nueva_velocidad_incrementada_por _20_porciento

    assert_equal 120, velocidad.valor
  end
end
