# Enums
```c#
public enum ActivityStatus
{
    InProcess,
    Completed,
}
public enum ActivityType {
    Soaking = 0,
    Dehydrating = 1,
    StockingMaterial = 2,
    Transformation = 3,
    Bagging = 4
}
public enum LogAction
{
    Create = 0,
    Update = 1,
    Delete = 2
}
public enum StockType
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


# AuthController
login

## ``POST api/login``
get un token de connexion

### Body
```json
{
   "UserName" : "string",
   "Password" : "string"
}
```

### Returns
- ``OK (200)`` retourne un token dans le body 
   ```json
   {
      "token": "string",
      "isAdmin" : "bool" 
   }
   ```
- ``Bad Request (400)`` : Mot de passe ou username invalide


# UsersController

Toutes les routes de ce contrôleur nécessitent un token JWT valide.

---

## `GET api/users`

Retourne la liste de tous les utilisateurs.

### Autorisation

Authentification requise (JWT). **Administrateur uniquement.**

### Returns

* `200 OK`

```json
[
  {
    "Id": "int",
    "Name": "string",
    "UserType": "UserType (enum)"
  }
]
```

---

## `POST api/users`

Crée un nouvel utilisateur.

### Autorisation

Authentification requise (JWT). **Administrateur uniquement.**

### Body

```json
{
  "Name": "string",
  "UserName": "string",
  "Password": "string",
  "UserType": "UserType (enum)"
}
```

### Returns

* `204 No Content` : Utilisateur créé avec succès.

### Erreurs possibles

* `400 Bad Request` : Corps de la requête invalide ou données manquantes.
* `401 Unauthorized` : Token JWT absent ou invalide.
* `403 Forbidden` : L'utilisateur n'est pas administrateur.


# ProtocolsController

Toutes les routes de ce contrôleur nécessitent un token JWT valide.

---

## `GET api/protocols`

Retourne la liste de tous les protocoles.

### Autorisation

Authentification requise (JWT).

### Returns

* `200 OK`

```json
[
  {
    "VarietyId": "int",
    "Description": "string",
    "ActivityType": "ActivityType (enum)"
  }
]
```

---

## `POST api/protocols`

Crée un nouveau protocole.

### Autorisation

Authentification requise (JWT). **Administrateur uniquement.**

### Body

```json
{
  "VarietyId": "int",
  "ActivityType": "ActivityType (enum)",
  "Description": "string"
}
```

### Returns

* `200 OK`

```json
{
  "VarietyId": "int",
  "Description": "string",
  "ActivityType": "ActivityType (enum)"
}
```

### Erreurs possibles

* `400 Bad Request` : Corps de la requête invalide ou données manquantes.
* `401 Unauthorized` : Token JWT absent ou invalide.
* `403 Forbidden` : L'utilisateur n'est pas administrateur.



# VarietiesController

Toutes les routes de ce contrôleur nécessitent un token JWT valide.

---

## `GET api/varieties`

Retourne la liste de toutes les variétés.

### Autorisation

Authentification requise (JWT).

### Returns

* `200 OK`

```json
[
  {
    "Id": "int",
    "Name": "string",
    "Protocols": [
      {
        "Description": "string",
        "ActivityType": "ActivityType (enum)"
      }
    ]
  }
]
```

---

## `POST api/varieties`

Crée une nouvelle variété.

### Autorisation

Authentification requise (JWT).

### Body

```json
{
  "Name": "string"
}
```

### Returns

* `200 OK`

```json
{
  "Id": "int",
  "Name": "string",
  "Protocols": [
    {
      "VarietyId" : "int"
      "Description": "string",
      "ActivityType": "ActivityType (enum)"
    }
  ]
}
```

### Erreurs possibles

* `400 Bad Request` : Corps de la requête invalide ou données manquantes.
* `401 Unauthorized` : Token JWT absent ou invalide.

---

## `PATCH api/varieties`

Modifie le nom d'une variété existante.

### Autorisation

Authentification requise (JWT). **Administrateur uniquement.**

### Body

```json
{
  "Id": "int",
  "Name": "string"
}
```

### Returns

* `204 No Content` : Variété modifiée avec succès.

### Erreurs possibles

* `400 Bad Request` : Corps de la requête invalide ou données manquantes.
* `401 Unauthorized` : Token JWT absent ou invalide.
* `403 Forbidden` : L'utilisateur n'est pas administrateur.
* `404 Not Found` : Aucune variété ne correspond à l'identifiant fourni.


# DeliveriesController

Toutes les routes de ce contrôleur nécessitent un token JWT valide.

---

## `GET api/deliveries`

Retourne la liste de toutes les livraisons.

### Autorisation

Authentification requise (JWT).

### Returns

* `200 OK`

```json
[
  {
    "Id": "int",
    "SupplierName": "string",
    "PackageType": "DeliveryPackageType (enum)",
    "PackageWeightKg": "float",
    "PackageQuantity": "int",
    "VarietyName": "string",
    "BatchNumber": "string",
    "DeliveryDate": "string (ISO 8601)"
  }
]
```

---

## `GET api/deliveries/{id}`

Retourne une livraison à partir de son identifiant.

### Autorisation

Authentification requise (JWT).

### Paramètres

| Nom | Type | Description                  |
| --- | ---- | ---------------------------- |
| id  | int  | Identifiant de la livraison. |

### Returns

* `200 OK`

```json
{
  "Id": "int",
  "SupplierName": "string",
  "PackageType": "DeliveryPackageType (enum)",
  "PackageWeightKg": "float",
  "PackageQuantity": "int",
  "VarietyName": "string",
  "BatchNumber": "string",
  "DeliveryDate": "string (ISO 8601)"
}
```

### Erreurs possibles

* `401 Unauthorized` : Token JWT absent ou invalide.
* `404 Not Found` : Aucune livraison ne correspond à l'identifiant fourni.

---

## `POST api/deliveries`

Crée une nouvelle livraison.

### Autorisation

Authentification requise (JWT).

### Body

```json
{
  "SupplierName": "string",
  "PackageType": "DeliveryPackageType (enum)",
  "PackageWeightKg": "float",
  "PackageQuantity": "int",
  "VarietyId": "int",
  "BatchNumber": "string"
}
```

### Returns

* `200 OK`

```json
{
  "Id": "int",
  "SupplierName": "string",
  "PackageType": "DeliveryPackageType (enum)",
  "PackageWeightKg": "float",
  "PackageQuantity": "int",
  "VarietyName": "string",
  "BatchNumber": "string",
  "DeliveryDate": "string (ISO 8601)"
}
```

### Erreurs possibles

* `400 Bad Request` : Corps de la requête invalide ou données manquantes.
* `401 Unauthorized` : Token JWT absent ou invalide.
* `404 Not Found` : La variété demandée n'existe pas.


# StocksController

Toutes les routes de ce contrôleur nécessitent un token JWT valide.

---

## `GET api/stocks`

Retourne la liste de tous les stocks.

### Autorisation

Authentification requise (JWT).

### Returns

* `200 OK`

```json
[
  {
    "Id": "int",
    "Variety": {
      "Id": "int",
      "Name": "string",
      "Protocols": [
        {
          "Description": "string",
          "ActivityType": "ActivityType (enum)"
        }
      ]
    },
    "BatchNumber": "string",
    "QuantityKg": "float",
    "StockType": "StockType (enum)"
  }
]
```

---

## `GET api/stocks/batch/{batchNumber}`

Retourne tous les stocks associés à un numéro de lot.

### Autorisation

Authentification requise (JWT).

### Paramètres

| Nom         | Type   | Description              |
| ----------- | ------ | ------------------------ |
| batchNumber | string | Numéro de lot recherché. |

### Returns

* `200 OK`

```json
[
  {
    "Id": "int",
    "Variety": {
      "Id": "int",
      "Name": "string",
      "Protocols": [
        {
          "Description": "string",
          "ActivityType": "ActivityType (enum)"
        }
      ]
    },
    "BatchNumber": "string",
    "QuantityKg": "float",
    "StockType": "StockType (enum)"
  }
]
```

### Erreurs possibles

* `401 Unauthorized` : Token JWT absent ou invalide.

---

## `POST api/stocks`

Crée un nouveau stock.

### Autorisation

Authentification requise (JWT).

### Body

```json
{
  "VarietyId": "int",
  "BatchNumber": "string",
  "QuantityKg": "float",
  "StockType": "StockType (enum)"
}
```

### Returns

* `200 OK`

```json
{
  "Id": "int",
  "Variety": {
    "Id": "int",
    "Name": "string",
    "Protocols": [
      {
        "Description": "string",
        "ActivityType": "ActivityType (enum)"
      }
    ]
  },
  "BatchNumber": "string",
  "QuantityKg": "float",
  "StockType": "StockType (enum)"
}
```

### Erreurs possibles

* `400 Bad Request` : Corps de la requête invalide ou données manquantes.
* `401 Unauthorized` : Token JWT absent ou invalide.

---

## `PATCH api/stocks`

Modifie un stock existant.

### Autorisation

Authentification requise (JWT).

### Body

```json
{
  "Id": "int",
  "VarietyId": "int",
  "BatchNumber": "string",
  "QuantityKg": "float",
  "StockType": "StockType (enum)"
}
```

### Returns

* `204 No Content` : Stock modifié avec succès.

### Erreurs possibles

* `400 Bad Request` : Corps de la requête invalide ou données manquantes.
* `401 Unauthorized` : Token JWT absent ou invalide.
* `404 Not Found` : Aucun stock ne correspond à l'identifiant fourni.

---

## `DELETE api/stocks/{id}`

Supprime un stock.

### Autorisation

Authentification requise (JWT).

### Paramètres

| Nom | Type | Description                       |
| --- | ---- | --------------------------------- |
| id  | int  | Identifiant du stock à supprimer. |

### Returns

* `204 No Content` : Stock supprimé avec succès.

### Erreurs possibles

* `401 Unauthorized` : Token JWT absent ou invalide.
* `404 Not Found` : Aucun stock ne correspond à l'identifiant fourni.


# FormatsController

Toutes les routes de ce contrôleur nécessitent un token JWT valide.

---

## `GET api/formats`

Retourne la liste de tous les formats de produits.

### Autorisation

Authentification requise (JWT).

### Returns

* `200 OK`

```json
[
  {
    "Id": "int",
    "Format": "string"
  }
]
```

---

## `POST api/formats`

Crée un nouveau format de produit.

### Autorisation

Authentification requise (JWT). **Administrateur uniquement.**

### Body

```json
{
  "Format": "string"
}
```

### Returns

* `200 OK`

```json
{
  "Id": "int",
  "Format": "string"
}
```

### Erreurs possibles

* `400 Bad Request` : Corps de la requête invalide ou données manquantes.
* `401 Unauthorized` : Token JWT absent ou invalide.
* `403 Forbidden` : L'utilisateur n'est pas administrateur.


# ActivityController

> **⚠️ Warning**
>
> **Ce contrôleur est encore en développement.** Les routes, les paramètres, les réponses et le comportement peuvent être modifiés dans les prochaines versions de l'API.

Toutes les routes de ce contrôleur nécessitent un token JWT valide.

---

## `GET api/activity`

Retourne la liste de toutes les activités.

### Autorisation

Authentification requise (JWT).

### Returns

* `200 OK`

```json
[
  {
    "Id": "int",
    "ActivityType": "ActivityType (enum)",
    "ActivityStatus": "ActivityStatus (enum)",
    "StartedByUserName": "string",
    "CompletedByUserName": "string",
    "StartedDate": "string (ISO 8601)",
    "CompletedDate": "string (ISO 8601)",
    "BatchNumber": "string",
    "Data": "object"
  }
]
```

---

## `GET api/activity/{id}`

Retourne une activité à partir de son identifiant.

### Autorisation

Authentification requise (JWT).

### Paramètres

| Nom | Type | Description                |
| --- | ---- | -------------------------- |
| id  | int  | Identifiant de l'activité. |

### Returns

* `200 OK`

```json
{
  "Id": "int",
  "ActivityType": "ActivityType (enum)",
  "ActivityStatus": "ActivityStatus (enum)",
  "StartedByUserName": "string",
  "CompletedByUserName": "string",
  "StartedDate": "string (ISO 8601)",
  "CompletedDate": "string (ISO 8601)",
  "BatchNumber": "string",
  "Data": "object"
}
```

### Erreurs possibles

* `401 Unauthorized` : Token JWT absent ou invalide.
* `404 Not Found` : Aucune activité ne correspond à l'identifiant fourni.

---

## `GET api/activity/user/{userId}`

Retourne les activités associées à un utilisateur.

> **⚠️ Cette route n'est pas encore complètement implémentée.** Elle retourne actuellement toutes les activités au lieu de filtrer par utilisateur.

### Autorisation

Authentification requise (JWT). **Administrateur uniquement.**

### Paramètres

| Nom    | Type | Description                   |
| ------ | ---- | ----------------------------- |
| userId | int  | Identifiant de l'utilisateur. |

### Returns

* `200 OK`

```json
[
  {
    "Id": "int",
    "ActivityType": "ActivityType (enum)",
    "ActivityStatus": "ActivityStatus (enum)",
    "StartedByUserName": "string",
    "CompletedByUserName": "string",
    "StartedDate": "string (ISO 8601)",
    "CompletedDate": "string (ISO 8601)",
    "BatchNumber": "string",
    "Data": "object"
  }
]
```

### Erreurs possibles

* `401 Unauthorized` : Token JWT absent ou invalide.
* `403 Forbidden` : L'utilisateur n'est pas administrateur.

---

## `POST api/activity/start`

Démarre une nouvelle activité.

### Autorisation

Authentification requise (JWT).

### Body

```json
{
  "ActivityType": "ActivityType (enum)",
  "StartedByUser": "User",
  "BatchNumber": "string",
  "Data": "object"
}
```

### Returns

* `200 OK`

```json
{
  "Id": "int",
  "ActivityType": "ActivityType (enum)",
  "ActivityStatus": "ActivityStatus (enum)",
  "StartedByUserName": "string",
  "CompletedByUserName": "string",
  "StartedDate": "string (ISO 8601)",
  "CompletedDate": "string (ISO 8601)",
  "BatchNumber": "string",
  "Data": "object"
}
```

### Erreurs possibles

* `400 Bad Request` : Corps de la requête invalide ou données manquantes.
* `401 Unauthorized` : Token JWT absent ou invalide.



# FinishedProductsController

Toutes les routes de ce contrôleur nécessitent un token JWT valide.

---

## `GET api/finishedproducts`

Retourne la liste de tous les produits finis.

### Autorisation

Authentification requise (JWT).

### Returns

* `200 OK`

```json
[
  {
    "Id": "int",
    "Format": "string",
    "BatchNumber": "string",
    "ProductType": "ProductType (enum)",
    "QuantityUsedKg": "float",
    "Quantity": "int",
    "DateProduction": "string (ISO 8601)",
    "ProductsUniqueId": "string"
  }
]
```

---

## `POST api/finishedproducts`

Crée un nouveau produit fini.

### Autorisation

Authentification requise (JWT).

### Body

```json
{
  "FormatId": "int",
  "BatchNumber": "string",
  "ProductType": "ProductType (enum)",
  "QuantityUsedKg": "float",
  "Quantity": "int",
  "ProductsUniqueId": "string"
}
```

### Returns

* `200 OK`

```json
{
  "Id": "int",
  "Format": "string",
  "BatchNumber": "string",
  "ProductType": "ProductType (enum)",
  "QuantityUsedKg": "float",
  "Quantity": "int",
  "DateProduction": "string (ISO 8601)",
  "ProductsUniqueId": "string"
}
```

### Erreurs possibles

* `400 Bad Request` : Corps de la requête invalide ou données manquantes.
* `401 Unauthorized` : Token JWT absent ou invalide.


# ProtocolsController

Toutes les routes de ce contrôleur nécessitent un token JWT valide.

---

## `GET api/protocols`

Retourne la liste de tous les protocoles.

### Autorisation

Authentification requise (JWT).

### Returns

* `200 OK`

```json
[
  {
    "VarietyId": "int",
    "Description": "string",
    "ActivityType": "ActivityType (enum)"
  }
]
```

---

## `POST api/protocols`

Crée un nouveau protocole.

### Autorisation

Authentification requise (JWT). **Administrateur uniquement.**

### Body

```json
{
  "VarietyId": "int",
  "ActivityType": "ActivityType (enum)",
  "Description": "string"
}
```

### Returns

* `200 OK`

```json
{
  "VarietyId": "int",
  "Description": "string",
  "ActivityType": "ActivityType (enum)"
}
```

### Erreurs possibles

* `400 Bad Request` : Corps de la requête invalide ou données manquantes.
* `401 Unauthorized` : Token JWT absent ou invalide.
* `403 Forbidden` : L'utilisateur n'est pas administrateur.
