describe("Add to Cart", () => {
  it("should navigate to home", () => {
    cy.visit("/");
  })
  it("should click on a product's add to cart", () => {
    cy.contains("Scented Blade").parent('article').find(".btn").click({ force: true })

  })
  it("should increment by 1", () => {
    cy.contains("My Cart (1)").should("exist")
  })
});