class AddReferenceToProducst < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :person, foreign_key: true, index: true
  end
end
