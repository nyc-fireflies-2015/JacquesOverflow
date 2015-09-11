FactoryGirl.define do
  factory :question do
    title {Faker::Hacker.say_something_smar}
    content {Faker::Lorem.paragraph}
  end

end
