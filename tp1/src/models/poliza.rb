require 'securerandom'

class Poliza
  attr_reader :poliza

  def initialize
    @poliza = SecureRandom.uuid
  end
end
