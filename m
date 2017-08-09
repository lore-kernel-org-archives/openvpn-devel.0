MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10806D5BC3@...2294...>
References: <99D61A626FDA8A4B90A270669121BE10806D5BC3@...2294...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 9 Aug 2017 11:30:01 -0400
Message-ID: <CAKuzo_gmn-B6=4Vho9OwUENzqT0C5ibNZghOY-9B1cpTGRE42Q@...278...>
Content-Type: multipart/alternative; boundary="001a113a2cb61178bc055653c207"
Subject: Re: [Openvpn-devel] OVPN Interactive Service for non-admin users
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113a2cb61178bc055653c207
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

Adding to what I wrote in my reply to your private email:


> I am developing an eduVPN client for Windows. Imagine the eduVPN client as
> a custom OpenVPN GUI. The client uses openvpn.exe for connecting, the
> configuration file is provided by eduVPN server once user authenticates
> using OAuth. User running the eduVPN client is not an administrator.
> Elevation is out of the question.
>
>
>
> I would like to use the Interactive Service to start openvpn.exe, but I
> have some problems:
>
>
>
> 1.       The configuration file is dynamically downloaded by the eduVPN
> client and stored somewhere user can write (user's temporary folder for
> example). But the Interactive Service was specifically programmed to allow
> configurations from "C:\Program Files\OpenVPN\config" folder only. But user
> running eduVPN client can't write to this folder.
>
> 2.       Interactive Service can launch openvpn.exe using any
> configuration file if user is a member of the "OpenVPN Administrators"
> group. Then, I would need to add all users of the computer to that group,
> again requiring elevation.
>
>
>
> Is there any specific reason, why Interactive Service is so paranoid,
> knowing that it launches openvpn.exe and all external scripts as the
> interactive user anyway?
>

The service does privileged operations so some admin has to bless a user to
allow certain options when launching openvpn.exe. In other words, options
allowed in user editable configs are restricted unless the user is in a
designated group.

An admin installing openvpn can change this behaviour by customizing the
ovpn_admin_group and/or by adding users to that group.


>
>
> I have a work-around for this paradox in my sleeve: the eduVPN setup shall
> create an "eduVPN" subfolder in the "C:\Program Files\OpenVPN\config"
> folder, and grant all users desirable permissions*: a sort of public spool
> folder.
>

Setting up such a folder requires admin rights. If your installer has admin
rights, just add all users to "OpenVPN Administrators" group or set the
registry key ovpn_admin_group to "Users"


>
>
> But that would open the OpenVPN Interactive Service to any user and
> application. This is why we would like your opinion first.
>

Yes the service will then launch openvpn with arbitrary configs as any
user, but that is what you want isn't it?

Regards,

Selva

