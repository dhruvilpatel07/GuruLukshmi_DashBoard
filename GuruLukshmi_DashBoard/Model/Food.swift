//
//  Food.swift
//  DashBoard
//
//  Created by Xcode User on 2020-09-29.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

/// # Food Model and it's Attributes
struct Food: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var foodName: String
    var foodDescription: String
    var foodType: String
    var foodSubCategory: String?
    var imgName: String
    var categoryImage: String
    var foodPrice: Double

}



#if DEBUG
    let testData = [
        // MARK: - Appetizers
        Food(foodName: "Chilli Bajji (Pakora)", foodDescription: "Deep fried mild chillies coated with mildly spiced chick pea batter served with coconut and coriander chutney",  foodType: "Appetizers", foodSubCategory: "Finger Foods" , imgName: "Appetizers", categoryImage: "Appetizers",foodPrice: 6.50),
        Food(foodName: "Potato Bonda", foodDescription: "Deep fried potato ball fritters served with coconut chutney",  foodType: "Appetizers",foodSubCategory: "Finger Foods", imgName: "Appetizers", categoryImage: "Appetizers",foodPrice: 6.50),
        Food(foodName: "Samosa Plate", foodDescription: "Fried Indian pastry stuffed with flavoured potatoes served with coriander and tamarind chutney", foodType: "Appetizers",foodSubCategory: "Finger Foods", imgName: "Appetizers", categoryImage: "Appetizers",foodPrice: 4.50)
]
#endif



