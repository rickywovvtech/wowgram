class AddPictureToWow < ActiveRecord::Migration[6.0]
  def self.up
    change_table :wows do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :wows, :picture
  end
end
