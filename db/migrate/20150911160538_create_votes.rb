class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.integer :value, null:false
    	t.references :voteable, polymorphic: true, index:true
    	t.references :voter
      t.timestamps
    end
  end
end
