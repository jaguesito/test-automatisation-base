Feature: Test de API súper simple

  Background:
    * configure ssl = true
    * url 'http://localhost:8080/testuser/api/characters'
    * def generarHeaders =
      """
      function() {
        return {
          "Content-Type": "application/json"
        };
      }
      """
    * def headers = generarHeaders()
    * headers headers

  Scenario: Obtener todos los personajes (GET)
    When method GET
    Then status 200

  Scenario: Crear personaje (POST)
    # Crear personaje
    * def randomName = 'User_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    * def jsonData = { "name": '#(randomName)', "alterego": "Tony Stark", "description": "Genius billionaire", "powers": ["Armor", "Flight"] }
    And request jsonData
    When method POST
    Then status 201

  Scenario: Obtener personaje por ID (GET)
    # Crear personaje
    * def randomName = 'User_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    * def jsonData = { "name": '#(randomName)', "alterego": "Tony Stark", "description": "Genius billionaire", "powers": ["Armor", "Flight"] }
    And request jsonData
    When method POST
    Then status 201
    * def personajeId = response.id
    # Obtener personaje creado
    * path '/' + personajeId
    When method GET
    Then status 200    

  Scenario: Actualizar personaje (PUT)
    # Crear personaje
    * def randomName = 'User_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    * def jsonData = { "name": '#(randomName)', "alterego": "Tony Stark", "description": "Genius billionaire", "powers": ["Armor", "Flight"] }
    And request jsonData
    When method POST
    Then status 201
    * def personajeId = response.id
    # Actualizar personaje creado
    * path '/' + personajeId
    * def jsonData = { "name": '#(randomName)', "alterego": "Tony Stark", "description": "Updated description", "powers": ["Armor", "Flight"] }
    And request jsonData
    When method PUT
    Then status 200

  Scenario: Eliminar personaje (DELETE)
    # Crear personaje
    * def randomName = 'User_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    * def jsonData = { "name": '#(randomName)', "alterego": "Tony Stark", "description": "Genius billionaire", "powers": ["Armor", "Flight"] }
    And request jsonData
    When method POST
    Then status 201
    * def personajeId = response.id
    # Eliminar personaje creado
    * path '/' + personajeId
    When method DELETE
    Then status 204
