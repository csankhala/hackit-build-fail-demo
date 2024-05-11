package org.epam.hackit.service;

import org.epam.hackit.model.Product;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProductService {

    private final Map<Long, Product> productCache = new HashMap<>();

    public Product create(Product product) {
        productCache.put(product.getId(), product);
        return product;
    }

    public List<Product> getAll() {
        return new ArrayList<>(productCache.values());
    }

    public Product getById(Long id) {
        return productCache.get(id);
    }

    public Product update(Long id, Product product) {
        productCache.put(id, product);
        return product;
    }

    public void delete(Long id) {
        productCache.remove(id);
    }
}
