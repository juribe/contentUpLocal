class CreatePublisherContents < ActiveRecord::Migration[7.0]
  def change
    create_table :publisher_contents do |t|
      t.references :content
      t.references :publisher
      t.timestamps
    end
  end
end
