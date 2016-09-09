class CreateScheduledLedgerTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :scheduled_ledger_transactions do |t|
      t.integer :transaction_id
      t.references :user, foreign_key: true
      t.datetime :transaction_date
      t.text :description
      t.decimal :amount
      t.boolean :paused
      t.boolean :deleted

      t.timestamps
    end
  end
end
