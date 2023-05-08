class Generate < ApplicationRecord
    mount_uploader :csv_file, CsvUploader

    def self.import_data(file)
        csv_data = CSV.parse(file.read, headers: true)
        array_of_hashes = csv_data.map(&:to_hash)
    
        import(array_of_hashes, on_duplicate_key_update: { conflict_target: [:id], columns: ["name"] })
    end

end
