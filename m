MIME-Version: 1.0
In-Reply-To: <20171010231130.6832-3-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-3-simon@...2293...>
From: Selva <selva.nair@...277...>
Date: Wed, 11 Oct 2017 22:44:58 -0400
Message-ID: <CAKuzo_h=KGNOMkyJXKD8ih07+zFcd9oRtGN9hwM9QyDQJtwW2w@...278...>
Content-Type: multipart/alternative; boundary="001a11406242defdc0055b508777"
Subject: Re: [Openvpn-devel] [PATCH 03/13] RtlIpv6AddressToStringW() and
 RtlIpv4AddressToStringW() require mstcpip.h
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

--001a11406242defdc0055b508777
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Oct 10, 2017 at 7:11 PM, <simon@...2293...> wrote:

> From: Simon Rozman <simon@...2293...>
>
> ---
>  src/openvpnserv/interactive.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 4b08086..2019d38 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -33,6 +33,7 @@
>  #include <stdio.h>
>  #include <sddl.h>
>  #include <shellapi.h>
> +#include <mstcpip.h>
>
>  #ifdef HAVE_VERSIONHELPERS_H
>  #include <versionhelpers.h>
>

In mingw build mstcpip.h gets pulled-in though ws2tcpip.h but MSDN says to
explicitly include it for RtlIpv4AddressToStringW etc.

Anyway mingw is still happy at least with this order of includes, so looks
good to me.

ACK.

Selva

--001a11406242defdc0055b508777
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div class=3D"gmail_extra"><br><div class=3D"gmail_quot=
e">On Tue, Oct 10, 2017 at 7:11 PM,  <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:simon@...2293..." target=3D"_blank">simon@...2293...</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">From: Simon Rozman &=
lt;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</=
a>&gt;<br>
<br>
---<br>
=C2=A0src/openvpnserv/interactive.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/src/openvpnserv/interactive.<wbr>c b/src/openvpnserv/interacti=
ve.<wbr>c<br>
index 4b08086..2019d38 100644<br>
--- a/src/openvpnserv/interactive.<wbr>c<br>
+++ b/src/openvpnserv/interactive.<wbr>c<br>
@@ -33,6 +33,7 @@<br>
=C2=A0#include &lt;stdio.h&gt;<br>
=C2=A0#include &lt;sddl.h&gt;<br>
=C2=A0#include &lt;shellapi.h&gt;<br>
+#include &lt;mstcpip.h&gt;<br>
<br>
=C2=A0#ifdef HAVE_VERSIONHELPERS_H<br>
=C2=A0#include &lt;versionhelpers.h&gt;<br></blockquote><div><br></div><div=
>In mingw build mstcpip.h gets pulled-in though ws2tcpip.h but MSDN says to=
 explicitly include it for RtlIpv4AddressToStringW etc.</div><div><br></div=
><div>Anyway mingw is still happy at least with this order of includes, so =
looks good to me.</div><div><br></div><div>ACK.</div><div><br>Selva</div></=
div></div></div>

--001a11406242defdc0055b508777--

