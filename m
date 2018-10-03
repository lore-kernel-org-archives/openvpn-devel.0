MIME-Version: 1.0
References: <1538229228-10620-1-git-send-email-selva.nair@...277...>
 <1538510474-27602-1-git-send-email-selva.nair@...277...>
 <1538510474-27602-3-git-send-email-selva.nair@...277...>
In-Reply-To: <1538510474-27602-3-git-send-email-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 3 Oct 2018 12:56:54 +0300
Message-ID: <CAGyAFMWJyNAwmkmj8S2ex=_CJETrhE1yURhu9Rcy0xrKGxmFUA@...278...>
Content-Type: multipart/alternative; boundary="0000000000008b2cd80577500f38"
Subject: Re: [Openvpn-devel] [PATCH 3/3] Refactor sending commands to
 interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000008b2cd80577500f38
Content-Type: text/plain; charset="UTF-8"

Built and tested on VS, works as expected.

ACK.

ti 2. lokak. 2018 klo 23.02 selva.nair@...277... kirjoitti:

> From: Selva Nair <selva.nair@...277...>
>
> Move writing the message buffer to the interactive service pipe and
> reading acknowledgement to a function.
>
> A minor bug in open_tun where the ack data could be read even after
> a communication error is fixed.
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/route.c |  6 +-----
>  src/openvpn/tun.c   | 34 +++++++++-------------------------
>  src/openvpn/win32.c | 27 ++++++++++++++++++++++-----
>  src/openvpn/win32.h |  9 +++++++++
>  4 files changed, 41 insertions(+), 35 deletions(-)
>
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index ff39230..8a3e8b4 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -2991,16 +2991,12 @@ del_route_ipapi(const struct route_ipv4 *r, const
> struct tuntap *tt)
>  static bool
>  do_route_service(const bool add, const route_message_t *rt, const size_t
> size, HANDLE pipe)
>  {
> -    DWORD len;
>      bool ret = false;
>      ack_message_t ack;
>      struct gc_arena gc = gc_new();
>
> -    if (!WriteFile(pipe, rt, size, &len, NULL)
> -        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
> +    if (!send_msg_iservice(pipe, rt, size, &ack, "ROUTE"))
>      {
> -        msg(M_WARN, "ROUTE: could not talk to service: %s [%lu]",
> -            strerror_win32(GetLastError(), &gc), GetLastError());
>          goto out;
>      }
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index a2d5315..948fd17 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -82,7 +82,6 @@ static DWORD get_adapter_index_flexible(const char
> *name);
>  static bool
>  do_address_service(const bool add, const short family, const struct
> tuntap *tt)
>  {
> -    DWORD len;
>      bool ret = false;
>      ack_message_t ack;
>      struct gc_arena gc = gc_new();
> @@ -115,11 +114,8 @@ do_address_service(const bool add, const short
> family, const struct tuntap *tt)
>          addr.prefix_len = tt->netbits_ipv6;
>      }
>
> -    if (!WriteFile(pipe, &addr, sizeof(addr), &len, NULL)
> -        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
> +    if (!send_msg_iservice(pipe, &addr, sizeof(addr), &ack, "TUN"))
>      {
> -        msg(M_WARN, "TUN: could not talk to service: %s [%lu]",
> -            strerror_win32(GetLastError(), &gc), GetLastError());
>          goto out;
>      }
>
> @@ -141,7 +137,6 @@ out:
>  static bool
>  do_dns6_service(bool add, const struct tuntap *tt)
>  {
> -    DWORD len;
>      bool ret = false;
>      ack_message_t ack;
>      struct gc_arena gc = gc_new();
> @@ -185,11 +180,8 @@ do_dns6_service(bool add, const struct tuntap *tt)
>      msg(D_LOW, "%s IPv6 dns servers on '%s' (if_index = %d) using
> service",
>          (add ? "Setting" : "Deleting"), dns.iface.name, dns.iface.index);
>
> -    if (!WriteFile(pipe, &dns, sizeof(dns), &len, NULL)
> -        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
> +    if (!send_msg_iservice(pipe, &dns, sizeof(dns), &ack, "TUN"))
>      {
> -        msg(M_WARN, "TUN: could not talk to service: %s [%lu]",
> -            strerror_win32(GetLastError(), &gc), GetLastError());
>          goto out;
>      }
>
> @@ -5222,11 +5214,8 @@ service_enable_dhcp(const struct tuntap *tt)
>          .iface = { .index = tt->adapter_index, .name = "" }
>      };
>
> -    if (!WriteFile(pipe, &dhcp, sizeof(dhcp), &len, NULL)
> -        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
> +    if (!send_msg_iservice(pipe, &dhcp, sizeof(dhcp), &ack,
> "Enable_dhcp"))
>      {
> -        msg(M_WARN, "Enable_dhcp: could not talk to service: %s [%lu]",
> -            strerror_win32(GetLastError(), &gc), GetLastError());
>          goto out;
>      }
>
> @@ -5461,18 +5450,16 @@ fork_dhcp_action(struct tuntap *tt)
>  static void
>  register_dns_service(const struct tuntap *tt)
>  {
> -    DWORD len;
>      HANDLE msg_channel = tt->options.msg_channel;
>      ack_message_t ack;
>      struct gc_arena gc = gc_new();
>
>      message_header_t rdns = { msg_register_dns, sizeof(message_header_t),
> 0 };
>
> -    if (!WriteFile(msg_channel, &rdns, sizeof(rdns), &len, NULL)
> -        || !ReadFile(msg_channel, &ack, sizeof(ack), &len, NULL))
> +    if (!send_msg_iservice(msg_channel, &rdns, sizeof(rdns), &ack,
> "Register_dns"))
>      {
> -        msg(M_WARN, "Register_dns: could not talk to service: %s
> [status=0x%lx]",
> -            strerror_win32(GetLastError(), &gc), GetLastError());
> +        gc_free(&gc);
> +        return;
>      }
>
>      else if (ack.error_number != NO_ERROR)
> @@ -5936,14 +5923,11 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>                      .iface = { .index = index, .name = "" }
>                  };
>
> -                if (!WriteFile(tt->options.msg_channel, &msg,
> sizeof(msg), &len, NULL)
> -                    || !ReadFile(tt->options.msg_channel, &ack,
> sizeof(ack), &len, NULL))
> +                if (send_msg_iservice(tt->options.msg_channel, &msg,
> sizeof(msg),
> +                    &ack, "TUN"))
>                  {
> -                    msg(M_WARN, "TUN: could not talk to service: %s
> [%lu]",
> -                        strerror_win32(GetLastError(), &gc),
> GetLastError());
> +                    status = ack.error_number;
>                  }
> -
> -                status = ack.error_number;
>              }
>              else
>              {
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index 3905524..e43296e 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -1264,7 +1264,6 @@ win_get_tempdir(void)
>  static bool
>  win_block_dns_service(bool add, int index, const HANDLE pipe)
>  {
> -    DWORD len;
>      bool ret = false;
>      ack_message_t ack;
>      struct gc_arena gc = gc_new();
> @@ -1278,11 +1277,8 @@ win_block_dns_service(bool add, int index, const
> HANDLE pipe)
>          .iface = { .index = index, .name = "" }
>      };
>
> -    if (!WriteFile(pipe, &data, sizeof(data), &len, NULL)
> -        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
> +    if (!send_msg_iservice(pipe, &data, sizeof(data), &ack, "Block_DNS"))
>      {
> -        msg(M_WARN, "Block_DNS: could not talk to service: %s [%lu]",
> -            strerror_win32(GetLastError(), &gc), GetLastError());
>          goto out;
>      }
>
> @@ -1473,4 +1469,25 @@ win32_version_string(struct gc_arena *gc, bool
> add_name)
>      return (const char *)out.data;
>  }
>
> +bool
> +send_msg_iservice(HANDLE pipe, const void *data, size_t size,
> +                  ack_message_t *ack, const char *context)
> +{
> +    struct gc_arena gc = gc_new();
> +    DWORD len;
> +    bool ret = true;
> +
> +    if (!WriteFile(pipe, data, size, &len, NULL)
> +        || !ReadFile(pipe, ack, sizeof(*ack), &len, NULL))
> +    {
> +        msg(M_WARN, "%s: could not talk to service: %s [%lu]",
> +            context? context : "Unknown",
> +            strerror_win32(GetLastError(), &gc), GetLastError());
> +        ret = false;
> +    }
> +
> +    gc_free(&gc);
> +    return ret;
> +}
> +
>  #endif /* ifdef _WIN32 */
> diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
> index 4b99a5e..b5cbe25 100644
> --- a/src/openvpn/win32.h
> +++ b/src/openvpn/win32.h
> @@ -26,6 +26,7 @@
>  #define OPENVPN_WIN32_H
>
>  #include "mtu.h"
> +#include "openvpn-msg.h"
>
>  /* location of executables */
>  #define SYS_PATH_ENV_VAR_NAME "SystemRoot"  /* environmental variable
> name that normally contains the system path */
> @@ -307,5 +308,13 @@ int win32_version_info(void);
>   */
>  const char *win32_version_string(struct gc_arena *gc, bool add_name);
>
> +/*
> + * Send the |size| bytes in buffer |data| to the interactive service
> |pipe|
> + * and read the result in |ack|. Returns false on communication error.
> + * The string in |context| is used to prefix error messages.
> + */
> +bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,
> +                       ack_message_t *ack, const char *context);
> +
>  #endif /* ifndef OPENVPN_WIN32_H */
>  #endif /* ifdef _WIN32 */
> --
> 2.1.4
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

--0000000000008b2cd80577500f38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Built and tested on VS, works as expected.<div><br></div><=
div>ACK.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">ti 2. l=
okak. 2018 klo 23.02 <a href=3D"mailto:selva.nair@...277...">selva.nair@...493...=
277...</a> kirjoitti:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Selva N=
air &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nai=
r@...277...</a>&gt;<br>
<br>
Move writing the message buffer to the interactive service pipe and<br>
reading acknowledgement to a function.<br>
<br>
A minor bug in open_tun where the ack data could be read even after<br>
a communication error is fixed.<br>
<br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." targe=
t=3D"_blank">selva.nair@...277...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/route.c |=C2=A0 6 +-----<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0| 34 +++++++++-------------------------=
<br>
=C2=A0src/openvpn/win32.c | 27 ++++++++++++++++++++++-----<br>
=C2=A0src/openvpn/win32.h |=C2=A0 9 +++++++++<br>
=C2=A04 files changed, 41 insertions(+), 35 deletions(-)<br>
<br>
diff --git a/src/openvpn/route.c b/src/openvpn/route.c<br>
index ff39230..8a3e8b4 100644<br>
--- a/src/openvpn/route.c<br>
+++ b/src/openvpn/route.c<br>
@@ -2991,16 +2991,12 @@ del_route_ipapi(const struct route_ipv4 *r, const s=
truct tuntap *tt)<br>
=C2=A0static bool<br>
=C2=A0do_route_service(const bool add, const route_message_t *rt, const siz=
e_t size, HANDLE pipe)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 DWORD len;<br>
=C2=A0 =C2=A0 =C2=A0bool ret =3D false;<br>
=C2=A0 =C2=A0 =C2=A0ack_message_t ack;<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
<br>
-=C2=A0 =C2=A0 if (!WriteFile(pipe, rt, size, &amp;len, NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !ReadFile(pipe, &amp;ack, sizeof(ack), &amp=
;len, NULL))<br>
+=C2=A0 =C2=A0 if (!send_msg_iservice(pipe, rt, size, &amp;ack, &quot;ROUTE=
&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;ROUTE: could not talk to ser=
vice: %s [%lu]&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror_win32(GetLastError(), &=
amp;gc), GetLastError());<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index a2d5315..948fd17 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -82,7 +82,6 @@ static DWORD get_adapter_index_flexible(const char *name)=
;<br>
=C2=A0static bool<br>
=C2=A0do_address_service(const bool add, const short family, const struct t=
untap *tt)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 DWORD len;<br>
=C2=A0 =C2=A0 =C2=A0bool ret =3D false;<br>
=C2=A0 =C2=A0 =C2=A0ack_message_t ack;<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
@@ -115,11 +114,8 @@ do_address_service(const bool add, const short family,=
 const struct tuntap *tt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr.prefix_len =3D tt-&gt;netbits_ipv6;<=
br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!WriteFile(pipe, &amp;addr, sizeof(addr), &amp;len, NULL=
)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !ReadFile(pipe, &amp;ack, sizeof(ack), &amp=
;len, NULL))<br>
+=C2=A0 =C2=A0 if (!send_msg_iservice(pipe, &amp;addr, sizeof(addr), &amp;a=
ck, &quot;TUN&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;TUN: could not talk to servi=
ce: %s [%lu]&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror_win32(GetLastError(), &=
amp;gc), GetLastError());<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -141,7 +137,6 @@ out:<br>
=C2=A0static bool<br>
=C2=A0do_dns6_service(bool add, const struct tuntap *tt)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 DWORD len;<br>
=C2=A0 =C2=A0 =C2=A0bool ret =3D false;<br>
=C2=A0 =C2=A0 =C2=A0ack_message_t ack;<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
@@ -185,11 +180,8 @@ do_dns6_service(bool add, const struct tuntap *tt)<br>
=C2=A0 =C2=A0 =C2=A0msg(D_LOW, &quot;%s IPv6 dns servers on &#39;%s&#39; (i=
f_index =3D %d) using service&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(add ? &quot;Setting&quot; : &quot;Deleti=
ng&quot;), <a href=3D"http://dns.iface.name" rel=3D"noreferrer" target=3D"_=
blank">dns.iface.name</a>, dns.iface.index);<br>
<br>
-=C2=A0 =C2=A0 if (!WriteFile(pipe, &amp;dns, sizeof(dns), &amp;len, NULL)<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !ReadFile(pipe, &amp;ack, sizeof(ack), &amp=
;len, NULL))<br>
+=C2=A0 =C2=A0 if (!send_msg_iservice(pipe, &amp;dns, sizeof(dns), &amp;ack=
, &quot;TUN&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;TUN: could not talk to servi=
ce: %s [%lu]&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror_win32(GetLastError(), &=
amp;gc), GetLastError());<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -5222,11 +5214,8 @@ service_enable_dhcp(const struct tuntap *tt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iface =3D { .index =3D tt-&gt;adapter_in=
dex, .name =3D &quot;&quot; }<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
-=C2=A0 =C2=A0 if (!WriteFile(pipe, &amp;dhcp, sizeof(dhcp), &amp;len, NULL=
)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !ReadFile(pipe, &amp;ack, sizeof(ack), &amp=
;len, NULL))<br>
+=C2=A0 =C2=A0 if (!send_msg_iservice(pipe, &amp;dhcp, sizeof(dhcp), &amp;a=
ck, &quot;Enable_dhcp&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;Enable_dhcp: could not talk =
to service: %s [%lu]&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror_win32(GetLastError(), &=
amp;gc), GetLastError());<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -5461,18 +5450,16 @@ fork_dhcp_action(struct tuntap *tt)<br>
=C2=A0static void<br>
=C2=A0register_dns_service(const struct tuntap *tt)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 DWORD len;<br>
=C2=A0 =C2=A0 =C2=A0HANDLE msg_channel =3D tt-&gt;options.msg_channel;<br>
=C2=A0 =C2=A0 =C2=A0ack_message_t ack;<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
<br>
=C2=A0 =C2=A0 =C2=A0message_header_t rdns =3D { msg_register_dns, sizeof(me=
ssage_header_t), 0 };<br>
<br>
-=C2=A0 =C2=A0 if (!WriteFile(msg_channel, &amp;rdns, sizeof(rdns), &amp;le=
n, NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !ReadFile(msg_channel, &amp;ack, sizeof(ack=
), &amp;len, NULL))<br>
+=C2=A0 =C2=A0 if (!send_msg_iservice(msg_channel, &amp;rdns, sizeof(rdns),=
 &amp;ack, &quot;Register_dns&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;Register_dns: could not talk=
 to service: %s [status=3D0x%lx]&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror_win32(GetLastError(), &=
amp;gc), GetLastError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gc_free(&amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0else if (ack.error_number !=3D NO_ERROR)<br>
@@ -5936,14 +5923,11 @@ open_tun(const char *dev, const char *dev_type, con=
st char *dev_node, struct tun<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.iface =3D { .index =3D index, .name =3D &quot;&quot; }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!WriteFile(tt-=
&gt;options.msg_channel, &amp;msg, sizeof(msg), &amp;len, NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || !=
ReadFile(tt-&gt;options.msg_channel, &amp;ack, sizeof(ack), &amp;len, NULL)=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (send_msg_iserv=
ice(tt-&gt;options.msg_channel, &amp;msg, sizeof(msg),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;ack, &quot;TUN&quot;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
M_WARN, &quot;TUN: could not talk to service: %s [%lu]&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 strerror_win32(GetLastError(), &amp;gc), GetLastError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stat=
us =3D ack.error_number;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D ack.err=
or_number;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c<br>
index 3905524..e43296e 100644<br>
--- a/src/openvpn/win32.c<br>
+++ b/src/openvpn/win32.c<br>
@@ -1264,7 +1264,6 @@ win_get_tempdir(void)<br>
=C2=A0static bool<br>
=C2=A0win_block_dns_service(bool add, int index, const HANDLE pipe)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 DWORD len;<br>
=C2=A0 =C2=A0 =C2=A0bool ret =3D false;<br>
=C2=A0 =C2=A0 =C2=A0ack_message_t ack;<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
@@ -1278,11 +1277,8 @@ win_block_dns_service(bool add, int index, const HAN=
DLE pipe)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iface =3D { .index =3D index, .name =3D =
&quot;&quot; }<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
-=C2=A0 =C2=A0 if (!WriteFile(pipe, &amp;data, sizeof(data), &amp;len, NULL=
)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !ReadFile(pipe, &amp;ack, sizeof(ack), &amp=
;len, NULL))<br>
+=C2=A0 =C2=A0 if (!send_msg_iservice(pipe, &amp;data, sizeof(data), &amp;a=
ck, &quot;Block_DNS&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;Block_DNS: could not talk to=
 service: %s [%lu]&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror_win32(GetLastError(), &=
amp;gc), GetLastError());<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1473,4 +1469,25 @@ win32_version_string(struct gc_arena *gc, bool add_n=
ame)<br>
=C2=A0 =C2=A0 =C2=A0return (const char *)out.data;<br>
=C2=A0}<br>
<br>
+bool<br>
+send_msg_iservice(HANDLE pipe, const void *data, size_t size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ack_message=
_t *ack, const char *context)<br>
+{<br>
+=C2=A0 =C2=A0 struct gc_arena gc =3D gc_new();<br>
+=C2=A0 =C2=A0 DWORD len;<br>
+=C2=A0 =C2=A0 bool ret =3D true;<br>
+<br>
+=C2=A0 =C2=A0 if (!WriteFile(pipe, data, size, &amp;len, NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !ReadFile(pipe, ack, sizeof(*ack), &amp;len=
, NULL))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;%s: could not talk to servic=
e: %s [%lu]&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 context? context : &quot;Unknown=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror_win32(GetLastError(), &=
amp;gc), GetLastError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 gc_free(&amp;gc);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
=C2=A0#endif /* ifdef _WIN32 */<br>
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h<br>
index 4b99a5e..b5cbe25 100644<br>
--- a/src/openvpn/win32.h<br>
+++ b/src/openvpn/win32.h<br>
@@ -26,6 +26,7 @@<br>
=C2=A0#define OPENVPN_WIN32_H<br>
<br>
=C2=A0#include &quot;mtu.h&quot;<br>
+#include &quot;openvpn-msg.h&quot;<br>
<br>
=C2=A0/* location of executables */<br>
=C2=A0#define SYS_PATH_ENV_VAR_NAME &quot;SystemRoot&quot;=C2=A0 /* environ=
mental variable name that normally contains the system path */<br>
@@ -307,5 +308,13 @@ int win32_version_info(void);<br>
=C2=A0 */<br>
=C2=A0const char *win32_version_string(struct gc_arena *gc, bool add_name);=
<br>
<br>
+/*<br>
+ * Send the |size| bytes in buffer |data| to the interactive service |pipe=
|<br>
+ * and read the result in |ack|. Returns false on communication error.<br>
+ * The string in |context| is used to prefix error messages.<br>
+ */<br>
+bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ack_message_t *ack, const char *context);<br>
+<br>
=C2=A0#endif /* ifndef OPENVPN_WIN32_H */<br>
=C2=A0#endif /* ifdef _WIN32 */<br>
-- <br>
2.1.4<br>
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
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature">-Lev</div>

--0000000000008b2cd80577500f38--

