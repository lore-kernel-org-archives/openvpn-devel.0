MIME-Version: 1.0
References: <CAGyAFMXBmLQB0XDGHixESqVWj8SksVNvgLtFgv9AfpZTr5r-Qw@...278...>
 <20230406071546.1056-1-lstipakov@...277...>
In-Reply-To: <20230406071546.1056-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 6 Apr 2023 21:16:57 -0400
Message-ID: <CAKuzo_hDpmsYNjdUGE3mq3g00vrwhc0FCtrUuukM1+Mg7=P4Mw@...278...>
Content-Type: multipart/alternative; boundary="000000000000fe88b505f8b4c8b7"
Subject: Re: [Openvpn-devel] [PATCH v2] Support of DNS domain for DHCP-less
 drivers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--000000000000fe88b505f8b4c8b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Apr 6, 2023 at 3:17=E2=80=AFAM Lev Stipakov <lstipakov@...277...> w=
rote:

> From: Lev Stipakov <lev@...515...>
>
> We set DNS domain either via interactve service or DHCP.
> When interactive service is not used, for example,
> when profiles are started by OpenVPNService, this option
> is not working for DCO and wintun.
>
> This implements setting DNS domain via WMIC command,
> similar to implementation in interactive service.
> This is done when:
>
>  - interactive service is not used
>
>  - DHCP is not used (ip-win32 is either NETSH or IPAPI,
>  or IPv4 address is not pushed)
>
> Fixes https://github.com/OpenVPN/openvpn/issues/306
>
> Change-Id: Ic72a4ecd0414c0d7bf013415f52640fd122cb739
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  v2:
>   - remove tuntap_maybe_dhcp() check in ipv6 setup/teardown,
>   because we still need wmic call in this case
>
>   - remove the whole tuntap_maybe_dhcp() function, because
>   let's do refactoring separately
>
>   - rename wmic_do_dns_domain() to do_dns_domain_wmic() to be
>   consistent with do_dns_domain_service()
>
>  src/openvpn/tun.c   | 68 ++++++++++++++++++++++++++++++++++++---------
>  src/openvpn/win32.h |  1 +
>  2 files changed, 56 insertions(+), 13 deletions(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 2ebe4809..2320e8b1 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -84,6 +84,8 @@ static void netsh_set_dns6_servers(const struct in6_addr
> *addr_list,
>
>  static void netsh_command(const struct argv *a, int n, int msglevel);
>
> +static void exec_command(const char *prefix, const struct argv *a, int n,
> int msglevel);
> +
>  static const char *netsh_get_id(const char *dev_node, struct gc_arena
> *gc);
>
>  static bool
> @@ -324,6 +326,22 @@ out:
>      return ret;
>  }
>
> +static void
> +do_dns_domain_wmic(bool add, const struct tuntap *tt)
> +{
> +    if (!tt->options.domain)
> +    {
> +        return;
> +    }
> +
> +    struct argv argv =3D argv_new();
> +    argv_printf(&argv, "%s%s nicconfig where (InterfaceIndex=3D%ld) call
> SetDNSDomain %s",
> +                get_win_sys_path(), WMIC_PATH_SUFFIX, tt->adapter_index,
> add ? tt->options.domain : "");
> +    exec_command("WMIC", &argv, 1, M_WARN);
> +
> +    argv_free(&argv);
> +}
> +
>  #endif /* ifdef _WIN32 */
>
>  #ifdef TARGET_SOLARIS
> @@ -1190,6 +1208,11 @@ do_ifconfig_ipv6(struct tuntap *tt, const char
> *ifname, int tun_mtu,
>          /* set ipv6 dns servers if any are specified */
>          netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len,
> tt->adapter_index);
>          windows_set_mtu(tt->adapter_index, AF_INET6, tun_mtu);
> +
> +        if (!tt->did_ifconfig_setup)
> +        {
> +            do_dns_domain_wmic(true, tt);
> +        }
>      }
>  #else /* platforms we have no IPv6 code for */
>      msg(M_FATAL, "Sorry, but I don't know how to do IPv6 'ifconfig'
> commands on this operating system.  You should ifconfig your TUN/TAP devi=
ce
> manually or use an --up script.");
> @@ -1535,11 +1558,18 @@ do_ifconfig_ipv4(struct tuntap *tt, const char
> *ifname, int tun_mtu,
>          do_dns_service(true, AF_INET, tt);
>          do_dns_domain_service(true, tt);
>      }
> -    else if (tt->options.ip_win32_type =3D=3D IPW32_SET_NETSH)
> +    else
>      {
> -        netsh_ifconfig(&tt->options, tt->adapter_index, tt->local,
> -                       tt->adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);
> +        if (tt->options.ip_win32_type =3D=3D IPW32_SET_NETSH)
> +        {
> +            netsh_ifconfig(&tt->options, tt->adapter_index, tt->local,
> +                           tt->adapter_netmask, NI_IP_NETMASK |
> NI_OPTIONS);
> +        }
> +
> +        do_dns_domain_wmic(true, tt);
>      }
> +
> +
>      if (tt->options.msg_channel)
>      {
>          do_set_mtu_service(tt, AF_INET, tun_mtu);
> @@ -5238,12 +5268,8 @@ dhcp_renew(const struct tuntap *tt)
>      }
>  }
>
> -/*
> - * netsh functions
> - */
> -
>  static void
> -netsh_command(const struct argv *a, int n, int msglevel)
> +exec_command(const char *prefix, const struct argv *a, int n, int
> msglevel)
>  {
>      int i;
>      for (i =3D 0; i < n; ++i)
> @@ -5251,8 +5277,8 @@ netsh_command(const struct argv *a, int n, int
> msglevel)
>          bool status;
>          management_sleep(0);
>          netcmd_semaphore_lock();
> -        argv_msg_prefix(M_INFO, a, "NETSH");
> -        status =3D openvpn_execve_check(a, NULL, 0, "ERROR: netsh command
> failed");
> +        argv_msg_prefix(M_INFO, a, prefix);
> +        status =3D openvpn_execve_check(a, NULL, 0, "ERROR: command
> failed");
>          netcmd_semaphore_release();
>          if (status)
>          {
> @@ -5260,7 +5286,13 @@ netsh_command(const struct argv *a, int n, int
> msglevel)
>          }
>          management_sleep(4);
>      }
> -    msg(msglevel, "NETSH: command failed");
> +    msg(msglevel, "%s: command failed", prefix);
> +}
> +
> +static void
> +netsh_command(const struct argv *a, int n, int msglevel)
> +{
> +    exec_command("NETSH", a, n, msglevel);
>  }
>
>  void
> @@ -6927,6 +6959,11 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ct=
x)
>          }
>          else
>          {
> +            if (!tt->did_ifconfig_setup)
> +            {
> +                do_dns_domain_wmic(false, tt);
> +            }
> +
>              netsh_delete_address_dns(tt, true, &gc);
>          }
>      }
> @@ -6947,9 +6984,14 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ct=
x)
>              do_dns_service(false, AF_INET, tt);
>              do_address_service(false, AF_INET, tt);
>          }
> -        else if (tt->options.ip_win32_type =3D=3D IPW32_SET_NETSH)
> +        else
>          {
> -            netsh_delete_address_dns(tt, false, &gc);
> +            do_dns_domain_wmic(false, tt);
> +
> +            if (tt->options.ip_win32_type =3D=3D IPW32_SET_NETSH)
> +            {
> +                netsh_delete_address_dns(tt, false, &gc);
> +            }
>          }
>      }
>
> diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
> index 72ffb012..36059662 100644
> --- a/src/openvpn/win32.h
> +++ b/src/openvpn/win32.h
> @@ -38,6 +38,7 @@
>  #define WIN_ROUTE_PATH_SUFFIX "\\system32\\route.exe"
>  #define WIN_IPCONFIG_PATH_SUFFIX "\\system32\\ipconfig.exe"
>  #define WIN_NET_PATH_SUFFIX "\\system32\\net.exe"
> +#define WMIC_PATH_SUFFIX "\\system32\\wbem\\wmic.exe"
>
>  /*
>   * Win32-specific OpenVPN code, targeted at the mingw
>

Acked-by: Selva Nair <selva.nair@...277...>

Useful to have in 2.6 as well, as dco is the default now. The changes are
minimal and should not have any side effects.

Did some quick test runs on Win 10 using tap-windows6 and dco drivers with
and without "dhcp-option DOMAIN".

Selva

--000000000000fe88b505f8b4c8b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Apr 6, 2023 at 3:17=E2=80=AFAM Lev Stipakov=
 &lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...493...=
277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_bl=
ank">lev@...515...</a>&gt;<br>
<br>
We set DNS domain either via interactve service or DHCP.<br>
When interactive service is not used, for example,<br>
when profiles are started by OpenVPNService, this option<br>
is not working for DCO and wintun.<br>
<br>
This implements setting DNS domain via WMIC command,<br>
similar to implementation in interactive service.<br>
This is done when:<br>
<br>
=C2=A0- interactive service is not used<br>
<br>
=C2=A0- DHCP is not used (ip-win32 is either NETSH or IPAPI,<br>
=C2=A0or IPv4 address is not pushed)<br>
<br>
Fixes <a href=3D"https://github.com/OpenVPN/openvpn/issues/306" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn/issues/306</a>=
<br>
<br>
Change-Id: Ic72a4ecd0414c0d7bf013415f52640fd122cb739<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0v2:<br>
=C2=A0 - remove tuntap_maybe_dhcp() check in ipv6 setup/teardown,<br>
=C2=A0 because we still need wmic call in this case<br>
<br>
=C2=A0 - remove the whole tuntap_maybe_dhcp() function, because<br>
=C2=A0 let&#39;s do refactoring separately<br>
<br>
=C2=A0 - rename wmic_do_dns_domain() to do_dns_domain_wmic() to be<br>
=C2=A0 consistent with do_dns_domain_service()<br>
<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0| 68 ++++++++++++++++++++++++++++++++++=
++---------<br>
=C2=A0src/openvpn/win32.h |=C2=A0 1 +<br>
=C2=A02 files changed, 56 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 2ebe4809..2320e8b1 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -84,6 +84,8 @@ static void netsh_set_dns6_servers(const struct in6_addr =
*addr_list,<br>
<br>
=C2=A0static void netsh_command(const struct argv *a, int n, int msglevel);=
<br>
<br>
+static void exec_command(const char *prefix, const struct argv *a, int n, =
int msglevel);<br>
+<br>
=C2=A0static const char *netsh_get_id(const char *dev_node, struct gc_arena=
 *gc);<br>
<br>
=C2=A0static bool<br>
@@ -324,6 +326,22 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+static void<br>
+do_dns_domain_wmic(bool add, const struct tuntap *tt)<br>
+{<br>
+=C2=A0 =C2=A0 if (!tt-&gt;options.domain)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 struct argv argv =3D argv_new();<br>
+=C2=A0 =C2=A0 argv_printf(&amp;argv, &quot;%s%s nicconfig where (Interface=
Index=3D%ld) call SetDNSDomain %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_win_sys_path()=
, WMIC_PATH_SUFFIX, tt-&gt;adapter_index, add ? tt-&gt;options.domain : &qu=
ot;&quot;);<br>
+=C2=A0 =C2=A0 exec_command(&quot;WMIC&quot;, &amp;argv, 1, M_WARN);<br>
+<br>
+=C2=A0 =C2=A0 argv_free(&amp;argv);<br>
+}<br>
+<br>
=C2=A0#endif /* ifdef _WIN32 */<br>
<br>
=C2=A0#ifdef TARGET_SOLARIS<br>
@@ -1190,6 +1208,11 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifna=
me, int tun_mtu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set ipv6 dns servers if any are specif=
ied */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netsh_set_dns6_servers(tt-&gt;options.dns=
6, tt-&gt;options.dns6_len, tt-&gt;adapter_index);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0windows_set_mtu(tt-&gt;adapter_index, AF_=
INET6, tun_mtu);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tt-&gt;did_ifconfig_setup)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_dns_domain_wmic(true, tt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#else /* platforms we have no IPv6 code for */<br>
=C2=A0 =C2=A0 =C2=A0msg(M_FATAL, &quot;Sorry, but I don&#39;t know how to d=
o IPv6 &#39;ifconfig&#39; commands on this operating system.=C2=A0 You shou=
ld ifconfig your TUN/TAP device manually or use an --up script.&quot;);<br>
@@ -1535,11 +1558,18 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifn=
ame, int tun_mtu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_dns_service(true, AF_INET, tt);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_dns_domain_service(true, tt);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 else if (tt-&gt;options.ip_win32_type =3D=3D IPW32_SET_NETSH=
)<br>
+=C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 netsh_ifconfig(&amp;tt-&gt;options, tt-&gt;ada=
pter_index, tt-&gt;local,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tt-&gt;adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;options.ip_win32_type =3D=3D IPW32_=
SET_NETSH)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netsh_ifconfig(&amp;tt-&gt;optio=
ns, tt-&gt;adapter_index, tt-&gt;local,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0tt-&gt;adapter_netmask, NI_IP_NETMASK | NI_OPTIONS)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_dns_domain_wmic(true, tt);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (tt-&gt;options.msg_channel)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_set_mtu_service(tt, AF_INET, tun_mtu);=
<br>
@@ -5238,12 +5268,8 @@ dhcp_renew(const struct tuntap *tt)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-/*<br>
- * netsh functions<br>
- */<br>
-<br>
=C2=A0static void<br>
-netsh_command(const struct argv *a, int n, int msglevel)<br>
+exec_command(const char *prefix, const struct argv *a, int n, int msglevel=
)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; n; ++i)<br>
@@ -5251,8 +5277,8 @@ netsh_command(const struct argv *a, int n, int msglev=
el)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool status;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0management_sleep(0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netcmd_semaphore_lock();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 argv_msg_prefix(M_INFO, a, &quot;NETSH&quot;);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D openvpn_execve_check(a, NULL, 0, &q=
uot;ERROR: netsh command failed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 argv_msg_prefix(M_INFO, a, prefix);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D openvpn_execve_check(a, NULL, 0, &q=
uot;ERROR: command failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netcmd_semaphore_release();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
@@ -5260,7 +5286,13 @@ netsh_command(const struct argv *a, int n, int msgle=
vel)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0management_sleep(4);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 msg(msglevel, &quot;NETSH: command failed&quot;);<br>
+=C2=A0 =C2=A0 msg(msglevel, &quot;%s: command failed&quot;, prefix);<br>
+}<br>
+<br>
+static void<br>
+netsh_command(const struct argv *a, int n, int msglevel)<br>
+{<br>
+=C2=A0 =C2=A0 exec_command(&quot;NETSH&quot;, a, n, msglevel);<br>
=C2=A0}<br>
<br>
=C2=A0void<br>
@@ -6927,6 +6959,11 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tt-&gt;did_ifconfig_setup)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_dns_domain_wmic=
(false, tt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netsh_delete_address_dns(tt=
, true, &amp;gc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -6947,9 +6984,14 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_dns_service(false, AF_IN=
ET, tt);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_address_service(false, A=
F_INET, tt);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (tt-&gt;options.ip_win32_type =3D=3D I=
PW32_SET_NETSH)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netsh_delete_address_dns(tt, fal=
se, &amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_dns_domain_wmic(false, tt);<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;options.ip_win32_type=
 =3D=3D IPW32_SET_NETSH)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netsh_delete_addre=
ss_dns(tt, false, &amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h<br>
index 72ffb012..36059662 100644<br>
--- a/src/openvpn/win32.h<br>
+++ b/src/openvpn/win32.h<br>
@@ -38,6 +38,7 @@<br>
=C2=A0#define WIN_ROUTE_PATH_SUFFIX &quot;\\system32\\route.exe&quot;<br>
=C2=A0#define WIN_IPCONFIG_PATH_SUFFIX &quot;\\system32\\ipconfig.exe&quot;=
<br>
=C2=A0#define WIN_NET_PATH_SUFFIX &quot;\\system32\\net.exe&quot;<br>
+#define WMIC_PATH_SUFFIX &quot;\\system32\\wbem\\wmic.exe&quot;<br>
<br>
=C2=A0/*<br>
=C2=A0 * Win32-specific OpenVPN code, targeted at the mingw<br></blockquote=
><div><br></div><div>Acked-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@=
...277..." target=3D"_blank">selva.nair@...277...</a>&gt;<br></div><div><br=
></div><div>Useful to=C2=A0have in 2.6 as well, as dco is the default now. =
The changes are minimal and should not have any side effects.</div><div><br=
></div><div>Did some quick=C2=A0test runs on Win 10 using tap-windows6 and =
dco drivers with and without &quot;dhcp-option DOMAIN&quot;.</div><div><br>=
</div><div>Selva</div></div></div>

--000000000000fe88b505f8b4c8b7--

