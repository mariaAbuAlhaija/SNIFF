import { DateTime } from 'luxon'
import { BaseModel, beforeSave, column, HasMany, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Review from './Review'
import Order from './Order'
import Hash from '@ioc:Adonis/Core/Hash'

export default class User extends BaseModel {
  public static table= "users"
  @column({ isPrimary: true })
  public id: number

  @column ({serializeAs: "first_name"})
  public firstName: string

  @column ({serializeAs: "email"})
  public email: string

  @column ({serializeAs: "password"})
  public password: string

  @column ({serializeAs: "last_name"})
  public lastName: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @hasMany (()=>Review)
  public review: HasMany<typeof Review>

  @hasMany (()=>Order)
  public order: HasMany<typeof Order>

  @beforeSave()
  public static async hashPassword (user: User) {
    if (user.$dirty.password) {
      user.password = await Hash.make(user.password)
    }

}
}
