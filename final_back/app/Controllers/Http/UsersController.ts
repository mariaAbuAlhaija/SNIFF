import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema,rules} from '@ioc:Adonis/Core/Validator'
import User from 'App/Models/User'

export default class UsersController {
    
    public async get(ctx: HttpContextContract){
        const user = await ctx.auth.authenticate()
        if(user){
        return user
    }
        var result = await User.all()
        return result
    }

    public async getId(ctx: HttpContextContract){
        var id= ctx.params.id
        var result = await User.findOrFail(id)
        return result
    }

    public async login(ctx: HttpContextContract){
        const newSchema= schema.create({
            email: schema.string({}, [rules.email(),]),
            password: schema.string(),
            
        })
        const fields= ctx.request.validate({schema:newSchema})
        const email= (await fields).email
        const password= (await fields).password
        var result = ctx.auth.attempt(email, password)
        return result
    }

    public async logout(ctx: HttpContextContract){
        var obj = await ctx.auth.authenticate()
        await ctx.auth.logout()
        return { message: "Logout" }
    }

    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            first_name: schema.string(),
            last_name: schema.string(),
            email: schema.string(),
            password: schema.string(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var  user = new  User();
         user.firstName = fields.first_name;
         user.lastName = fields.last_name;
         user.email = fields.email;
         user.password = fields.password;
         await  user.save();
        var result = await ctx.auth.attempt(fields.email, fields.password)
        return result
    }

    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            first_name: schema.string(),
            last_name: schema.string(),
            email: schema.string(),
            password: schema.string(),
            id: schema.number(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var id = fields.id;
        var  user = await  User.findOrFail(id);
        user.firstName = fields.first_name;
        user.lastName = fields.last_name;
        user.email = fields.email;
        user.password = fields.password;
        var result = await  user.save();
        return result;
    }


    public async destroy(ctx: HttpContextContract) {
        try{
        var id = ctx.params.id;
        var  user = await  User.findOrFail(id);
        try{
        await  user.delete();
        return { message: "The  user has been deleted!" }
        }
        catch(e: unknown){
          return  { message: "Cannot delete a used foreign key :(" }
        }
    }
        catch(e:unknown){
            return { message: "user not found :(" }
        }
    }  


}
