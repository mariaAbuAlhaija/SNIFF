import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema, rules} from '@ioc:Adonis/Core/Validator'
import Database from '@ioc:Adonis/Lucid/Database'
import { column } from '@ioc:Adonis/Lucid/Orm'
import Review from 'App/Models/Review'

export default class ReviewsController {
    public async get(ctx: HttpContextContract){
        var user = await ctx.auth.authenticate()
        var product_id= ctx.request.input('product_id')
        if(product_id) {
            var result = await Review.query().where("product_id", product_id)
            return result
         }
        var result = await Review.query().where("user_id", user.id)
        return result
    }
    public async getId(ctx: HttpContextContract){
        var id= ctx.params.id
        var result = await Review.findOrFail(id)
        return result
    }
    public async getRating(ctx: HttpContextContract){
        var product_id= ctx.request.input("product_id")
        var result = Database.from("reviews").where("product_id", product_id).avg('rating' as "rating")
        return result
    } 
    public async getTotalReviews(ctx: HttpContextContract){
        var product_id= ctx.request.input("product_id")
        var result = Database.from("reviews").where("product_id", product_id).count('rating')
        return result
    } 


    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            user_id: schema.number([
                rules.exists({
                    table: 'users',
                    column: 'id'
                })  
            ]),
            product_id: schema.number([
                rules.exists({
                    table: 'products',
                    column: 'id'
                })  
            ]),
            rating: schema.number(),
            comment: schema.string(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var  review = new  Review();
         review.userId = fields.user_id;
         review.productId = fields.product_id;
         review.rating = fields.rating;
         review.comment = fields.comment;
        var result = await  review.save();
        return result;
    }

    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            user_id: schema.number([
                rules.exists({
                    table: 'users',
                    column: 'id'
                })  
            ]),
            product_id: schema.number([
                rules.exists({
                    table: 'products',
                    column: 'id'
                })  
            ]),
            rating: schema.number(),
            comment: schema.string(),
            id: schema.number(),
          })

        const fields = await ctx.request.validate({ schema: newSchema, messages:{
            "exists": "{{field}} (foreign key) is not existed"
        } })
        var id = fields.id;
        var  review = await  Review.findOrFail(id);
        review.userId = fields.user_id;
        review.productId = fields.product_id;
        review.rating = fields.rating;
        review.comment = fields.comment;
        var result = await  review.save();
        return result;
    }


    public async destroy(ctx: HttpContextContract) {
        try{
        var id = ctx.params.id;
        var  review = await  Review.findOrFail(id);
        try{
        await  review.delete();
        return { message: "The  review has been deleted!" }
        }
        catch(e: unknown){
          return  { message: "Cannot delete a used foreign key :(" }
        }
    }
        catch(e:unknown){
            return { message: "review not found :(" }
        }
    }  


}
