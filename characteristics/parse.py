import json

json_file = open("yelp_dataset_challenge_academic_dataset/yelp_academic_dataset_business.json")

# new_file = open("yelp_dataset_challenge_academic_dataset/business.json" , "w")

# new_file.write("[")


# for line in json_file:
# 	new_file.write(line+",\n")

# new_file.write("]")
# # for i in range(2):
# # 	print reviews_json.readline()
# new_file.close()

new_file = open("yelp_dataset_challenge_academic_dataset/business.json" )



data = json.load(new_file)

category_dict = {}
for business in data:
	if u'Restaurants' in business['categories']:
		for cat in business['categories']:
			if cat in category_dict:
				category_dict[cat] += 1
			else:
				category_dict[cat] = 1

import operator
sorted_dict = sorted(category_dict.items(), key=operator.itemgetter(1) , reverse=True)

print sorted_dict