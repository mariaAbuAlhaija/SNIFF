import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema, rules} from '@ioc:Adonis/Core/Validator'
import City from 'App/Models/City'

export default class CitiesController {
    public async get(){
        var result = await City.all()
        return result
    }
    public async getId(ctx: HttpContextContract){
        var id= ctx.params.id
        var result = await City.findOrFail(id)
        return result
    }
    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            country_id: schema.number([
                rules.exists({
                    table: 'countries',
                    column: 'id'
                })  
            ]),
            name: schema.string(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var  city = new  City();
         city.countryId = fields.country_id;
         city.name = fields.name;
        var result = await  city.save();
        return result;
    }

    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            country_id: schema.number([
                rules.exists({
                    table: 'countries',
                    column: 'id'
                })  
            ]),
            name: schema.string(),
            id: schema.number(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var id = fields.id;
        var  city = await  City.findOrFail(id);
        city.countryId = fields.country_id;
         city.name = fields.name;
        var result = await  city.save();
        return result;
    }


    public async destroy(ctx: HttpContextContract) {
        try{
        var id = ctx.params.id;
        var  city = await  City.findOrFail(id);
        try{
        await  city.delete();
        return { message: "The  city has been deleted!" }
        }
        catch(e: unknown){
          return  { message: "Cannot delete a used foreign key :(" }
        }
    }
        catch(e:unknown){
            return { message: "city not found :(" }
        }
    }  


}
