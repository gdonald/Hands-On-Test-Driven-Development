FactoryBot.define do
  factory :image do
    name { 'Name' }
    
    after(:build) do |image|
      io = Rails.root.join('spec/factories/images/image.jpeg').open
      image.image.attach(io: io,
                         filename: 'image.jpeg',
                         content_type: 'image/jpeg')
    end
  end
end
