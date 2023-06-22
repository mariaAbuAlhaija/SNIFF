import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import Product from './Product'

export default class Image extends BaseModel {
  public static table= "images"
  @column({ isPrimary: true })
  public id: number

  @column ({serializeAs: "product_id"})
  public productId: number

  @column ({serializeAs: "image"})
  public image: string
  
  @belongsTo (()=>Product)
  public product: BelongsTo<typeof Product>
}
