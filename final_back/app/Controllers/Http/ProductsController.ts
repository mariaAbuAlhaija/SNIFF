import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema,} from '@ioc:Adonis/Core/Validator'
import Brand from 'App/Models/Brand'
import Product from 'App/Models/Product'
import Query from 'mysql2/typings/mysql/lib/protocol/sequences/Query'

export default class ProductsController {
    public async get(ctx: HttpContextContract){
        var gender= ctx.request.input("gender")
        var brandName= ctx.request.input('brand_name')
       var query= Product.query();
       var result ;
        if(gender){result = await query.where("gender", '=', gender)
         }
          if(brandName){
            var brandId= await Brand.findBy("name", brandName)
        if(brandId){
             result = await query.preload("brand").where("brand_id", brandId.id)}}
         result = await query.preload('image').preload("brand").preload('review')
        
        return result
    }
    public async getId(ctx: HttpContextContract){
        var id= ctx.params.id
        var result = await Product.query().where("id", id).preload('image').preload("brand").preload('review')
        return result
    }
    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            name: schema.string(),
            brand_id: schema.number(),
            description: schema.string(),
            price: schema.number(),
            stock: schema.number(),
            quantity: schema.number(),
            gender: schema.enum(["her", "him"]),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var  product = new  Product();
         product.name = fields.name;
         product.brandId = fields.brand_id;
         product.description = fields.description;
         product.price = fields.price;
         product.stock = fields.stock;
         product.quantity = fields.quantity;
         product.gender = fields.gender;
        var result = await  product.save();
        return result;
    }

    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            name: schema.string(),
            brand_id: schema.number(),
            description: schema.string(),
            price: schema.number(),
            stock: schema.number(),
            quantity: schema.number(),
            id: schema.number(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var id = fields.id;
        var  product = await  Product.findOrFail(id);
        product.name = fields.name;
        product.brandId = fields.brand_id;
        product.description = fields.description;
        product.price = fields.price;
        product.stock = fields.stock;
        product.quantity = fields.quantity;
        var result = await  product.save();
        return result;
    }


    public async destroy(ctx: HttpContextContract) {
        try{
        var id = ctx.params.id;
        var  product = await  Product.findOrFail(id);
        try{
        await  product.delete();
        return { message: "The  product has been deleted!" }
        }
        catch(e: unknown){
          return  { message: "Cannot delete a used foreign key :(" }
        }
    }
        catch(e:unknown){
            return { message: "product not found :(" }
        }
    }  


}
