package is.moo.snippet.buildpack.mooing;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MooingController {

  @GetMapping("/mooing")
  public String mooing() {
    return "Moo!";
  }

}
