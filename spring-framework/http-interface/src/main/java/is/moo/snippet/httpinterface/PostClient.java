package is.moo.snippet.httpinterface;

import is.moo.snippet.httpinterface.model.Post;
import java.util.List;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.service.annotation.GetExchange;
import org.springframework.web.service.annotation.HttpExchange;

@HttpExchange(url = "/", accept = "application/json", contentType = "application/json")
public interface PostClient {
  @GetExchange("posts")
  List<Post> getPosts();
  @GetExchange("posts/{id}")
  Post getPost(@PathVariable int id);

}
