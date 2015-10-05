class Velocidad
  attr_reader :valor
  include Comparable

  # TODO: Faltaria agregar las Unidades de KM/h y esas cosas
  def initialize(valor)
    @valor = valor
  end

  def nueva_velocidad_incrementada_por(porcentaje)
    Velocidad.new porcentaje.aplicar_a(@valor) + @valor
  end

  def diferencia_de_velocidad_con(otra_velocidad)
    Velocidad.new((valor - otra_velocidad.valor).abs)
  end

  def <=> otra_velocidad
    valor <=> otra_velocidad.valor
  end
end
