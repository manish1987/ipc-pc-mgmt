require 'yaml'

desc "Populates Region Model"
task :load_areas => [:environment] do
  regions=YAML.load_file(Rails.root.to_s+"/db/fixtures/region_codes.yml")
  regions.keys.each do |code|
    i_code=code.to_i
    if i_code<=34
      region_type="state"
    elsif i_code<=66
      region_type="tamil_nadu"
    else
      region_type="international"
    end
    Region.create(:name=>regions[code],:code=>code,:count=>0,:region_type=>region_type)
  end
  puts "Regions Loaded"
end
