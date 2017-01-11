MIME-Version: 1.0
In-Reply-To: <1484080473-10415-2-git-send-email-davids@...515...>
References: <04b17e24-74d9-193b-ff8d-575efbf4d63a@...2080...>
	<1484080473-10415-1-git-send-email-davids@...515...>
	<1484080473-10415-2-git-send-email-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 11 Jan 2017 14:52:50 -0500
Message-ID: <CAKuzo_joW385+8RFtRO2_gET-uTJET+CdxnpJ=0JE1MjOBFjYw@...278...>
Content-Type: multipart/alternative; boundary=001a113e7bf6508ea80545d6f34d
Subject: Re: [Openvpn-devel] [PATCH 2/2] management: Remove a redundant
	#ifdef block
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113e7bf6508ea80545d6f34d
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 10, 2017 at 3:34 PM, David Sommerseth <davids@...515...>
wrote:

> Bascially removes two independent #ifdef ENABLE_MANAGEMENT blocks into
> a single block, which makes the logic flow more easy to read.
>
> Signed-off-by: David Sommerseth <davids@...515...>
> Cc: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/init.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 4786232..5296345 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -414,11 +414,7 @@ next_connection_entry(struct context *c)
>                  break;
>              }
>          }
> -        else
> -#endif
> -
> -#ifdef ENABLE_MANAGEMENT
> -        if (ce_defined && management && management_query_proxy_enabled
> (management))
> +        else if (ce_defined && management &&
> management_query_proxy_enabled(management))
>          {
>              ce_defined = ce_management_query_proxy(c);
>              if (IS_SIG(c))
>

One more ifdef gone, and good riddance!

ACK.

--001a113e7bf6508ea80545d6f34d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jan 10, 2017 at 3:34 PM, David Sommerseth <span dir=3D"ltr">&lt;<a =
href=3D"mailto:davids@...515..." target=3D"_blank">davids@...515...</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D"m_-481493157181=
0615402:1c5" class=3D"m_-4814931571810615402a3s m_-4814931571810615402aXjCH=
 m_-4814931571810615402m1598a1708233865d">Bascially removes two independent=
 #ifdef ENABLE_MANAGEMENT blocks into<br>
a single block, which makes the logic flow more easy to read.<br>
<br>
Signed-off-by: David Sommerseth &lt;<a href=3D"mailto:davids@...515..." tar=
get=3D"_blank">davids@...515...</a>&gt;<br>
Cc: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank=
">selva.nair@...277...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/init.c | 6 +-----<br>
=C2=A01 file changed, 1 insertion(+), 5 deletions(-)<br>
<br>
diff --git a/src/openvpn/init.c b/src/openvpn/init.c<br>
index 4786232..5296345 100644<br>
--- a/src/openvpn/init.c<br>
+++ b/src/openvpn/init.c<br>
@@ -414,11 +414,7 @@ next_connection_entry(struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-#endif<br>
-<br>
-#ifdef ENABLE_MANAGEMENT<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ce_defined &amp;&amp; management &amp;&amp=
; management_query_proxy_enabled<wbr>(management))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (ce_defined &amp;&amp; management &amp=
;&amp; management_query_proxy_enabled<wbr>(management))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ce_defined =3D ce_managemen=
t_query_proxy(c);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_SIG(c))<div class=3D=
"m_-4814931571810615402yj6qo m_-4814931571810615402ajU"><div id=3D"m_-48149=
31571810615402:4p9" class=3D"m_-4814931571810615402ajR"></div></div></div><=
/blockquote></div><br>One more ifdef gone, and good riddance!</div><div cla=
ss=3D"gmail_extra"><br></div><div class=3D"gmail_extra">ACK.</div></div>

--001a113e7bf6508ea80545d6f34d--

