import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import Country from './Country'

export default class City extends BaseModel {
  public static table= "cities"
  @column({ isPrimary: true })
  public id: number

  @column ({serializeAs: "country_id"})
  public countryId: number

  @column ({serializeAs: "name"})
  public name: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @belongsTo (()=>Country)
  public country: BelongsTo<typeof Country>
}
