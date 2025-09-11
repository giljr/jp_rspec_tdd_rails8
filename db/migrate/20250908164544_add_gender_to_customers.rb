class AddGenderToCustomers < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :gender, :string
  end
end
