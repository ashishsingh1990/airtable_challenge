require 'airtables'
class CopyController < ApplicationController
  before_action :set_records

  def index
    if params["key"].present?
      if params["key"] == "refersh"
        begin
            Airtables.import_airtable
            res = true 
        rescue Exception => e
            res = false
        end
      else
        res = Airtables.get_result(@records,params)
      end
      json_response({value: res}, 200)
    else
      json_response({value: false}, 422)
    end
  end

  def set_records
    @records = eval(File.read('./copy.json'))
  end

end
