class OperadorDeVelocidades
  class <<self
    def mayor_o_igual(una_velocidad, otra_velocidad)
      una_velocidad.valor >= otra_velocidad.valor
    end

    def restar(una_velocidad, otra_velocidad)
      Velocidad.new((una_velocidad.valor - otra_velocidad.valor).abs)
    end
  end
end