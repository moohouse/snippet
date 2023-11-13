package is.moo.snippet.modulith.blog.news.breaking.internal;

import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class BreakingNewsController {

    private final BreakingNewsRepository repository;

    public BreakingNewsController(BreakingNewsRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/breakingnews")
    public List<BreakingNews> getAll() {
        return repository.findAll();
    }
}
