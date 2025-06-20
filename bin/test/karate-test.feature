@REQ_CHR-001 @HU001 @agente1
Feature: CHR-001 API de Personajes 

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'lusantil'
    * def basePath = '/' + username + '/api/characters'
    * def datos = read('classpath:data/data.json')
    * def character = datos[0]

  @id:1 @personajes @obtenerTodos
  Scenario: T-API-CHR-001-CA1 - Obtener todos los personajes
    Given path basePath
    When method get
    Then status 200
    And match response == '#[]'

  @id:2 @personajes @crearNuevo
  Scenario: T-API-CHR-001-CA2 - Crear y eliminar un personaje nuevo

    Given path basePath
    And request character
    When method post
    Then status 201
    And match response.name == character.name
    And def id = response.id

    Given path basePath, id
    When method delete
    Then status 204

    Given path basePath, id
    When method get
    Then status 404

  @id:3 @personajes @obtenerPorId 
  Scenario: T-API-CHR-001-CA3 - Obtener personaje por ID
 
    Given path basePath
    And request character
    When method post
    Then status 201
    And def id = response.id

    Given path basePath, id
    When method get
    Then status 200
    And match response.name == character.name

    Given path basePath, id
    When method delete
    Then status 204

  @id:4 @personajes @actualizar
  Scenario: T-API-CHR-001-CA4 - Actualizar personaje existente
 
    Given path basePath
    And request character
    When method post
    Then status 201
    And def id = response.id

    Given path basePath, id
    And request
      """
      {
        "name": "Hulk",
        "alterego": "Bruce Banner",
        "description": "El más fuerte que existe",
        "powers": ["Fuerza", "Regeneración", "Salto"]
      }
      """
    When method put
    Then status 200
    And match response.description == "El más fuerte que existe"

    Given path basePath, id
    When method delete
    Then status 204


  @id:5 @personajes @crearDuplicado
  Scenario: T-API-CHR-001-CA5 - Crear personaje duplicado (debe fallar)
 
    Given path basePath
    And request character
    When method post
    Then status 201
    And def id = response.id

    Given path basePath
    And request character
    When method post
    Then status 400

    Given path basePath, id
    When method delete
    Then status 204


