package is.moo.snippet.httpinterface;

import is.moo.snippet.httpinterface.model.Post;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@Slf4j
public class HttpInterfaceController {

  final HttpInterfaceService httpInterfaceService;
  @GetMapping("/posts")
  public ResponseEntity<List<Post>> getPosts() {
    try {
      return httpInterfaceService.getAllPosts();
    } catch (Exception e) {
      log.error(e.getMessage());
      return ResponseEntity.internalServerError().build();
    }
  }

  @GetMapping("/post/{id}")
  public ResponseEntity<Post> getPost(@PathVariable int id) {
    try {
      return httpInterfaceService.getPost(id);
    } catch (Exception e) {
      log.error(e.getMessage());
      return ResponseEntity.internalServerError().build();
    }
  }
}
