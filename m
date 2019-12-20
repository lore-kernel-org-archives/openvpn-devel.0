MIME-Version: 1.0
References: <20191219223917.1614-1-simon@...2293...>
 <20191219223917.1614-3-simon@...2293...>
In-Reply-To: <20191219223917.1614-3-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 20 Dec 2019 10:42:59 +0200
Message-ID: <CAGyAFMVVTo6t-OML6UJvmEifp_UJULZfb4n3Leobq9eFK7XJyA@...278...>
Content-Type: multipart/alternative; boundary="000000000000d79d86059a1eaa70"
Subject: Re: [Openvpn-devel] [PATCH 3/7] tun.c: make
 wintun_register_ring_buffer() non-fatal on failures
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000d79d86059a1eaa70
Content-Type: text/plain; charset="UTF-8"

Compiled with MSVC, ran under debugger - works as expected.

Acked-by: Lev Stipakov <lstipakov@...277...>

pe 20. jouluk. 2019 klo 0.40 Simon Rozman (simon@...2293...) kirjoitti:

> Wintun allows multiple handles to be opened on it's NDIS device pipe.
> Just by succeeding to open the pipe does not warrant the adapter is
> unused.
>
> When iterating for available Wintun adapter, we will need to try
> registering ring buffers with each one to actually determine which one
> is used and which one is not.
>
> Therefore, a failure to register ring buffers should be detectable, but
> not M_FATAL.
>
> Signed-off-by: Simon Rozman <simon@...2293...>
> ---
>  src/openvpn/tun.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 623ed37b..220dee87 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -5647,11 +5647,12 @@ register_dns_service(const struct tuntap *tt)
>      gc_free(&gc);
>  }
>
> -static void
> +static bool
>  service_register_ring_buffers(const struct tuntap *tt)
>  {
>      HANDLE msg_channel = tt->options.msg_channel;
>      ack_message_t ack;
> +    bool ret = true;
>      struct gc_arena gc = gc_new();
>
>      register_ring_buffers_message_t msg = {
> @@ -5669,13 +5670,13 @@ service_register_ring_buffers(const struct tuntap
> *tt)
>
>      if (!send_msg_iservice(msg_channel, &msg, sizeof(msg), &ack,
> "Register ring buffers"))
>      {
> -        gc_free(&gc);
> -        return;
> +        ret = false;
>      }
>      else if (ack.error_number != NO_ERROR)
>      {
> -        msg(M_FATAL, "Register ring buffers failed using service: %s
> [status=0x%x]",
> +        msg(M_NONFATAL, "Register ring buffers failed using service: %s
> [status=0x%x]",
>              strerror_win32(ack.error_number, &gc), ack.error_number);
> +        ret = false;
>      }
>      else
>      {
> @@ -5683,6 +5684,7 @@ service_register_ring_buffers(const struct tuntap
> *tt)
>      }
>
>      gc_free(&gc);
> +    return ret;
>  }
>
>  void
> @@ -5922,9 +5924,11 @@ tuntap_set_ip_addr(struct tuntap *tt,
>      gc_free(&gc);
>  }
>
> -static void
> +static bool
>  wintun_register_ring_buffer(struct tuntap *tt)
>  {
> +    bool ret = true;
> +
>      tt->wintun_send_ring = (struct tun_ring
> *)MapViewOfFile(tt->wintun_send_ring_handle,
>
>  FILE_MAP_ALL_ACCESS,
>                                                              0,
> @@ -5939,7 +5943,7 @@ wintun_register_ring_buffer(struct tuntap *tt)
>
>      if (tt->options.msg_channel)
>      {
> -        service_register_ring_buffers(tt);
> +        ret = service_register_ring_buffers(tt);
>      }
>      else
>      {
> @@ -5953,13 +5957,16 @@ wintun_register_ring_buffer(struct tuntap *tt)
>              tt->rw_handle.read,
>              tt->rw_handle.write))
>          {
> -            msg(M_FATAL, "ERROR:  Failed to register ring buffers: %lu",
> GetLastError());
> +            msg(M_NONFATAL, "Failed to register ring buffers: %lu",
> GetLastError());
> +            ret = false;
>          }
>          if (!RevertToSelf())
>          {
>              msg(M_FATAL, "ERROR:  RevertToSelf error: %lu",
> GetLastError());
>          }
>      }
> +
> +    return ret;
>  }
>
>  static void
> @@ -6367,7 +6374,10 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>
>      if (tt->wintun)
>      {
> -        wintun_register_ring_buffer(tt);
> +        if (!wintun_register_ring_buffer(tt))
> +        {
> +            msg(M_FATAL, "Failed to register ring buffers");
> +        }
>      }
>      else
>      {
> --
> 2.24.1.windows.2
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


-- 
-Lev

--000000000000d79d86059a1eaa70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Compiled with MSVC, ran under debugger - works as expected=
.<div><br></div><div>Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lstipakov=
@...277...">lstipakov@...277...</a>&gt;</div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">pe 20. jouluk. 2019 klo 0.40 S=
imon Rozman (<a href=3D"mailto:simon@...2293...">simon@...2293...</a>) kirj=
oitti:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Wintun al=
lows multiple handles to be opened on it&#39;s NDIS device pipe.<br>
Just by succeeding to open the pipe does not warrant the adapter is<br>
unused.<br>
<br>
When iterating for available Wintun adapter, we will need to try<br>
registering ring buffers with each one to actually determine which one<br>
is used and which one is not.<br>
<br>
Therefore, a failure to register ring buffers should be detectable, but<br>
not M_FATAL.<br>
<br>
Signed-off-by: Simon Rozman &lt;<a href=3D"mailto:simon@...2293..." target=
=3D"_blank">simon@...2293...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/tun.c | 26 ++++++++++++++++++--------<br>
=C2=A01 file changed, 18 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 623ed37b..220dee87 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -5647,11 +5647,12 @@ register_dns_service(const struct tuntap *tt)<br>
=C2=A0 =C2=A0 =C2=A0gc_free(&amp;gc);<br>
=C2=A0}<br>
<br>
-static void<br>
+static bool<br>
=C2=A0service_register_ring_buffers(const struct tuntap *tt)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0HANDLE msg_channel =3D tt-&gt;options.msg_channel;<br>
=C2=A0 =C2=A0 =C2=A0ack_message_t ack;<br>
+=C2=A0 =C2=A0 bool ret =3D true;<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
<br>
=C2=A0 =C2=A0 =C2=A0register_ring_buffers_message_t msg =3D {<br>
@@ -5669,13 +5670,13 @@ service_register_ring_buffers(const struct tuntap *=
tt)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!send_msg_iservice(msg_channel, &amp;msg, sizeof(ms=
g), &amp;ack, &quot;Register ring buffers&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gc_free(&amp;gc);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else if (ack.error_number !=3D NO_ERROR)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;Register ring buffers faile=
d using service: %s [status=3D0x%x]&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_NONFATAL, &quot;Register ring buffers fa=
iled using service: %s [status=3D0x%x]&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strerror_win32(ack.error_nu=
mber, &amp;gc), ack.error_number);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -5683,6 +5684,7 @@ service_register_ring_buffers(const struct tuntap *tt=
)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0gc_free(&amp;gc);<br>
+=C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
=C2=A0void<br>
@@ -5922,9 +5924,11 @@ tuntap_set_ip_addr(struct tuntap *tt,<br>
=C2=A0 =C2=A0 =C2=A0gc_free(&amp;gc);<br>
=C2=A0}<br>
<br>
-static void<br>
+static bool<br>
=C2=A0wintun_register_ring_buffer(struct tuntap *tt)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 bool ret =3D true;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0tt-&gt;wintun_send_ring =3D (struct tun_ring *)MapViewO=
fFile(tt-&gt;wintun_send_ring_handle,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FILE_M=
AP_ALL_ACCESS,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00,<br>
@@ -5939,7 +5943,7 @@ wintun_register_ring_buffer(struct tuntap *tt)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (tt-&gt;options.msg_channel)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 service_register_ring_buffers(tt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D service_register_ring_buffers(tt);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -5953,13 +5957,16 @@ wintun_register_ring_buffer(struct tuntap *tt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tt-&gt;rw_handle.read,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tt-&gt;rw_handle.write))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;ERROR:=C2=A0 =
Failed to register ring buffers: %lu&quot;, GetLastError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_NONFATAL, &quot;Failed to =
register ring buffers: %lu&quot;, GetLastError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!RevertToSelf())<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_FATAL, &quot;ERROR:=
=C2=A0 RevertToSelf error: %lu&quot;, GetLastError());<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
=C2=A0static void<br>
@@ -6367,7 +6374,10 @@ open_tun(const char *dev, const char *dev_type, cons=
t char *dev_node, struct tun<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (tt-&gt;wintun)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 wintun_register_ring_buffer(tt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!wintun_register_ring_buffer(tt))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;Failed to reg=
ister ring buffers&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-- <br>
2.24.1.windows.2<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000d79d86059a1eaa70--

