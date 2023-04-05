MIME-Version: 1.0
References: <20230404075931.840-1-lstipakov@...277...>
In-Reply-To: <20230404075931.840-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 5 Apr 2023 14:44:26 -0400
Message-ID: <CAKuzo_hx9rqbMMV+EidpSe5-myQppMfbQXaYN0ikAkSSWtOi-w@...278...>
Content-Type: multipart/alternative; boundary="0000000000006e64a905f89b2f18"
Subject: Re: [Openvpn-devel] [PATCH] Support of DNS domain for DHCP-less
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

--0000000000006e64a905f89b2f18
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 4, 2023 at 4:01=E2=80=AFAM Lev Stipakov <lstipakov@...277...> w=
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
>  - ip_win32_type is either METSH or IPAPI, which is
> the case for DCO and wintun.
>
> Fixes https://github.com/OpenVPN/openvpn/issues/306
>
> Change-Id: I9ab51bf1c0774564204c75ecce9ebfb818db2f5b
> ---
>  src/openvpn/options.c |  8 ++---
>  src/openvpn/tun.c     | 72 ++++++++++++++++++++++++++++++++++---------
>  src/openvpn/tun.h     |  6 ++++
>  src/openvpn/win32.h   |  1 +
>  4 files changed, 67 insertions(+), 20 deletions(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 2680f268..36d54ceb 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3396,11 +3396,11 @@ options_postprocess_mutate_invariant(struct
> options *options)
>  #ifdef _WIN32
>      const int dev =3D dev_type_enum(options->dev, options->dev_type);
>
> +    const bool dhcp =3D tuntap_maybe_dhcp(&options->tuntap_options);
> +
>      /* when using wintun/ovpn-dco, kernel doesn't send DHCP requests, so
> don't use it */
>      if ((options->windows_driver =3D=3D WINDOWS_DRIVER_WINTUN
> -         || options->windows_driver =3D=3D WINDOWS_DRIVER_DCO)
> -        && (options->tuntap_options.ip_win32_type =3D=3D IPW32_SET_DHCP_=
MASQ
> -            || options->tuntap_options.ip_win32_type =3D=3D
> IPW32_SET_ADAPTIVE))
> +         || options->windows_driver =3D=3D WINDOWS_DRIVER_DCO) && dhcp)
>      {
>          options->tuntap_options.ip_win32_type =3D IPW32_SET_NETSH;
>      }
> @@ -3408,8 +3408,6 @@ options_postprocess_mutate_invariant(struct options
> *options)
>      if ((dev =3D=3D DEV_TYPE_TUN || dev =3D=3D DEV_TYPE_TAP) &&
> !options->route_delay_defined)
>      {
>          /* delay may only be necessary when we perform DHCP handshake */
> -        const bool dhcp =3D (options->tuntap_options.ip_win32_type =3D=3D
> IPW32_SET_DHCP_MASQ)
> -                          || (options->tuntap_options.ip_win32_type =3D=
=3D
> IPW32_SET_ADAPTIVE);
>          if ((options->mode =3D=3D MODE_POINT_TO_POINT) && dhcp)
>          {
>              options->route_delay_defined =3D true;
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 2ebe4809..c2cc7e26 100644
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
> +wmic_do_dns_domain(bool add, const struct tuntap *tt)
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
> +        if (!tt->did_ifconfig_setup && !tuntap_maybe_dhcp(&tt->options))
>

Adding "!tuntap_maybe_dhcp()" here looks wrong. We must set the domain if
not set during IPv4 processing and that is indicated by did_ifconfig_setup.
Just as done in the case handled by interactive-service above.

For example: in case there is no IPv4 address, the domain will not be set
at this point but tuntap_may_dhcp() could still be true if the driver is
tap-windows6. And the above will wrongly skip the wmic call. Even
otherwise, adding a seemingly dhcp-related check in IPv6 case will only
confuse us in future.

Same in close_tun() to match.

Once that check is removed there is no need to introduce
tuntap_maybe_dhcp() in this patch at all. This can be kept simple by just
adding wmic_do_dns_domain() and calling it in two places under the same
conditions as done using service. Plus the netsh_command() to
exec_command() generalization. That makes it easier to review as well.

As for refactoring/cleaning up, we can address it separately as the whole
ip-win32 thing is a mess that could benefit from a thorough cleanup.

+        {
> +            wmic_do_dns_domain(true, tt);
> +        }
>      }
>  #else /* platforms we have no IPv6 code for */
>      msg(M_FATAL, "Sorry, but I don't know how to do IPv6 'ifconfig'
> commands on this operating system.  You should ifconfig your TUN/TAP devi=
ce
> manually or use an --up script.");
> @@ -1525,7 +1548,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char
> *ifname, int tun_mtu,
>              ifname, ifconfig_local,
>              ifconfig_remote_netmask);
>      }
> -    else if (tt->options.ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ ||
> tt->options.ip_win32_type =3D=3D IPW32_SET_ADAPTIVE)
> +    else if (tuntap_maybe_dhcp(&tt->options))
>      {
>          /* Let the DHCP configure the interface. */
>      }
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
> +        wmic_do_dns_domain(true, tt);
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
> +            if (!tt->did_ifconfig_setup &&
> !tuntap_maybe_dhcp(&tt->options))
>

