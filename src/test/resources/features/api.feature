Feature: Transferencia bancaria

    @P123-28
    Scenario: Transferencia exitosa
        Given la API está disponible
        When el usuario hace una petición POST a "/transfer" con el siguiente contenido en JSON:
            """
            {
            "userAuthenticated": true,
            "token": "123456",
            "accountFrom": "123",
            "accountTo": "456",
            "funds": 500,
            "amount": 300,
            "currency": "PEN",
            "time": 10
            }
            """
        Then el código de respuesta debe ser 200
        And el "message" de respuesta debe ser "Transferencia exitosa"

    Scenario: Transferencia fallida por autenticación
        Given la API está disponible
        When el usuario hace una petición POST a "/transfer" con el siguiente contenido en JSON:
            """
            {
            "userAuthenticated": false,
            "token": "123456",
            "accountFrom": "123",
            "accountTo": "456",
            "funds": 500,
            "amount": 300,
            "currency": "PEN",
            "time": 10
            }
            """
        Then el código de respuesta debe ser 401
        And el "error" de respuesta debe ser "Error de autenticación"

    Scenario: Transferencia fallida por token digital
        Given la API está disponible
        When el usuario hace una petición POST a "/transfer" con el siguiente contenido en JSON:
            """
            {
            "userAuthenticated": true,
            "token": "938473",
            "accountFrom": "123",
            "accountTo": "456",
            "funds": 500,
            "amount": 300,
            "currency": "PEN",
            "time": 10
            }
            """
        Then el código de respuesta debe ser 400
        And el "error" de respuesta debe ser "Error de token digital"

    Scenario: Transferencia fallida por cuenta de origen
        Given la API está disponible
        When el usuario hace una petición POST a "/transfer" con el siguiente contenido en JSON:
            """
            {
            "userAuthenticated": true,
            "token": "123456",
            "accountFrom": "999",
            "accountTo": "456",
            "funds": 500,
            "amount": 300,
            "currency": "PEN",
            "time": 10
            }
            """
        Then el código de respuesta debe ser 400
        And el "error" de respuesta debe ser "Error de cuenta de origen"

    Scenario: Transferencia fallida por cuenta de destino
        Given la API está disponible
        When el usuario hace una petición POST a "/transfer" con el siguiente contenido en JSON:
            """
            {
            "userAuthenticated": true,
            "token": "123456",
            "accountFrom": "123",
            "accountTo": "999",
            "funds": 500,
            "amount": 300,
            "currency": "PEN",
            "time": 10
            }
            """
        Then el código de respuesta debe ser 400
        And el "error" de respuesta debe ser "Error de cuenta de destino"

    Scenario: Transferencia fallida por fondos disponibles
        Given la API está disponible
        When el usuario hace una petición POST a "/transfer" con el siguiente contenido en JSON:
            """
            {
            "userAuthenticated": true,
            "token": "123456",
            "accountFrom": "123",
            "accountTo": "456",
            "funds": 200,
            "amount": 300,
            "currency": "PEN",
            "time": 10
            }
            """
        Then el código de respuesta debe ser 400
        And el "error" de respuesta debe ser "Error de fondos disponibles"

    Scenario: Transferencia fallida por monto
        Given la API está disponible
        When el usuario hace una petición POST a "/transfer" con el siguiente contenido en JSON:
            """
            {
            "userAuthenticated": true,
            "token": "123456",
            "accountFrom": "123",
            "accountTo": "456",
            "funds": 12000,
            "amount": 11000,
            "currency": "PEN",
            "time": 10
            }
            """
        Then el código de respuesta debe ser 400
        And el "error" de respuesta debe ser "Error de monto"

    Scenario: Transferencia fallida por tipo de moneda
        Given la API está disponible
        When el usuario hace una petición POST a "/transfer" con el siguiente contenido en JSON:
            """
            {
            "userAuthenticated": true,
            "token": "123456",
            "accountFrom": "123",
            "accountTo": "456",
            "funds": 500,
            "amount": 300,
            "currency": "EUR",
            "time": 10
            }
            """
        Then el código de respuesta debe ser 400
        And el "error" de respuesta debe ser "Error de tipo de moneda"

    Scenario: Transferencia fallida por horario de atención
        Given la API está disponible
        When el usuario hace una petición POST a "/transfer" con el siguiente contenido en JSON:
            """
            {
            "userAuthenticated": true,
            "token": "123456",
            "accountFrom": "123",
            "accountTo": "456",
            "funds": 500,
            "amount": 300,
            "currency": "PEN",
            "time": 18
            }
            """
        Then el código de respuesta debe ser 400
        And el "error" de respuesta debe ser "Error de horario"