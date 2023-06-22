import { DateTime } from 'luxon'
import { BaseModel, belongsTo, BelongsTo, column, HasMany, hasMany } from '@ioc:Adonis/Lucid/Orm'
import User from './User'
import City from './City'
import Order from './Order'

export default class Address extends BaseModel {
  public static table= "addresses"
  @column({ isPrimary: true })
  public id: number

  @column ({serializeAs: "customer_id"})
  public customerId: number

  @column ({serializeAs: "city_id"})
  public cityId: number

  @column ({serializeAs: "phone_number"})
  public phoneNumber: string

  @column ({serializeAs: "address"})
  public address: string

  @column ({serializeAs: "zip_code"})
  public zipCode: string

  @column ({serializeAs: "default"})
  public default: boolean

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
  
  @belongsTo (()=>User)
  public customer: BelongsTo<typeof User>
  
  @belongsTo (()=>City)
  public city: BelongsTo<typeof City>

  @hasMany(()=>Order)
  public order:HasMany<typeof Order>

}
