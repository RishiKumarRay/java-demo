## Building and running locally
Once you clone the project to your local system, you can build and test locally by running:

`mvn clean test` - for unit testing

`mvn clean package` - to compile a *jar executable 
which you can run locally

After successful compilation, you will find the executable jar in the `target/` directory.

You can also run the `hello` service with the following command from the project root directory:

`java -jar target/*.jar`

Once the service is running, point your web browser to `localhost:8080` or run the command:

`curl localhost:8080` 

on the command line to see the welcome message.

Note: Try `localhost:8080/api` as well!
## Unit testing
The test class `HelloControllerTest` contains a unit test to ensure the application returns the string "Hello World!"

~~~
@Test
    public void getHello() throws Exception {
        mvc.perform(MockMvcRequestBuilders.get("/").accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().string(equalTo("Hello World!")));
    }
~~~

When you use maven to package or test, you can see if the test passes or fails (passes by defualt).

`mvn test`

~~~
[INFO] Results:
[INFO] 
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
[INFO] 
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 8.661 s
[INFO] Finished at: 2018-06-20T07:49:20-07:00
[INFO] ------------------------------------------------------------------------

~~~


To see the unit test fail, edit `String greeting`string in the `HelloController` class.

Example:

~~~
@RestController
public class HelloController {

	String greeting = "Hello Foo!";

    @RequestMapping("/")
    public String index() { return greeting; }
    ...

}
~~~

If you run your test again with maven, you will get an error:

`mvn test`

~~~
[ERROR] Failures: 
[ERROR]   HelloControllerTest.getHello:29 Response content
Expected: "Hello World!"
     but: was "Hello Foo!"
[INFO] 
[ERROR] Tests run: 1, Failures: 1, Errors: 0, Skipped: 0
[INFO] 
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 6.799 s
[INFO] Finished at: 2018-06-20T08:03:55-07:00
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-surefire-plugin:2.21.0:test (default-test) on project hello: There are test failures.
~~~

Fix your code and verify it will pass testing once again.
