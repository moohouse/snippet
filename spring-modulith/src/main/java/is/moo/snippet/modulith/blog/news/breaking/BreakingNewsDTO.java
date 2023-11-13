package is.moo.snippet.modulith.blog.news.breaking;

import java.time.Instant;

public record BreakingNewsDTO(Long id, String label, Instant timestamp) {
}
