package is.moo.snippet.modulith.blog.pricing.internal;

import org.springframework.data.jpa.repository.JpaRepository;

public interface PricingRepository extends JpaRepository<Pricing, Long> {

    Pricing findByProductId(Long productId);
}