same here


> +            {
> +                wmic_do_dns_domain(false, tt);
> +            }
> +
>              netsh_delete_address_dns(tt, true, &gc);
>          }
>      }
> @@ -6937,7 +6974,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
>          {
>              /* We didn't do ifconfig. */
>          }
> -        else if (tt->options.ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ ||
> tt->options.ip_win32_type =3D=3D IPW32_SET_ADAPTIVE)
> +        else if (tuntap_maybe_dhcp(&tt->options))
>          {
>              /* We don't have to clean the configuration with DHCP. */
>          }
> @@ -6947,9 +6984,14 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ct=
x)
>              do_dns_service(false, AF_INET, tt);
>              do_address_service(false, AF_INET, tt);
>          }
> -        else if (tt->options.ip_win32_type =3D=3D IPW32_SET_NETSH)
> +        else
>          {
> -            netsh_delete_address_dns(tt, false, &gc);
> +            wmic_do_dns_domain(false, tt);
> +
> +            if (tt->options.ip_win32_type =3D=3D IPW32_SET_NETSH)
> +            {
> +                netsh_delete_address_dns(tt, false, &gc);
> +            }
>          }
>      }
>
> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
> index e19e1a2e..0d8e2307 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -668,6 +668,12 @@ tuntap_is_dco_win_timeout(struct tuntap *tt, int
> status)
>  const char *
>  print_windows_driver(enum windows_driver_type windows_driver);
>
> +static inline bool
> +tuntap_maybe_dhcp(struct tuntap_options *o)
> +{
> +    return o->ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ || o->ip_win32_ty=
pe =3D=3D
> IPW32_SET_ADAPTIVE;
> +}
> +
>  #else  /* ifdef _WIN32 */
>
>  static inline bool
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
> --
> 2.23.0.windows.1


Selva

--0000000000006e64a905f89b2f18
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Apr 4, 2023 at 4:01=E2=80=AFAM Lev Stipako=
v &lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...1186...=
.277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_b=
lank">lev@...515...</a>&gt;<br>
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
=C2=A0- ip_win32_type is either METSH or IPAPI, which is<br>
the case for DCO and wintun.<br>
<br>
Fixes <a href=3D"https://github.com/OpenVPN/openvpn/issues/306" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn/issues/306</a>=
<br>
<br>
Change-Id: I9ab51bf1c0774564204c75ecce9ebfb818db2f5b<br>
---<br>
=C2=A0src/openvpn/options.c |=C2=A0 8 ++---<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0| 72 +++++++++++++++++++++++++++=
+++++++---------<br>
=C2=A0src/openvpn/tun.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++++<br>
=C2=A0src/openvpn/win32.h=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A04 files changed, 67 insertions(+), 20 deletions(-)<br>
<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index 2680f268..36d54ceb 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -3396,11 +3396,11 @@ options_postprocess_mutate_invariant(struct options=
 *options)<br>
