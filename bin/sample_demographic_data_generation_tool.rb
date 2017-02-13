require "faker"

districts =
[
["BLK", "Balaka", "South"],
["BT", "Blantyre", "South"],
["CK", "Chikwawa", "South"],
["CZ", "Chiradzulu", "South"],
["CP", "Chitipa", "North"],
["DZ", "Dedza", "Centre"],
["DA", "Dowa", "Centre"],
["KA", "Karonga", "North"],
["KU", "Kasungu", "Centre"],
["LA", "Likoma", "North"],
["LL", "Lilongwe", "Centre"],
["MHG", "Machinga", "South"],
["MH", "Mangochi", "South"],
["MC", "Mchinji", "Centre"],
["MJ", "Mulanje", "South"],
["MN", "Mwanza", "South"],
["MZ", "Mzimba", "North"],
["NN", "Neno", "South"],
["NB", "Nkhata Bay", "North"],
["KK", "Nkhotakota", "Centre"],
["NE", "Nsanje", "South"],
["NU", "Ntcheu", "Centre"],
["NS", "Ntchisi", "Centre"],
["PE", "Phalombe", "South"],
["RU", "Rumphi", "South"],
["SA", "Salima", "Centre"],
["TO", "Thyolo", "South"],
["ZA", "Zomba", "South"]
]

first_names = [
"Nyasia",
"Juliet",
"Belle",
"Bobbie",
"Brannon",
"Elvie",
"Enrique",
"Francisca",
"Khalid",
"Marisa",
"Carolyne",
"Tony",
"Liliane",
"Oran",
"Keyshawn",
"Bailey",
"Salvatore",
"Rosetta",
"Elvis",
"Elliot",
"Laisha",
"Sheldon",
"Bernhard",
"Lennie",
"Ivory",
"Tessie",
"Taya",
"Josefa",
"Rosemary",
"Marcos",
"Norberto",
"Madelyn",
"Eldred",
"Janie",
"Edyth",
"Damien",
"Adelia",
"Pat",
"Friedrich",
"Elisha",
"Earl",
"Beth",
"Alvera",
"Hayley",
"Camylle",
"Vernice",
"Robyn",
"Caesar",
"Corine",
"Donald"
]

last_names = [
"Kreiger",
"Erdman",
"Feest",
"Ullrich",
"Hickle",
"Schmidt",
"Johnson",
"Hirthe",
"White",
"Steuber",
"Hoeger",
"Ziemann",
"Kreiger",
"Schneider",
"Doyle",
"Quitzon",
"Weimann",
"Kessler",
"Tillman",
"Halvorson",
"Harber",
"Baumbach",
"Schaden",
"Stracke",
"Thiel",
"Glover",
"Stark",
"Beahan",
"Rempel",
"Reilly",
"Kuvalis",
"Runte",
"Hudson",
"Fadel",
"Waelchi",
"Shields",
"Effertz",
"Balistreri",
"Green",
"Ward",
"Dickens",
"Donnelly",
"Gutkowski",
"Sanford",
"Littel",
"Brown",
"Langosh",
"Kunde",
"Funk",
"Smith",
]

gender = ["MALE", "FEMALE"]

FIRST_NAME  = 0
LAST_NAME = 1
MIDDLE_NAME = 2
DATE_OF_BIRTH = 3
SEX = 4
PLACE_OF_BIRTH = 5
MOTHER_FIRST_NAME = 6
MOTHER_MIDDLE_NAME = 7
MOTHER_LAST_NAME = 8
FATHER_FIRST_NAME = 9
FATHER_MIDDLE_NAME = 10
FATHER_LAST_NAME = 11

#data = ["id, group_id, group_id2, date_created, title, document"]
data = []
dup = 0
dup_name_swap = 0
dup_mother_swap = 0
dup_father_swap = 0

def name_swap(a,b,row)
	tmp = row[a]
	row[a] = row[b]
	row[b] = tmp
	row
