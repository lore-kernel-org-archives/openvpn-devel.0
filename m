MIME-Version: 1.0
In-Reply-To: <56C2F17D.5020903@...277...>
References: <56C2E0DD.3050707@...515...> <56C2F17D.5020903@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 16 Feb 2016 10:11:59 -0500
Message-ID: <CAKuzo_j227mZbd1G7nMpUXAxTJTB9zEqMQJAJdF4oHDi0rXM2w@...278...>
Content-Type: multipart/alternative; boundary=001a1140f40030ae14052be48f7f
Subject: Re: [Openvpn-devel] --block-outside-dns speed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1140f40030ae14052be48f7f
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, Feb 16, 2016 at 4:53 AM, Lev Stipakov <lstipakov@...277...> wrote:

> Hi James,
>
> > Has anyone seen issues with --block-outside-dns speed?  Because this
> > approach drops certain DNS packets, I'm wondering if apps will
> > experience lag time while waiting for dropped DNS requests to time out.
>
> Yes, I have experienced issues with that patch.
>
> On only machine I was able to reproduce DNS leak, this patch causes
> _all_ DNS requests to take 10 seconds to execute. According to
> Wireshark, Windows sends DNS requests to all adapters, got fast response
> from "right one", but nevertheless waits for about 10 seconds before
> giving up.
>

On the contrary, on the only win10 machine I had tested this, there was no
apparent delay in resolution. Unlike Lev, I see DNS requests to all
interfaces on wireshark only when --block-outside-dns is _not_ used. When
blocked, the only DNS traffic seen on wireshark was through the TAP
interface. That looked right as the packets are dropped before they reach
the wireshark hooks, I suppose..

Anyway, the dns client service may still expect replies to those lost
packets, but no apparent name resolution delay in applications was seen.

However, I did not test programs that directly connect to the dns servers
(e.g., nslookup) instead of using the dns client service.

Selva

--001a1140f40030ae14052be48f7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, Feb 16, 2016 at 4:53 AM, Lev St=
ipakov <span dir=3D"ltr">&lt;<a href=3D"mailto:lstipakov@...277..." target=
=3D"_blank">lstipakov@...277...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div id=3D":by5" class=3D"a3s" style=3D"overflow:hidden">Hi J=
ames,<br>
<span class=3D""><br>
&gt; Has anyone seen issues with --block-outside-dns speed?=C2=A0 Because t=
his<br>
&gt; approach drops certain DNS packets, I&#39;m wondering if apps will<br>
&gt; experience lag time while waiting for dropped DNS requests to time out=
.<br>
<br>
</span>Yes, I have experienced issues with that patch.<br>
<br>
On only machine I was able to reproduce DNS leak, this patch causes<br>
_all_ DNS requests to take 10 seconds to execute. According to<br>
Wireshark, Windows sends DNS requests to all adapters, got fast response<br>
from &quot;right one&quot;, but nevertheless waits for about 10 seconds bef=
ore<br>
giving up.</div></blockquote></div><div class=3D"gmail_extra"><br></div>On =
the contrary, on the only win10 machine I had tested this, there was no app=
arent delay in resolution. Unlike Lev, I see DNS requests to all interfaces=
 on wireshark only when --block-outside-dns is _not_ used. When blocked, th=
e only DNS traffic seen on wireshark was through the TAP interface. That lo=
oked right as the packets are dropped before they reach the wireshark hooks=
, I suppose..</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail=
_extra">Anyway, the dns client service may still expect replies to those lo=
st packets, but no apparent name resolution delay in applications was seen.=
</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Howev=
er, I did not test programs that directly connect to the dns servers (e.g.,=
 nslookup) instead of using the dns client service.</div><div class=3D"gmai=
l_extra"><br></div><div class=3D"gmail_extra">Selva</div></div>

--001a1140f40030ae14052be48f7f--

