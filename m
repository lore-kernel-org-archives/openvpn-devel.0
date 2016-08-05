MIME-Version: 1.0
In-Reply-To: <57A3C76A.1020809@...277...>
References: <57A3C76A.1020809@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 4 Aug 2016 22:04:43 -0400
Message-ID: <CAKuzo_h0vMR4jv=iAgT2Vr2kq-nJRDs0Pq=3JC7eydQ-m1Ucpw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c06623aae3b480539497e87
Subject: Re: [Openvpn-devel] Win10 Tun Server +Standard W10 User +OVPN
 Interactive Service +OVPN GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c06623aae3b480539497e87
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 4, 2016 at 6:53 PM, debbie10t <debbie10t@...277...> wrote:

> Hi
>
> So windows 10 as a Server.
>
> ===
>
> General details:
>    Non admin Win10 unmodified user
>    Using OVPN GUI
>    OVPN Interactive service started and used
>    Win10 Tun Server (auto + manual)
>    IPv4 + IPv6 In average constant use
>    ~20 Clients virtual, local and remote
>        win xp/7/10 +linux
>
> (Todo: --server-bridge/tap .. maybe)
>
> Tested using:
>    cfg 1. --server & --server-ipv6 *no* CCD files in use
>    cfg 2. --ifconfig & --ifconfig-ipv6 CCD files in use
>
> Reminder: --keep6alive --ping6 etc
> See:
> https://forums.openvpn.net/viewtopic.php?f=4&t=22119#p63274
>
> ===
>
>
> 24 hours now with Zero hiccups.
>

Glad to know..


>
> Selva,
>
> If you have any specific tests please send me details.
>

Tasks needing admin access happens early on when the server starts so this
looks good especially since you tested ipv6 as well.

One thing to try:
With the server running, edit the config to change the tunnel network (ip
and pool) and issue a SIGHUP to re-read the config (reconnect from the GUI
status window will do this). The old routes should get torn down (log will
show route deletion via service succeeded) the ip should change to the new
one and new routes get added etc.

Although not related to the interactive service, you could also test
running the server on a port < 1024. This being windows I suppose binding
to "privileged" ports doesn't require admin rights.

Thanks,

Selva

--94eb2c06623aae3b480539497e87
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Aug 4, 2016 at 6:53 PM, debbie10t <span dir=3D"ltr">&lt;<a href=
=3D"mailto:debbie10t@...277..." target=3D"_blank">debbie10t@...277...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi<br>
<br>
So windows 10 as a Server.<br>
<br>
=3D=3D=3D<br>
<br>
General details:<br>
=C2=A0 =C2=A0Non admin Win10 unmodified user<br>
=C2=A0 =C2=A0Using OVPN GUI<br>
=C2=A0 =C2=A0OVPN Interactive service started and used<br>
=C2=A0 =C2=A0Win10 Tun Server (auto + manual)<br>
=C2=A0 =C2=A0IPv4 + IPv6 In average constant use<br>
=C2=A0 =C2=A0~20 Clients virtual, local and remote<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0win xp/7/10 +linux<br>
<br>
(Todo: --server-bridge/tap .. maybe)<br>
<br>
Tested using:<br>
=C2=A0 =C2=A0cfg 1. --server &amp; --server-ipv6 *no* CCD files in use<br>
=C2=A0 =C2=A0cfg 2. --ifconfig &amp; --ifconfig-ipv6 CCD files in use<br>
<br>
Reminder: --keep6alive --ping6 etc<br>
See:<br>
<a href=3D"https://forums.openvpn.net/viewtopic.php?f=3D4&amp;t=3D22119#p63=
274" rel=3D"noreferrer" target=3D"_blank">https://forums.openvpn.net/viewto=
pic.php?f=3D4&amp;t=3D22119#p63274</a><br>
<br>
=3D=3D=3D<br>
<br>
<br>
24 hours now with Zero hiccups.<br></blockquote><div><br></div><div>Glad to=
 know.. <br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
Selva,<br>
<br>
If you have any specific tests please send me details.<br></blockquote><div=
><br></div><div>Tasks needing admin access happens early on when the server=
 starts so this looks good especially since you tested ipv6 as well.<br><br=
></div><div>One thing to try:<br></div><div>With the server running, edit t=
he config to change the tunnel network (ip and pool) and issue a SIGHUP to =
re-read the config (reconnect from the GUI status window will do this). The=
 old routes should get torn down (log will show route deletion via service =
succeeded) the ip should change to the new one and new routes get added etc=
.<br><br></div><div>Although not related to the interactive service, you co=
uld also test running the server on a port &lt; 1024. This being windows I =
suppose binding to &quot;privileged&quot; ports doesn&#39;t require admin r=
ights.<br><br></div><div>Thanks,<br><br></div><div>Selva<br></div></div><br=
></div></div>

--94eb2c06623aae3b480539497e87--

