require_relative '../helper'

class VelocidadTest < Test::Unit::TestCase

  def test_compara_correctamente_por_mayor_o_igual
    velocidad1 = Velocidad.new 100
    velocidad2 = Velocidad.new 85

    assert_equal true, OperadorDeVelocidades.mayor_o_igual(velocidad1, velocidad2)
  end

  def test_resta_correctamente
    velocidad1 = Velocidad.new 100
    velocidad2 = Velocidad.new 80

    nueva_velocidad = OperadorDeVelocidades.restar(velocidad1, velocidad2)

    assert_equal 20, nueva_velocidad.valor
  end
end
