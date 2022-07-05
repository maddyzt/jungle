describe("add to cart", () => {
  it("user can click on a product to add it to cart", () => {
    cy.visit("/");
    cy.get("#add-to-cart")
    .click()
    cy.get("#cart")
    .contains("1");
});
})