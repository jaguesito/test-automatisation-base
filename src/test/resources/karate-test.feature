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
    * def randomName = 'User_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    * set jsonData.name = randomName
    And request jsonData
    When method POST
    Then status 201

  Scenario: Obtener personaje por ID (GET)
    * def randomName = 'User_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    * set jsonData.name = randomName
    And request jsonData
    When method POST
    Then status 201
    * def personajeId = response.id
    * path '/' + personajeId
    # Obtener personaje existente
    When method GET
    Then status 200    

  Scenario: Actualizar personaje (PUT)
    * def randomName = 'User_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    * set jsonData.name = randomName
    And request jsonData
    When method POST
    Then status 201
    * def personajeId = response.id
    * path '/' + personajeId
    * def jsonData = read('classpath:data/marvel_characters_api/request_update_character.json')
    * set jsonData.name = randomName
    And request jsonData
    # Actualizar personaje existente
    When method PUT
    Then status 200

  Scenario: Eliminar personaje (DELETE)
    * def randomName = 'User_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    * set jsonData.name = randomName
    And request jsonData
    When method POST
    Then status 201
    * def personajeId = response.id
    * path '/' + personajeId
    # Eliminar personaje existente
    When method DELETE
    Then status 204

  Scenario: Crear personaje ya existente (POST)
    # Obtener todos los personajes
    When method GET
    Then status 200
    * def personajes = response
    * def primerPersonaje = personajes[0]
    * def jsonData = { "name": '#(primerPersonaje.name)', "alterego": '#(primerPersonaje.alterego)', "description": '#(primerPersonaje.description)', "powers": '#(primerPersonaje.powers)' }
    And request jsonData
    # Crear personaje existente
    When method POST
    Then status 400
