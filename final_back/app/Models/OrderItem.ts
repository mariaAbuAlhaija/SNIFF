import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import Order from './Order'
import Product from './Product'

export default class OrderItem extends BaseModel {
  public static table= "order_items"
  @column({ isPrimary: true })
  public id: number

  @column ({serializeAs: "order_id"})
  public orderId: number

  @column ({serializeAs: "product_id"})
  public productId: number

  @column ({serializeAs: "quantity"})
  public quantity: number

  @column ({serializeAs: "price"})
  public price: number

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @belongsTo(()=>Order)
  public order: BelongsTo<typeof Order>
  
  @belongsTo (()=>Product)
  public product: BelongsTo<typeof Product>
}
