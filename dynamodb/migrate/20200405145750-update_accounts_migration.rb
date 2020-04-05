class UpdateAccountsMigration < Dynomite::Migration
  def up
    update_table :accounts do |t|
      t.gsi(:create) do |i|
        i.partition_key "client_id:string:hash" # required

        i.provisioned_throughput(5)
      end

      # Examples:
      # t.gsi(:update, "update-me-index") do |i|
      #   i.provisioned_throughput(10)
      # end

      # t.gsi(:delete, "delete-me-index")

      # Must use :create, :update, :delete one at a time in separate migration files.
      # DynamoDB imposes this.
    end
  end
end

# More examples: https://github.com/tongueroo/dynomite/tree/master/docs
