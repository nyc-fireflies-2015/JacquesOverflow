class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
    	t.text :content, null:false, limit:2000	
    	t.references :responder
    	t.references :question
      t.timestamps
    end
  end
end
