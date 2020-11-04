require 'airtables'
namespace :airtable do
  task import: :environment do
  	Airtables.import_airtable
  end
end