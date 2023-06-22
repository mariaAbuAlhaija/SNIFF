
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema, } from '@ioc:Adonis/Core/Validator'
import Country from 'App/Models/Country'

export default class CountriesController {
    public async get(){
        var result = await Country.query().preload("city")
        return result
    }
    public async getId(ctx: HttpContextContract){
        var id= ctx.params.id
        var result = await Country.findOrFail(id)
        return result
    }
    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            name: schema.string(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var  country = new  Country();
         country.name = fields.name;
        var result = await  country.save();
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
        var  country = await  Country.findOrFail(id);
        country.name = fields.name;
       var result = await  country.save();
        return result;
    }


    public async destroy(ctx: HttpContextContract) {
        try{
        var id = ctx.params.id;
        var  country = await  Country.findOrFail(id);
        try{
        await  country.delete();
        return { message: "The  country has been deleted!" }
        }
        catch(e: unknown){
          return  { message: "Cannot delete a used foreign key :(" }
        }
    }
        catch(e:unknown){
            return { message: "country not found :(" }
        }
    }  


}
