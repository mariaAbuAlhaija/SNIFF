import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema, rules} from '@ioc:Adonis/Core/Validator'
import OrderItem from 'App/Models/OrderItem'

export default class OrderItemsController {
    public async get(){
        var result = await OrderItem.all()
        return result
    }
    public async getId(ctx: HttpContextContract){
        var id= ctx.params.id
        var result = await OrderItem.findOrFail(id)
        return result
    }
    
    public async getByOrderId(ctx: HttpContextContract){
        var orderId= ctx.request.input('order_id')
        var result = await OrderItem.query().where("order_id", '=', orderId)
        return result
    }

    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            order_id: schema.number([
                rules.exists({
                    table: 'orders',
                    column: 'id'
                })  
            ]),
            product_id: schema.number([
                rules.exists({
                    table: 'products',
                    column: 'id'
                })  
            ]),
            quantity: schema.number(),
            price: schema.number(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var  orderItem = new  OrderItem();
         orderItem.productId = fields.product_id;
         orderItem.orderId = fields.order_id;
         orderItem.quantity = fields.quantity;
         orderItem.price = fields.price;
        var result = await  orderItem.save();
        return result;
    }

    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            order_id: schema.number([
                rules.exists({
                    table: 'orders',
                    column: 'id'
                })  
            ]),
            product_id: schema.number([
                rules.exists({
                    table: 'products',
                    column: 'id'
                })  
            ]),
            quantity: schema.number(),
            price: schema.number(),
            id: schema.number(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var id = fields.id;
        var  orderItem = await  OrderItem.findOrFail(id);
        orderItem.productId = fields.product_id;
        orderItem.orderId = fields.order_id;
        orderItem.quantity = fields.quantity;
        orderItem.price = fields.price;
        var result = await  orderItem.save();
        return result;
    }


    public async destroy(ctx: HttpContextContract) {
        try{
        var id = ctx.params.id;
        var  orderItem = await  OrderItem.findOrFail(id);
        try{
        await  orderItem.delete();
        return { message: "The  orderItem has been deleted!" }
        }
        catch(e: unknown){
          return  { message: "Cannot delete a used foreign key :(" }
        }
    }
        catch(e:unknown){
            return { message: "orderItem not found :(" }
        }
    }  


}
