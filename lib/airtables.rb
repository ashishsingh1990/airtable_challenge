require 'json'
class Airtables
  def self.import_airtable
    # Initializing airtable client
    @client = Airtable::Client.new(ENV["airtable_key"])
    # Fetching table from worksheet
    @table  = @client.table(ENV["worksheet_key"], "copy")
    #writing data in copy.json
    File.write('./copy.json', JSON.parse(@table.records.to_json))
  end

  def self.get_result(records,params={})
    copy = ""
    records.each do |obj|
      key  = obj["attrs"]["key"]
      copy = obj["attrs"]["copy"]
      if key == params[:key] 
        new_params = JSON.parse(params.except(:action, :controller, :key).to_json)
        new_params.each do |k, val|
          if ["created_at", "updated_at", "time"].include?(k)
            k = "{#{k}, datetime}"
            val = Time.at(val.to_i).strftime("%a %b %d %H:%M:%S%p") if val.present?
          else
            k = "{#{k}}"
          end
          copy = copy.gsub(k, val)
        end
        break
      end
    end
    return copy
  end
end