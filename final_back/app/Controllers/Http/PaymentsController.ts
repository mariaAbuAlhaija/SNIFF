import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema, rules} from '@ioc:Adonis/Core/Validator'
import Payment from 'App/Models/Payment'

export default class PaymentsController {
    public async get(){
        var result = await Payment.all()
        return result
    }
    public async getId(ctx: HttpContextContract){
        var id= ctx.params.id
        var result = await Payment.findOrFail(id)
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
            amount: schema.number(),
            payment_status: schema.enum(['pending', 'approved', 'declined', 'refunded']),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var  payment = new  Payment();
         payment.orderId = fields.order_id;
         payment.amount = fields.amount;
         payment.paymentStatus = fields.payment_status;
        var result = await  payment.save();
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
            amount: schema.number(),
            payment_status: schema.enum(['pending', 'approved', 'declined', 'refunded']),
            id: schema.number(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var id = fields.id;
        var  payment = await  Payment.findOrFail(id);
        payment.orderId = fields.order_id;
        payment.amount = fields.amount;
        payment.paymentStatus = fields.payment_status;
        var result = await  payment.save();
        return result;
    }


    public async destroy(ctx: HttpContextContract) {
        try{
        var id = ctx.params.id;
        var  payment = await  Payment.findOrFail(id);
        try{
        await  payment.delete();
        return { message: "The  payment has been deleted!" }
        }
        catch(e: unknown){
          return  { message: "Cannot delete a used foreign key :(" }
        }
    }
        catch(e:unknown){
            return { message: "payment not found :(" }
        }
    }  


}
