class MemberInviteMailer < ApplicationMailer
  
  def invite(m, team, member)
    @team = team
    @member = member
    mail(
      subject: "【Torus】#{@member.name}さんから招待が届きました", #メールのタイトル,
      to: m #宛先
    )
  end
end