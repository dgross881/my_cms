class AlterPages < ActiveRecord::Migration
  def change
  	use_table("pages")
  	change_column("pages", "permalink", :string, :limit => 255)
  end
end
