class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.integer :proposal_id
      t.integer :price_breakdown
      t.string :content
      t.timestamps null: false
    end
  end
end
