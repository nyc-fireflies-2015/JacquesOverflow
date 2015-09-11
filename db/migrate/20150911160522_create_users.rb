class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :username, null:false, limit:50
    	t.string :email, null:false, limit:50
    	t.string :avatar_url, null:false, limit:50
    	t.string :password_digest, null:false   
    	t.text :bio, default:"This user likes to be mysterious"	
      t.timestamps
    end
  end
end
