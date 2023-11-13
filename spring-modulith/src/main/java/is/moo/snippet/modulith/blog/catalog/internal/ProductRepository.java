package is.moo.snippet.modulith.blog.catalog.internal;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long> {
}
