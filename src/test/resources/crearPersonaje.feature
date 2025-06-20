@REQ_CHR-001 @HU001 @agente1
Feature: CHR-001 API de Personajes 

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'lusantil'
    * def basePath = '/' + username + '/api/characters'
    * def datos = read('classpath:data/characters.json')
    * def character = datos[0]



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
