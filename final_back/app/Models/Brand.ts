import { BaseModel, HasMany, column, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Product from './Product'

export default class Brand extends BaseModel {
  public static table= "brands"
  @column({ isPrimary: true })
  public id: number

  @column ({serializeAs: "name"})
  public name: string

  @column ({serializeAs: "image"})
  public image: string

  @column ({serializeAs: "description"})
  public description: string
  
  @hasMany(()=> Product)
  public product: HasMany<typeof Product>
}
