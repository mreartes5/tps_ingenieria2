class Porcentaje
  def initialize(valor)
    @valor = valor
  end

  def aplicar_a(numero)
     numero * @valor / 100.0
  end
end
