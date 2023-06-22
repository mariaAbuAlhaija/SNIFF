import { DateTime } from 'luxon'
import { BaseModel, column, HasMany, hasMany } from '@ioc:Adonis/Lucid/Orm'
import City from './City'

export default class Country extends BaseModel {
  public static table= "countries"
  @column({ isPrimary: true })
  public id: number

  @column ({serializeAs: "name"})
  public name: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @hasMany (()=>City)
  public city: HasMany<typeof City>
}
