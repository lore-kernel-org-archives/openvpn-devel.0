MIME-Version: 1.0
In-Reply-To: <f66c1367-1b63-fe29-1522-3ecd59eb53b8@...515...>
References: <f66c1367-1b63-fe29-1522-3ecd59eb53b8@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 30 Jun 2016 12:37:50 -0400
Message-ID: <CAKuzo_i=xX3JzbdgFsbpR+6xwN0Vwkv0eBVvADqVq3djhry4Vg@...278...>
Content-Type: multipart/alternative; boundary=001a114f6a24d9f0f70536817e70
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

--001a114f6a24d9f0f70536817e70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 30, 2016 at 11:04 AM, Samuli Sepp=C3=A4nen <samuli@...515...>
wrote:

> 2) OpenVPNServiceInteractive ("OpenVPN Interactive Service")
>
> This service is registered by openvpnserv.exe. This part is still very
> useful, as it allows OpenVPN GUI to be used without admin privileges.
>
> Right now this service has "startupmode" hardcoded to "automatic" in
> src/openvpnserv/interactive.c.
>

Automatic startup mode will start the service on next reboot, but an
immediate start at the end of installation would be useful. Is that how
this installer is supposed to work?

Selva

--001a114f6a24d9f0f70536817e70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Jun 30, 2016 at 11:04 AM, Samul=
i Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." t=
arget=3D"_blank">samuli@...515...</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div id=3D":16a" class=3D"a3s aXjCH m155a1d918e1c6359">2) Op=
enVPNServiceInteractive (&quot;OpenVPN Interactive Service&quot;)<br>
<br>
This service is registered by openvpnserv.exe. This part is still very<br>
useful, as it allows OpenVPN GUI to be used without admin privileges.<br>
<br>
Right now this service has &quot;startupmode&quot; hardcoded to &quot;autom=
atic&quot; in<br>
src/openvpnserv/interactive.c.</div></blockquote></div><br>Automatic startu=
p mode will start the service on next reboot, but an immediate start at the=
 end of installation would be useful. Is that how this installer is suppose=
d to work?</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_ex=
tra">Selva</div><div class=3D"gmail_extra"><br></div></div>

--001a114f6a24d9f0f70536817e70--

