class MedidaDelMes
  attr_reader :mediciones, :poliza

  def initialize(mediciones, poliza)
    @mediciones, @poliza = mediciones, poliza
  end
end
