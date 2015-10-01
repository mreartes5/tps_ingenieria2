require_relative 'measure'
require_relative 'evento'

gen = GeneradorDeScoring.new


coord1 = Coordenada.new(1,1)
coord2 = Coordenada.new(23,13)
coord3 = Coordenada.new(2,2)
# coord4 = Coordenada.new(1,2)

medicion = Medicion.new coord1, Velocidad.new(100), Time.now
medicion2 = Medicion.new coord2, Velocidad.new(130), Time.now
medicion3 = Medicion.new coord3, Velocidad.new(150), Time.now

del_mes = MedidaDelMes.new [medicion, medicion2, medicion3], :policy

scoring = gen.generar_scoring del_mes
require 'pry'; binding.pry

puts scoring.puntaje


# Como dueño quiero que la aplicacion consulte un servicio de mapas para obtener informacion de velocidad máxima permitida del lugar transitado
# Como dueño quiero que la aplicacion consulte un servicio de mapas para obtener informacion de Zona insegura del lugar transitado
