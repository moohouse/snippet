package is.moo.snippet.modulith.blog.pricing.internal;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Pricing {

    @Id
    private Long productId;
    private Double price;

    public Double getPrice() {
        return price;
    }

    public Long getProductId() {
        return productId;
    }
}
