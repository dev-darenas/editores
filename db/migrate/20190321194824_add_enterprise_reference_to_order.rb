class AddEnterpriseReferenceToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :enterprise, index: true
  end
end
