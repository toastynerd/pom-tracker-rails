class CreatePomodoros < ActiveRecord::Migration[6.1]
  def change
    create_table :pomodoros do |t|
      t.string :task
      t.text :notes

      t.timestamps
    end
  end
end
