//
//  DefaultRecipesManager.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/5/24.
//

import Foundation
import SwiftData

enum CategoryNames: String {
    case All, Favorites, Argentinian, Chilean, Paraguayan, Peruvian, American, Meat, Vegetables, Dinner, Lunch, Breakfast
}

/// This struct's responsability is to create, and save to the `ModelContext` the initial list of `recipes` ,`categories` and `ingredients`.
struct DefaultRecipesManager {
    
    //MARK: - Properties
    
    var modelContext: ModelContext
    var categories: [Category] = []
    
    
    //MARK: - Init
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        generateInitialCategories()
    }
    
    
    //MARK: - Create Default Data

    func createDefaultData() {
        
        
        //MARK: - Completo
        recipeGenerator(
            ingredients: [Ingredient(name: "🥖 Hot Buns", amount: "2", scale: "units"),
                          Ingredient(name: "🌭 Hot dogs", amount: "2", scale: "units"),
                          Ingredient(name: "🍅 Diced Tomatoes", amount: "500", scale: "Gr"),
                          Ingredient(name: "🥑 Avocado", amount: "2", scale: "units")],
            instructions: [
                Instruction(order: 1, title: "Cook", descriptions: "The first thing you’ll want to do is boil or grill your hot dogs."),
                Instruction(order: 2, title: "Slice & Dice", descriptions: "While the hot dogs are cooking, you want to chop your onions and tomatoes, as well as mash-up your avocado."),
                Instruction(order: 3, title: "Layer", descriptions: """
                    When you’re building your completo it’s all about layering in the proper order.
                    First, you’ll put the diced tomatoes and onions on first
                    Next, spread the avocado over the top. This will “seal” them against the hot dog so they’ll stay put while you’re eating it.
                    Then top everything off with ketchup and mustard and you’re all done and ready to enjoy them!
                    """),
            ],
            recipe: Recipe(
                name: "Completo",
                imageURL: "https://upload.wikimedia.org/wikipedia/commons/e/e0/Completo_italiano.jpg",
                recipeDescription: """
                   A completo is a Chilean-style hot dog (yes, there is a hot dog under there) in a fresh, soft bun that’s topped with diced onions, chopped tomatoes, ketchup, mustard, and mashed avocado. In Chile, they add lots of mayo to the mix but their mayonnaise is different than ours in the US, so we decided not to use that here.
                   """,
                cookTime: 30,
                servings: 1,
                instructions: [],
                categories: [],
                ingredients: []
              ),
            categories: getCategories(titles: [.Favorites, .Chilean])
        )
        
        //MARK: - Chacarrero
        recipeGenerator(ingredients: [
            Ingredient(name: "Thinly Sliced Beef Steak", amount: "6", scale: "oz"),
            Ingredient(name: "Bread Roll (Marraqueta or French Bread)", amount: "1", scale: "large"),
            Ingredient(name: "Tomato", amount: "1", scale: "large, sliced"),
            Ingredient(name: "Green Beans", amount: "1/2", scale: "cup, cooked"),
            Ingredient(name: "Avocado", amount: "1", scale: "ripe, mashed"),
            Ingredient(name: "Mayonnaise", amount: "2", scale: "tbsp"),
            Ingredient(name: "Chili Pepper (Ají Verde or Serrano)", amount: "1", scale: "small, sliced"),
            Ingredient(name: "Salt", amount: "1", scale: "pinch"),
            Ingredient(name: "Black Pepper", amount: "1", scale: "pinch"),
            Ingredient(name: "Vegetable Oil", amount: "1", scale: "tbsp"),

        ], instructions: [
            Instruction(order: 1, title: "Prepare the Steak", descriptions: "Season the thinly sliced beef steak with salt and black pepper on both sides."),
            Instruction(order: 2, title: "Cook the Steak", descriptions: "Heat the vegetable oil in a skillet over medium-high heat. Cook the steak until browned and cooked to your liking, about 2–3 minutes per side."),
            Instruction(order: 3, title: "Prepare the Bread", descriptions: "Slice the bread roll in half and spread mayonnaise on the cut sides."),
            Instruction(order: 4, title: "Assemble the Sandwich", descriptions: "Layer the cooked steak on the bottom half of the bread, followed by the sliced tomatoes, cooked green beans, and sliced chili pepper."),
            Instruction(order: 5, title: "Add Avocado", descriptions: "Spread the mashed avocado on the top half of the bread."),
            Instruction(order: 6, title: "Combine and Serve", descriptions: "Close the sandwich with the top half of the bread and serve immediately.")
        ], recipe: Recipe(
            name: "Chacarero Sandwich",
            imageURL: "https://www.seriouseats.com/thmb/butcu-S3iYd1zmRYrIOTTvb4CT0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/20240221-SEA-ChacareroChileno-EstudioComo18-78cddeb4684c42e8a70213a2b447d86d.jpg",
            recipeDescription: "A traditional Chilean sandwich featuring thinly sliced beef, green beans, tomatoes, avocado, and a hint of chili for a flavorful and satisfying meal.",
            cookTime: 15,
            servings: 1
        ), categories: getCategories(titles: [.Chilean, .Meat, .Lunch]))
        
        
        //MARK: - Argentinian Empanadas
        recipeGenerator(
            ingredients: [
                Ingredient(name: "Medium Potatoes", amount: "2", scale: "units"),
                Ingredient(name: "Onions", amount: "2", scale: "units"),
                Ingredient(name: "Ground Beef", amount: "1", scale: "pound"),
                Ingredient(name: "Empanada pastry rounds", amount: "24", scale: "units"),
                Ingredient(name: "Egg", amount: "1", scale: "unit")
            ],
            instructions: [
                Instruction(order: 1, title: "Place potatoes", descriptions: "Place potatoes in a large pot and cover with water; bring to a boil. Reduce heat to medium-low and simmer until barely tender, about 8 minutes. Drain. Once cool enough to handle, peel and cut into cubes. Set aside."),
                Instruction(order: 2, title: "Melt butter", descriptions: "Meanwhile, melt butter in a large skillet and cook onion and green onions until softened, about 5 minutes. Add bell pepper and cook for 3 minutes. Add ground beef; cook and stir until beef is browned, about 5 minutes. Season with paprika, cayenne pepper, and salt."),
                Instruction(order: 3, title: "Beef", descriptions: "Remove beef mixture from heat; add potatoes and olives. Stir in chopped hard-cooked eggs; set filling aside to cool, about 20 minutes."),
                Instruction(order: 4, title: "Oven", descriptions: "Preheat the oven to 425 degrees F (220 degrees C). Line 2 baking sheets with aluminum foil and lightly grease with olive oil."),
                Instruction(order: 5, title: "Place empanada", descriptions: "Place an empanada pastry round on a flat surface and lightly wet the edges with warm water. Put a large tablespoon of cooled filling in the center and fold dough over. Seal edges by pressing with a fork. Repeat with remaining rounds and filling. Transfer empanadas to the prepared baking sheets and brush with beaten egg."),
                Instruction(order: 6, title: "Bake", descriptions: "Bake in the preheated oven until golden brown, 15 to 20 minutes.")
            ],
            recipe: Recipe(
                name: "Argentinian Beef Empanadas",
                imageURL: "https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_4:3/k%2FPhoto%2FRecipes%2F2024-02-empanadas%2Fempanadas-515_1",
                recipeDescription: "This authentic empanada recipe is for Argentinian beef empanadas filled with a savory and delicious mixture of ground beef, hard-cooked eggs, green olives, and potatoes. These classic empanadas are ubiquitous all over Argentina.",
                cookTime: 90,
                servings: 12,
                instructions: [],
                categories: [],
                ingredients: []
            ),
            categories: getCategories(titles: [.Favorites, .Argentinian, .Meat, .Lunch, .Dinner]))
        
        //MARK: - Chipa soo
        recipeGenerator(
            ingredients: [
                Ingredient(name: "Harina Paraguaya", amount: "500", scale: "grs"),
                Ingredient(name: "Yuca starch", amount: "2", scale: "tbsps"),
                Ingredient(name: "Queso blanco", amount: "200", scale: "grs"),
                Ingredient(name: "Hard boiled Eggs", amount: "4", scale: "units"),
                Ingredient(name: "Boneless Beef Chuck", amount: "1", scale: "kg")
            ],
            instructions: [
                Instruction(order: 1, title: "Prepare the Beef Filling", descriptions: """
                    In a large nonstick pot, combine beef, 2 tablespoons olive oil, water, beef bouillon, ground black pepper, red pepper flakes, and garlic. Stir and bring to a simmer over medium-high heat.
                    Reduce heat to low, cover, and simmer, occasionally stirring, until the beef is tender, about 1 hour. Remove the lid and increase heat to high until the liquid reduces to a juicy but dry consistency, about 3 to 5 minutes.
                    Add the paprika, white part of the scallions, onions, and peppers. Cook until soft, about 10 minutes.
                    Add the parsley and the green part of the green onions. Sauté for another 10 minutes to eliminate any excess liquid (the mixture should be moist but not runny). Taste and adjust seasoning if needed.
                    Working in batches, transfer the meat mixture to a food processor or blender and pulse until it is coarsely shredded (do not overdo it, or you'll end up with a puree).
                    Transfer each batch of shredded meat mixture into a large mixing bowl and mix in the minced eggs. Let it cool to room temperature, then cover and refrigerate until ready to use.
                """),
                Instruction(order: 2, title: "Prepare the Dough", descriptions: """
                    Whisk the cornmeal, yuca starch, and 3 teaspoons of kosher salt in a large bowl.
                    Make a well in the center of the cornmeal mixture and add the butter, milk, cheese, and egg.
                    Work the wet mixture into the cornmeal mixture to form a soft and smooth dough. If more liquid is needed, add a little more milk. Cover and refrigerate until ready to use.
                """),
                Instruction(order: 3, title: "Assemble the Chipa So'o", descriptions: """
                    Preheat the oven to 350°F.
                    Grab a handful of dough and roll it into a large ball. Flatten it with your hand, creating a hollow in the center with one of your thumbs to create a basket-like shape.
                    Place a heaping spoonful of the filling in the center of the dough, then slowly close it to form a ball with the filling inside. Flatten the base on one side and give it a rounded or domed shape.
                    Place the finished piece on a non-stick oven sheet or lightly greased and lightly dusted with cornmeal. Repeat the process until all the pieces are finished. If necessary, cook the Chipa So'o in two batches.
                    Bake the Chipa So'o for 20 to 25 minutes or until golden brown.
                """)
            ],
            recipe: Recipe(
                name: "Chipa Soo",
                imageURL: "https://assets.elgourmet.com/wp-content/uploads/2023/09/UO_EPISODICAS_CHIPA_SOO-3.jpg",
                recipeDescription: "Chipa So'o is a traditional and iconic dish in Paraguayan cuisine. This savory snack, rooted in Guarani-Spanish Jesuit culinary heritage, consists of a delicious baked corn dough filled with savory meat. It's a popular choice for a mid-morning snack or lunch.",
                cookTime: 90,
                servings: 24,
                instructions: [],
                categories: [],
                ingredients: []
            ),
            categories: getCategories(titles: [.Paraguayan, .Favorites, .Lunch, .Breakfast, .Meat])
        )
        
        
        //MARK: - Taco Soup
        recipeGenerator(
            ingredients: [
                Ingredient(name: "Ground Beef", amount: "1", scale: "lb"),
                Ingredient(name: "Onion", amount: "1", scale: "large"),
                Ingredient(name: "Black Beans", amount: "1", scale: "can (15 oz)"),
                Ingredient(name: "Pinto Beans", amount: "1", scale: "can (15 oz)"),
                Ingredient(name: "Corn", amount: "1", scale: "can (15 oz)"),
                Ingredient(name: "Diced Tomatoes", amount: "1", scale: "can (15 oz)"),
                Ingredient(name: "Green Chilies", amount: "1", scale: "can (4 oz)"),
                Ingredient(name: "Taco Seasoning", amount: "1", scale: "packet"),
                Ingredient(name: "Ranch Dressing Mix", amount: "1", scale: "packet"),
                Ingredient(name: "Water", amount: "2", scale: "cups"),

            ],
            instructions: [
                Instruction(order: 1, title: "Cook Ground Beef", descriptions: "In a large pot or skillet, cook the ground beef over medium heat until browned. Drain any excess fat."),
                Instruction(order: 2, title: "Sauté Onion", descriptions: "Add the chopped onion to the pot and sauté until softened, about 5 minutes."),
                Instruction(order: 3, title: "Add Ingredients", descriptions: "Stir in black beans, pinto beans, corn, diced tomatoes, green chilies, taco seasoning, and ranch dressing mix."),
                Instruction(order: 4, title: "Add Water", descriptions: "Pour in the water and mix everything together."),
                Instruction(order: 5, title: "Simmer", descriptions: "Bring the mixture to a boil, then reduce the heat to low. Simmer for 20–30 minutes, stirring occasionally."),
                Instruction(order: 6, title: "Serve", descriptions: "Ladle the soup into bowls and serve with your favorite toppings like shredded cheese, sour cream, or tortilla chips.")
            ],
            recipe: Recipe(
                name: "Taco Soup",
                imageURL: "https://www.cookingclassy.com/wp-content/uploads/2019/08/taco-soup-16-600x908.jpg",
                recipeDescription: "A hearty and flavorful soup made with ground beef, beans, corn, and classic taco seasonings. Perfect for a cozy dinner or meal prep.",
                cookTime: 30,
                servings: 6
            ),
            categories: getCategories(titles: [.American, .Vegetables, .Dinner, .Lunch])
        )
        
        //MARK: - Chilean Empanadas
        recipeGenerator(
            ingredients: [
                Ingredient(name: "All-Purpose Flour", amount: "4", scale: "cups"),
                Ingredient(name: "Salt", amount: "1", scale: "tsp"),
                Ingredient(name: "Unsalted Butter", amount: "1/2", scale: "cup"),
                Ingredient(name: "Egg", amount: "1", scale: "large"),
                Ingredient(name: "Water", amount: "1", scale: "cup"),
                Ingredient(name: "Ground Beef", amount: "1", scale: "lb"),
                Ingredient(name: "Onion", amount: "2", scale: "medium, diced"),
                Ingredient(name: "Hard-Boiled Eggs", amount: "2", scale: "sliced"),
                Ingredient(name: "Black Olives", amount: "1/2", scale: "cup"),
                Ingredient(name: "Raisins", amount: "1/4", scale: "cup"),
                Ingredient(name: "Cumin", amount: "1", scale: "tsp"),
                Ingredient(name: "Paprika", amount: "1", scale: "tsp"),
                Ingredient(name: "Salt", amount: "1/2", scale: "tsp"),
                Ingredient(name: "Pepper", amount: "1/4", scale: "tsp"),
                Ingredient(name: "Vegetable Oil", amount: "2", scale: "tbsp")
            ],
            instructions: [
                Instruction(order: 1, title: "Prepare Dough", descriptions: "Mix flour and salt in a large bowl. Cut in butter until crumbly. Add the egg and water, mixing until dough forms. Wrap in plastic and chill for 30 minutes."),
                Instruction(order: 2, title: "Cook Filling", descriptions: "Heat oil in a skillet over medium heat. Add onions and sauté until translucent. Add ground beef, cumin, paprika, salt, and pepper, and cook until browned."),
                Instruction(order: 3, title: "Assemble Empanadas", descriptions: "Roll out dough and cut into circles. Place a spoonful of filling in the center, add a slice of egg, a black olive, and a few raisins. Fold and seal the edges."),
                Instruction(order: 4, title: "Bake Empanadas", descriptions: "Preheat oven to 375°F (190°C). Place empanadas on a baking sheet and bake for 20–25 minutes, or until golden brown."),
                Instruction(order: 5, title: "Serve", descriptions: "Let empanadas cool slightly before serving. Enjoy warm or at room temperature.")
            ],
            recipe: Recipe(
                name: "Chilean Empanadas",
                imageURL: "https://cravingsjournal.com/wp-content/uploads/2023/09/chilean-empanadas-3.jpg",
                recipeDescription: "Traditional Chilean empanadas filled with ground beef, onions, hard-boiled eggs, black olives, and raisins, wrapped in a golden baked pastry.",
                cookTime: 60,
                servings: 8
            ),
            categories: getCategories(titles: [.Chilean, .Lunch, .Dinner, .Meat])
        )

        //MARK: - Argentina Chimichurri Steak
        recipeGenerator(
            ingredients: [
                Ingredient(name: "Flank Steak", amount: "1", scale: "lb"),
                Ingredient(name: "Salt", amount: "1", scale: "tsp"),
                Ingredient(name: "Black Pepper", amount: "1/2", scale: "tsp"),
                Ingredient(name: "Olive Oil", amount: "2", scale: "tbsp"),
                Ingredient(name: "Garlic", amount: "4", scale: "cloves, minced"),
                Ingredient(name: "Fresh Parsley", amount: "1", scale: "cup, finely chopped"),
                Ingredient(name: "Fresh Oregano", amount: "2", scale: "tbsp, chopped"),
                Ingredient(name: "Red Chili Flakes", amount: "1", scale: "tsp"),
                Ingredient(name: "Red Wine Vinegar", amount: "2", scale: "tbsp"),
                Ingredient(name: "Water", amount: "2", scale: "tbsp")
            ],
            instructions: [
                Instruction(order: 1, title: "Season Steak", descriptions: "Pat the steak dry with paper towels. Season both sides with salt and black pepper."),
                Instruction(order: 2, title: "Cook Steak", descriptions: "Heat olive oil in a skillet over medium-high heat. Sear the steak for 4–5 minutes on each side, or until desired doneness. Let it rest for 5 minutes."),
                Instruction(order: 3, title: "Prepare Chimichurri", descriptions: "In a bowl, mix parsley, oregano, garlic, red chili flakes, red wine vinegar, olive oil, and water. Stir to combine and let sit for 10 minutes."),
                Instruction(order: 4, title: "Slice Steak", descriptions: "Thinly slice the rested steak against the grain."),
                Instruction(order: 5, title: "Serve", descriptions: "Drizzle chimichurri sauce over the steak slices and serve. Enjoy with a side of grilled vegetables or roasted potatoes.")
            ],
            recipe: Recipe(
                name: "Chimichurri Steak",
                imageURL: "https://res.cloudinary.com/hksqkdlah/image/upload/31997_sfs-argantinian-steaks-51.jpg",
                recipeDescription: "A classic Argentinian dish featuring a perfectly seared flank steak topped with a vibrant and zesty chimichurri sauce.",
                cookTime: 30,
                servings: 4
            ),
            categories: getCategories(titles: [.Argentinian, .Meat, .Dinner])
        )

        //MARK: - Apple Pie
        recipeGenerator(
            ingredients: [
                Ingredient(name: "Pie Crust", amount: "2", scale: "crusts, 9-inch"),
                Ingredient(name: "Apples", amount: "6", scale: "medium, peeled and sliced"),
                Ingredient(name: "Granulated Sugar", amount: "3/4", scale: "cup"),
                Ingredient(name: "Brown Sugar", amount: "1/4", scale: "cup"),
                Ingredient(name: "Ground Cinnamon", amount: "1", scale: "tsp"),
                Ingredient(name: "Ground Nutmeg", amount: "1/4", scale: "tsp"),
                Ingredient(name: "Lemon Juice", amount: "1", scale: "tbsp"),
                Ingredient(name: "All-Purpose Flour", amount: "2", scale: "tbsp"),
                Ingredient(name: "Butter", amount: "2", scale: "tbsp, cut into small pieces"),
                Ingredient(name: "Egg", amount: "1", scale: "large, beaten"),
                Ingredient(name: "Milk", amount: "1", scale: "tbsp")
            ],
            instructions: [
                Instruction(order: 1, title: "Prepare Pie Crust", descriptions: "Place one pie crust in a 9-inch pie pan. Set aside."),
                Instruction(order: 2, title: "Prepare Filling", descriptions: "In a large bowl, combine the sliced apples, granulated sugar, brown sugar, cinnamon, nutmeg, lemon juice, and flour. Toss until the apples are evenly coated."),
                Instruction(order: 3, title: "Fill Pie Crust", descriptions: "Pour the apple mixture into the prepared pie crust. Dot with small pieces of butter."),
                Instruction(order: 4, title: "Top with Second Crust", descriptions: "Place the second pie crust over the apples. Trim and crimp the edges to seal the pie. Cut small slits in the top crust to allow steam to escape."),
                Instruction(order: 5, title: "Brush with Egg Wash", descriptions: "Brush the top crust with the beaten egg and milk mixture for a golden finish."),
                Instruction(order: 6, title: "Bake", descriptions: "Preheat the oven to 425°F (220°C). Bake the pie for 45-50 minutes, or until the crust is golden brown and the filling is bubbling."),
                Instruction(order: 7, title: "Cool and Serve", descriptions: "Allow the pie to cool for at least an hour before slicing. Serve with vanilla ice cream or whipped cream.")
            ],
            recipe: Recipe(
                name: "Apple Pie",
                imageURL: "https://recipe30.com/wp-content/uploads/2020/11/Apple-pie.jpg",
                recipeDescription: "A classic American dessert, this apple pie features a flaky crust and a sweet, spiced apple filling. Perfect for any occasion.",
                cookTime: 60,
                servings: 8
            ),
            categories: getCategories(titles: [.American, .Lunch])
        )

        //MARK: - Chipa Paraguaya
        recipeGenerator(
            ingredients: [
                Ingredient(name: "Masa Harina (corn flour)", amount: "2", scale: "cups"),
                Ingredient(name: "Tapioca Flour", amount: "1", scale: "cup"),
                Ingredient(name: "Grated Paraguayan Cheese", amount: "2", scale: "cups"),
                Ingredient(name: "Grated Parmesan Cheese", amount: "1/2", scale: "cup"),
                Ingredient(name: "Eggs", amount: "2", scale: "large"),
                Ingredient(name: "Butter", amount: "1/4", scale: "cup, melted"),
                Ingredient(name: "Milk", amount: "1/2", scale: "cup"),
                Ingredient(name: "Baking Powder", amount: "1", scale: "tsp"),
                Ingredient(name: "Salt", amount: "1", scale: "tsp"),
                Ingredient(name: "Ground White Pepper", amount: "1/2", scale: "tsp")
            ],
            instructions: [
                Instruction(order: 1, title: "Preheat Oven", descriptions: "Preheat your oven to 350°F (175°C)."),
                Instruction(order: 2, title: "Mix Dry Ingredients", descriptions: "In a large bowl, mix together the masa harina, tapioca flour, baking powder, salt, and pepper."),
                Instruction(order: 3, title: "Add Wet Ingredients", descriptions: "Add the grated cheeses, eggs, melted butter, and milk to the dry ingredients. Stir until combined. The dough should be thick but soft."),
                Instruction(order: 4, title: "Shape the Dough", descriptions: "Divide the dough into small balls, about 1 inch in diameter, and place them on a greased baking sheet. Leave space between each ball for expansion."),
                Instruction(order: 5, title: "Bake", descriptions: "Bake in the preheated oven for 15-20 minutes, or until the chipa are lightly golden and firm to the touch."),
                Instruction(order: 6, title: "Serve", descriptions: "Let the chipa cool slightly before serving. They are best enjoyed warm and can be served as a snack or alongside a meal.")
            ],
            recipe: Recipe(
                name: "Chipa",
                imageURL: "https://media.istockphoto.com/id/1170988641/photo/chipa-cheese-bread-balls-from-paraguay.jpg?s=612x612&w=0&k=20&c=QVtRqJgZ1BEMMHUa3FZYeaUyuHbjrnavOx3ioQ0wTAQ=",
                recipeDescription: "Chipa is a traditional Paraguayan cheese bread made with masa harina, tapioca flour, and cheese. It's savory, cheesy, and delicious.",
                cookTime: 30,
                servings: 6
            ),
            categories: getCategories(titles: [.Paraguayan, .Breakfast])
        )
        
        //MARK: - Pastel de Choclo
        recipeGenerator(
            ingredients: [
                Ingredient(name: "Ground Beef", amount: "1", scale: "lb"),
                Ingredient(name: "Onion", amount: "1", scale: "large, finely chopped"),
                Ingredient(name: "Garlic", amount: "2", scale: "cloves, minced"),
                Ingredient(name: "Sweet Corn", amount: "4", scale: "cups, fresh or frozen"),
                Ingredient(name: "Milk", amount: "1/2", scale: "cup"),
                Ingredient(name: "Butter", amount: "1/4", scale: "cup"),
                Ingredient(name: "Egg", amount: "1", scale: "large"),
                Ingredient(name: "Black Olives", amount: "1/4", scale: "cup, pitted and chopped"),
                Ingredient(name: "Hard-Boiled Eggs", amount: "2", scale: "sliced"),
                Ingredient(name: "Raisins", amount: "1/4", scale: "cup"),
                Ingredient(name: "Ground Cumin", amount: "1/2", scale: "tsp"),
                Ingredient(name: "Paprika", amount: "1", scale: "tsp"),
                Ingredient(name: "Salt", amount: "to taste", scale: ""),
                Ingredient(name: "Pepper", amount: "to taste", scale: "")
            ],
            instructions: [
                Instruction(order: 1, title: "Cook the Meat", descriptions: "In a large skillet, cook the ground beef over medium heat. Add the chopped onion and garlic, and cook until softened and the beef is browned."),
                Instruction(order: 2, title: "Season the Filling", descriptions: "Stir in the ground cumin, paprika, salt, and pepper. Add the black olives, raisins, and hard-boiled eggs. Remove from heat and set aside."),
                Instruction(order: 3, title: "Prepare the Corn Topping", descriptions: "In a blender or food processor, blend the sweet corn with the milk and butter until smooth. Season with salt and pepper to taste."),
                Instruction(order: 4, title: "Assemble the Pastel de Choclo", descriptions: "In a greased baking dish, spread the meat mixture evenly. Pour the corn mixture over the top, smoothing it into an even layer."),
                Instruction(order: 5, title: "Bake", descriptions: "Preheat the oven to 375°F (190°C). Bake the pastel for 30-35 minutes or until the corn topping is golden brown on top."),
                Instruction(order: 6, title: "Serve", descriptions: "Let the pastel de choclo cool for a few minutes before serving. It’s often enjoyed with a side of salad.")
            ],
            recipe: Recipe(
                name: "Pastel de Choclo",
                imageURL: "https://www.seriouseats.com/thmb/Q49esZbdB_HXuPWlFwrJFED7zWs=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/20240725-SEA-PASTELDECHOCLO-EstudioComo-Hero-02-02-773d9d85354d46f18b0cdc7f08c23bf3.jpg",
                recipeDescription: "Pastel de Choclo is a traditional Chilean corn pie made with a savory beef and onion filling topped with a creamy corn mixture. A flavorful, comforting dish.",
                cookTime: 60,
                servings: 6
            ),
            categories: getCategories(titles: [.Chilean, .Dinner, .Lunch])
        )


        //MARK: - Cazuela
        recipeGenerator(
            ingredients: [
                Ingredient(name: "Beef Shank or Stew Meat", amount: "2", scale: "lb, cut into chunks"),
                Ingredient(name: "Onion", amount: "1", scale: "large, chopped"),
                Ingredient(name: "Garlic", amount: "2", scale: "cloves, minced"),
                Ingredient(name: "Carrots", amount: "2", scale: "medium, peeled and chopped"),
                Ingredient(name: "Potatoes", amount: "4", scale: "medium, peeled and cut into chunks"),
                Ingredient(name: "Corn on the Cob", amount: "2", scale: "ears, cut into thirds"),
                Ingredient(name: "Pumpkin", amount: "1/4", scale: "medium, peeled and cut into chunks"),
                Ingredient(name: "Green Beans", amount: "1", scale: "cup, chopped"),
                Ingredient(name: "Cilantro", amount: "1/4", scale: "cup, chopped"),
                Ingredient(name: "Beef Broth", amount: "6", scale: "cups"),
                Ingredient(name: "Bay Leaves", amount: "2", scale: "leaves"),
                Ingredient(name: "Salt", amount: "to taste", scale: ""),
                Ingredient(name: "Pepper", amount: "to taste", scale: "")
            ],
            instructions: [
                Instruction(order: 1, title: "Brown the Meat", descriptions: "In a large pot, heat some oil over medium-high heat. Brown the beef chunks on all sides. Remove the meat and set aside."),
                Instruction(order: 2, title: "Sauté the Onion and Garlic", descriptions: "In the same pot, add the chopped onion and garlic. Sauté for 3-4 minutes until softened and fragrant."),
                Instruction(order: 3, title: "Add Broth and Vegetables", descriptions: "Return the beef to the pot. Add the beef broth, bay leaves, carrots, potatoes, corn, pumpkin, and salt and pepper to taste. Bring to a boil."),
                Instruction(order: 4, title: "Simmer", descriptions: "Reduce the heat and simmer for 45 minutes to 1 hour, until the beef is tender and the vegetables are cooked through."),
                Instruction(order: 5, title: "Add Green Beans and Cilantro", descriptions: "Add the green beans and chopped cilantro to the pot. Continue simmering for 10-15 more minutes until the beans are tender."),
                Instruction(order: 6, title: "Serve", descriptions: "Serve the cazuela hot, with a piece of beef and a generous amount of vegetables and broth in each bowl.")
            ],
            recipe: Recipe(
                name: "Cazuela de Vacuno",
                imageURL: "https://www.gourmet.cl/wp-content/uploads/2011/03/cazuela_de_vacuno.jpg",
                recipeDescription: "Cazuela de Vacuno is a traditional Chilean beef stew with a variety of vegetables like carrots, potatoes, corn, and pumpkin, simmered in a flavorful broth.",
                cookTime: 90,
                servings: 6
            ),
            categories: getCategories(titles: [.Chilean, .Dinner, .Meat, .Vegetables])
        )

        //MARK: - Sopaipillas
        recipeGenerator(
            ingredients: [
                Ingredient(name: "All-Purpose Flour", amount: "2", scale: "cups"),
                Ingredient(name: "Baking Powder", amount: "2", scale: "teaspoons"),
                Ingredient(name: "Salt", amount: "1/2", scale: "teaspoon"),
                Ingredient(name: "Butter", amount: "1/4", scale: "cup, cold and cut into small pieces"),
                Ingredient(name: "Warm Water", amount: "3/4", scale: "cup"),
                Ingredient(name: "Pumpkin Puree", amount: "1/2", scale: "cup, optional for color and flavor"),
                Ingredient(name: "Vegetable Oil", amount: "for frying", scale: ""),
                Ingredient(name: "Chilean Pebre or Chancaca Syrup", amount: "optional", scale: "for topping")
            ],
            instructions: [
                Instruction(order: 1, title: "Make the Dough", descriptions: "In a large bowl, whisk together the flour, baking powder, and salt. Add the cold butter and rub it into the flour until it resembles coarse crumbs. Add warm water (and pumpkin puree if using) and knead until a smooth dough forms."),
                Instruction(order: 2, title: "Rest the Dough", descriptions: "Cover the dough with a clean kitchen towel and let it rest for 30 minutes."),
                Instruction(order: 3, title: "Roll Out the Dough", descriptions: "Once the dough has rested, roll it out on a lightly floured surface to about 1/4 inch thickness."),
                Instruction(order: 4, title: "Cut the Dough", descriptions: "Cut the dough into circles using a cookie cutter or a drinking glass (about 2 inches in diameter)."),
                Instruction(order: 5, title: "Heat the Oil", descriptions: "Heat vegetable oil in a deep pan or fryer to about 350°F (175°C)."),
                Instruction(order: 6, title: "Fry the Sopaipillas", descriptions: "Fry the dough circles in batches until golden brown, about 2-3 minutes per side. Remove and drain on paper towels."),
                Instruction(order: 7, title: "Serve", descriptions: "Serve the sopaipillas hot with your choice of pebre (a Chilean salsa) or chancaca syrup (a sweet sugar syrup).")
            ],
            recipe: Recipe(
                name: "Sopaipillas",
                imageURL: "https://stirringupadventure.com/wp-content/uploads/2020/02/Sopaipillas-Idli-Papp-shutterstock_276736553-sized.jpg",
                recipeDescription: "Sopaipillas are a traditional Chilean fried dough, soft and fluffy on the inside, often served with pebre (a Chilean salsa) or chancaca syrup (a sweet sugar syrup).",
                cookTime: 45,
                servings: 6
            ),
            categories: getCategories(titles: [.Chilean, .Breakfast])
        )

        //MARK: - Porotos Granados
        recipeGenerator(
            ingredients: [
                Ingredient(name: "Fresh Cranberry Beans", amount: "2", scale: "cups, shelled (or use canned if unavailable)"),
                Ingredient(name: "Corn Kernels", amount: "2", scale: "cups, fresh or frozen"),
                Ingredient(name: "Onion", amount: "1", scale: "medium, chopped"),
                Ingredient(name: "Garlic", amount: "2", scale: "cloves, minced"),
                Ingredient(name: "Tomato", amount: "2", scale: "large, chopped"),
                Ingredient(name: "Basil", amount: "1", scale: "cup, fresh leaves, chopped"),
                Ingredient(name: "Olive Oil", amount: "2", scale: "tablespoons"),
                Ingredient(name: "Salt", amount: "to taste", scale: ""),
                Ingredient(name: "Pepper", amount: "to taste", scale: ""),
                Ingredient(name: "Water", amount: "6", scale: "cups"),
                Ingredient(name: "Pumpkin", amount: "1", scale: "cup, peeled and cubed (optional, for added flavor)")
            ],
            instructions: [
                Instruction(order: 1, title: "Prepare the Beans", descriptions: "If using fresh cranberry beans, soak them overnight in water. Drain and rinse. If using canned beans, drain and rinse them."),
                Instruction(order: 2, title: "Sauté the Vegetables", descriptions: "In a large pot, heat olive oil over medium heat. Add the chopped onion and garlic, sautéing until softened, about 5 minutes."),
                Instruction(order: 3, title: "Add Tomatoes and Cook", descriptions: "Add the chopped tomatoes and cook for 5-7 minutes until they release their juices and soften."),
                Instruction(order: 4, title: "Cook the Beans", descriptions: "Add the soaked beans and water to the pot. Bring to a boil, then reduce the heat and simmer for 1–1.5 hours, or until the beans are tender."),
                Instruction(order: 5, title: "Add Corn and Pumpkin", descriptions: "Add the corn kernels, cubed pumpkin (if using), and basil to the pot. Stir well and simmer for another 20–30 minutes until the corn and pumpkin are cooked through."),
                Instruction(order: 6, title: "Season and Serve", descriptions: "Season with salt and pepper to taste. Serve hot, garnished with extra basil if desired.")
            ],
            recipe: Recipe(
                name: "Porotos Granados",
                imageURL: "https://www.midiariodecocina.com/wp-content/uploads/2015/05/Porotos-granados01.jpg",
                recipeDescription: "Porotos Granados is a classic Chilean bean stew made with fresh cranberry beans, corn, tomatoes, and basil. A flavorful and comforting dish, perfect for any season.",
                cookTime: 90,
                servings: 6
            ),
            categories: getCategories(titles: [.Chilean, .Vegetables, .Dinner, .Lunch])
        )
        
        //MARK: - Chorrillana
        recipeGenerator(
            ingredients: [
                Ingredient(name: "Beef Skirt Steak", amount: "1", scale: "lb, sliced into strips"),
                Ingredient(name: "Onion", amount: "1", scale: "large, thinly sliced"),
                Ingredient(name: "Potatoes", amount: "4", scale: "large, peeled and cut into fries"),
                Ingredient(name: "Eggs", amount: "4", scale: "large"),
                Ingredient(name: "Chorizo", amount: "2", scale: "sausages, sliced"),
                Ingredient(name: "Bell Pepper", amount: "1", scale: "medium, sliced"),
                Ingredient(name: "Garlic", amount: "2", scale: "cloves, minced"),
                Ingredient(name: "Olive Oil", amount: "2", scale: "tablespoons"),
                Ingredient(name: "Salt", amount: "to taste", scale: ""),
                Ingredient(name: "Black Pepper", amount: "to taste", scale: "")
            ],
            instructions: [
                Instruction(order: 1, title: "Fry the Potatoes", descriptions: "Heat oil in a deep fryer or large pan and fry the potato strips until golden and crispy. Remove and set aside on paper towels to drain excess oil."),
                Instruction(order: 2, title: "Cook the Steak", descriptions: "In a large skillet, heat some olive oil over medium-high heat. Add the sliced beef skirt steak and cook until browned on all sides. Season with salt and pepper."),
                Instruction(order: 3, title: "Sauté the Onions and Chorizo", descriptions: "In the same skillet, add the sliced onions, garlic, bell pepper, and chorizo. Cook until the onions soften and the chorizo is slightly crispy."),
                Instruction(order: 4, title: "Fry the Eggs", descriptions: "In another pan, fry the eggs sunny-side-up or to your preferred level of doneness."),
                Instruction(order: 5, title: "Assemble the Chorrillana", descriptions: "On a large plate, layer the fried potatoes, followed by the beef, onion, and chorizo mixture. Top with the fried eggs."),
                Instruction(order: 6, title: "Serve", descriptions: "Serve immediately, and enjoy the delicious Chilean Chorrillana!")
            ],
            recipe: Recipe(
                name: "Chorrillana",
                imageURL: "https://www.gourmet.cl/wp-content/uploads/2015/08/chorrillana.jpg",
                recipeDescription: "Chorrillana is a hearty Chilean dish made with fried potatoes, beef, chorizo, onions, and topped with fried eggs. Perfect for sharing!",
                cookTime: 30,
                servings: 4
            ),
            categories: getCategories(titles: [.Chilean, .Meat, .Dinner])
        )
        
        //MARK: - Mate
        recipeGenerator(
            ingredients: [
                Ingredient(name: "Yerba Mate", amount: "1", scale: "cup"),
                Ingredient(name: "Hot Water", amount: "500", scale: "ml (around 90°C or 194°F)"),
                Ingredient(name: "Sugar", amount: "to taste", scale: "optional")
            ],
            instructions: [
                Instruction(order: 1, title: "Prepare the Mate", descriptions: "Fill the mate glass (gourd) about half full with yerba mate. Tilt the glass to a 45-degree angle so that the yerba mate settles on one side."),
                Instruction(order: 2, title: "Heat the Water", descriptions: "Heat water in a kettle until it reaches about 90°C (194°F). The water should not be boiling; it should be hot but not too hot to burn the leaves."),
                Instruction(order: 3, title: "Add Hot Water", descriptions: "Pour a small amount of hot water (about 1/4 of the glass) into the yerba mate to soak it. Let it sit for a minute."),
                Instruction(order: 4, title: "Insert the Straw", descriptions: "Insert the straw (bombilla) into the yerba mate at an angle, ensuring it stays at the bottom of the glass."),
                Instruction(order: 5, title: "Add More Hot Water", descriptions: "Pour the rest of the hot water into the yerba mate, filling the glass to your desired level."),
                Instruction(order: 6, title: "Serve", descriptions: "Drink the mate through the straw. Once it's finished, refill the gourd with hot water for the next serving. Pass the gourd around to share with others.")
            ],
            recipe: Recipe(
                name: "Mate",
                imageURL: "https://argentineasado.com/wp-content/uploads/2023/11/image.png",
                recipeDescription: "Mate is a traditional Argentine drink made from yerba mate leaves steeped in hot water. It's often shared among friends and family and served in a gourd with a straw.",
                cookTime: 5,
                servings: 1
            ),
            categories: getCategories(titles: [.Argentinian])
        )


        
        try? modelContext.save()
    }
     
    mutating func generateInitialCategories() {
        self.categories = [
            Category(title: CategoryNames.All.rawValue, emoji: "🍽️"),
            Category(title: CategoryNames.Favorites.rawValue, emoji: "⭐️"),
            Category(title: CategoryNames.Chilean.rawValue, emoji: "🇨🇱"),
            Category(title: CategoryNames.Argentinian.rawValue, emoji: "🇦🇷"),
            Category(title: CategoryNames.Paraguayan.rawValue, emoji: "🇵🇾"),
            Category(title: CategoryNames.Peruvian.rawValue, emoji: "🇵🇪"),
            Category(title: CategoryNames.American.rawValue, emoji: "🇺🇸"),
            Category(title: CategoryNames.Meat.rawValue, emoji: "🥩"),
            Category(title: CategoryNames.Vegetables.rawValue, emoji: "🥦"),
            Category(title: CategoryNames.Dinner.rawValue, emoji: "🌙"),
            Category(title: CategoryNames.Lunch.rawValue, emoji: "🕛"),
            Category(title: CategoryNames.Breakfast.rawValue, emoji: "🌅")
        ]
    }

    
    //MARK: - Helper Functions
    
    func recipeGenerator(ingredients: [Ingredient], instructions: [Instruction], recipe: Recipe, categories: [Category]) {
        let allCategory = self.categories.first(where: { $0.title == CategoryNames.All.rawValue })
        
        recipe.ingredients = ingredients
        recipe.categories = categories
        recipe.categories.append(allCategory!)
        recipe.instructions = instructions
        modelContext.insert(recipe)
    }
    
    func getCategories(titles: [CategoryNames]) -> [Category] {
        var titlesAsString: [String] = []
        
        for title in titles {
            titlesAsString.append(title.rawValue)
        }
        
        titlesAsString.append(CategoryNames.All.rawValue)
        
        return self.categories.filter { titlesAsString.contains($0.title) }
    }
}
