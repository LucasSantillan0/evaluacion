@REQ_CHR-001 @HU001 @agente1
Feature: CHR-001 API de Personajes 

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'lusantil'
    * def basePath = '/' + username + '/api/characters'
    * def datos = read('classpath:data/characters.json')
    * def character = datos[0]


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