end

def generate_duplicate(row)

end

100000.times do |c|

	record = {
		
		"first_name" => first_names[rand(0..49)],
		"last_name"  => last_names[rand(0..49)],
		"middle_name" => first_names[rand(0..49)],
		"date_of_birth" => Faker::Date.backward(36500).strftime('%Y-%m-%d'),
		"Sex" => gender[rand(0..1)],
		"place_of_birth" => districts[rand(1..27)][1],
		"mother_first_name" => Faker::Name.first_name,
		"mother_middle_name" => Faker::Name.first_name,
		"mother_last_name"  => Faker::Name.last_name,
		"father_first_name" => Faker::Name.first_name,
		"father_middle_name" => Faker::Name.first_name,
		"father_last_name"  => Faker::Name.last_name,
		"id" => c
	}

	row = []
	record.keys.each{|k| row << "#{record[k]}"}	
	
	data << row.join(",")
	
	if 0 == rand(0..100)%15		

		#Change date
		if 0 == rand(0..100)%3
			row[DATE_OF_BIRTH] = Faker::Date.backward(36500).strftime('%Y-%m-%d')
		end

		data << row.join(",")
		dup+=1
	end

	#swap first and last name names
	if 0 == rand(0..100)%5
				
		row[MIDDLE_NAME] = "" if 0 == rand(0..100)%9

		row = name_swap(FIRST_NAME, LAST_NAME,row)
		data << row.join(",")
		dup_name_swap+=1
	end

	#swap first and last name mother
	if 0 == rand(0..100)%7

		row[MOTHER_MIDDLE_NAME] = "" if 0 == rand(0..100)%9
		row = name_swap(MOTHER_FIRST_NAME, MOTHER_LAST_NAME,row)	
		data << row.join(",")
		dup_mother_swap+=1
	end

	#swap first and last name father
	if 0 == rand(0..100)%9
		row[FATHER_MIDDLE_NAME] = "" if 0 == rand(0..100)%5
		#puts "father middle name"
		#blank name
		if row[FATHER_MIDDLE_NAME] == "" && 0 == rand(0..100)%5

		#puts " #{c} Both names"

			row[FATHER_FIRST_NAME] = ""
			row[FATHER_LAST_NAME] = ""

		end
		
		row = name_swap(FATHER_FIRST_NAME, FATHER_LAST_NAME,row)
		data << row.join(",")
	end

	#BLANK F
	if 0 == rand(0..100)%10
		row = row
		data << name_swap(FATHER_FIRST_NAME, FATHER_LAST_NAME,row).join(",")
		dup_father_swap+=1
	end
end

#print

time = Time.now.strftime "%Y-%m-%d %H:%M:%S"

["id, group_id, group_id2, date_created, title, document"]

File.open("test_data.csv", 'w') do |file|
	data.each_with_index do |d, i|
		tmp = d.split(",")
		tmp_s = i.to_s + "," + tmp[12].to_s + ",0,"+ Time.now.to_date.to_s + "," + tmp[0] + " " + tmp[1] + "," + tmp[2..11].join(" ")  
		file.puts tmp_s
		
p = Document.create(id: i, group_id: tmp[12], group_id2: 0, date_added:  Time.now, title: tmp[0] + " " + tmp[1],content: "#{tmp[2]} #{Time.now.to_date}" +  tmp[4..11].join(" "))
puts p.inspect
#file.puts "Document.create(id: " + i.to_s + ", group_id: " + tmp[12].to_s + ", group_id2: 0, date_added:  Time.now, title: \"" + tmp[0] + " " + tmp[1] + "\", content: \"" +  tmp[2..11].join(" ") + "\")"

	end
end



#puts "Dup: #{dup}"
#puts "name: #{dup_name_swap}"
#puts "mother: #{dup_mother_swap}"
#puts "father: #{dup_father_swap}"

