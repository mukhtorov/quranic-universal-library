class AddDigitalKhatText < ActiveRecord::Migration[7.0]
  def change
    c = Word.connection
    c.add_column :words, :text_digital_khatt, :string
    c.add_column :verses, :text_digital_khatt, :string
  end
end
