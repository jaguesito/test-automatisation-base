@REQ_BTPMCDP-999 @HU999 @marvel_characters_api @marvel_characters_api @Agente2 @E2 @iniciativa_marvel
Feature: BTPMCDP-999 Pruebas API de personajes de Marvel (microservicio para gestión de personajes)
  Background:
    * url port_marvel_characters_api
    * path '/testuser/api/characters'
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

  @id:1 @obtenerPersonajes @solicitudExitosa200
  Scenario: T-API-BTPMCDP-999-CA01-Obtener todos los personajes exitosamente 200 - karate
    When method GET
    Then status 200
    # And match response == []
    # And match response.length >= 0

  @id:2 @obtenerPersonajePorId @solicitudExitosa200
  Scenario: T-API-BTPMCDP-999-CA02-Obtener personaje por ID exitosamente 200 - karate
    * path '/1'
    When method GET
    Then status 200
    # And match response.id == 1
    # And match response.name == 'Iron Man'

  @id:3 @obtenerPersonajePorId @noEncontrado404
  Scenario: T-API-BTPMCDP-999-CA03-Obtener personaje por ID no existente 404 - karate
    * path '/999'
    When method GET
    Then status 404
    # And match response.error == 'Character not found'
    # And match response != null

  @id:4 @crearPersonaje @solicitudExitosa201
  Scenario: T-API-BTPMCDP-999-CA04-Crear personaje exitosamente 201 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    And request jsonData
    When method POST
    Then status 201
    # And match response.name == 'Iron Man'
    # And match response.id != null

  @id:5 @crearPersonaje @nombreDuplicado400
  Scenario: T-API-BTPMCDP-999-CA05-Crear personaje con nombre duplicado 400 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character_duplicate.json')
    And request jsonData
    When method POST
    Then status 400
    # And match response.error == 'Character name already exists'
    # And match response != null

  @id:6 @crearPersonaje @camposInvalidos400
  Scenario: T-API-BTPMCDP-999-CA06-Crear personaje con campos inválidos 400 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character_invalid.json')
    And request jsonData
    When method POST
    Then status 400
    # And match response.name == 'Name is required'
    # And match response.powers == 'Powers are required'

  @id:7 @actualizarPersonaje @solicitudExitosa200
  Scenario: T-API-BTPMCDP-999-CA07-Actualizar personaje exitosamente 200 - karate
    * path '/1'
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    * set jsonData.description = 'Updated description'
    And request jsonData
    When method PUT
    Then status 200
    # And match response.description == 'Updated description'
    # And match response.id == 1

  @id:8 @actualizarPersonaje @noEncontrado404
  Scenario: T-API-BTPMCDP-999-CA08-Actualizar personaje no existente 404 - karate
    * path '/999'
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    And request jsonData
    When method PUT
    Then status 404
    # And match response.error == 'Character not found'
    # And match response != null

  @id:9 @eliminarPersonaje @solicitudExitosa204
  Scenario: T-API-BTPMCDP-999-CA09-Eliminar personaje exitosamente 204 - karate
    * path '/1'
    When method DELETE
    Then status 204
    # And match response == null
    # And match response == ''

  @id:10 @eliminarPersonaje @noEncontrado404
  Scenario: T-API-BTPMCDP-999-CA10-Eliminar personaje no existente 404 - karate
    * path '/999'
    When method DELETE
    Then status 404
    # And match response.error == 'Character not found'
    # And match response != null
