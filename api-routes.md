# Enums
```c#
public enum ActivityType {
    Soaking = 0,
    Dehydrating = 1,
    StockingMaterial = 2,
    Transformation = 3,
    Bagging = 4
}
public enum ItemDirection
{
    Input = 0,
    Output = 1,
}
public enum ItemType
{
    Material = 0,
    FinishedProduct = 1
}
public enum LogAction
{
    Create = 0,
    Update = 1,
    Delete = 2
}
public enum MaterialType
{
    Raw = 0,
    Soaked = 1,
    Dehydrating = 2,
    Dehydrated = 3
    
}
public enum ProductType
{
    Jar = 0,
    Bag = 1
}
public enum UserType
{
    User = 0,
    SuperUser = 1,
}
```

# Controllers

## AuthController
login

### ``POST api/login``
get un token de connexion

**Body:**
```json
{
   "UserName" : "string",
   "Password" : "string"
}
```

**Returns:**
- ``OK (200)`` retourne un token dans le body 
   ```json
   { "token": "string" }
   ```
- ``Bad Request (400)`` : Mot de passe ou username invalide


## UsersController

### ``POST api/users/register`` (SuperUser)
register un nouveau user

**Body:**
```json
{
   "Name" : "string"
   "UserName" : "string"
   "Password" : "string"
   "UserType" : "int"
}
```

**Returns:**
- ``NoContent (204)`` : utilisateur créé
- ``BadRequest (400)`` : champs manquant, mauvais format, etc.
- ``Unauthorized (401)`` : pas connecter en super us


## ProductsController

### ``GET api/products``
retourne tout les produits

**Returns:**
- liste des produits
```json
[
   {
      "Id" : "int",
      "Name" : "string"
   },
   ...
]
```

### ``GET api/products/{id}``
prend le produit avec un certain id

**Returns:**
- ``Ok (200)`` : le produit don't l'id match
```json
{
   "Id" : "int",
   "Name" : "string"
}
```
- ``NotFound (404)`` : l'id match aucun produit

### ``POST api/products`` (SuperUser)
créer un nouveau produit

**Body:**
```json
{
   "Name" : "string"
}
```
**Returns:**
- ``Ok (200)`` : le produit créé avec son Id
```json
{
   "Id" : "int",
   "Name" : "string"
}
```

## MaterialsController

``GET api/materials``
returns tout les matériaux

**Returns:**
- ``OK (200)`` : array des matériaux
```json
[
   {
      "Id" : "int",
      "DeliveryId" : "int",
      "BatchNumber" : "string",
      "VarietyName" : "string",
      "QuantityKg" : "float",
      "MaterialType" : "int" //0 = cru, 1 = trempé, 2 = en déshydratage, 3 = déshydraté
   }
]
```


### ``Get api/materials/batch/{batchNumber}``
returns tout les matériaux avec un certain batch number
```json
[
   {
      "Id" : "int",
      "DeliveryId" : "int",
      "BatchNumber" : "string",
      "VarietyName" : "string",
      "QuantityKg" : "float",
      "MaterialType" : "int" //0 = cru, 1 = trempé, 2 = en déshydratage, 3 = déshydraté
   }
]
```


**returns**
- ``Ok (200)`` : avec la liste


### ``PATCH api/materials``
update le materiel

**Body:**
```json
{
   "Id" : "int",
   "DeliveryId" : "int",
   "QuantityKg" : "float",
      "MaterialType" : "int" //0 = cru, 1 = trempé, 2 = en déshydratage, 3 = déshydraté
}
```

**Returns:**
- ``NoContent (204)`` : updated
- ``NotFound (404)`` : mauvais Id ou delivery Id


### ``POST api/materials``
crée un materiel

**Body:**
```json
{
   "DeliveryId" : "int",
   "QuantityKg" : "float",
   "MaterialType" : "int" //0 = cru, 1 = trempé, 2 = en déshydratage, 3 = déshydraté
}
```

**Returns:**
- ``Ok (200)`` : le matériel créer
```json
   {
      "Id" : "int",
      "DeliveryId" : "int",
      "BatchNumber" : "string",
      "VarietyName" : "string",
      "QuantityKg" : "float",
      "MaterialType" : "int" //0 = cru, 1 = trempé, 2 = en déshydratage, 3 = déshydraté
   }
```
- ``NotFound (404)`` : l'id delivery est incorrect


### ``DELETE api/materials/{id}``
supprime un matériel

**Returns:**
- ``NoContent (204)`` : supprimé
- ``NotFound (404)`` : id match pas


## DeliveryController

### ``GET api/deliveries``
return tout les delivies

**returns**
- ``Ok (200)``
```json
[
   {
      "Id" : "int",
      "BatchNumber" : "string",
      "QuantityKg" : "float",
      "DeliveryDate" : "??? string je pense? DateTime?",
      "Supplier" : "string",
      "VarietyId" : "int",
      "VarietyName" : "string"
   }
]
```

### ``GET api/deliveries/{id}``
return le delivery avec l'id

**returns**
- ``Ok (200)``
```json
{
   "Id" : "int",
   "BatchNumber" : "string",
   "QuantityKg" : "float",
   "DeliveryDate" : "??? string je pense? DateTime?",
   "Supplier" : "string",
   "VarietyId" : "int",
   "VarietyName" : "string"
}
```

### ``POST api/deliveries``
crée un delivery

**Body**
```json
{
   "BatchNumber" : "string",
   "QuantityKg" : "float",
   "DeliveryDate" : "??? string je pense? DateTime?",
   "Supplier" : "string",
   "VarietyId" : "int"
}
```

