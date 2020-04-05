class Account < ApplicationItem
    partition_key :client_id
    column :id, :client_id, :name, :last_name

    def before_create
        self.id = UUID.new.generate
    end
end
