class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
    	t.string :title, null:false, limit:150
    	t.text :content, null:false, limit:5000
    	t.references :submitter
    	t.integer :best_answer_id
      t.timestamps
    end
  end
end
