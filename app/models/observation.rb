class Observation
  attr_accessor :id, :type, :value, :unit
  def self.for_patient(patient_id)
    response = RestClient.get("http://localhost:3001/Observation?patient=#{@id}")
    json = JSON.parse(response.body)
  end
end
