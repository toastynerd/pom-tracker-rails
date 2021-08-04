class AddPomUserAssociation < ActiveRecord::Migration[6.1]
  def change
    change_table :pomodoros do |t|
      t.belongs_to :user
    end
  end
end
