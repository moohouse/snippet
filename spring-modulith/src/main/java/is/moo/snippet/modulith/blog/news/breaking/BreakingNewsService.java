package is.moo.snippet.modulith.blog.news.breaking;

import java.util.List;
import is.moo.snippet.modulith.blog.news.breaking.internal.BreakingNewsRepository;
import org.springframework.stereotype.Service;

@Service
public class BreakingNewsService {
    private final BreakingNewsRepository repository;

    public BreakingNewsService(BreakingNewsRepository repository) {
        this.repository = repository;
    }

    public List<BreakingNewsDTO> findAll() {
        return repository.findAll()
                .stream()
                .map(entity -> new BreakingNewsDTO(entity.getId(), entity.getLabel(), entity.getTimestamp()))
                .toList();
    }
}
