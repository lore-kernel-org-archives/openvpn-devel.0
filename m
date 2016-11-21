MIME-Version: 1.0
In-Reply-To: <1479677932-22078-1-git-send-email-selva.nair@...277...>
References: <1479677932-22078-1-git-send-email-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 21 Nov 2016 12:14:49 -0500
Message-ID: <CAKuzo_g_MFYvpHVvqxwV5=xSOcRYhKRSgcCBppBUMvjbdCey+g@...278...>
Content-Type: multipart/alternative; boundary=001a1147bc424493d50541d2cc34
Subject: Re: [Openvpn-devel] [PATCH] Handle --dhcp-option DNS6 on Windows
	using netsh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1147bc424493d50541d2cc34
Content-Type: text/plain; charset=UTF-8

On Sun, Nov 20, 2016 at 4:38 PM, Selva Nair <selva.nair@...277...> wrote:

> TODO: set dns servers using the interactive service
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  doc/openvpn.8         |  5 ++---
>  src/openvpn/options.c | 22 ++++++++++++++--------
>  src/openvpn/tun.c     | 30 ++++++++++++++++++++++++++++++
>  src/openvpn/tun.h     |  3 +++
>  4 files changed, 49 insertions(+), 11 deletions(-)
>

Just realized the dns addresses should be removed when tun is closed (these
statically set server addresses will stick around otherwise). Will send a
v2 after the "stub implementation v2" is merged.

Selva

--001a1147bc424493d50541d2cc34
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Nov 20, 2016 at 4:38 PM, Selva Nair <span dir=3D"ltr">&lt;<a href=
=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D"m_-39662445=
47379690892:259" class=3D"m_-3966244547379690892a3s m_-3966244547379690892a=
XjCH m_-3966244547379690892m15883ad82fc7ab68">TODO: set dns servers using t=
he interactive service<br>
<br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." targe=
t=3D"_blank">selva.nair@...277...</a>&gt;<br>
---<br>
=C2=A0doc/openvpn.8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 ++---<br>
=C2=A0src/openvpn/options.c | 22 ++++++++++++++--------<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0| 30 +++++++++++++++++++++++++++=
+++<br>
=C2=A0src/openvpn/tun.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +++<br>
=C2=A04 files changed, 49 insertions(+), 11 deletions(-)</div></blockquote>=
</div><br>Just realized the dns addresses should be removed when tun is clo=
sed (these statically set server addresses will stick around otherwise). Wi=
ll send a v2 after the &quot;stub implementation v2&quot; is merged.</div><=
div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div><=
/div>

--001a1147bc424493d50541d2cc34--

