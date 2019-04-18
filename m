MIME-Version: 1.0
References: <20190401204032.GH31008@...1296...>
 <20190404111656.14916-1-cschenk@...2502...>
In-Reply-To: <20190404111656.14916-1-cschenk@...2502...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 18 Apr 2019 11:47:53 -0400
Message-ID: <CAKuzo_ipef3kq+S0kiuz18RzgyYRZSTORgwqWPyNQot-Zk=rTg@...278...>
Content-Type: multipart/alternative; boundary="000000000000cb90e70586cfedd9"
Subject: Re: [Openvpn-devel] [PATCH] Set the correct mtu on windows based
 systems
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

--000000000000cb90e70586cfedd9
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for the new version. I somehow missed it as it
went into a new thread.

For the record, this is an updated version of the series
https://patchwork.openvpn.net/project/openvpn2/list/?series=471
with requested changes:

(i) tabs removed + some good white-space changes
(ii) GetIpInterfaceEntry() called first to read-in the current
parameters before calling SetIpInterfaceEntry()

Summary:
The  patch sets the tun_mtu value (either the default of 1500 or
user-specified --tun-mtu xxx) on the tun/tap  interface on Windows
using the IP helper API, preferably via the interactive service.

Looks good now and a quick test on WIndows 7 behaves
as expected.

I'm ACKing this, but one remark: the patch does not revert the
mtu back to the previous value on disconnect. This is an issue
only (?) if we want to support clean downgrades to an earlier
version without recreating the tun/tap interfaces.

On Thu, Apr 4, 2019 at 7:18 AM Christopher Schenk <
cschenk@...2502...> wrote:

