# app.rb

# Login to nutshell.
$nutshell = NutshellCrmAPI::Client.new($username, $apiKey)


# Get all companies in nutshell.
companies = []
i = 0
loop do
	i+=1
	response = $nutshell.find_accounts([], nil, nil, 100, i, false)
	break if response.length == 0
	companies.concat(response)
end


# Filter companies that have no people
# associated with them.
companies_never_contacted = []
companies.each do |company|
	if company["lastContactedDate"] == nil
		companies_never_contacted.push(company)
	end
end


# Create spreadsheet with missing companies.
CSV.open("companies_never_contacted.csv", "wb") do |csv|
	companies_never_contacted.each do |company|
		csv << [].push(company["name"])
	end
end


# Print message to Jenkins
puts "#####################################"
puts "You have #{companies_never_contacted.length} companies never contacted."
puts "#####################################"
