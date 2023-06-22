import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema, rules} from '@ioc:Adonis/Core/Validator'
import Address from 'App/Models/Address'

export default class AddressesController {
    public async get(ctx: HttpContextContract){
        var user= await ctx.auth.authenticate()
        var result = await Address.query().where("customer_id", user.id).preload("city", (query)=>{query.preload("country")})
        return result
    }
    public async getId(ctx: HttpContextContract){
        var id= ctx.params.id
        var result = await Address.findOrFail(id)
        return result
    }
    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            customer_id: schema.number([
                rules.exists({
                    table: 'users',
                    column: 'id'
                })  
            ]),
            city_id: schema.number([
                rules.exists({
                    table: 'cities',
                    column: 'id'
                })  
             ]),
            phone_number: schema.string(),
            address: schema.string(),
            zip_code: schema.string(),
            default: schema.boolean(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var  address = new  Address();
         address.customerId = fields.customer_id;
         address.cityId = fields.city_id;
         address.phoneNumber = fields.phone_number;
         address.phoneNumber = fields.phone_number;
         address.address = fields.address;
         address.zipCode = fields.zip_code; 
         address.default = fields.default; 
         await  address.save();
         var result = Address.query().where("id",address.customerId).preload("city", (query)=>{query.preload("country")})
        return result;
    }

    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            customer_id: schema.number([
                rules.exists({
                    table: 'users',
                    column: 'id'
                })  
            ]),
            city_id: schema.number([
                rules.exists({
                    table: 'cities',
                    column: 'id'
                })  
             ]),
            phone_number: schema.string(),
            address: schema.string(),
            zip_code: schema.string(), 
            default: schema.boolean(), 
            id: schema.number(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var id = fields.id;
        var  address = await  Address.findOrFail(id);
        address.customerId = fields.customer_id;
         address.cityId = fields.city_id;
         address.phoneNumber = fields.phone_number;
         address.phoneNumber = fields.phone_number;
         address.address = fields.address;
         address.zipCode = fields.zip_code;
         address.default = fields.default; 
        var result = await  address.save();
        return result;
    }


    public async destroy(ctx: HttpContextContract) {
        try{
        var id = ctx.params.id;
        var  address = await  Address.findOrFail(id);
        try{
        await  address.delete();
        return { message: "The  address has been deleted!" }
        }
        catch(e: unknown){
          return  { message: "Cannot delete a used foreign key :(" }
        }
    }
        catch(e:unknown){
            return { message: "address not found :(" }
        }
    }  


}
