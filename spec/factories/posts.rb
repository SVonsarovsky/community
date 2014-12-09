FactoryGirl.define do
  factory :post do
    #title "Post title"
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraph }
    user
  end

end
