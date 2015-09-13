FactoryGirl.define do
  factory :user do
    username {Faker::Name.name}
    email {Faker::Internet.email}
    bio "This user likes to be mysterious"
    password "supersecure"

    factory :unique_username_user do
    	username nil
    	password nil
    end

    factory :unique_email_user do
    	email nil
    	password nil
    end

    factory(:invalid_user) do
        username nil
        email nil
    end
  end
end
