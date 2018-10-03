MIME-Version: 1.0
References: <1538229228-10620-1-git-send-email-selva.nair@...277...>
 <1538510474-27602-1-git-send-email-selva.nair@...277...>
 <1538510474-27602-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1538510474-27602-2-git-send-email-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 3 Oct 2018 12:53:09 +0300
Message-ID: <CAGyAFMXJXG71ktMYmA6eqgSNi8v3uxggET1PthCd-ffQ=kvrfA@...278...>
Content-Type: multipart/alternative; boundary="0000000000002720af057750020c"
Subject: Re: [Openvpn-devel] [PATCH 2/3 v2] Enable dhcp on tap adapter using
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

--0000000000002720af057750020c
Content-Type: text/plain; charset="UTF-8"

ACK

ti 2. lokak. 2018 klo 23.02 selva.nair@...277... kirjoitti:

> From: Selva Nair <selva.nair@...277...>
>
> Currently, if dhcp on the TAP interface is disabled, OpenVPN
> on Windows tries to enable it using netsh but that succeeds only when
> run with admin privileges.
>
> When interactive service is available, delegate this task to the
> service.
>
> Trac #1111
> Tested on Windows 7
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> v2 changes: As suggested by Lev
> - In comment, clarify the 10 chars room is for printing 32 bit int
> - Use get_win_sys_path() added in the accompanying patch (1 of 3)
>
> Refactoring of writing to the message channel is in the
> following patch.
>
>  include/openvpn-msg.h         |  8 ++++++-
>  src/openvpn/tun.c             | 53
> ++++++++++++++++++++++++++++++++++++++++++-
>  src/openvpnserv/interactive.c | 47 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+), 2 deletions(-)
>
> diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
> index 82ecfe8..66177a2 100644
> --- a/include/openvpn-msg.h
> +++ b/include/openvpn-msg.h
> @@ -37,7 +37,8 @@ typedef enum {
>      msg_flush_neighbors,
>      msg_add_block_dns,
>      msg_del_block_dns,
> -    msg_register_dns
> +    msg_register_dns,
> +    msg_enable_dhcp,
>  } message_type_t;
>
>  typedef struct {
> @@ -111,4 +112,9 @@ typedef struct {
>      interface_t iface;
>  } block_dns_message_t;
>
> +typedef struct {
> +    message_header_t header;
> +    interface_t iface;
> +} enable_dhcp_message_t;
> +
>  #endif /* ifndef OPENVPN_MSG_H_ */
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 50f158c..a2d5315 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -5203,6 +5203,49 @@ netsh_enable_dhcp(const struct tuntap_options *to,
>      argv_reset(&argv);
>  }
>
> +/* Enable dhcp on tap adapter using iservice */
> +static bool
> +service_enable_dhcp(const struct tuntap *tt)
> +{
> +    DWORD len;
> +    bool ret = false;
> +    ack_message_t ack;
> +    struct gc_arena gc = gc_new();
> +    HANDLE pipe = tt->options.msg_channel;
> +
> +    enable_dhcp_message_t dhcp = {
> +        .header = {
> +            msg_enable_dhcp,
> +            sizeof(enable_dhcp_message_t),
> +            0
> +        },
> +        .iface = { .index = tt->adapter_index, .name = "" }
> +    };
> +
> +    if (!WriteFile(pipe, &dhcp, sizeof(dhcp), &len, NULL)
> +        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
> +    {
> +        msg(M_WARN, "Enable_dhcp: could not talk to service: %s [%lu]",
> +            strerror_win32(GetLastError(), &gc), GetLastError());
> +        goto out;
> +    }
> +
> +    if (ack.error_number != NO_ERROR)
> +    {
> +        msg(M_NONFATAL, "TUN: enabling dhcp using service failed: %s
> [status=%u if_index=%d]",
> +            strerror_win32(ack.error_number, &gc), ack.error_number,
> dhcp.iface.index);
> +    }
> +    else
> +    {
> +        msg(M_INFO, "DHCP enabled on interface %d using service",
> dhcp.iface.index);
> +        ret = true;
> +    }
> +
> +out:
> +    gc_free(&gc);
> +    return ret;
> +}
> +
>  /*
>   * Return a TAP name for netsh commands.
>   */
> @@ -5683,7 +5726,15 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>               */
>              if (dhcp_status(tt->adapter_index) == DHCP_STATUS_DISABLED)
>              {
> -                netsh_enable_dhcp(&tt->options, tt->actual_name);
> +                /* try using the service if available, else directly
> execute netsh */
> +                if (tt->options.msg_channel)
> +                {
> +                    service_enable_dhcp(tt);
> +                }
> +                else
> +                {
> +                    netsh_enable_dhcp(&tt->options, tt->actual_name);
> +                }
>              }
>              dhcp_masq = true;
>              dhcp_masq_post = true;
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 0489684..c0fdc19 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -1165,6 +1165,45 @@ out:
>      return err;
>  }
>
> +static DWORD
> +HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
> +{
> +    DWORD err = 0;
> +    DWORD timeout = 5000; /* in milli seconds */
> +    wchar_t argv0[MAX_PATH];
> +
> +    /* Path of netsh */
> +    swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(),
> L"netsh.exe");
> +    argv0[_countof(argv0) - 1] = L'\0';
> +
> +    /* cmd template:
> +     * netsh interface ipv4 set address name=$if_index source=dhcp
> +     */
> +    const wchar_t *fmt = L"netsh interface ipv4 set address name=\"%d\"
> source=dhcp";
> +
> +    /* max cmdline length in wchars -- include room for if index:
> +     * 10 chars for 32 bit int in decimal and +1 for NUL
> +     */
> +    size_t ncmdline = wcslen(fmt) + 10 + 1;
> +    wchar_t *cmdline = malloc(ncmdline*sizeof(wchar_t));
> +    if (!cmdline)
> +    {
> +        err = ERROR_OUTOFMEMORY;
> +        return err;
> +    }
> +
> +    openvpn_sntprintf(cmdline, ncmdline, fmt, dhcp->iface.index);
> +
> +    err = ExecCommand(argv0, cmdline, timeout);
> +
> +    /* Note: This could fail if dhcp is already enabled, so the caller
> +     * may not want to treat errors as FATAL.
> +     */
> +
> +    free(cmdline);
> +    return err;
> +}
> +
>  static VOID
>  HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events,
> undo_lists_t *lists)
>  {
> @@ -1176,6 +1215,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count,
> LPHANDLE events, undo_lists
>          flush_neighbors_message_t flush_neighbors;
>          block_dns_message_t block_dns;
>          dns_cfg_message_t dns;
> +        enable_dhcp_message_t dhcp;
>      } msg;
>      ack_message_t ack = {
>          .header = {
> @@ -1236,6 +1276,13 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD
> count, LPHANDLE events, undo_lists
>              ack.error_number = HandleDNSConfigMessage(&msg.dns, lists);
>              break;
>
> +        case msg_enable_dhcp:
> +            if (msg.header.size == sizeof(msg.dhcp))
> +            {
> +                ack.error_number = HandleEnableDHCPMessage(&msg.dhcp);
> +            }
> +            break;
> +
>          default:
>              ack.error_number = ERROR_MESSAGE_TYPE;
>              MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Unknown message type
> %d"), msg.header.type);
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

--0000000000002720af057750020c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ACK</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">t=
i 2. lokak. 2018 klo 23.02 <a href=3D"mailto:selva.nair@...277...">selva.na=
ir@...277...</a> kirjoitti:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: S=
elva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">sel=
va.nair@...277...</a>&gt;<br>
<br>
Currently, if dhcp on the TAP interface is disabled, OpenVPN<br>
on Windows tries to enable it using netsh but that succeeds only when<br>
run with admin privileges.<br>
<br>
When interactive service is available, delegate this task to the<br>
service.<br>
<br>
Trac #1111<br>
Tested on Windows 7<br>
<br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." targe=
t=3D"_blank">selva.nair@...277...</a>&gt;<br>
---<br>
v2 changes: As suggested by Lev<br>
- In comment, clarify the 10 chars room is for printing 32 bit int<br>
- Use get_win_sys_path() added in the accompanying patch (1 of 3)<br>
<br>
Refactoring of writing to the message channel is in the<br>
following patch.<br>
<br>
=C2=A0include/openvpn-msg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++++=
++-<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 53=
 ++++++++++++++++++++++++++++++++++++++++++-<br>
=C2=A0src/openvpnserv/interactive.c | 47 ++++++++++++++++++++++++++++++++++=
++++<br>
=C2=A03 files changed, 106 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h<br>
index 82ecfe8..66177a2 100644<br>
--- a/include/openvpn-msg.h<br>
+++ b/include/openvpn-msg.h<br>
@@ -37,7 +37,8 @@ typedef enum {<br>
=C2=A0 =C2=A0 =C2=A0msg_flush_neighbors,<br>
=C2=A0 =C2=A0 =C2=A0msg_add_block_dns,<br>
=C2=A0 =C2=A0 =C2=A0msg_del_block_dns,<br>
-=C2=A0 =C2=A0 msg_register_dns<br>
+=C2=A0 =C2=A0 msg_register_dns,<br>
+=C2=A0 =C2=A0 msg_enable_dhcp,<br>
=C2=A0} message_type_t;<br>
<br>
=C2=A0typedef struct {<br>
@@ -111,4 +112,9 @@ typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0interface_t iface;<br>
=C2=A0} block_dns_message_t;<br>
<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 message_header_t header;<br>
+=C2=A0 =C2=A0 interface_t iface;<br>
+} enable_dhcp_message_t;<br>
+<br>
=C2=A0#endif /* ifndef OPENVPN_MSG_H_ */<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 50f158c..a2d5315 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -5203,6 +5203,49 @@ netsh_enable_dhcp(const struct tuntap_options *to,<b=
r>
=C2=A0 =C2=A0 =C2=A0argv_reset(&amp;argv);<br>
=C2=A0}<br>
<br>
+/* Enable dhcp on tap adapter using iservice */<br>
+static bool<br>
+service_enable_dhcp(const struct tuntap *tt)<br>
+{<br>
+=C2=A0 =C2=A0 DWORD len;<br>
+=C2=A0 =C2=A0 bool ret =3D false;<br>
+=C2=A0 =C2=A0 ack_message_t ack;<br>
+=C2=A0 =C2=A0 struct gc_arena gc =3D gc_new();<br>
+=C2=A0 =C2=A0 HANDLE pipe =3D tt-&gt;options.msg_channel;<br>
+<br>
+=C2=A0 =C2=A0 enable_dhcp_message_t dhcp =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .header =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_enable_dhcp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(enable_dhcp_message_t),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .iface =3D { .index =3D tt-&gt;adapter_index, =
.name =3D &quot;&quot; }<br>
+=C2=A0 =C2=A0 };<br>
+<br>
+=C2=A0 =C2=A0 if (!WriteFile(pipe, &amp;dhcp, sizeof(dhcp), &amp;len, NULL=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !ReadFile(pipe, &amp;ack, sizeof(ack), &amp=
;len, NULL))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;Enable_dhcp: could not talk =
to service: %s [%lu]&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror_win32(GetLastError(), &=
amp;gc), GetLastError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ack.error_number !=3D NO_ERROR)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_NONFATAL, &quot;TUN: enabling dhcp using=
 service failed: %s [status=3D%u if_index=3D%d]&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror_win32(ack.error_number,=
 &amp;gc), ack.error_number, dhcp.iface.index);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;DHCP enabled on interface %d=
 using service&quot;, dhcp.iface.index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 gc_free(&amp;gc);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Return a TAP name for netsh commands.<br>
