json.array!(@contacts) do |contact|
  json.extract! contact, :full_name, :title, :company, :phone, :email, :qq, :weibo, :website, :background_info
  json.url contact_url(contact, format: :json)
end
