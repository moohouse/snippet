package is.moo.snippet.modulith.blog.catalog;

import is.moo.snippet.modulith.blog.catalog.internal.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository repository;

    public List<ProductDTO> findAll() {

        return repository.findAll()
                .stream()
                .map(entity -> new ProductDTO(entity.getId(), entity.getName(), entity.getDescription()))
                .toList();
    }
}
