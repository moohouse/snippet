package is.moo.snippet.modulith.blog.catalog.internal;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Product {

    @Id
    private Long id;
    private String name;
    private String description;

    public Long getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public String getName() {
        return name;
    }
}
