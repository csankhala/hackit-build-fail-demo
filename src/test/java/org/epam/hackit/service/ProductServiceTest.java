package org.epam.hackit.service;

import org.epam.hackit.model.Product;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@RunWith(MockitoJUnitRunner.class)
public class ProductServiceTest {

    @InjectMocks
    private ProductService productService;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testCreate() {
        Product product = new Product();
        product.setId(1L);
        Product createdProduct = productService.create(product);
        assertEquals(product, createdProduct);
    }

    @Test
    public void testGetAll() {
        Product product = new Product();
        product.setId(1L);
        productService.create(product);
        List<Product> products = productService.getAll();
        assertFalse(products.isEmpty());
        assertEquals(1, products.size());
        assertEquals(product, products.get(0));
    }

    @Test
    public void testGetById() {
        Product product = new Product();
        product.setId(1L);
        productService.create(product);
        Product fetchedProduct = productService.getById(1L);
        assertEquals(product, fetchedProduct);
    }

    @Test
    public void testUpdate() {
        Product product = new Product();
        product.setId(1L);
        productService.create(product);
        Product updatedProduct = new Product();
        updatedProduct.setId(1L);
        updatedProduct.setName("Updated Product");
        productService.update(1L, updatedProduct);
        Product fetchedProduct = productService.getById(1L);
        assertEquals(updatedProduct, fetchedProduct);
    }

    @Test
    public void testDelete() {
        Product product = new Product();
        product.setId(1L);
        productService.create(product);
        productService.delete(1L);
        Product fetchedProduct = productService.getById(1L);
        assertNull(fetchedProduct);
    }
}