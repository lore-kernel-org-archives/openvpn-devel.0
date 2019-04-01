MIME-Version: 1.0
References: <20190329193805.GQ31008@...1296...>
 <20190401112140.13212-1-cschenk@...2502...>
 <20190401112140.13212-3-cschenk@...2502...>
In-Reply-To: <20190401112140.13212-3-cschenk@...2502...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 1 Apr 2019 11:56:43 -0400
Message-ID: <CAKuzo_igyJmre=gH6AT7mx_GB7TRMc0KZitUR3mgHgEMXF512A@...278...>
Content-Type: multipart/alternative; boundary="000000000000158b7205857a127c"
Subject: Re: [Openvpn-devel] [PATCH 3/4] Use netioapi instead of netsh to
 set mtu
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christopher Schenk <cschenk@...2502...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000158b7205857a127c
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Apr 1, 2019 at 7:22 AM Christopher Schenk <
cschenk@...2502...> wrote:

> ---
>  src/openvpn/tun.c             | 68 +++++++++++++++++++----------------
>  src/openvpnserv/interactive.c | 44 +++++------------------
>  2 files changed, 46 insertions(+), 66 deletions(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index b0230a7c..9fe8444f 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -69,10 +69,8 @@ static void netsh_ifconfig(const struct tuntap_options
> *to,
>                             const in_addr_t netmask,
>                             const unsigned int flags);
>
> -static void netsh_set_mtu_ipv4(const char *flex_name,
> -                               const int mtu);
> -
> -static void netsh_set_mtu_ipv6(const char *flex_name,
> +static void windows_set_mtu(const int iface_indey,
> +                                                               short
> family,
>                                 const int mtu);
>

Do not use tabs, use 4 whitespace characters for indent
as in the rest of the code.


>
>  static void netsh_set_dns6_servers(const struct in6_addr *addr_list,
> @@ -1064,7 +1062,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char
> *ifname, int tun_mtu,
>          netsh_command(&argv, 4, M_FATAL);
>          /* set ipv6 dns servers if any are specified */
>          netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len,
> ifname);
> -        netsh_set_mtu_ipv6(ifname, tun_mtu);
> +               windows_set_mtu(tt->adapter_index, AF_INET6, tun_mtu);
>

Code indentation is not "correct" in many places like this -- see
remarks in my response to commit 4.


>      }
>
>      /* explicit route needed */
> @@ -1464,7 +1462,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char
> *ifname, int tun_mtu,
>                 }
>                 else
>                 {
> -                       netsh_set_mtu_ipv4(ifname, tun_mtu);
> +                       windows_set_mtu(tt->adapter_index, AF_INET,
> tun_mtu);
>                 }
>      }
>
> @@ -5309,35 +5307,45 @@ out:
>  }
>
>  static void
> -netsh_set_mtu_ipv4(const char *flex_name,
> -                   const int mtu)
> -{
> -       struct argv argv = argv_new();
> -       argv_printf(&argv, "%s%sc interface ipv4 set subinterface %s mtu =
> %d store=active",
> -               get_win_sys_path(),
> -               NETSH_PATH_SUFFIX,
> -               flex_name,
> -               mtu);
> -
> -       netsh_command(&argv, 3, M_WARN);
> -       argv_reset(&argv);
> -}
> -
> -static void
> -netsh_set_mtu_ipv6(const char *flex_name,
> +windows_set_mtu(const int iface_index, const short family,
>         const int mtu)
>
 {
> -       struct argv argv = argv_new();
> -       argv_printf(&argv, "%s%sc interface ipv6 set subinterface %s mtu =
> %d store=active",
> -               get_win_sys_path(),
> -               NETSH_PATH_SUFFIX,
> -               flex_name,
> -               mtu);
> +       DWORD err = 0;
> +       struct gc_arena gc = gc_new();
> +       MIB_IPINTERFACE_ROW row;
> +       InitializeIpInterfaceEntry(&row);
> +       row.Family = family;
> +       row.InterfaceIndex = iface_index;
> +       row.NlMtu = mtu;
>
> -       netsh_command(&argv, 3, M_WARN);
> -       argv_reset(&argv);
> +       err = SetIpInterfaceEntry(&row);
>

I think this has the potential to reset other interface parameters
edited elsewhere (or set by the user) to the default values. The
right approach would be to get the current state using
GetIpInterfaceEntry(&row) and then modify only the mtu before
calling SetIpInterfaceEntry().

See how its done in block_dns.c or consult the IP Helper docs.

Same in interactive.c

+       if (family == AF_INET)
> +       {
> +               if (err != NO_ERROR)
> +               {
> +                       msg(M_WARN, "TUN: Setting IPv4 mtu failed: %s
> [status=%u if_index=%d]",
> +                               strerror_win32(err, &gc), err,
> iface_index);
> +               }
> +               else
> +               {
> +                       msg(M_INFO, "Successfully set IPv4 mtu on
> interface %d", iface_index);
> +               }
> +       }
> +       else if (family == AF_INET6)
> +       {
> +               if (err != NO_ERROR)
> +               {
> +                       msg(M_WARN, "TUN: Setting IPv6 mtu failed: %s
> [status=%u if_index=%d]",
> +                               strerror_win32(err, &gc), err,
> iface_index);
> +               }
> +               else
> +               {
> +                       msg(M_INFO, "Successfully set IPv6 mtu on
> interface %d", iface_index);
> +               }
> +       }
>  }
>
> +
>  /*
>   * Return a TAP name for netsh commands.
>   */
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 31e4afa0..6e6a63fe 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -33,6 +33,7 @@
>  #include <sddl.h>
>  #include <shellapi.h>
>  #include <mstcpip.h>
> +#include <netioapi.h>
>
>
There should be no need to include this header directly. Instead let
the main IP Helper API header (iphlpapi.h) include it correctly.
The latter is already included both in tun.c and interactive.c


>  #ifdef HAVE_VERSIONHELPERS_H
>  #include <versionhelpers.h>
> @@ -1202,42 +1203,13 @@ static DWORD
>  HandleMTUMessage(const set_mtu_message_t *mtu)
>  {
>         DWORD err = 0;
> -       DWORD timeout = 5000; /* in milli seconds */
> -       wchar_t argv0[MAX_PATH];
> -
> -       /* Path of netsh */
> -       swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(),
> L"netsh.exe");
> -       argv0[_countof(argv0) - 1] = L'\0';
> -
> -       /* cmd template:
> -        * netsh interface $family set subinterface "$if_name" mtu=$mtu
> -        */
> -       const wchar_t *fmt;
> -       if (mtu->family == AF_INET)
> -       {
> -               fmt = L"netsh interface ipv4 set subinterface \"%d\" mtu=
> %d";
> -       }
> -       else if (mtu->family == AF_INET6)
> -       {
> -               fmt = L"netsh interface ipv6 set subinterface \"%d\" mtu=
> %d";
> -       }
> -
> -       /* max cmdline length in wchars -- include room for if index:
> -        * 20 chars for two 32 bit int in decimal and +1 for NUL
> -        */
> -       size_t ncmdline = wcslen(fmt) + 20 + 1;
> -       wchar_t *cmdline = malloc(ncmdline * sizeof(wchar_t));
> -       if (!cmdline)
> -       {
> -               err = ERROR_OUTOFMEMORY;
> -               return err;
> -       }
> -
> -       openvpn_sntprintf(cmdline, ncmdline, fmt, mtu->iface.index,
> mtu->mtu);
> -
> -       err = ExecCommand(argv0, cmdline, timeout);
> -
> -       free(cmdline);
> +       MIB_IPINTERFACE_ROW row;
> +       InitializeIpInterfaceEntry(&row);
> +       row.Family = mtu->family;
> +       row.InterfaceIndex = mtu->iface.index;
> +       row.NlMtu = mtu->mtu;
> +
> +       err = SetIpInterfaceEntry(&row);
>

See the remark above.


>         return err;
>  }
>
>
Selva

--000000000000158b7205857a127c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br></div><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Apr 1, 2019 at 7:22 AM Christopher Sc=
henk &lt;<a href=3D"mailto:cschenk@...2502..." target=3D"_blank">cschenk@...1186...=
.2502...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">---<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 68=
 +++++++++++++++++++----------------<br>
=C2=A0src/openvpnserv/interactive.c | 44 +++++------------------<br>
=C2=A02 files changed, 46 insertions(+), 66 deletions(-)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index b0230a7c..9fe8444f 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -69,10 +69,8 @@ static void netsh_ifconfig(const struct tuntap_options *=
to,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const in_addr_t netmask,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned int flags);<br>
<br>
-static void netsh_set_mtu_ipv4(const char *flex_name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int mtu);<br>
-<br>
-static void netsh_set_mtu_ipv6(const char *flex_name,<br>
+static void windows_set_mtu(const int iface_indey,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0short family,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const int mtu);<br></blockquote><div=
><br></div><div>Do not use tabs, use 4 whitespace characters for indent<br>=
as in the rest of the code.<br></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
=C2=A0static void netsh_set_dns6_servers(const struct in6_addr *addr_list,<=
br>
@@ -1064,7 +1062,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifnam=
e, int tun_mtu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netsh_command(&amp;argv, 4, M_FATAL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set ipv6 dns servers if any are specif=
ied */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netsh_set_dns6_servers(tt-&gt;options.dns=
6, tt-&gt;options.dns6_len, ifname);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 netsh_set_mtu_ipv6(ifname, tun_mtu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0windows_set_mtu(tt-=
&gt;adapter_index, AF_INET6, tun_mtu);<br></blockquote><div><br></div><div>=
Code indentation is not &quot;correct&quot; in many places like this -- see=
 <br>remarks in my response to commit 4.<br></div><div>=C2=A0<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* explicit route needed */<br>
@@ -1464,7 +1462,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifnam=
e, int tun_mtu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0netsh_set_mtu_ipv4(ifname, tun_mtu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0windows_set_mtu(tt-&gt;adapter_index, AF_INET, tun_mtu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -5309,35 +5307,45 @@ out:<br>
=C2=A0}<br>
<br>
=C2=A0static void<br>
-netsh_set_mtu_ipv4(const char *flex_name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const=
 int mtu)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct argv argv =3D argv_new();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0argv_printf(&amp;argv, &quot;%s%sc interface ip=
v4 set subinterface %s mtu =3D %d store=3Dactive&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_win_sys_path(),=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NETSH_PATH_SUFFIX,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flex_name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mtu);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0netsh_command(&amp;argv, 3, M_WARN);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0argv_reset(&amp;argv);<br>
-}<br>
-<br>
-static void<br>
-netsh_set_mtu_ipv6(const char *flex_name,<br>
+windows_set_mtu(const int iface_index, const short family,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const int mtu) <br></blockquote><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct argv argv =3D argv_new();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0argv_printf(&amp;argv, &quot;%s%sc interface ip=
v6 set subinterface %s mtu =3D %d store=3Dactive&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_win_sys_path(),=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NETSH_PATH_SUFFIX,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flex_name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mtu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DWORD err =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0MIB_IPINTERFACE_ROW row;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0InitializeIpInterfaceEntry(&amp;row);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0row.Family =3D family;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0row.InterfaceIndex =3D iface_index;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0row.NlMtu =3D mtu;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0netsh_command(&amp;argv, 3, M_WARN);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0argv_reset(&amp;argv);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D SetIpInterfaceEntry(&amp;row);<br></blo=
ckquote><div><br></div><div>I think this has the potential to reset other i=
nterface parameters<br>edited elsewhere (or set by the user) to the default=
 values. The<br>right approach would be to get the current state using<br>G=
etIpInterfaceEntry(&amp;row) and then modify only the mtu before<br>calling=
 SetIpInterfaceEntry().<br><br>See how its done in block_dns.c or consult t=
he IP Helper docs.<br><br></div><div>Same in interactive.c<br><br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (family =3D=3D AF_INET)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err !=3D NO_ERR=
OR)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0msg(M_WARN, &quot;TUN: Setting IPv4 mtu failed: %s [status=3D%u i=
f_index=3D%d]&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strerror_win32(err, &amp;gc), err, if=
ace_index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0msg(M_INFO, &quot;Successfully set IPv4 mtu on interface %d&quot;=
, iface_index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else if (family =3D=3D AF_INET6)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err !=3D NO_ERR=
OR)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0msg(M_WARN, &quot;TUN: Setting IPv6 mtu failed: %s [status=3D%u i=
f_index=3D%d]&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strerror_win32(err, &amp;gc), err, if=
ace_index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0msg(M_INFO, &quot;Successfully set IPv6 mtu on interface %d&quot;=
, iface_index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Return a TAP name for netsh commands.<br>
=C2=A0 */<br>
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c<=
br>
index 31e4afa0..6e6a63fe 100644<br>
--- a/src/openvpnserv/interactive.c<br>
+++ b/src/openvpnserv/interactive.c<br>
@@ -33,6 +33,7 @@<br>
=C2=A0#include &lt;sddl.h&gt;<br>
=C2=A0#include &lt;shellapi.h&gt;<br>
=C2=A0#include &lt;mstcpip.h&gt;<br>
+#include &lt;netioapi.h&gt;<br>
<br></blockquote><div><br></div><div>There should be no need to include thi=
s header directly. Instead let<br>the main IP Helper API header (iphlpapi.h=
) include it correctly.<br>The latter is already included both in tun.c and=
 interactive.c<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
=C2=A0#ifdef HAVE_VERSIONHELPERS_H<br>
=C2=A0#include &lt;versionhelpers.h&gt;<br>
@@ -1202,42 +1203,13 @@ static DWORD<br>
=C2=A0HandleMTUMessage(const set_mtu_message_t *mtu)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD err =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DWORD timeout =3D 5000; /* in milli seconds */<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0wchar_t argv0[MAX_PATH];<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Path of netsh */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0swprintf(argv0, _countof(argv0), L&quot;%s\\%s&=
quot;, get_win_sys_path(), L&quot;netsh.exe&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0argv0[_countof(argv0) - 1] =3D L&#39;\0&#39;;<b=
r>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* cmd template:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * netsh interface $family set subinterface &qu=
ot;$if_name&quot; mtu=3D$mtu<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0const wchar_t *fmt;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mtu-&gt;family =3D=3D AF_INET)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmt =3D L&quot;nets=
h interface ipv4 set subinterface \&quot;%d\&quot; mtu=3D %d&quot;;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else if (mtu-&gt;family =3D=3D AF_INET6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmt =3D L&quot;nets=
h interface ipv6 set subinterface \&quot;%d\&quot; mtu=3D %d&quot;;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* max cmdline length in wchars -- include room=
 for if index:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * 20 chars for two 32 bit int in decimal and +=
1 for NUL<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t ncmdline =3D wcslen(fmt) + 20 + 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0wchar_t *cmdline =3D malloc(ncmdline * sizeof(w=
char_t));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cmdline)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D ERROR_OUTOF=
MEMORY;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0openvpn_sntprintf(cmdline, ncmdline, fmt, mtu-&=
gt;iface.index, mtu-&gt;mtu);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D ExecCommand(argv0, cmdline, timeout);<b=
r>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0free(cmdline);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0MIB_IPINTERFACE_ROW row;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0InitializeIpInterfaceEntry(&amp;row);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0row.Family =3D mtu-&gt;family;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0row.InterfaceIndex =3D mtu-&gt;iface.index;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0row.NlMtu =3D mtu-&gt;mtu;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D SetIpInterfaceEntry(&amp;row);<br></blo=
ckquote><div><br></div><div>See the remark above.<br>=C2=A0<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
=C2=A0}<br>
<br></blockquote><br><div>Selva<br></div></div></div>

--000000000000158b7205857a127c--

