class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.integer :user_id
      t.string :why_me
      t.string :title
      t.string :email
      t.integer :budget
      t.string :terms
      t.boolean :invoice_paid, :default => false
      t.boolean :proposal_accepted, :default => false
      t.timestamps null: false
      t.string :signer
    end
  end
end
