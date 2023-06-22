import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema, } from '@ioc:Adonis/Core/Validator'
import Brand from 'App/Models/Brand'

export default class BrandsController {
    public async get(ctx: HttpContextContract){
        var result = await Brand.all()
        return result
    }
    public async getId(ctx: HttpContextContract){
        var id= ctx.params.id
        var result = await Brand.findOrFail(id)
        return result
    }
    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            name: schema.string(),
            image: schema.string(),
            description: schema.string(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var  brand = new  Brand();
         brand.name = fields.name;
         brand.image = fields.image;
         brand.description = fields.description;
        var result = await  brand.save();
        return result;
    }

    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            name: schema.string(),
            image: schema.string(),
            description: schema.string(),
            id: schema.number(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var id = fields.id;
        var  brand = await  Brand.findOrFail(id);
        brand.name = fields.name;
        brand.image = fields.image;
        brand.description = fields.description;
       var result = await  brand.save();
        return result;
    }


    public async destroy(ctx: HttpContextContract) {
        try{
        var id = ctx.params.id;
        var  brand = await  Brand.findOrFail(id);
        try{
        await  brand.delete();
        return { message: 'The  brand has been deleted!' }
        }
        catch(e: unknown){
          return  { message: "Cannot delete a used foreign key :(" }
        }
    }
        catch(e:unknown){
            return { message: "brand not found :(" }
        }
    }  


}
