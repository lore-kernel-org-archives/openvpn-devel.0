MIME-Version: 1.0
In-Reply-To: <d6bc8749-5ebf-e8f4-f311-e13a02b61684@...515...>
References: <6c0ea9bb-351e-1c5a-eb2e-ed8a301ececf@...515...>
	<d6bc8749-5ebf-e8f4-f311-e13a02b61684@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 23 Aug 2016 11:03:01 -0400
Message-ID: <CAKuzo_gZ76OvOuNYGq7czm8Bn4Aun29TN2u0NiQq-mAZbehZfg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05602e3caffd053abe775f
Subject: Re: [Openvpn-devel] Summary of today's (Monday,
 22nd Aug 2016) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c05602e3caffd053abe775f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Following up on the IRC chatlog:

On Mon, Aug 22, 2016 at 4:00 PM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

> Hi,
>
> Here's the summary of today's IRC meeting.
>
>
snip..


> cron3, dazo, jamesyonan, mattock, OSTIF-Derek, syzzer, Thermi and
> valdikss participated in this meeting.
>
>
snip.


> Discussed an issue with .ovpn file associations in Windows. It would be
> best if clicking on a .ovpn file would bring up a gui that asks "do you
> want to import this, or start it right away". Valdikss has planned on
> doing a GUI such as that, and will hopefully provide a patch soon.
>

The GUI master branch does have an "import config file" menu. Its very
basic and works only if the config file is self-contained with key, cert
etc. as no additional files are imported. The config file gets copied to
the users' config folder and gets added to the menu from where it could be
started.

As discussed here https://github.com/OpenVPN/openvpn-gui/issues/61 and
based on a feature request on trac (?) we now plan (PR #62) to use file
association of .ovpn to select the editor from "Edit config" menu in the
GUI. It will default to notepad.exe if no file association is found. This
allows the user to associate .ovpn with an editor of their choice. Instead,
if we associate it with openvpn-gui as suggested above, we have to decide
what to do for using user-defined editor for .ovpn files.

Selva

--94eb2c05602e3caffd053abe775f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">Following up on the IRC chatlog:<=
/div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Aug =
22, 2016 at 4:00 PM, Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"=
mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-sty=
le:solid;padding-left:1ex">Hi,<br>
<br>
Here&#39;s the summary of today&#39;s IRC meeting.<br><br></blockquote><div=
><br></div><div>snip..</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-col=
or:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
cron3, dazo, jamesyonan, mattock, OSTIF-Derek, syzzer, Thermi and<br>
valdikss participated in this meeting.<br><br></blockquote><div><br></div><=
div>snip.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,20=
4,204);border-left-style:solid;padding-left:1ex">
Discussed an issue with .ovpn file associations in Windows. It would be<br>
best if clicking on a .ovpn file would bring up a gui that asks &quot;do yo=
u<br>
want to import this, or start it right away&quot;. Valdikss has planned on<=
br>
doing a GUI such as that, and will hopefully provide a patch soon.<br></blo=
ckquote><div><br></div><div>The GUI master branch does have an &quot;import=
 config file&quot; menu. Its very basic and works only if the config file i=
s self-contained with key, cert etc. as no additional files are imported. T=
he config file gets copied to the users&#39; config folder and gets added t=
o the menu from where it could be started.</div><div><br></div><div>As disc=
ussed here <a href=3D"https://github.com/OpenVPN/openvpn-gui/issues/61">htt=
ps://github.com/OpenVPN/openvpn-gui/issues/61</a> and based on a feature re=
quest on trac (?) we now plan (PR #62) to use file association of .ovpn to =
select the editor from &quot;Edit config&quot; menu in the GUI. It will def=
ault to notepad.exe if no file association is found. This allows the user t=
o associate .ovpn with an editor of their choice. Instead, if we associate =
it with openvpn-gui as suggested above, we have to decide what to do for us=
ing user-defined editor for .ovpn files.</div><div>=C2=A0<br></div><div>Sel=
va</div></div></div></div>

--94eb2c05602e3caffd053abe775f--

