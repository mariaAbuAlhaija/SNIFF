import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema, rules} from '@ioc:Adonis/Core/Validator'
import Order from 'App/Models/Order'
import OrderItem from 'App/Models/OrderItem'
import Product from 'App/Models/Product'

export default class OrdersController {
    public async get(ctx: HttpContextContract){
        var status= ctx.request.input('status')
        if(status) {
            var result = await Order.query().where("status", status).preload("orderItem").preload("address")
            return result
         }
        var result = await Order.query().preload("orderItem").preload("address", (addressQuery)=>{addressQuery.preload("city", (query)=>{query.preload("country")})})
        return result
    }

    public async getId(ctx: HttpContextContract){
        var id= ctx.params.id
        var result = await Order.findOrFail(id)
        return result
    }
    
    public async getByAuth(ctx: HttpContextContract){
        var user = await ctx.auth.authenticate()
        var result = await Order.query().where("user_id", user.id).preload("address", (addressQuery)=>{addressQuery.preload("city", (query)=>{query.preload("country")})}).preload("orderItem")
        return result
    }

    public async create(ctx: HttpContextContract) {  
          const user = await ctx.auth.authenticate()
          var total=0
          const { products } = ctx.request.only(['products'])
          const newSchema = schema.create({
            user_id: schema.number([
                rules.exists({
                    table: 'users',
                    column: 'id'
                })  
            ]),
            address_id: schema.number([
                rules.exists({
                    table: 'addresses',
                    column: 'id'
                })  
            ]),
            status: schema.enum(['pending', 'processing', 'shipped', 'delivered', 'cancelled']),
          }
          )

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var  order = new  Order();
         order.userId = fields.user_id;
         order.addressId = fields.address_id;
         order.status = fields.status;
         var result = await  order.save();

          try {
            var productList= JSON.parse(products)
            for (const  productData of productList) {
                console.log(productData)
                
              const product = await Product.find(productData)
      
              if (!product) {
                continue
              }
              
              await OrderItem.create({
                orderId: order.id,
                productId: product.id,
                quantity: product.quantity,
                price: product.price
              })
              total+= (product.price*product.quantity)
            }
            order.total= total
  
        var result = await  order.save();
      
            return result
          } catch (error) {
            console.error(error)
            return ctx.response.status(500).json({ error: 'Failed to create order' })
          }
        
        return result;
    }
    

    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            user_id: schema.number([
                rules.exists({
                    table: 'users',
                    column: 'id'
                })  
            ]),
            address_id: schema.number([
                rules.exists({
                    table: 'addresses',
                    column: 'id'
                })  
            ]),
            status: schema.enum(['pending', 'processing', 'shipped', 'delivered', 'cancelled']),
            id: schema.number(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var id = fields.id;
        var  order = await  Order.findOrFail(id);
        order.userId = fields.user_id;
         order.addressId = fields.address_id;
         order.status = fields.status;
        var result = await  order.save();
        return result;
    }


    public async destroy(ctx: HttpContextContract) {
        try{
        var id = ctx.params.id;
        var  order = await  Order.findOrFail(id);
        try{
        await  order.delete();
        return { message: "The  order has been deleted!" }
        }
        catch(e: unknown){
          return  { message: "Cannot delete a used foreign key :(" }
        }
    }
        catch(e:unknown){
            return { message: "order not found :(" }
        }
    }  


}
