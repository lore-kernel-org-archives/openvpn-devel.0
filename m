MIME-Version: 1.0
In-Reply-To: <1470943420-15103-1-git-send-email-gert@...1296...>
References: <1470943420-15103-1-git-send-email-gert@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 12 Aug 2016 00:46:37 +0500
Message-ID: <CAFHpkQEUeDsBfDngqg0n9qc_6ZJukknG1eBwBsyGYTBatkO6_w@...278...>
Content-Type: multipart/alternative; boundary=047d7bd91cea2deb8e0539d10698
Subject: Re: [Openvpn-devel] [PATCH] Change timestamps to POSIX format.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7bd91cea2deb8e0539d10698
Content-Type: text/plain; charset=UTF-8

iso 8601 is good format.
it is accepted by default by sql servers, Log Parser


2016-08-12 0:23 GMT+05:00 Gert Doering <gert@...1296...>:

> All our timestams used to be "what ctime()" produces, which is
>
>   "Thu Aug 11 21:15:27 2016"
>
> Changed to use POSIX standard format, which is
>
>   "2016-08-11 21:15:27"
>
> this applies to logging (except to syslog or if --machine-readable-ouput
> is used) and to various other places where informational timestamps are
> produced.  Among these are the status files / status to management
> interface, so applications parsing these time stamp need to be adjusted.
>
> trac#719
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/otime.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
> index 2c1e5b1..c10a6a8 100644
> --- a/src/openvpn/otime.c
> +++ b/src/openvpn/otime.c
> @@ -112,6 +112,7 @@ time_string (time_t t, int usec, bool show_usec,
> struct gc_arena *gc)
>  {
>    struct buffer out = alloc_buf_gc (64, gc);
>    struct timeval tv;
> +  struct tm *tm;
>
>    if (t)
>      {
> @@ -124,8 +125,10 @@ time_string (time_t t, int usec, bool show_usec,
> struct gc_arena *gc)
>      }
>
>    t = tv.tv_sec;
> -  buf_printf (&out, "%s", ctime(&t));
> -  buf_rmtail (&out, '\n');
> +  tm = localtime(&t);
> +  buf_printf (&out, "%04d-%02d-%02d %02d:%02d:%02d",
> +               tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
> +               tm->tm_hour, tm->tm_min, tm->tm_sec );
>
>    if (show_usec && tv.tv_usec)
>      buf_printf (&out, " us=%d", (int)tv.tv_usec);
> --
> 2.7.3
>
>
> ------------------------------------------------------------
> ------------------
> What NetFlow Analyzer can do for you? Monitors network bandwidth and
> traffic
> patterns at an interface-level. Reveals which users, apps, and protocols
> are
> consuming the most bandwidth. Provides multi-vendor support for NetFlow,
> J-Flow, sFlow and other flows. Make informed decisions using capacity
> planning reports. http://sdm.link/zohodev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--047d7bd91cea2deb8e0539d10698
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>iso 8601 is good format.<br></div>it is accepted=
 by default by sql servers, Log Parser<br><br></div></div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">2016-08-12 0:23 GMT+05:00 Gert Doe=
ring <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_bl=
ank">gert@...1296...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">All =
our timestams used to be &quot;what ctime()&quot; produces, which is<br>
<br>
=C2=A0 &quot;Thu Aug 11 21:15:27 2016&quot;<br>
<br>
Changed to use POSIX standard format, which is<br>
<br>
=C2=A0 &quot;2016-08-11 21:15:27&quot;<br>
<br>
this applies to logging (except to syslog or if --machine-readable-ouput<br>
is used) and to various other places where informational timestamps are<br>
produced.=C2=A0 Among these are the status files / status to management<br>
interface, so applications parsing these time stamp need to be adjusted.<br>
<br>
trac#719<br>
<br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...493...=
1296...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/otime.c | 7 +++++--<br>
=C2=A01 file changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c<br>
index 2c1e5b1..c10a6a8 100644<br>
--- a/src/openvpn/otime.c<br>
+++ b/src/openvpn/otime.c<br>
@@ -112,6 +112,7 @@ time_string (time_t t, int usec, bool show_usec, struct=
 gc_arena *gc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0struct buffer out =3D alloc_buf_gc (64, gc);<br>
=C2=A0 =C2=A0struct timeval tv;<br>
+=C2=A0 struct tm *tm;<br>
<br>
=C2=A0 =C2=A0if (t)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -124,8 +125,10 @@ time_string (time_t t, int usec, bool show_usec, struc=
t gc_arena *gc)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0t =3D tv.tv_sec;<br>
-=C2=A0 buf_printf (&amp;out, &quot;%s&quot;, ctime(&amp;t));<br>
-=C2=A0 buf_rmtail (&amp;out, &#39;\n&#39;);<br>
+=C2=A0 tm =3D localtime(&amp;t);<br>
+=C2=A0 buf_printf (&amp;out, &quot;%04d-%02d-%02d %02d:%02d:%02d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tm-&gt;tm_year+1900=
, tm-&gt;tm_mon+1, tm-&gt;tm_mday,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tm-&gt;tm_hour, tm-=
&gt;tm_min, tm-&gt;tm_sec );<br>
<br>
=C2=A0 =C2=A0if (show_usec &amp;&amp; tv.tv_usec)<br>
=C2=A0 =C2=A0 =C2=A0buf_printf (&amp;out, &quot; us=3D%d&quot;, (int)tv.tv_=
usec);<br>
--<br>
2.7.3<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffi=
c<br>
patterns at an interface-level. Reveals which users, apps, and protocols ar=
e<br>
consuming the most bandwidth. Provides multi-vendor support for NetFlow,<br>
J-Flow, sFlow and other flows. Make informed decisions using capacity<br>
planning reports. <a href=3D"http://sdm.link/zohodev2dev" rel=3D"noreferrer=
" target=3D"_blank">http://sdm.link/zohodev2dev</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div><br></div>

--047d7bd91cea2deb8e0539d10698--

