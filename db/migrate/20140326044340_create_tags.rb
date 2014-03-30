class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :xloc
      t.integer :yloc
      t.integer :width
      t.integer :height
    end
  end
end
