package is.moo.snippet.modulith.blog.news.internal;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import java.time.Instant;

@Entity
public class News {

    @Id
    private Long id;
    private Instant timestamp;
    private String label;

    public Long getId() {
        return id;
    }

    public String getLabel() {
        return label;
    }

    public Instant getTimestamp() {
        return timestamp;
    }
}