**returns**
- ``Ok (200)``
```json
{
   "Id" : "int",
   "BatchNumber" : "string",
   "QuantityKg" : "float",
   "DeliveryDate" : "??? string je pense? DateTime?",
   "Supplier" : "string",
   "VarietyId" : "int",
   "VarietyName" : "string"
}
```


## FinishedProductController

### ``GET api/finishedproduct``
liste des produits terminées

**Returns**
- ``Ok (200)``
```json
[
   {
      "Id" : "int",
      "ProductName" : "string",
      "DateProduction" : "??? string je pense? DateTime?",
      "ProductType" : "int", //0 = Jar, 1 = Bag
      "QuantityG" : "float",
      "AmountProduced" : "int",
      "ProductUniqueId" : "string",
      "ActivityId" : "int"
   }
]
```

### ``POST api/finishedproduct``
crée un produit terminer
 
 **Body**
 ```json
{
   "ProductId" : "int",
   "DateProduction" : "??? string je pense? DateTime?",
   "ProductionType" : "int", //0 = Jar, 1 = Bag
   "QuantityG" : "float",
   "AmountProduced" : "int",
   "ProductUniqueId" : "int",
   "ActivityId" : "int"

}
 ```

 **returns**
 - ``NotFound (404)`` : product ou activity id match pas
 - ``Ok (200)`` : produit fini créé
 ```json
 {
   "Id" : "int",
   "ProductName" : "string",
   "DateProduction" : "??? string je pense? DateTime?",
   "ProductionType" : "int", //0 = Jar, 1 = Bag
   "QuantityG" : "float",
   "AmountProduced" : "int",
   "ProductUniqueId" : "int",
   "ActivityId" : "int"
 }
 ```
## VarietiesController

### ``GET api/varieties``
retourne la liste des variétées

**Returns**
```json
[
   {
      "Id" : "int",
      "Name" : "string",
      "IsActive" : "bool",
      "Protocol" : "string"
   }
]
```

### ``POST api/varieties`` (SuperUser)
crée une variété

**Body**
```json
{
   "Name" : "string",
   "IsActive" : "bool",
   "Protocol" : "string"
}
```

**Returns**
- ``OK (200)`` : Créé
```json
{
   "Id" : "int",
   "Name" : "string",
   "IsActive" : "bool",
   "Protocol" : "string"
}
```

### ``PATCH api/varieties`` (SuperUser)
update la variété

**Body**
```json
{
   "Name" : "string",
   "IsActive" : "bool",
   "Protocol" : "string"
}
```

**Returns**
- ``NotFound (404)`` : variété non trouvé
- ``NoContent (204)`` : updated

## ActivitiesController
une activité est la transformation d'un matériel (trempage, déshydratage, transformation, ensachage).

### ``GET api/activities``
liste des activités

**Returns**
- ``Ok (200)`` : liste
```json
[
   {
      "Id" : "int",
      "UserId" : "int",
      "Date" : "??? string je pense? DateTime?",
      "ActivityType" : "int", //0 = Soaking, 1 = Dehydrating, 2 = StockingMaterial, 3 = Transformation, 4 = Bagging
      "Items" :
      [
         {
            "Id" : "int",
            "ActivityId" : "int",
            "ItemId" : "int",
            "ItemType" : "int", // 0 = Material, 1 = FinishedProduct
            "ItemQuantityKg" : "float",
            "ItemName" : "string",
            "ItemBatchNumber" : "string",
            "Direction" : "int", //0 = Input, 1 = Output
         }
      ]
   }
]
```

### ``GET api/activities/{id}``
retourne l'activité avec l'id

**Returns**
- ``NotFound (404)`` : l'id ne match pas
- ``Ok (200)`` : retourne l'activité
```json
{
   "Id" : "int",
   "UserId" : "int",
   "Date" : "??? string je pense? DateTime?",
   "ActivityType" : "int", //0 = Soaking, 1 = Dehydrating, 2 = StockingMaterial, 3 = Transformation, 4 = Bagging
   "Items" :
   [
      {
         "Id" : "int",
         "ActivityId" : "int",
         "ItemId" : "int",
         "ItemType" : "int", // 0 = Material, 1 = FinishedProduct
         "ItemQuantityKg" : "float",
         "ItemName" : "string",
         "ItemBatchNumber" : "string",
         "Direction" : "int", //0 = Input, 1 = Output
      }
   ]
}
```

### ``POST api/activities``
créer une activité

**Body**
```json
{
   "Date" : "??? string je pense? DateTime?",
   "ActivityType" : "int",
   "Data" : {
      "FieldName" : "Info en plus selon l'activité"
   },
   "Items" : 
   [
      {
         "ItemId" : "",
         "ItemType" : "int", // 0 = Material, 1 = FinishedProduct
         "ItemQuantityKg" : "float",
         "ItemBatchNumber" : "string",
         "ItemName" : "string",
         "Direction" : "int", //0 = Input, 1 = Output
      }
   ]
}
```

**Returns**
- ``Ok (200)`` : créer
```json
{
      "Id" : "int",
      "UserId" : "int",
      "Date" : "??? string je pense? DateTime?",
      "ActivityType" : "int", //0 = Soaking, 1 = Dehydrating, 2 = StockingMaterial, 3 = Transformation, 4 = Bagging
      "Items" :
      [
         {
            "Id" : "int",
            "ActivityId" : "int",
            "ItemId" : "int",
            "ItemType" : "int", // 0 = Material, 1 = FinishedProduct
            "ItemQuantityKg" : "float",
            "ItemName" : "string",
            "ItemBatchNumber" : "string",
            "Direction" : "int", //0 = Input, 1 = Output
         }
      ]
   }
```
