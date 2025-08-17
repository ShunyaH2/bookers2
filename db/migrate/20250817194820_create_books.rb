class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      ## 課題指示_STEP2
      t.text :title
      t.text :comment

      t.timestamps
    end
  end
end
