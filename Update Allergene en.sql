update [InhaltsstoffeLocal].[dbo].[AllergensLocals] set AllergenLocalName = 'cereals containing gluten' where AllergenLocalName = 'gluten corn'
update [InhaltsstoffeLocal].[dbo].[AllergensLocals] set AllergenLocalName = 'crustaceans' where AllergenLocalName = 'shellfish'
update [InhaltsstoffeLocal].[dbo].[AllergensLocals] set AllergenLocalName = 'eggs' where AllergenLocalName = 'egg'
update [InhaltsstoffeLocal].[dbo].[AllergensLocals] set AllergenLocalName = 'peanuts' where AllergenLocalName = 'peanut'
update [InhaltsstoffeLocal].[dbo].[AllergensLocals] set AllergenLocalName = 'soybeans' where AllergenLocalName = 'soybean'
update [InhaltsstoffeLocal].[dbo].[AllergensLocals] set AllergenLocalName = 'nuts' where AllergenLocalName = 'peel fruits'
update [InhaltsstoffeLocal].[dbo].[AllergensLocals] set AllergenLocalName = 'molluscs' where AllergenLocalName = 'mollusk'

update [InhaltsstoffeLocal].[dbo].[AllergensLocals] set AllergenLocalToolTip = 'ToolTip ' + AllergenLocalName

update [InhaltsstoffeLocal].[dbo].[CategoriesLocals] set CategoryLocalName = 'partproduct' WHERE CategoryLocalID = 4