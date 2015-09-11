class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
    	t.text :content, null:false, limit:2000	
      t.timestamps
    end
  end
end
