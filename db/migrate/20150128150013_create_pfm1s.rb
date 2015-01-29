class CreatePfm1s < ActiveRecord::Migration
  def change
    create_table :pfm1s do |t|
      t. bigint :id_in_plu, :presence => true
      t.integer :type_of, :default => 0, limit: 4
      t.integer :width, :default => 0, limit: 4
      t.integer :height, :default => 0, limit: 4
      t.integer :l1, :default => 0, limit: 4
      t.integer :l2, :default => 0, limit: 4
      t.integer :l3, :default => 0, limit: 4
      t.integer :k1, :default => 0, limit: 4
      t.integer :k2, :default => 0, limit: 4
      t.integer :k3, :default => 0, limit: 4
      t.integer :is_check, :default => 0

      t.timestamps null: false
    end
  end
end
