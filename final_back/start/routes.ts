
import Route from '@ioc:Adonis/Core/Route'



Route.group(
  ()=>{
    Route.get("/", "AddressesController.get"),
    Route.get("/:id", "AddressesController.getId"),
    Route.post("/", "AddressesController.create"), 
    Route.put("/", "AddressesController.update"), 
    Route.delete("/:id", "AddressesController.destroy")
  }
).prefix("/address")

Route.group(
  ()=>{
    Route.get("/", "BrandsController.get"),
    Route.get("/:id", "BrandsController.getId"),
    Route.post("/", "BrandsController.create"), 
    Route.put("/", "BrandsController.update"), 
    Route.delete("/:id", "BrandsController.destroy")
  }
).prefix("/brand")

Route.group(
  ()=>{
    Route.get("/", "CategoriesController.get"),
    Route.get("/:id", "CategoriesController.getId"),
    Route.post("/", "CategoriesController.create"), 
    Route.put("/", "CategoriesController.update"), 
    Route.delete("/:id", "CategoriesController.destroy")
  }
).prefix("/category")

Route.group(
  ()=>{
    Route.get("/", "CitiesController.get"),
    Route.get("/:id", "CitiesController.getId"),
    Route.post("/", "CitiesController.create"), 
    Route.put("/", "CitiesController.update"), 
    Route.delete("/:id", "CitiesController.destroy")
  }
).prefix("/city")

Route.group(
  ()=>{
    Route.get("/", "CountriesController.get"),
    Route.get("/:id", "CountriesController.getId"),
    Route.post("/", "CountriesController.create"), 
    Route.put("/", "CountriesController.update"), 
    Route.delete("/:id", "CountriesController.destroy")
  }
).prefix("/country")

Route.group(
  ()=>{
    Route.get("/", "ImagesController.get"),
    Route.get("/:id", "ImagesController.getId"),
    Route.get("/Auth", "ImagesController.getByProduct"),
    Route.post("/", "ImagesController.create"), 
    Route.put("/", "ImagesController.update"), 
    Route.delete("/:id", "ImagesController.destroy")
  }
).prefix("/image")

Route.group(
  ()=>{
    Route.get("/", "OrderItemsController.get"),
    Route.get("/:id", "OrderItemsController.getId"),
    Route.get("/order", "OrderItemsController.getByOrderId"),
    Route.post("/", "OrderItemsController.create"), 
    Route.put("/", "OrderItemsController.update"), 
    Route.delete("/:id", "OrderItemsController.destroy")
  }
).prefix("/orderItem")

Route.group(
  ()=>{
    Route.get("/", "OrdersController.get"),
    Route.get("/auth", "OrdersController.getByAuth"),
    Route.get("/:id", "OrdersController.getId"),
    Route.post("/", "OrdersController.create"), 
    Route.put("/", "OrdersController.update"), 
    Route.delete("/:id", "OrdersController.destroy")
  }
).prefix("/order")

Route.group(
  ()=>{
    Route.get("/", "PaymentsController.get"),
    Route.get("/:id", "PaymentsController.getId"),
    Route.post("/", "PaymentsController.create"), 
    Route.put("/", "PaymentsController.update"), 
    Route.delete("/:id", "PaymentsController.destroy")
  }
).prefix("/payment")

Route.group(
  ()=>{
    Route.get("/", "ProductsController.get"),
    Route.get("/:id", "ProductsController.getId"),
    Route.post("/", "ProductsController.create"), 
    Route.put("/", "ProductsController.update"), 
    Route.delete("/:id", "ProductsController.destroy")
  }
).prefix("/product")

Route.group(
  ()=>{
    Route.get("/", "ReviewsController.get"),
    Route.get("/rating/", "ReviewsController.getRating"),
    Route.get("/totals/", "ReviewsController.getTotalReviews"),
    Route.get("/:id", "ReviewsController.getId"),
    Route.post("/", "ReviewsController.create"), 
    Route.put("/", "ReviewsController.update"), 
    Route.delete("/:id", "ReviewsController.destroy")
  }
).prefix("/review")

Route.group(
  ()=>{
    Route.get("/", "UsersController.get"),
    Route.get("/:id", "UsersController.getId"),
    Route.post("/", "UsersController.create"), 
    Route.post("/login", "UsersController.login"),
    Route.post("/logout", "UsersController.logout"),
    Route.put("/", "UsersController.update"), 
    Route.delete("/:id", "UsersController.destroy")
  }
).prefix("/user")
