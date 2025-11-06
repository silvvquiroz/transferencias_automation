package steps;

import io.cucumber.java.en.*;
import io.restassured.http.ContentType;
import io.restassured.response.Response;

import static io.restassured.RestAssured.*;
import static org.junit.Assert.*;

public class ApiSteps {

    private Response response;

    @Given("la API está disponible")
    public void la_api_esta_disponible() {
        baseURI = "http://localhost:3000";
    }

    @When("el usuario hace una petición POST a {string}  con el siguiente contenido en JSON:")
    public void usuario_hace_peticion_post(String endpoint, String jsonBody) {

        response = given().contentType(ContentType.JSON).body(jsonBody).when().post(endpoint);
    }

    @Then("el código de respuesta debe ser {int}")
    public void verificar_codigo_respuesta(int statusCode) {
        assertEquals(statusCode, response.getStatusCode());
    }

    @And("el {string} de respuesta debe ser {string}")
    public void verificar_campo(String campo, String valorEsperado) {
        String valor = response.jsonPath().getString(campo);
        assertEquals(valorEsperado, valor);
    }
}
