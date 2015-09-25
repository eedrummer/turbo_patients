json.array!(@patients) do |patient|
  json.extract! patient, :id, :name, :gender
  json.url patient_url(patient, format: :json)
end