/*
 #if DEBUG
 let testData = [
     // MARK: - Appetizers
     Food(foodName: "Chilli Bajji (Pakora)", foodDescription: "Deep fried mild chillies coated with mildly spiced chick pea batter served with coconut and coriander chutney",  foodType: "Appetizers", foodSubCategory: "Finger Foods" , imgName: "Appetizers", categoryImage: "Appetizers",foodPrice: 6.50),
     Food(foodName: "Potato Bonda", foodDescription: "Deep fried potato ball fritters served with coconut chutney",  foodType: "Appetizers",foodSubCategory: "Finger Foods", imgName: "Appetizers", categoryImage: "Appetizers",foodPrice: 6.50),
     Food(foodName: "Samosa Plate", foodDescription: "Fried Indian pastry stuffed with flavoured potatoes served with coriander and tamarind chutney", foodType: "Appetizers",foodSubCategory: "Finger Foods", imgName: "Appetizers", categoryImage: "Appetizers",foodPrice: 4.50),
     Food(foodName: "Rava Upma", foodDescription: "Traditional South Indian light meal made with suji/rava (semolina) and spices, served with sambar, cocnut chutney and sugar", foodType: "Appetizers", foodSubCategory: "Finger Foods",imgName: "Appetizers", categoryImage: "Appetizers",foodPrice: 9.50),
     Food(foodName: "Medhu Vada", foodDescription: "Fried lentil flour doughnuts mildly spiced served with sambhar, cocunut chutney and tomato chutney", foodType: "Appetizers" ,foodSubCategory: "Vada", imgName: "Appetizers", categoryImage: "Appetizers",foodPrice: 5.50),
     Food(foodName: "Sambhar Vada", foodDescription: "Fried lentil flour doughnuts dipped in sambhar, topped with ghee, fresh onions, coriander, and coconut chutney", foodType: "Appetizers",foodSubCategory: "Vada", imgName: "Appetizers", categoryImage: "Appetizers",foodPrice: 7.50),
     Food(foodName: "Rasa Vada", foodDescription: "Lentil doughnuts dipped in rasam and topped with fresh onions and coriander", foodType: "Appetizers" ,foodSubCategory: "Vada", imgName: "Appetizers", categoryImage: "Appetizers",foodPrice: 7.25),
     Food(foodName: "Salty Dahi (Yogurt) Vada", foodDescription: "Lentil doughnuts soaked in seasoned yoghurt, topped with fresh coriander, boondhi and sweet & spicy tamarind sauce", foodType: "Appetizers",foodSubCategory: "Vada", imgName: "Appetizers", categoryImage: "Appetizers",foodPrice: 7.00),
     Food(foodName: "Sweet Dahi (Yoghurt) Vada", foodDescription: "Lentil doughnuts soaked in sweet seasoned yoghurt, topped with fresh coriander, boondhi and sweet & spicy tamarind sauce", foodType: "Appetizers" ,foodSubCategory: "Vada", imgName: "Appetizers", categoryImage: "Appetizers",foodPrice: 7.00),
     Food(foodName: "Spicy Rasam", foodDescription: "A South Indian home-made spicy and tangy soup made with lentil, tomato, and tamarind juice flavoured with red chillies, pepper and spices.", foodType: "Appetizers" ,foodSubCategory: "Soup", imgName: "Appetizers", categoryImage: "Appetizers",foodPrice: 4.25),

     // MARK: - Dosa
     Food(foodName: "Plain Dosa", foodDescription: "A golden thin crepe made of fermented lentil and rice batter",  foodType: "Dosa", foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImage: "Dosa",foodPrice: 8.00),
     Food(foodName: "Aloo Masala Dosa", foodDescription: "A mildly spiced traditional potato and onions stuffing in a plain dosa",  foodType: "Dosa",foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImage: "Dosa",foodPrice: 10.00),
     Food(foodName: "Onion Dosa", foodDescription: "Finely chopped sautéed onions topped on dosa and garnished with fresh coriander", foodType: "Dosa" ,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImage: "Dosa",foodPrice: 9.50),
     Food(foodName: "Steam Dosa", foodDescription: "A healthy soft dosa made with no oil", foodType: "Dosa" ,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImage: "Dosa",foodPrice: 8.50),
     Food(foodName: "Set Dosa", foodDescription: "A set of 2 fluffy and spongy dosas cooked with a little butter, topped with some onions, coriander and tomatoes and mild spices", foodType: "Dosa" ,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImage: "Dosa",foodPrice: 9.50),
     Food(foodName: "Paper Dosa", foodDescription: "Larger and crispier version of the plain dosa", foodType: "Dosa" ,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImage: "Dosa",foodPrice: 11.00),
     Food(foodName: "Cheese Dosa", foodDescription: "Rennet free vegetable mozzarella cheese on dosa", foodType: "Dosa" ,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImage: "Dosa",foodPrice: 11.00),
     Food(foodName: "Chilli Cheese Dosa", foodDescription: "Rennet free mozzarella cheese, freshly chopped green chillies and ginger on dosa", foodType: "Dosa" ,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImage: "Dosa",foodPrice: 11.50),
     Food(foodName: "Ghee Dosa", foodDescription: "Delicious homemade clarified butter drizzled on a crispy dosa", foodType: "Dosa" ,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImage: "Dosa",foodPrice: 9.50),
     Food(foodName: "Ghee Paper Dosa", foodDescription: "Extra large and crispy dosa drizzled with homemade clarified butter and rolled to golden perfection", foodType: "Dosa" ,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImage: "Dosa",foodPrice: 12.00),
     Food(foodName: "Butter Dosa", foodDescription: "Crispy dosa drizzled with butter and rolled to golden perfection", foodType: "Dosa",foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImage: "Dosa",foodPrice: 9.50),
     Food(foodName: "Butter Paper Dosa", foodDescription: "Larger and crispier version of butter dosa", foodType: "Dosa" ,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImage: "Dosa",foodPrice: 12.00),
     Food(foodName: "Rava Dosa", foodDescription: "Thin and crispy crepe made from semolina and rice batter, topped with fresh ginger and coriander", foodType: "Dosa" ,foodSubCategory: "DOSA - RAVA", imgName: "dosa", categoryImage: "Dosa",foodPrice: 10.00),
     Food(foodName: "Ghee Rava Dosa", foodDescription: "Thin and crispy crepe made from semolina and rice batter, cooked in ghee (clarified butter) and topped with fresh ginger and coriander", foodType: "Dosa" ,foodSubCategory: "DOSA - RAVA", imgName: "dosa", categoryImage: "Dosa",foodPrice: 11.00),
     Food(foodName: "Onion Rava Dosa", foodDescription: "Thin crepe made from semolina and rice batter, sprinkled with sautéed onions and topped with ginger and corriander", foodType: "Dosa",foodSubCategory: "DOSA - RAVA", imgName: "dosa", categoryImage: "Dosa",foodPrice: 11.00),
     Food(foodName: "Dry Fruit Rava Dosa", foodDescription: "Thin crepe made from semolina and rice batter, garnished with dry nuts, raisins and topped with ginger and corriander", foodType: "Dosa" ,foodSubCategory: "DOSA - RAVA", imgName: "dosa", categoryImage: "Dosa",foodPrice: 11.50),
     Food(foodName: "Spicy Rava Dosa", foodDescription: "Special herbs and spices added to our semolina and rice batter, for added flavour and kick, this creations is topped with fresh ginger and coriander", foodType: "Dosa" ,foodSubCategory: "DOSA - RAVA", imgName: "dosa", categoryImage: "Dosa",foodPrice: 11.00),
     
     
     
     // MARK: - Rice
     Food(foodName: "Lemon Rice ", foodDescription: "South Indian style lemon flavoured rice mixed with spices, garnished with coriander and served with pickle, raitha and papad", foodType: "Rice" ,foodSubCategory: "Rice", imgName: "rice", categoryImage: "Rice",foodPrice:9.00 ),
     Food(foodName: "Spinach Rice", foodDescription: "South Indian style spinach flavoured rice mixed with homemade ghee served with pickle, raitha and papad", foodType: "Rice" ,foodSubCategory: "Rice", imgName: "rice", categoryImage: "Rice",foodPrice: 9.00),
     Food(foodName: "Tamarind Rice", foodDescription: "South Indian style tamarind flavoured rice mixed with spices, garnished with coriander and served with pickle, raitha and papad *Caution: May Contain Sesame Seeds", foodType: "Rice" ,foodSubCategory: "Rice", imgName: "rice", categoryImage: "Rice",foodPrice: 9.00),
     Food(foodName: "Dahi (Yoghurt) Rice", foodDescription: "South Indian style yoghurt rice mixed with mild spices, garnished with coriander, raisins, red peppers and served with pickle and papad", foodType: "Rice" ,foodSubCategory: "Rice", imgName: "rice", categoryImage: "Rice",foodPrice: 9.00),
     
     
     // MARK: - Beverages
     Food(foodName: "Madras Filter Coffee", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:2.75),
     Food(foodName: "Cold Coffee", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:4.00),
     Food(foodName: "Milk Tea", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:2.50),
     Food(foodName: "Masala Tea", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:3.00),
     Food(foodName: "Green Tea", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:2.00),
     Food(foodName: "Ice Tea", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:2.00),
     Food(foodName: "Chocolate Milk", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:3.50),
     Food(foodName: "Masala Soda", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:3.00),
     Food(foodName: "Soft Drinks", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:1.50),
     Food(foodName: "Lichi", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:4.00),
     Food(foodName: "Mango", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:4.00),
     Food(foodName: "Orange juices", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:4.00),
     Food(foodName: "Lemonade", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:2.00),
     Food(foodName: "Fanta", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:2.50),
     Food(foodName: "Limca", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:2.50),
     Food(foodName: "Thums Up", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:2.50),
     Food(foodName: "", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:4.50),
     Food(foodName: "Salt Lassi", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:4.50),
     Food(foodName: "Sweet Lassi", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:5.00),
     Food(foodName: "Mango Lassi", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:4.50),
     Food(foodName: "Jeera Lassi", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:4.50),
     Food(foodName: "Ginger Lassi", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:5.00),
     Food(foodName: "Mango Milk Shake", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:1.50),
     Food(foodName: "Bottled Water", foodDescription: "", foodType: "Beverages" ,foodSubCategory: "", imgName: "beverages", categoryImage: "Beverages",foodPrice:2.00),
     
     
     
     // MARK: - Indian Bread
     Food(foodName: "Chapathi (2) with Potato Bhaji", foodDescription: "Thin whole wheat Indian flatbread served with mild potato curry", foodType: "Indian Bread" ,foodSubCategory: "", imgName: "indainbread", categoryImage: "IndianBread",foodPrice:8.00),
     Food(foodName: "Chapathi (2) with Vegetable Kurma", foodDescription: "Thin whole wheat Indian flatbread served with mild mix vegetable curry", foodType: "Indian Bread" ,foodSubCategory: "", imgName: "indainbread", categoryImage: "IndianBread",foodPrice:9.00),
     Food(foodName: "Poori (2) with Potato Bhaji", foodDescription: "Fried puffed bread made with wheat and semonlina , served with mild potato curry", foodType: "Indian Bread" ,foodSubCategory: "", imgName: "indainbread", categoryImage: "IndianBread",foodPrice:8.00),
     Food(foodName: "Poori (2) with Vegetable Kurma", foodDescription: "Fried puffed bread made with wheat and semolina, served with mild mix vegetable curry", foodType: "Indian Bread" ,foodSubCategory: "", imgName: "indainbread", categoryImage: "IndianBread",foodPrice:9.00),
     Food(foodName: "1 Extra Poori / Chappathi with order", foodDescription: "", foodType: "Indian Bread" ,foodSubCategory: "", imgName: "indainbread", categoryImage: "IndianBread",foodPrice:2.50),
     
     
     

     // MARK: - Signature Dosa
     Food(foodName: "Spinach (Palak) Dosa", foodDescription: "South Indian style spinach cooked with special herbs and spices spread on dosa with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Butter Garlic Dosa", foodDescription: "Dosa enriched with mouth-watering garlic and butter flavour topped with parsley with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Jeera Malli Dosa", foodDescription: "Dosa topped with crushed jeera, black pepper, fresh coriander and drizzled with ghee with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Coriander Dosa", foodDescription: "Fresh coriander and spices crushed into a fine paste with a traditional mortar and1 spread on dosa (earthy taste and aroma!) with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Mysore Bhaji Aloo Masala Dosa", foodDescription: "Mild Mysore paste spread on dosa, topped with a perfect combination of fresh onions, coriander, green & red peppers, special spices and butter to give it a pleasantly surprising taste", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Spicy Coconut Dosa", foodDescription: "Spiced fresh grated coconut mixture spread on dosa topped with onions and coriander with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Chat-Pata Cheese Dosa", foodDescription: "South Indian special tangy & spicy dosa with cheese with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Mysore Dosa", foodDescription: "A spicy paste made of garlic, special herbs and spices with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Spicy Mysore Dosa", foodDescription: "A spicier version of the mysore (spicy paste made of garlic, special herbs and spices) with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:13.00),
     Food(foodName: "Mysore Paper Dosa", foodDescription: "Larger and crispier version of mysore dosa with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:14.50),
     Food(foodName: "Spicy Mysore Paper Dosa", foodDescription: "A spicier version of the mysore (spicy paste made of garlic, special herbs and spices) with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:15.50),
     Food(foodName: "Spicy Channa Dal Powder Dosa", foodDescription: "Blend of spiced channa dal powder and herbs on dosa, topped with onions, coriander, tomatoes and ghee with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Spicy Channa Panner Dosa", foodDescription: "Blend of spiced channa dal powder spread on dosa and stuffed with Gurulukshmi`s South Indian style paneer garnished with fresh onions and coriander", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:16.00),
     Food(foodName: "Country Style-EggPlant BenganDosa", foodDescription: "A hearty roasted eggplant curry spread on dosa garnished with coriander. The real taste of South India in one bite", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Andhra (Achaar) Dosa", foodDescription: "Aachar style thick gravy of Gongura greens and red chillies cooked with our own herbs and spices spread on dosa with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Green Chilli Dosa", foodDescription: "A unique blend of freshly ground green chillies, spices and herbs spread on dosa with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Chettinad Dosa", foodDescription: "A daring blend of red chillies, spices and herbs spread on dosa with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Kaara Dosa- Extreme Hot", foodDescription: "An extremely spicy blend of spices and six different types of chillies spread on dosa (consider yourself warned!!!) with aloo masala", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:13.00),
     Food(foodName: "Dosa Chole", foodDescription: "South Indian style chana (chickpea) masala slow cooked with our special blend of herbs and spices spread on dosa topped with freshly chopped onions and coriander.", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Chaat Dosa", foodDescription: "Another ‘North meets South’ dosa made with fresh onions, coriander, tomatoes, chaat powder topped on dosa and garnished with sweet and spicy tamarind sauce", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:13.00),
     Food(foodName: "Pav Bhaji Dosa", foodDescription: "Experience the line where North meets South – the bhaji (thick mix veg curry) from the famous Pav Bhaji is spread on dosa, topped with fresh onions and corriander with a splash of lime", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.50),
     Food(foodName: "Spicy Sweet Onion Dosa", foodDescription: "Onions sautéed with specials herbs and spices perfectly blended with a hint of sweetness.", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:12.00),
     Food(foodName: "Paneer Dosa", foodDescription: "A hearty South Indian style paneer (Indian cottage cheese) stuffing sautéed with onions, chillies, red peppers and mouth-watering spices topped with fresh coriander and onions inside the dosa (Guru Lukshmi style)", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:13.50),
     Food(foodName: "Mushroom Dosa", foodDescription: "Succulent button mushrooms cooked with red chillies and special herbs spread on dosa and garnished with fresh coriander (Guru Lukshmi style)", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:13.50),
     Food(foodName: "Pizza Dosa", foodDescription: "Indian style vegetable pizza with marinara sauce, cheese,onions,coriander, green peppers, red peppers, tomatoe (ginger and chillies optional)", foodType: "Dosa" ,foodSubCategory: "specialDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:13.50),
     
     Food(foodName: "Fresh Vegetable Spring Masala Dosa", foodDescription: "A low calorie diet dosa with thinly sliced carrot, cabbage, onions, coriander, green/red pepper and masala rolled and cut into pieces with the option of having any one of our signature pastes spread inside the dosa. If you need more/less vegetables or more/less potato fillings, please let us know.", foodType: "Dosa" ,foodSubCategory: "springDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:13.50),
     Food(foodName: "Spicy Chole Vegetable Spring DosaTM (Plain)", foodDescription: "South Indian style chana masala with special blend of herbs / spices fresh cabbage, carrots, onions, coriander, tomatoes, green and red peppers rolled and cut into pieces", foodType: "Dosa" ,foodSubCategory: "springDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:15.50),
     Food(foodName: "Paneer Vegetable Spring Dosa", foodDescription: "Mild Paneer Vegetable Spring Dosa South Indian style curried paneer stuffed in the dosa with fresh cabbage, carrots, onions, coriander", foodType: "Dosa" ,foodSubCategory: "springDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:17.00),
     Food(foodName: "Tofu Vegetable Spring Dosa", foodDescription: "Malaysian style curried tofu stuffed in the dosa with fresh cabbage, carrots, onions, coriander, tomato, red and green peppers, rolled and cut into pieces", foodType: "Dosa" ,foodSubCategory: "springDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:17.00),
     Food(foodName: "Mushroom Spring Dosa", foodDescription: "Guru Lukshmi style curried mushroom stuffed in the dosa with fresh cabbage, carrots, onions, coriander, tomato, red and green peppers, rolled and cut into pieces", foodType: "Dosa" ,foodSubCategory: "springDosa", imgName: "signaturedosa", categoryImage: "SignatureDosa",foodPrice:17.00),
     
     
     // MARK: - Side Dish
     Food(foodName: "Sambhar 8 ounces", foodDescription: "", foodType: "Side Dish" ,foodSubCategory: "", imgName: "sideDish", categoryImage: "SideDish",foodPrice:1.50),
     Food(foodName: "Tamarind Chutney", foodDescription: "", foodType: "Side Dish" ,foodSubCategory: "", imgName: "sideDish", categoryImage: "SideDish",foodPrice:1.25),
     Food(foodName: "Masala", foodDescription: "", foodType: "Side Dish" ,foodSubCategory: "", imgName: "sideDish", categoryImage: "SideDish",foodPrice:1.50),
     Food(foodName: "Cheese", foodDescription: "", foodType: "Side Dish" ,foodSubCategory: "", imgName: "sideDish", categoryImage: "SideDish",foodPrice:3.00),
     Food(foodName: "Milagapodi (Idly Powder)", foodDescription: "", foodType: "Side Dish" ,foodSubCategory: "", imgName: "sideDish", categoryImage: "SideDish",foodPrice:1.50),
     Food(foodName: "Appalam (Papad)", foodDescription: "", foodType: "Side Dish" ,foodSubCategory: "", imgName: "sideDish", categoryImage: "SideDish",foodPrice:0.50),
     Food(foodName: "Chutney", foodDescription: "", foodType: "Side Dish" ,foodSubCategory: "", imgName: "sideDish", categoryImage: "SideDish",foodPrice:0.75),
     Food(foodName: "Curd", foodDescription: "", foodType: "Side Dish" ,foodSubCategory: "", imgName: "sideDish", categoryImage: "SideDish",foodPrice:2.50),
     Food(foodName: "Ghee-butter", foodDescription: "", foodType: "Side Dish" ,foodSubCategory: "", imgName: "sideDish", categoryImage: "SideDish",foodPrice:1.50),
     Food(foodName: "Raitha", foodDescription: "", foodType: "Side Dish" ,foodSubCategory: "", imgName: "sideDish", categoryImage: "SideDish",foodPrice:2.50),
     Food(foodName: "Chappathi", foodDescription: "", foodType: "Side Dish" ,foodSubCategory: "", imgName: "sideDish", categoryImage: "SideDish",foodPrice:2.50),
     Food(foodName: "Poori", foodDescription: "", foodType: "Side Dish" ,foodSubCategory: "", imgName: "sideDish", categoryImage: "SideDish",foodPrice:2.50),
     
     
     // MARK: - Idly
     Food(foodName: "Idly (2)", foodDescription: "Steamed rice and lentil cakes served with sambhar, coconut and tomato chutney", foodType: "Idly" ,foodSubCategory: "", imgName: "idly", categoryImage: "Idly",foodPrice:7.00),
     Food(foodName: "Sambhar Idly (2)", foodDescription: "Idlies dipped in sambhar, topped with ghee, fresh onions, coriander and coconut chutney", foodType: "Idly" ,foodSubCategory: "", imgName: "idly", categoryImage: "Idly",foodPrice:8.00),
     Food(foodName: "Spicy Sambhar Idly (2)", foodDescription: "dlies dipped in spicy sambhar, topped with ghee, fresh onions, coriander and coconut chutney", foodType: "Idly" ,foodSubCategory: "", imgName: "idly", categoryImage: "Idly",foodPrice:8.50),
     Food(foodName: "Rasam Idly (2)", foodDescription: "Idlies dipped in rasam, topped with fresh onions and coriander", foodType: "Idly" ,foodSubCategory: "", imgName: "idly", categoryImage: "Idly",foodPrice:7.50),
     Food(foodName: "14 Pieces Mini Idly", foodDescription: "Toonie sized idlies dipped in sambhar, topped with ghee, fresh onions, coriander and coconut chutney *(let us know if you would like the idly separate)", foodType: "Idly" ,foodSubCategory: "", imgName: "idly", categoryImage: "Idly",foodPrice:8.00),
     Food(foodName: "Spicy 14 piece Mini Idly", foodDescription: "Toonie sized idlies dipped in spicy sambhar, topped with ghee, fresh onions and coriander", foodType: "Idly" ,foodSubCategory: "", imgName: "idly", categoryImage: "Idly",foodPrice:8.50),
     Food(foodName: "Mini Rasam Idly", foodDescription: "Toonie sized idlies dipped in rasam, topped with ghee, fresh onions and coriander", foodType: "Idly" ,foodSubCategory: "", imgName: "idly", categoryImage: "Idly",foodPrice:7.50),
     Food(foodName: "Salty Dahi (Yogurt) Idly (2)", foodDescription: "Steamed rice and lentil cakes dipped in seasoned yoghurt, topped with fresh coriander, boondhi and sweet & spicy tamarind sauce", foodType: "Idly" ,foodSubCategory: "", imgName: "idly", categoryImage: "Idly",foodPrice:7.50),
     Food(foodName: "Sweet Dahi (Yoghurt) Idly (2)", foodDescription: "Steamed rice and lentil cakes dipped in sweet seasoned yoghurt, topped with fresh coriander, boondhi and sweet & spicy tamarind sauce", foodType: "Idly" ,foodSubCategory: "", imgName: "idly", categoryImage: "Idly",foodPrice:7.50),
     
     Food(foodName: "1 Idly/ 1 Vada Combo", foodDescription: "Steamed rice cake and spiced lentil doughnut served with sambar, coconut and tomato chutney", foodType: "Idly" ,foodSubCategory: "Combos", imgName: "idly", categoryImage: "Idly",foodPrice:6.75),
     Food(foodName: "2 Idly/ 1 Vada OR 1 Idly/ 2 Vada", foodDescription: "Steamed rice cakes and spiced lentil doughnuts served with sambar, coconut and tomato chutney", foodType: "Idly" ,foodSubCategory: "Combos", imgName: "idly", categoryImage: "Idly",foodPrice:8.00),
     Food(foodName: "Sambhar (1 Idly/ 1 Vada) Combo", foodDescription: "1 idly and 1 vada soaked in sambhar topped with ghee, fresh onions, coriander and coconut chutney", foodType: "Idly" ,foodSubCategory: "Combos", imgName: "idly", categoryImage: "Idly",foodPrice:7.50),
     Food(foodName: "Rasam (1 Idly/ 1 Vada) Combo", foodDescription: "1 idly and 1 vada soaked in rasam topped with ghee, fresh onions and corriander", foodType: "Idly" ,foodSubCategory: "Combos", imgName: "idly", categoryImage: "Idly",foodPrice:7.25),
     Food(foodName: "Mini Tiffin", foodDescription: "Mini masala dosa, 5 piece mini idly, 1 vada, sambhar, coconut chutney & sweet rava kesari", foodType: "Idly" ,foodSubCategory: "Combos", imgName: "idly", categoryImage: "Idly",foodPrice:12.00),
     Food(foodName: "Dahi 1 Idly/ 1 Vada Sweet or Salty Combo`s", foodDescription: "Idly & Vada dipped in sweet or salty seasoned yoghurt topped with fresh coriander and sweet & spicy tarmind sauce", foodType: "Idly" ,foodSubCategory: "Combos", imgName: "idly", categoryImage: "Idly",foodPrice:7.25),

     
     // MARK: - Uthapams
     Food(foodName: "Plain Uthapam", foodDescription: "Plain uthapam with coriander sprinkled on top", foodType: "Uthapams" ,foodSubCategory: "", imgName: "uthapams", categoryImage: "Uthapams",foodPrice:8.50),
     Food(foodName: "Onion Chilli Uthapam", foodDescription: "Chopped onions, coriander and green chillies topped on the uthapam", foodType: "Uthapams" ,foodSubCategory: "", imgName: "uthapams", categoryImage: "Uthapams",foodPrice:10.00),
     Food(foodName: "Pineapple Cheese Uthapam", foodDescription: "Fresh pineapple, coriander, and cheese topped on the uthapam", foodType: "Uthapams" ,foodSubCategory: "", imgName: "uthapams", categoryImage: "Uthapams",foodPrice:12.00),
     Food(foodName: "Tomato and Onion Uthapam", foodDescription: "Chopped onions, tomatoes, and coriander topped on the uthapam", foodType: "Uthapams" ,foodSubCategory: "", imgName: "uthapams", categoryImage: "Uthapams",foodPrice:11.00),
     Food(foodName: "Cheese Sandwich Uthapam", foodDescription: "2 layers of toasted uthapams filled with our delicious and mild potato stuffing, topped with cheese, sweet and spicy tamarind sauce, onions, coriander, and a blend of herbs and spices", foodType: "Uthapams" ,foodSubCategory: "", imgName: "uthapams", categoryImage: "Uthapams",foodPrice:16.00),
     Food(foodName: "Mixed Vegetable Uthapam", foodDescription: "Chopped onions, green peppers, red peppers, tomato and coriander toppings on the uthapam", foodType: "Uthapams" ,foodSubCategory: "", imgName: "uthapams", categoryImage: "Uthapams",foodPrice:11.50),
     Food(foodName: "Podi (Channa Mirchi Powder) Uthapam", foodDescription: "A blend of herbs and spiced dal powder topped on the uthapam with chopped onions, tomato and coriander", foodType: "Uthapams" ,foodSubCategory: "", imgName: "uthapams", categoryImage: "Uthapams",foodPrice:11.50),
     Food(foodName: "Masala Uthapam", foodDescription: "Mildly spiced traditional potato and onion stuffing topped on uthapam", foodType: "Uthapams" ,foodSubCategory: "", imgName: "uthapams", categoryImage: "Uthapams",foodPrice:11.00),
     Food(foodName: "Fresh Vegetable Spring Uthapam", foodDescription: "Fresh shredded carrots, cabbage, onions, green peppers, red peppers, tomato, coriander and green chillies topped on the uthapam", foodType: "Uthapams" ,foodSubCategory: "", imgName: "uthapams", categoryImage: "Uthapams",foodPrice:12.00),
     Food(foodName: "Pizza Uthapam", foodDescription: "Indian style vegetable pizza with marinara sauce, cheese, onions, coriander, green peppers, red peppers, tomato, ginger and chillies", foodType: "Uthapams" ,foodSubCategory: "", imgName: "uthapams", categoryImage: "Uthapams",foodPrice:13.50),
     Food(foodName: "Paneer Uthapam", foodDescription: "South Indian style spicy paneer on the uthapam, topped with fresh onions and coriander", foodType: "Uthapams" ,foodSubCategory: "", imgName: "uthapams", categoryImage: "Uthapams",foodPrice:14.00),
     Food(foodName: "Mushroom Uthapam", foodDescription: "Succulent button mushrooms cooked with red chillies and special herbs spread on the uthapam, topped with fresh coriander (Guru Lukshmi style)", foodType: "Uthapams" ,foodSubCategory: "", imgName: "uthapams", categoryImage: "Uthapams",foodPrice:14.00),

     
     
     // MARK: - Dessert
     Food(foodName: "Chocolate Dosa", foodDescription: "Rich melted chocolate spread on dosa topped with cashew nuts and dusted with powdered sugar", foodType: "Dessert" ,foodSubCategory: "", imgName: "dessert", categoryImage: "Dessert",foodPrice:7.00),
     Food(foodName: "Rava Kesari", foodDescription: "Sweetened suji (semolina) and raisins roasted and cooked in ghee", foodType: "Dessert" ,foodSubCategory: "", imgName: "dessert", categoryImage: "Dessert",foodPrice:4.50),
     Food(foodName: "Badam Halwa *Gluten free", foodDescription: "Rich halwa made of sweetened almond puree and saffron", foodType: "Dessert" ,foodSubCategory: "", imgName: "dessert", categoryImage: "Dessert",foodPrice:5.00),
     Food(foodName: "Ras Malai", foodDescription: "Homemade cottage cheese in special condensed milk, flavoured with rose water and garnished with pistachio nuts", foodType: "Dessert" ,foodSubCategory: "", imgName: "dessert", categoryImage: "Dessert",foodPrice:4.50),
     Food(foodName: "Gulab Jamun", foodDescription: "Fried dry milk balls, soaked in syrup and rose water", foodType: "Dessert" ,foodSubCategory: "", imgName: "dessert", categoryImage: "Dessert",foodPrice:4.50),
     Food(foodName: "Kulfi Flavoured Frozen Yogurt", foodDescription: "Bombay kulfi flavours available in mango, pista or mixed (topped with candy and nuts)", foodType: "Dessert" ,foodSubCategory: "", imgName: "dessert", categoryImage: "Dessert",foodPrice:4.50),
     Food(foodName: "Paan (Take-out )", foodDescription: "", foodType: "Dessert" ,foodSubCategory: "", imgName: "dessert", categoryImage: "Dessert",foodPrice:2.50)
     
 ]
 #endif

 */
