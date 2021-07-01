class CreateWows < ActiveRecord::Migration[6.0]
  def change
    create_table :wows do |t|
      t.string :description

      t.timestamps
    end
  end
end
