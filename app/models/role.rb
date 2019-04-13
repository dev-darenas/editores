class Role < ApplicationRecord
has_and_belongs_to_many :users, :join_table => :users_roles

belongs_to :resource,
           :polymorphic => true,
           :optional => true


validates :resource_type,
          :inclusion => { :in => Rolify.resource_types },
          :allow_nil => true

scopify


  def role_name
    case name.to_sym
    when :admin
      "Administrador"
    when :seller
      "Vendedor"
    when :collector
      "Cobrador"
    end
  end

end
