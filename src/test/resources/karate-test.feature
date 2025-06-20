Feature: Test de API súper simple

  Background:
    * configure ssl = true
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
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

  Scenario: Verificar que un endpoint público responde 200
    Given url 'https://httpbin.org/get'
    When method get
    Then status 200

  Scenario: Obtener todos los personajes (GET)
    When method GET
    Then status 200
    # And match response == []
    # And match response.length >= 0

  Scenario: Obtener personaje por ID (GET)
    * path '/1'
    When method GET
    Then status 200
    # And match response.id == 1
    # And match response.name == 'Iron Man'

  Scenario: Crear personaje (POST)
    * def jsonData = { "name": "Iron Man", "alterego": "Tony Stark", "description": "Genius billionaire", "powers": ["Armor", "Flight"] }
    And request jsonData
    When method POST
    Then status 201
    # And match response.name == 'Iron Man'
    # And match response.id != null

  Scenario: Actualizar personaje (PUT)
    * path '/1'
    * def jsonData = { "name": "Iron Man", "alterego": "Tony Stark", "description": "Updated description", "powers": ["Armor", "Flight"] }
    And request jsonData
    When method PUT
    Then status 200
    # And match response.description == 'Updated description'
    # And match response.id == 1

  Scenario: Eliminar personaje (DELETE)
    * path '/1'
    When method DELETE
    Then status 204
    # And match response == null
    # And match response == ''
