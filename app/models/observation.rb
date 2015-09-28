class Observation
  attr_accessor :id, :kind, :value, :unit, :effective_time
  def self.for_patient(patient_id)
    response = RestClient.get("http://localhost:3001/Observation?patient=#{patient_id}")
    json = JSON.parse(response.body)
    observations = []
    json['entry'].each do |e|
      o = Observation.new
      resource = e['resource']
      o.id = resource['id']
      case resource['code']['coding'].first['code']
      when '8480-6'
        o.kind = :systolic_bp
      when '29463-7'
        o.kind = :weight
      when '8462-4'
        o.kind = :diastolic_bp
      when '8302-2'
        o.kind = :height
      else
        o.kind = :other
      end
      o.value = resource['valueQuantity']['value'].to_f
      o.unit = resource['valueQuantity']['units']
      o.effective_time = Time.parse(resource['effectiveDateTime'])
      observations << o
    end

    observations
  end

  def self.sorted_bmi(patient_id)
    observations = for_patient(patient_id)
    observations.sort_by! {|o| o.effective_time}
    height = observations.find {|o| o.kind == :height}
    bmi = []
    observations.each do |o|
      if o.kind == :weight
        bmi << {effective_time: o.effective_time,
                bmi: ((o.value/height.value**2)*703)}
      end
    end
    bmi
  end
end