=C2=A0#ifdef _WIN32<br>
=C2=A0 =C2=A0 =C2=A0const int dev =3D dev_type_enum(options-&gt;dev, option=
s-&gt;dev_type);<br>
<br>
+=C2=A0 =C2=A0 const bool dhcp =3D tuntap_maybe_dhcp(&amp;options-&gt;tunta=
p_options);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* when using wintun/ovpn-dco, kernel doesn&#39;t send =
DHCP requests, so don&#39;t use it */<br>
=C2=A0 =C2=A0 =C2=A0if ((options-&gt;windows_driver =3D=3D WINDOWS_DRIVER_W=
INTUN<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| options-&gt;windows_driver =3D=3D WIN=
DOWS_DRIVER_DCO)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; (options-&gt;tuntap_options.ip_win3=
2_type =3D=3D IPW32_SET_DHCP_MASQ<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || options-&gt;tuntap_options.ip=
_win32_type =3D=3D IPW32_SET_ADAPTIVE))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| options-&gt;windows_driver =3D=3D WIN=
DOWS_DRIVER_DCO) &amp;&amp; dhcp)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;tuntap_options.ip_win32_type =
=3D IPW32_SET_NETSH;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -3408,8 +3408,6 @@ options_postprocess_mutate_invariant(struct options *=
options)<br>
=C2=A0 =C2=A0 =C2=A0if ((dev =3D=3D DEV_TYPE_TUN || dev =3D=3D DEV_TYPE_TAP=
) &amp;&amp; !options-&gt;route_delay_defined)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* delay may only be necessary when we pe=
rform DHCP handshake */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const bool dhcp =3D (options-&gt;tuntap_option=
s.ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 || (options-&gt;tuntap_options.ip_win32_type =3D=3D IPW32=
_SET_ADAPTIVE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((options-&gt;mode =3D=3D MODE_POINT_T=
O_POINT) &amp;&amp; dhcp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;route_delay_def=
ined =3D true;<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 2ebe4809..c2cc7e26 100644<br>
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
+wmic_do_dns_domain(bool add, const struct tuntap *tt)<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tt-&gt;did_ifconfig_setup &amp;&amp; !tun=
tap_maybe_dhcp(&amp;tt-&gt;options))<br></blockquote><div><br></div><div>Ad=
ding &quot;!tuntap_maybe_dhcp()&quot; here looks wrong. We must set the dom=
ain if not set=C2=A0during IPv4 processing and that is indicated by did_ifc=
onfig_setup. Just as done in the case handled by interactive-service above.=
<br></div><div><br></div><div>For example: in case there is no IPv4 address=
, the domain will not be set at this point but tuntap_may_dhcp() could stil=
l be true if the driver is tap-windows6. And the above will wrongly skip th=
e wmic call. Even otherwise, adding a seemingly dhcp-related check in IPv6 =
case will only confuse=C2=A0us in=C2=A0future.</div><div><br></div><div>Sam=
e in close_tun() to match.</div><div><br></div><div>Once that check is remo=
ved there is no need to introduce tuntap_maybe_dhcp() in this patch at all.=
 This can be kept simple by just adding wmic_do_dns_domain() and calling it=
 in two places under the same conditions as done using service. Plus the ne=
tsh_command() to exec_command() generalization. That makes it easier to rev=
iew as well.</div><div><br></div><div>As for refactoring/cleaning up, we ca=
n address it separately as the whole ip-win32 thing is a mess that could be=
nefit from a thorough cleanup.</div><div><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wmic_do_dns_domain(true, tt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#else /* platforms we have no IPv6 code for */<br>
=C2=A0 =C2=A0 =C2=A0msg(M_FATAL, &quot;Sorry, but I don&#39;t know how to d=
o IPv6 &#39;ifconfig&#39; commands on this operating system.=C2=A0 You shou=
ld ifconfig your TUN/TAP device manually or use an --up script.&quot;);<br>
@@ -1525,7 +1548,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifnam=
e, int tun_mtu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ifname, ifconfig_local,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ifconfig_remote_netmask);<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 else if (tt-&gt;options.ip_win32_type =3D=3D IPW32_SET_DHCP_=
MASQ || tt-&gt;options.ip_win32_type =3D=3D IPW32_SET_ADAPTIVE)<br>
+=C2=A0 =C2=A0 else if (tuntap_maybe_dhcp(&amp;tt-&gt;options))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Let the DHCP configure the interface. =
*/<br>
=C2=A0 =C2=A0 =C2=A0}<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wmic_do_dns_domain(true, tt);<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tt-&gt;did_ifconfig_setup &=
amp;&amp; !tuntap_maybe_dhcp(&amp;tt-&gt;options))<br></blockquote><div><br=
></div><div>same here</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wmic_do_dns_domain=
(false, tt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netsh_delete_address_dns(tt=
, true, &amp;gc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -6937,7 +6974,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We didn&#39;t do ifconfi=
g. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (tt-&gt;options.ip_win32_type =3D=3D I=
PW32_SET_DHCP_MASQ || tt-&gt;options.ip_win32_type =3D=3D IPW32_SET_ADAPTIV=
E)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (tuntap_maybe_dhcp(&amp;tt-&gt;options=
))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We don&#39;t have to cle=
an the configuration with DHCP. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wmic_do_dns_domain(false, tt);<b=
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
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h<br>
index e19e1a2e..0d8e2307 100644<br>
--- a/src/openvpn/tun.h<br>
+++ b/src/openvpn/tun.h<br>
@@ -668,6 +668,12 @@ tuntap_is_dco_win_timeout(struct tuntap *tt, int statu=
s)<br>
=C2=A0const char *<br>
=C2=A0print_windows_driver(enum windows_driver_type windows_driver);<br>
<br>
+static inline bool<br>
+tuntap_maybe_dhcp(struct tuntap_options *o)<br>
+{<br>
+=C2=A0 =C2=A0 return o-&gt;ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ || o-&=
gt;ip_win32_type =3D=3D IPW32_SET_ADAPTIVE;<br>
+}<br>
+<br>
=C2=A0#else=C2=A0 /* ifdef _WIN32 */<br>
<br>
=C2=A0static inline bool<br>
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
=C2=A0 * Win32-specific OpenVPN code, targeted at the mingw<br>
-- <br>
2.23.0.windows.1</blockquote><div><br></div><div>Selva</div></div></div>

--0000000000006e64a905f89b2f18--

