class ApplicationItem < Dynomite::Item
    def before_create 
    end

    def self.sort_key(*args)
        case args.size
        when 0
            @sort_key || "id"
        when 1
            @sort_key = args[0].to_s
        end
    end

    def sort_key
        self.class.sort_key
    end

    def save
        self.before_create
        self.replace
    end

    def update(param)
        self.replace(param)
    end

    def destroy
        key = {}
        key[self.partition_key] = self.attrs[self.partition_key.to_sym]
        key[self.sort_key] = self.attrs[self.sort_key.to_sym]
        
        self.class.method(:delete).call(key)
    end

    def self.all(partition_key)
        key = {}
        key[self.partition_key] = partition_key
        index = "%s-index" % [self.partition_key]
        self.method(:where).call(key, {index_name: index})
    end
end