--001a113a2cb61178bc055653c207
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
>Hi Simon,</div><div><br></div><div>Adding to what I wrote in my reply to y=
our private email:</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><di=
v lang=3D"SL" link=3D"blue" vlink=3D"purple"><div class=3D"m_-3887839519535=
789151WordSection1"><p class=3D"MsoNormal"><span lang=3D"EN-GB">I am develo=
ping an eduVPN client for Windows. Imagine the eduVPN client as a custom Op=
enVPN GUI. The client uses openvpn.exe for connecting, the configuration fi=
le is provided by eduVPN server once user authenticates using OAuth. User r=
unning the eduVPN client is not an administrator. Elevation is out of the q=
uestion.<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-GB=
"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-GB=
">I would like to use the Interactive Service to start openvpn.exe, but I h=
ave some problems:<u></u><u></u></span></p><p class=3D"MsoNormal"><span lan=
g=3D"EN-GB"><u></u>=C2=A0<u></u></span></p><p class=3D"m_-38878395195357891=
51MsoListParagraph"><u></u><span lang=3D"EN-GB"><span>1.<span style=3D"font=
:7.0pt &quot;Times New Roman&quot;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 </=
span></span></span><u></u><span lang=3D"EN-GB">The configuration file is dy=
namically downloaded by the eduVPN client and stored somewhere user can wri=
te (user&#39;s temporary folder for example). But the Interactive Service w=
as specifically programmed to allow configurations from &quot;C:\Program Fi=
les\OpenVPN\config&quot; folder only. But user running eduVPN client can&#3=
9;t write to this folder.<u></u><u></u></span></p><p class=3D"m_-3887839519=
535789151MsoListParagraph"><u></u><span lang=3D"EN-GB"><span>2.<span style=
=3D"font:7.0pt &quot;Times New Roman&quot;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 </span></span></span><u></u><span lang=3D"EN-GB">Interactive Service=
 can launch openvpn.exe using any configuration file if user is a member of=
 the &quot;OpenVPN Administrators&quot; group. Then, I would need to add al=
l users of the computer to that group, again requiring elevation.<u></u><u>=
</u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-GB"><u></u>=C2=A0<u>=
</u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-GB">Is there any spe=
cific reason, why Interactive Service is so paranoid, knowing that it launc=
hes openvpn.exe and all external scripts as the interactive user anyway?</s=
pan></p></div></div></blockquote><div><br></div><div>The service does privi=
leged operations so some admin has to bless a user to allow certain options=
 when launching <span class=3D"" id=3D":a8s.1" tabindex=3D"-1">openvpn</spa=
n>.<span class=3D"" id=3D":a8s.2" tabindex=3D"-1">exe</span>. In other word=
s, options allowed in user editable <span class=3D"" id=3D":a8s.3" tabindex=
=3D"-1">configs</span> are restricted unless the user is in a designated gr=
oup.</div><div><br></div><div>An admin installing <span class=3D"" id=3D":a=
8s.4" tabindex=3D"-1">openvpn</span> can change this behaviour by customizi=
ng the <span class=3D"" id=3D":a8s.5" tabindex=3D"-1">ovpn</span>_admin_gro=
up and/or by adding users to that group.</div><div>=C2=A0=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><div lang=3D"SL" link=3D"blue" vlink=3D"purple"><d=
iv class=3D"m_-3887839519535789151WordSection1"><p class=3D"MsoNormal"><spa=
n lang=3D"EN-GB"><u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=
=3D"EN-GB"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span lang=
=3D"EN-GB">I have a work-around for this paradox in my sleeve: the eduVPN s=
etup shall create an &quot;eduVPN&quot; subfolder in the &quot;C:\Program F=
iles\OpenVPN\config&quot; folder, and grant all users desirable permissions=
*: a sort of public spool folder.</span></p></div></div></blockquote><div><=
br></div><div>Setting up such a folder requires admin rights. If your insta=
ller has admin rights, just add all users to &quot;<span class=3D"" id=3D":=
a8s.6" tabindex=3D"-1">OpenVPN</span> Administrators&quot; group or set the=
 registry key <span class=3D"" id=3D":a8s.7" tabindex=3D"-1">ovpn</span>_ad=
min_group to &quot;Users&quot;</div><div>=C2=A0=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div lang=3D"SL" link=3D"blue" vlink=3D"purple"><div class=
=3D"m_-3887839519535789151WordSection1"><p class=3D"MsoNormal"><span lang=
=3D"EN-GB"><u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN=
-GB"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN=
-GB">But that would open the OpenVPN Interactive Service to any user and ap=
plication. This is why we would like your opinion first.</span></p></div></=
div></blockquote><div><br></div><div>Yes the service will then launch <span=
 class=3D"" id=3D":a8s.8" tabindex=3D"-1">openvpn</span> with arbitrary <sp=
an class=3D"" id=3D":a8s.9" tabindex=3D"-1">configs</span> as any user, but=
 that is what you want isn&#39;t it?</div><div><br></div><div>Regards,</div=
><div><br></div><div><span class=3D"" id=3D":a8s.10" tabindex=3D"-1">Selva<=
/span></div></div></div></div>

--001a113a2cb61178bc055653c207--

