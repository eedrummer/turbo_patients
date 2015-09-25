class Patient
  attr_accessor :first_name, :last_name, :id

  def self.all
    response = RestClient.get("http://localhost:3001/Patient")
    json = JSON.parse(response.body)
    patients = []
    json['entry'].each do |e|
      p = Patient.new
      resource = e['resource']
      p.first_name = resource['name'].first['given'].first
      p.last_name = resource['name'].first['family'].first
      p.id = resource['id']

      patients << p
    end

    patients
  end

end
