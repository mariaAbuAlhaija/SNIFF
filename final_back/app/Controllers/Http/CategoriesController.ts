import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema, } from '@ioc:Adonis/Core/Validator'
import Category from 'App/Models/Category'

export default class CategoriesController {
    public async get(ctx: HttpContextContract){
        var result = await Category.all()
        return result
    }
    public async getId(ctx: HttpContextContract){
        var id= ctx.params.id
        var result = await Category.findOrFail(id)
        return result
    }
    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            name: schema.string(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var  category = new  Category();
         category.name = fields.name;
        var result = await  category.save();
        return result;
    }

    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            name: schema.string(),
            id: schema.number(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var id = fields.id;
        var  category = await  Category.findOrFail(id);
        category.name = fields.name;
       var result = await  category.save();
        return result;
    }


    public async destroy(ctx: HttpContextContract) {
        try{
        var id = ctx.params.id;
        var  category = await  Category.findOrFail(id);
        try{
        await  category.delete();
        return { message: 'The  category has been deleted!' }
        }
        catch(e: unknown){
          return  { message: "Cannot delete a used foreign key :(" }
        }
    }
        catch(e:unknown){
            return { message: "category not found :(" }
        }
    }  


}
