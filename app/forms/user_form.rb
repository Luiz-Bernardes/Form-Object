# VALIDATIONS REMOVED FROM MODEL AND SET HERE - Form Object
# DELEGATES,SCOPES,ETC

class UserForm
  include ActiveModel::Model
  include Virtus.model

  attribute :user, User
  attribute :name, String , default: :user_name
  attribute :phone, String, default: :user_phone
  attribute :email, String, default: :user_email

  # Validation
  validates :user, :name, presence: true

  # Delegate
  delegate :name, :phone, :email, to: :user, allow_nil: true, prefix: true # set default values to edit view (attribute)
  delegate :persisted?,  to: :user, allow_nil: true # verify em view if object is persisted, differ new from edit view in (form)
  # delegate :new_record?, to: :user, allow_nil: true

  def save
    return false unless valid?
    persist
    true
  end

  private
  def persist
    user.assign_attributes(name: name, phone: phone, email: email)
    user.save
  end

end