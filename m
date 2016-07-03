MIME-Version: 1.0
In-Reply-To: <f66c1367-1b63-fe29-1522-3ecd59eb53b8@...515...>
References: <f66c1367-1b63-fe29-1522-3ecd59eb53b8@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 2 Jul 2016 23:45:42 -0400
Message-ID: <CAKuzo_jOYoE6NA=zC7cvt5Zm0KekO-1wu=z8R5Qjp+5-=kXvpQ@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05c4fef42c000536b30e6d
Subject: Re: [Openvpn-devel] Windows service changes
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

--94eb2c05c4fef42c000536b30e6d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 30, 2016 at 11:04 AM, Samuli Sepp=C3=A4nen <samuli@...515...>
wrote:

> The installer linked to above implement all of the above. However, these
> three changes are required for things to work properly:
>
> <https://github.com/OpenVPN/openvpn-build/pull/23>
> <https://github.com/xkjyeah/openvpnserv2/pull/7>
>

Alternatively the startup mode may be changed from the installer using

sc config OpenVPNServiceInteractive start=3Dauto

Something like this to change the mode at install time will be required to
support the checkbox mentioned below.


> <https://github.com/OpenVPN/openvpn/pull/57>
>
> The only thing missing is launching the "Interactive Service" at install
> time, and adding a checkbox "Enable Interactive Service" to the
> installer, as agreed upon in this email thread:
>
>
Oh I missed this paragraph on the first read -- hence my stupid question in
the previous email.. Anyway, once the startup mode is set as automatic it
will anyway start after next reboot, so is there a need to have that
checkbox? Unless unchecking it also means the mode will be changed to
manual.


> <http://thread.gmane.org/gmane.network.openvpn.devel/12010/>
>
> Let me know if you have any comments regarding these changes
>

Selva

--94eb2c05c4fef42c000536b30e6d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Jun 30, 2016 at 11:04 AM, <span tabindex=3D"-1" id=3D":6xu.1" style=
=3D"" class=3D"">Samuli</span> <span tabindex=3D"-1" id=3D":6xu.2" style=3D=
"" class=3D"">Sepp=C3=A4nen</span> <span dir=3D"ltr">&lt;<a href=3D"mailto:=
samuli@...515..." target=3D"_blank"><span tabindex=3D"-1" id=3D":6xu.3" sty=
le=3D"" class=3D"">samuli</span>@<span tabindex=3D"-1" id=3D":6xu.4" style=
=3D"" class=3D"">openvpn</span>.net</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><div id=3D":4j0" class=3D"a3s aXjCH m155a1d918e1c6359">The=
 installer linked to above implement all of the above. However, these<br>
three changes are required for things to work properly:<br>
<br>
&lt;<a href=3D"https://github.com/OpenVPN/openvpn-build/pull/23" rel=3D"nor=
eferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn-build/pull/23=
</a>&gt;<br>
&lt;<a href=3D"https://github.com/xkjyeah/openvpnserv2/pull/7" rel=3D"noref=
errer" target=3D"_blank">https://github.com/xkjyeah/openvpnserv2/pull/7</a>=
&gt;<br></div></blockquote><div><br></div><div>Alternatively the <span tabi=
ndex=3D"-1" id=3D":6xu.5" style=3D"" class=3D"">startup</span> mode may be =
changed from the installer using<br></div><div><br><span tabindex=3D"-1" id=
=3D":6xu.6" style=3D"" class=3D"">sc</span> <span tabindex=3D"-1" id=3D":6x=
u.7" style=3D"" class=3D"">config</span> <span tabindex=3D"-1" id=3D":6xu.8=
" style=3D"" class=3D"">OpenVPNServiceInteractive</span> start=3Dauto<br><b=
r></div><div>Something like this to change the mode at install time will be=
 required to support the <span tabindex=3D"-1" id=3D":6xu.9" style=3D"" cla=
ss=3D"">checkbox</span> mentioned below.<br>=C2=A0<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><div id=3D":4j0" class=3D"a3s aXjCH m155a1d918e1c6359">
&lt;<a href=3D"https://github.com/OpenVPN/openvpn/pull/57" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/OpenVPN/openvpn/pull/57</a>&gt;<br>
<br>
The only thing missing is launching the &quot;Interactive Service&quot; at =
install<br>
time, and adding a checkbox &quot;Enable Interactive Service&quot; to the<b=
r>
installer, as agreed upon in this email thread:<br>
<br></div></blockquote><div>=C2=A0</div><div>Oh I missed this paragraph on =
the first read -- hence my stupid question in the previous email.. Anyway, =
once the <span tabindex=3D"-1" id=3D":6xu.10" style=3D"" class=3D"">startup=
</span> mode is set as automatic it will anyway start after next reboot, so=
 is there a need to have that <span tabindex=3D"-1" id=3D":6xu.11" style=3D=
"" class=3D"">checkbox</span>? Unless <span tabindex=3D"-1" id=3D":6xu.12" =
style=3D"" class=3D"">unchecking</span> it also means the mode will be chan=
ged to manual.<br></div><div>=C2=A0 <br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div id=3D":4j0" class=3D"a3s aXjCH m155a1d918e1c6359">
&lt;<a href=3D"http://thread.gmane.org/gmane.network.openvpn.devel/12010/" =
rel=3D"noreferrer" target=3D"_blank">http://thread.gmane.org/gmane.network.=
openvpn.devel/12010/</a>&gt;<br>
<br>
Let me know if you have any comments regarding these changes</div></blockqu=
ote></div><br></div><div class=3D"gmail_extra"><span tabindex=3D"-1" id=3D"=
:6xu.13" style=3D"" class=3D"">Selva</span><br></div></div>

--94eb2c05c4fef42c000536b30e6d--

