import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column, HasMany, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Review from './Review'
import OrderItem from './OrderItem'
import Brand from './Brand'
import Image from './Image'

export default class Product extends BaseModel {
  public static table= "products"
  @column({ isPrimary: true })
  public id: number

  @column ({serializeAs: "name"})
  public name: string

  @column ({serializeAs: "brand_id"})
  public brandId: number

  @column ({serializeAs: "description"})
  public description: string

  @column ({serializeAs: "price"})
  public price: number

  @column ({serializeAs: "stock"})
  public stock: number

  @column ({serializeAs: "quantity"})
  public quantity: number

  @column ({serializeAs: "gender"})
  public gender: String

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
  
  @belongsTo (()=>Brand)
  public brand: BelongsTo<typeof Brand>

  @hasMany(()=> Review)
  public review: HasMany<typeof Review>

  @hasMany(()=> OrderItem)
  public OrderItem: HasMany<typeof OrderItem>

  @hasMany(()=> Image)
  public image: HasMany<typeof Image>
}
