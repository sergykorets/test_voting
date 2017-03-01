class InviteMailer < ApplicationMailer
 
  def new_user_invite(invite, sign_up_url)
    @invite = invite
    @url  = sign_up_url
    mail(to: @invite.email, subject: 'You are invited to organization')
  end

  def existing_user_invite(invite)
  	@invite = invite
  	mail(to: @invite.email, subject: 'You are invited to organization')
  end

end