=C2=A0 */<br>
@@ -5683,7 +5726,15 @@ open_tun(const char *dev, const char *dev_type, cons=
t char *dev_node, struct tun<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dhcp_status(tt-&gt;adap=
ter_index) =3D=3D DHCP_STATUS_DISABLED)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netsh_enable_dhcp(=
&amp;tt-&gt;options, tt-&gt;actual_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* try using the s=
ervice if available, else directly execute netsh */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;options=
.msg_channel)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serv=
ice_enable_dhcp(tt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nets=
h_enable_dhcp(&amp;tt-&gt;options, tt-&gt;actual_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dhcp_masq =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dhcp_masq_post =3D true;<br>
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c<=
br>
index 0489684..c0fdc19 100644<br>
--- a/src/openvpnserv/interactive.c<br>
+++ b/src/openvpnserv/interactive.c<br>
@@ -1165,6 +1165,45 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0return err;<br>
=C2=A0}<br>
<br>
+static DWORD<br>
+HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)<br>
+{<br>
+=C2=A0 =C2=A0 DWORD err =3D 0;<br>
+=C2=A0 =C2=A0 DWORD timeout =3D 5000; /* in milli seconds */<br>
+=C2=A0 =C2=A0 wchar_t argv0[MAX_PATH];<br>
+<br>
+=C2=A0 =C2=A0 /* Path of netsh */<br>
+=C2=A0 =C2=A0 swprintf(argv0, _countof(argv0), L&quot;%s\\%s&quot;, get_wi=
n_sys_path(), L&quot;netsh.exe&quot;);<br>
+=C2=A0 =C2=A0 argv0[_countof(argv0) - 1] =3D L&#39;\0&#39;;<br>
+<br>
+=C2=A0 =C2=A0 /* cmd template:<br>
+=C2=A0 =C2=A0 =C2=A0* netsh interface ipv4 set address name=3D$if_index so=
urce=3Ddhcp<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 const wchar_t *fmt =3D L&quot;netsh interface ipv4 set addre=
ss name=3D\&quot;%d\&quot; source=3Ddhcp&quot;;<br>
+<br>
+=C2=A0 =C2=A0 /* max cmdline length in wchars -- include room for if index=
:<br>
+=C2=A0 =C2=A0 =C2=A0* 10 chars for 32 bit int in decimal and +1 for NUL<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 size_t ncmdline =3D wcslen(fmt) + 10 + 1;<br>
+=C2=A0 =C2=A0 wchar_t *cmdline =3D malloc(ncmdline*sizeof(wchar_t));<br>
+=C2=A0 =C2=A0 if (!cmdline)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D ERROR_OUTOFMEMORY;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 openvpn_sntprintf(cmdline, ncmdline, fmt, dhcp-&gt;iface.ind=
ex);<br>
+<br>
+=C2=A0 =C2=A0 err =3D ExecCommand(argv0, cmdline, timeout);<br>
+<br>
+=C2=A0 =C2=A0 /* Note: This could fail if dhcp is already enabled, so the =
caller<br>
+=C2=A0 =C2=A0 =C2=A0* may not want to treat errors as FATAL.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+<br>
+=C2=A0 =C2=A0 free(cmdline);<br>
+=C2=A0 =C2=A0 return err;<br>
+}<br>
+<br>
=C2=A0static VOID<br>
=C2=A0HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events,=
 undo_lists_t *lists)<br>
=C2=A0{<br>
@@ -1176,6 +1215,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, =
LPHANDLE events, undo_lists<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flush_neighbors_message_t flush_neighbors=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block_dns_message_t block_dns;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dns_cfg_message_t dns;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_dhcp_message_t dhcp;<br>
=C2=A0 =C2=A0 =C2=A0} msg;<br>
=C2=A0 =C2=A0 =C2=A0ack_message_t ack =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.header =3D {<br>
@@ -1236,6 +1276,13 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count,=
 LPHANDLE events, undo_lists<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ack.error_number =3D Handle=
DNSConfigMessage(&amp;msg.dns, lists);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case msg_enable_dhcp:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg.header.size =3D=3D sizeo=
f(msg.dhcp))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ack.error_number =
=3D HandleEnableDHCPMessage(&amp;msg.dhcp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ack.error_number =3D ERROR_=
MESSAGE_TYPE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MsgToEventLog(MSG_FLAGS_ERR=
OR, TEXT(&quot;Unknown message type %d&quot;), msg.header.type);<br>
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

--0000000000002720af057750020c--

