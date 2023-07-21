module DataManager
    def save_data_to_json(data, filename)
      json_array = data.map do |item|
        {
          id: item.id,
          **item.to_hash
        }
      end
  
      json = JSON.pretty_generate(json_array)
      File.write(filename, json)
    end
  
    def load_data_from_json(filename, item_class)
      return [] unless File.exist?(filename)
  
      json_data = JSON.parse(File.read(filename))
      json_data.map { |item_data| item_class.new(**item_data) }
    end
  end