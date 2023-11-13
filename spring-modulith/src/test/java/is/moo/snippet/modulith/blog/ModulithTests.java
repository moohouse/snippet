package is.moo.snippet.modulith.blog;

import is.moo.snippet.modulith.blog.DummyShop;
import org.junit.jupiter.api.Test;
import org.springframework.modulith.docs.Documenter;
import org.springframework.modulith.core.ApplicationModules;

class ModulithTests {

    @Test
    public void writeDocumentation() {
        var modules = ApplicationModules.of(DummyShop.class).verify();
        modules.forEach(System.out::println);


        new Documenter(modules)
            .writeModuleCanvases();
    }
}
