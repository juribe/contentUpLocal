class RemoveColumnFromContent < ActiveRecord::Migration[7.0]
  def change
    remove_column :contents, :text
  end
end
