import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import Product from './Product'
import User from './User'

export default class Review extends BaseModel {
  public static table= "reviews"
  @column({ isPrimary: true })
  public id: number

  @column ({serializeAs: "user_id"})
  public userId: number

  @column ({serializeAs: "product_id"})
  public productId: number

  @column ({serializeAs: "rating"})
  public rating: number

  @column ({serializeAs: "comment"})
  public comment: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @belongsTo (()=>Product)
  public product: BelongsTo<typeof Product>

  @belongsTo (()=>User)
  public user: BelongsTo<typeof User>
}
