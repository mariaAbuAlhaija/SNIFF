import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema, } from '@ioc:Adonis/Core/Validator'
import Image from 'App/Models/Image'

export default class ImagesController {
    public async get(ctx: HttpContextContract){
        var result = await Image.all()
        return result
    }
    public async getId(ctx: HttpContextContract){
        var id= ctx.params.id
        var result = await Image.findOrFail(id)
        return result
    }
    public async getByProduct(ctx: HttpContextContract){
        var productId= ctx.request.input('product_id')
        var result = await Image.query().where("product_id", '=', productId)
        return result
    }
    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            product_id: schema.number(),
            image: schema.string(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var  image = new  Image();
         image.productId = fields.product_id;
         image.image = fields.image;
        var result = await  image.save();
        return result;
    }

    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            product_id: schema.number(),
            image: schema.string(),
            id: schema.number(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var id = fields.id;
        var  image = await  Image.findOrFail(id);
        image.productId = fields.product_id;
        image.image = fields.image;
       var result = await  image.save();
        return result;
    }


    public async destroy(ctx: HttpContextContract) {
        try{
        var id = ctx.params.id;
        var  image = await  Image.findOrFail(id);
        try{
        await  image.delete();
        return { message: 'The  image has been deleted!' }
        }
        catch(e: unknown){
          return  { message: "Cannot delete a used foreign key :(" }
        }
    }
        catch(e:unknown){
            return { message: "image not found :(" }
        }
    }  


}
