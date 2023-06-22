import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column, HasMany, hasMany } from '@ioc:Adonis/Lucid/Orm'
import OrderItem from './OrderItem'
import User from './User'
import Address from './Address'

export default class Order extends BaseModel {
  public static table= "orders"
  @column({ isPrimary: true })
  public id: number
  
  @column ({serializeAs: "user_id"})
  public userId: number

  @column ({serializeAs: "address_id"})
  public addressId: number

  @column ({serializeAs: "total"})
  public total: number

  @column ({serializeAs: "status"})
  public status: string




  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @belongsTo (()=>User)
  public user: BelongsTo<typeof User>

  @belongsTo (()=>Address)
  public address: BelongsTo<typeof Address>
  
  @hasMany(()=> OrderItem)
  public orderItem: HasMany<typeof OrderItem>
}
