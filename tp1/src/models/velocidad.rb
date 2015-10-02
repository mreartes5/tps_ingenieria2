class Velocidad
  attr_reader :valor

  # TODO: Faltaria agregar las Unidades de KM/h y esas cosas
  def initialize(valor)
    @valor = valor
  end

  # TODO: Cambiar el nombre
  def dame_una_nueva_velocidad_incrementada_por(porcentaje)
    Velocidad.new porcentaje.aplicar_a(@valor) + @valor
  end
end
