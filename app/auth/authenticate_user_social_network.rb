# class AuthenticateUserSocialNetwork
#   def initialize(email, user_id, auth_token, provider)
#     @email = email
#     @auth_token = auth_token
#     @provider = provider
#     @user_id = user_id
#   end

#   def call
#     JsonWebToken.encode({user_id: user.id}) if user
#   end

#   private

#   attr_reader :email, :user_id, :auth_token, :provider

#   def user
#     user = User.where(uid: user_id, provider: provider).first

#     if user
#       user.update_attributes!(token: auth_token)
#       return user if user && User.find_by_token(auth_token)
#     else
#       user = User.find_by_email(email)
#         if user
#           user.provider = provider
#           user.uid      = user_id
#           user.token    = auth_token
#           user.save!
#           return user if user #&& User.authenticateEmail(user.email)
#         else
#           user = User.create!(
#             provider: provider,
#             uid:      user_id,
#             token:    auth_token,
#             email:    email,
#             password: user_id
#           )
#           return user if user && User.find_by_token(auth_token)
#         end
#     end
#     raise(ApiException::AuthenticationError, 'Invalid credentials')
#   end
# end
