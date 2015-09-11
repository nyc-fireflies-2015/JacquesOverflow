FactoryGirl.define do
  factory :user do
    username {Faker::Internet.user_name}
    email {Faker::Internet.email}
    avatar_url {Faker::Avatar.image}
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

  end

end
