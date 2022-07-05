describe("product", () => {
  it("user can click on a product to go to product detail page", () => {
    cy.visit("/");
    cy.get(".products article")
    .first()
    .click()
    cy.get(".product-detail")
    .should("be.visible");
});
})