> Signed-off-by: Christopher Schenk <cschenk@...2502...>
> ---
>  include/openvpn-msg.h         |  8 ++++
>  src/openvpn/tun.c             | 89 +++++++++++++++++++++++++++++++++++
>  src/openvpnserv/interactive.c | 31 ++++++++++++
>  3 files changed, 128 insertions(+)
>
> diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
> index 66177a21..10cd68ac 100644
> --- a/include/openvpn-msg.h
> +++ b/include/openvpn-msg.h
> @@ -39,6 +39,7 @@ typedef enum {
>      msg_del_block_dns,
>      msg_register_dns,
>      msg_enable_dhcp,
> +    msg_set_mtu,
>  } message_type_t;
>
>  typedef struct {
> @@ -117,4 +118,11 @@ typedef struct {
>      interface_t iface;
>  } enable_dhcp_message_t;
>
> +typedef struct {
> +    message_header_t header;
> +    interface_t iface;
> +    short family;
> +    int mtu;
> +} set_mtu_message_t;
> +
>  #endif /* ifndef OPENVPN_MSG_H_ */
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 48a8fdf7..3895e421 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -69,6 +69,10 @@ static void netsh_ifconfig(const struct tuntap_options
> *to,
>                             const in_addr_t netmask,
>                             const unsigned int flags);
>
> +static void windows_set_mtu(const int iface_index,
> +                            const short family,
> +                            const int mtu);
> +
>  static void netsh_set_dns6_servers(const struct in6_addr *addr_list,
>                                     const int addr_len,
>                                     const char *flex_name);
> @@ -201,6 +205,47 @@ out:
>      return ret;
>  }
>
> +static bool
> +do_set_mtu_service(const struct tuntap *tt, const short family, const int
> mtu)
> +{
> +    DWORD len;
> +    bool ret = false;
> +    ack_message_t ack;
> +    struct gc_arena gc = gc_new();
> +    HANDLE pipe = tt->options.msg_channel;
> +    const char *family_name = (family == AF_INET6) ? "IPv6" : "IPv4";
> +    set_mtu_message_t mtu_msg = {
> +        .header = {
> +            msg_set_mtu,
> +            sizeof(set_mtu_message_t),
> +            0
> +        },
> +        .iface = {.index = tt->adapter_index,.name = tt->actual_name },
> +        .mtu = mtu,
> +        .family = family
> +    };
> +
> +    if (!send_msg_iservice(pipe, &mtu_msg, sizeof(mtu_msg), &ack,
> "Set_mtu"))
> +    {
> +        goto out;
> +    }
> +
> +    if (ack.error_number != NO_ERROR)
> +    {
> +        msg(M_NONFATAL, "TUN: setting %s mtu using service failed: %s
> [status=%u if_index=%d]",
> +            family_name, strerror_win32(ack.error_number, &gc),
> ack.error_number, mtu_msg.iface.index);
>
+    }
> +    else
> +    {
> +        msg(M_INFO, "%s MTU set to %d on interface %d using service",
> family_name, mtu, mtu_msg.iface.index);
> +        ret = true;
> +    }
> +
> +out:
> +    gc_free(&gc);
> +    return ret;
> +}
> +
>  #endif /* ifdef _WIN32 */
>
>  #ifdef TARGET_SOLARIS
> @@ -984,6 +1029,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char
> *ifname, int tun_mtu,
>      {
>          do_address_service(true, AF_INET6, tt);
>          do_dns6_service(true, tt);
> +        do_set_mtu_service(tt, AF_INET6, tun_mtu);
>      }
>      else
>      {
> @@ -1000,6 +1046,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char
> *ifname, int tun_mtu,
>          netsh_command(&argv, 4, M_FATAL);
>          /* set ipv6 dns servers if any are specified */
>          netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len,
> ifname);
> +        windows_set_mtu(tt->adapter_index, AF_INET6, tun_mtu);
>      }
>
>      /* explicit route needed */
> @@ -1394,6 +1441,14 @@ do_ifconfig_ipv4(struct tuntap *tt, const char
> *ifname, int tun_mtu,
>
>                  break;
>          }
> +        if (tt->options.msg_channel)
> +        {
> +            do_set_mtu_service(tt, AF_INET, tun_mtu);
> +        }
> +        else
> +        {
> +            windows_set_mtu(tt->adapter_index, AF_INET, tun_mtu);
> +        }
>      }
>
>  #else  /* if defined(TARGET_LINUX) */
> @@ -5236,6 +5291,40 @@ out:
>      return ret;
>  }
>
> +static void
> +windows_set_mtu(const int iface_index, const short family,
> +                const int mtu)
> +{
> +    DWORD err = 0;
> +    struct gc_arena gc = gc_new();
> +    MIB_IPINTERFACE_ROW ipiface;
> +    InitializeIpInterfaceEntry(&ipiface);
> +    const char *family_name = (family == AF_INET6) ? "IPv6" : "IPv4";
> +    ipiface.Family = family;
> +    ipiface.InterfaceIndex = iface_index;
> +    err = GetIpInterfaceEntry(&ipiface);
> +    if (err == NO_ERROR)
> +    {
> +        if (family == AF_INET)
> +        {
> +            ipiface.SitePrefixLength = 0;
> +        }
> +        ipiface.NlMtu = mtu;
> +        err = SetIpInterfaceEntry(&ipiface);
> +    }
> +
> +    if (err != NO_ERROR)
> +    {
> +        msg(M_WARN, "TUN: Setting %s mtu failed: %s [status=%u
> if_index=%d]",
> +            family_name, strerror_win32(err, &gc), err, iface_index);
> +    }
> +    else
> +    {
> +        msg(M_INFO, "Successfully set %s mtu on interface %d",
> family_name, iface_index);
> +    }
> +}
> +
> +
>  /*
>   * Return a TAP name for netsh commands.
>   */
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 623c3ff7..c24cb22b 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -1198,6 +1198,29 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t
> *dhcp)
>      return err;
>  }
>
> +static DWORD
> +HandleMTUMessage(const set_mtu_message_t *mtu)
> +{
> +    DWORD err = 0;
> +    MIB_IPINTERFACE_ROW ipiface;
> +    InitializeIpInterfaceEntry(&ipiface);
> +    ipiface.Family = mtu->family;
> +    ipiface.InterfaceIndex = mtu->iface.index;
> +    err = GetIpInterfaceEntry(&ipiface);
> +    if (err != NO_ERROR)
> +    {
> +        return err;
> +    }
> +    if (mtu->family == AF_INET)
> +    {
> +        ipiface.SitePrefixLength = 0;
> +    }
> +    ipiface.NlMtu = mtu->mtu;
> +
> +    err = SetIpInterfaceEntry(&ipiface);
> +    return err;
> +}
> +
>  static VOID
>  HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events,
> undo_lists_t *lists)
>  {
> @@ -1210,6 +1233,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count,
> LPHANDLE events, undo_lists
>          block_dns_message_t block_dns;
>          dns_cfg_message_t dns;
>          enable_dhcp_message_t dhcp;
> +        set_mtu_message_t mtu;
>      } msg;
>      ack_message_t ack = {
>          .header = {
> @@ -1277,6 +1301,13 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD
> count, LPHANDLE events, undo_lists
>              }
>              break;
>
> +        case msg_set_mtu:
> +            if (msg.header.size == sizeof(msg.mtu))
> +            {
> +                ack.error_number = HandleMTUMessage(&msg.mtu);
> +            }
> +            break;
> +
>          default:
>              ack.error_number = ERROR_MESSAGE_TYPE;
>              MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Unknown message type
> %d"), msg.header.type);
>
>
Acked-by: Selva Nair <selva.nair@...277...>

Selva

--000000000000cb90e70586cfedd9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div dir=3D"ltr"><div><div><div>Hi,<br=
><br></div>Thanks for the new version. I somehow missed it as it<br>went in=
to a new thread.<br><br></div>For the record, this is an updated version of=
 the series<br><a href=3D"https://patchwork.openvpn.net/project/openvpn2/li=
st/?series=3D471" target=3D"_blank">https://patchwork.openvpn.net/project/o=
penvpn2/list/?series=3D471</a><br></div><div>with requested changes:<br><br=
></div><div>(i) tabs removed + some good white-space changes<br></div><div>=
(ii) GetIpInterfaceEntry() called first to read-in the current<br>parameter=
s before calling SetIpInterfaceEntry()<br><br>Summary:<br>The=C2=A0 patch s=
ets the tun_mtu value (either the default of 1500 or<br>user-specified --tu=
n-mtu xxx) on the tun/tap=C2=A0 interface on Windows<br>using the IP helper=
 API, preferably via the interactive service.<br><br>Looks good now and a q=
uick test on WIndows 7 behaves<br>as expected.<br><br></div></div></div></d=
iv>I&#39;m ACKing this, but one remark: the patch does not revert the<br>mt=
u back to the previous value on disconnect. This is an issue<br>only (?) if=
 we want to support clean downgrades to an earlier<br>version without recre=
ating the tun/tap interfaces.<br></div></div><div><div><br><div><div><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 4, 2=
019 at 7:18 AM Christopher Schenk &lt;<a href=3D"mailto:cschenk@...2502..."=
 target=3D"_blank">cschenk@...2502...</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Signed-off-by: Christopher Schenk &lt;=
<a href=3D"mailto:cschenk@...2502..." target=3D"_blank">cschenk@...2502...<=
/a>&gt;<br>
---<br>
=C2=A0include/openvpn-msg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++++=
<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 89=
 +++++++++++++++++++++++++++++++++++<br>
=C2=A0src/openvpnserv/interactive.c | 31 ++++++++++++<br>
=C2=A03 files changed, 128 insertions(+)<br>
<br>
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h<br>
index 66177a21..10cd68ac 100644<br>
--- a/include/openvpn-msg.h<br>
+++ b/include/openvpn-msg.h<br>
@@ -39,6 +39,7 @@ typedef enum {<br>
=C2=A0 =C2=A0 =C2=A0msg_del_block_dns,<br>
=C2=A0 =C2=A0 =C2=A0msg_register_dns,<br>
=C2=A0 =C2=A0 =C2=A0msg_enable_dhcp,<br>
+=C2=A0 =C2=A0 msg_set_mtu,<br>
=C2=A0} message_type_t;<br>
<br>
=C2=A0typedef struct {<br>
@@ -117,4 +118,11 @@ typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0interface_t iface;<br>
=C2=A0} enable_dhcp_message_t;<br>
<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 message_header_t header;<br>
+=C2=A0 =C2=A0 interface_t iface;<br>
+=C2=A0 =C2=A0 short family;<br>
+=C2=A0 =C2=A0 int mtu;<br>
+} set_mtu_message_t;<br>
+<br>
=C2=A0#endif /* ifndef OPENVPN_MSG_H_ */<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 48a8fdf7..3895e421 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -69,6 +69,10 @@ static void netsh_ifconfig(const struct tuntap_options *=
to,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const in_addr_t netmask,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned int flags);<br>
<br>
+static void windows_set_mtu(const int iface_index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const short family,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const int mtu);<br>
+<br>
=C2=A0static void netsh_set_dns6_servers(const struct in6_addr *addr_list,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const int addr_len,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *flex_name)=
;<br>
@@ -201,6 +205,47 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+static bool<br>
+do_set_mtu_service(const struct tuntap *tt, const short family, const int =
mtu)<br>
+{<br>
+=C2=A0 =C2=A0 DWORD len;<br>
+=C2=A0 =C2=A0 bool ret =3D false;<br>
+=C2=A0 =C2=A0 ack_message_t ack;<br>
+=C2=A0 =C2=A0 struct gc_arena gc =3D gc_new();<br>
+=C2=A0 =C2=A0 HANDLE pipe =3D tt-&gt;options.msg_channel;<br>
+=C2=A0 =C2=A0 const char *family_name =3D (family =3D=3D AF_INET6) ? &quot=
;IPv6&quot; : &quot;IPv4&quot;;<br>
+=C2=A0 =C2=A0 set_mtu_message_t mtu_msg =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .header =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_set_mtu,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(set_mtu_message_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .iface =3D {.index =3D tt-&gt;adapter_index,.n=
ame =3D tt-&gt;actual_name },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mtu =3D mtu,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .family =3D family<br>
+=C2=A0 =C2=A0 };<br>
+<br>
+=C2=A0 =C2=A0 if (!send_msg_iservice(pipe, &amp;mtu_msg, sizeof(mtu_msg), =
&amp;ack, &quot;Set_mtu&quot;))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ack.error_number !=3D NO_ERROR)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_NONFATAL, &quot;TUN: setting %s mtu usin=
g service failed: %s [status=3D%u if_index=3D%d]&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 family_name, strerror_win32(ack.=
error_number, &amp;gc), ack.error_number, mtu_msg.iface.index);<br></blockq=
uote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;%s MTU set to %d on interfac=
e %d using service&quot;, family_name, mtu, mtu_msg.iface.index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 gc_free(&amp;gc);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
=C2=A0#endif /* ifdef _WIN32 */<br>
<br>
=C2=A0#ifdef TARGET_SOLARIS<br>
@@ -984,6 +1029,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname=
, int tun_mtu,<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_address_service(true, AF_INET6, tt);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_dns6_service(true, tt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_set_mtu_service(tt, AF_INET6, tun_mtu);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -1000,6 +1046,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifnam=
e, int tun_mtu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netsh_command(&amp;argv, 4, M_FATAL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set ipv6 dns servers if any are specif=
ied */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netsh_set_dns6_servers(tt-&gt;options.dns=
6, tt-&gt;options.dns6_len, ifname);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 windows_set_mtu(tt-&gt;adapter_index, AF_INET6=
, tun_mtu);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* explicit route needed */<br>
@@ -1394,6 +1441,14 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifna=
me, int tun_mtu,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;options.msg_channel)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_set_mtu_service(tt, AF_INET, =
tun_mtu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 windows_set_mtu(tt-&gt;adapter_i=
ndex, AF_INET, tun_mtu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0#else=C2=A0 /* if defined(TARGET_LINUX) */<br>
@@ -5236,6 +5291,40 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+static void<br>
+windows_set_mtu(const int iface_index, const short family,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const int mtu)<br>
+{<br>
+=C2=A0 =C2=A0 DWORD err =3D 0;<br>
+=C2=A0 =C2=A0 struct gc_arena gc =3D gc_new();<br>
+=C2=A0 =C2=A0 MIB_IPINTERFACE_ROW ipiface;<br>
+=C2=A0 =C2=A0 InitializeIpInterfaceEntry(&amp;ipiface);<br>
+=C2=A0 =C2=A0 const char *family_name =3D (family =3D=3D AF_INET6) ? &quot=
;IPv6&quot; : &quot;IPv4&quot;;<br>
+=C2=A0 =C2=A0 ipiface.Family =3D family;<br>
+=C2=A0 =C2=A0 ipiface.InterfaceIndex =3D iface_index;<br>
+=C2=A0 =C2=A0 err =3D GetIpInterfaceEntry(&amp;ipiface);<br>
+=C2=A0 =C2=A0 if (err =3D=3D NO_ERROR)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (family =3D=3D AF_INET)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ipiface.SitePrefixLength =3D 0;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ipiface.NlMtu =3D mtu;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D SetIpInterfaceEntry(&amp;ipiface);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (err !=3D NO_ERROR)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;TUN: Setting %s mtu failed: =
%s [status=3D%u if_index=3D%d]&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 family_name, strerror_win32(err,=
 &amp;gc), err, iface_index);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;Successfully set %s mtu on i=
nterface %d&quot;, family_name, iface_index);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Return a TAP name for netsh commands.<br>
=C2=A0 */<br>
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c<=
br>
index 623c3ff7..c24cb22b 100644<br>
--- a/src/openvpnserv/interactive.c<br>
+++ b/src/openvpnserv/interactive.c<br>
@@ -1198,6 +1198,29 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t =
*dhcp)<br>
=C2=A0 =C2=A0 =C2=A0return err;<br>
=C2=A0}<br>
<br>
+static DWORD<br>
+HandleMTUMessage(const set_mtu_message_t *mtu)<br>
+{<br>
+=C2=A0 =C2=A0 DWORD err =3D 0;<br>
+=C2=A0 =C2=A0 MIB_IPINTERFACE_ROW ipiface;<br>
+=C2=A0 =C2=A0 InitializeIpInterfaceEntry(&amp;ipiface);<br>
+=C2=A0 =C2=A0 ipiface.Family =3D mtu-&gt;family;<br>
+=C2=A0 =C2=A0 ipiface.InterfaceIndex =3D mtu-&gt;iface.index;<br>
+=C2=A0 =C2=A0 err =3D GetIpInterfaceEntry(&amp;ipiface);<br>
+=C2=A0 =C2=A0 if (err !=3D NO_ERROR)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (mtu-&gt;family =3D=3D AF_INET)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ipiface.SitePrefixLength =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ipiface.NlMtu =3D mtu-&gt;mtu;<br>
+<br>
+=C2=A0 =C2=A0 err =3D SetIpInterfaceEntry(&amp;ipiface);<br>
+=C2=A0 =C2=A0 return err;<br>
+}<br>
+<br>
=C2=A0static VOID<br>
=C2=A0HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events,=
 undo_lists_t *lists)<br>
=C2=A0{<br>
@@ -1210,6 +1233,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, =
LPHANDLE events, undo_lists<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block_dns_message_t block_dns;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dns_cfg_message_t dns;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enable_dhcp_message_t dhcp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_mtu_message_t mtu;<br>
=C2=A0 =C2=A0 =C2=A0} msg;<br>
=C2=A0 =C2=A0 =C2=A0ack_message_t ack =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.header =3D {<br>
@@ -1277,6 +1301,13 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count,=
 LPHANDLE events, undo_lists<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case msg_set_mtu:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg.header.size =3D=3D sizeo=
f(msg.mtu))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ack.error_number =
=3D HandleMTUMessage(&amp;msg.mtu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ack.error_number =3D ERROR_=
MESSAGE_TYPE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MsgToEventLog(MSG_FLAGS_ERR=
OR, TEXT(&quot;Unknown message type %d&quot;), msg.header.type);<br><br></b=
lockquote><div><br></div><div>Acked-by: Selva Nair &lt;<a href=3D"mailto:se=
lva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;<br><br><=
/div><div>Selva<br></div><div>=C2=A0<br></div></div></div></div></div></div=
></div>

--000000000000cb90e70586cfedd9--

