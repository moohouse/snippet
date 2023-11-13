package is.moo.snippet.httpinterface;

import is.moo.snippet.httpinterface.model.Post;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

@Service
@RequiredArgsConstructor
@Slf4j
public class HttpInterfaceService {

  final PostClient postClient;
  public ResponseEntity<List<Post>> getAllPosts() {
    try {
      return ResponseEntity.ok(postClient.getPosts());
    } catch (Exception e) {
      log.error(e.getMessage());
      return ResponseEntity.internalServerError().build();
    }
  }

  public ResponseEntity<Post> getPost(int id) {
    try {
      return ResponseEntity.ok(postClient.getPost(id));
    } catch (Exception e) {
      log.error(e.getMessage());
      return ResponseEntity.internalServerError().build();
    }
  }

}
