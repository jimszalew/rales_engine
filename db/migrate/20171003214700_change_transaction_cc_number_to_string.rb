class ChangeTransactionCcNumberToString < ActiveRecord::Migration[5.1]
  def change
    change_column :transactions, :credit_card_number, :string
  end
end
