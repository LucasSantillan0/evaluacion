@REQ_CHR-001 @HU001 @agente1
Feature: CHR-001 API de Personajes 

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'lusantil'
    * def basePath = '/' + username + '/api/characters'
    * def datos = read('classpath:data/characters.json')
    * def character = datos[0]

  @id:1 @personajes @obtenerTodos
  Scenario: T-API-CHR-001-CA1 - Obtener todos los personajes
    Given path basePath
    When method get
    Then status 200
    And match response == '#[]'

