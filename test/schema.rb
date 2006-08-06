ActiveRecord::Schema.define(:version => 1) do
  create_table :nodes, :force => true do |t|
    t.column :name, :string
    t.column :parent_id, :integer
  end
end