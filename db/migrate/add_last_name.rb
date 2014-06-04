require 'active_record'

class AddLastName < ActiveRecord::Migration
  def change
    create_table :system_settings do |t|
      t.string  :name
      t.string  :label
      t.text    :value
      t.string  :type
      t.integer :position
    end
  end
end

AddLastName.new.migrate(:up)
