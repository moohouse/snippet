package is.moo.snippet.modulith.blog.news;

import is.moo.snippet.modulith.blog.news.internal.NewsRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NewsService {
    private final NewsRepository repository;

    public NewsService(NewsRepository repository) {
        this.repository = repository;
    }

    public List<NewsDTO> findAll() {
        return repository.findAll()
                .stream()
                .map(entity -> new NewsDTO(entity.getId(), entity.getLabel(), entity.getTimestamp()))
                .toList();
    }
}
