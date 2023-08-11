From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 11 Aug 2023 14:44:22 +0000
In-Reply-To: <gerrit.1690550288000.I47c22dcb728011dcedaae47cd03a57219e9c7607@...2715...>
References: <gerrit.1690550288000.I47c22dcb728011dcedaae47cd03a57219e9c7607@...2715...>
Reply-To: arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., a@...2181...
Message-ID: <b280475ebac6c5065688b0793577ff1ff30e0fbf-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G8wR8GNkRk4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Set WINS
 servers via interactice service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, selvanair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--G8wR8GNkRk4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/321?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Set WINS servers via interactice service
......................................................................

Set WINS servers via interactice service

At the moments WINS servers are set either:

 - via DHCP, which works only for tap-windows6 driver
 - via netsh when running without interactice service

This means that in 2.6 default setup (interactive service and dco)
WINS is silently ignored.

Add WINS support for non-DHCP drivers (like dco) by passing
WINS settings to interactive service and set them there with
netsh call, similar approach as we use for setting DNS.

Fixes https://github.com/OpenVPN/openvpn/issues/373

Change-Id: I47c22dcb728011dcedaae47cd03a57219e9c7607
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20230728131246.694-1-lstipakov@...277...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26=
903.html
Signed-off-by: Gert Doering <gert@...1296...>
(cherry picked from commit 18826de5737789cb74b48fc40a9ff5cb37d38d98)
---
M include/openvpn-msg.h
M src/openvpn/tun.c
M src/openvpnserv/interactive.c
3 files changed, 226 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/321/4

diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 8cd2631..a1464cd 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -40,7 +40,9 @@
     msg_register_dns,
     msg_enable_dhcp,
     msg_register_ring_buffers,
-    msg_set_mtu
+    msg_set_mtu,
+    msg_add_wins_cfg,
+    msg_del_wins_cfg
 } message_type_t;

 typedef struct {
@@ -89,6 +91,13 @@
 typedef struct {
     message_header_t header;
     interface_t iface;
+    int addr_len;
+    inet_address_t addr[4]; /* support up to 4 dns addresses */
+} wins_cfg_message_t;
+
+typedef struct {
+    message_header_t header;
+    interface_t iface;
     int disable_nbt;
     int nbt_type;
     char scope_id[256];
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index af959bb..1f2539d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -282,6 +282,72 @@
 }

 static bool
+do_wins_service(bool add, const struct tuntap *tt)
+{
+    bool ret =3D false;
+    ack_message_t ack;
+    struct gc_arena gc =3D gc_new();
+    HANDLE pipe =3D tt->options.msg_channel;
+    int len =3D tt->options.wins_len;
+    int addr_len =3D add ? len : 0;
+
+    if (addr_len =3D=3D 0 && add) /* no addresses to add */
+    {
+        return true;
+    }
+
+    wins_cfg_message_t wins =3D {
+        .header =3D {
+            (add ? msg_add_wins_cfg : msg_del_wins_cfg),
+            sizeof(wins_cfg_message_t),
+            0
+        },
+        .iface =3D {.index =3D tt->adapter_index, .name =3D "" },
+        .addr_len =3D addr_len
+    };
+
+    /* interface name is required */
+    strncpy(wins.iface.name, tt->actual_name, sizeof(wins.iface.name));
+    wins.iface.name[sizeof(wins.iface.name) - 1] =3D '\0';
+
+    if (addr_len > _countof(wins.addr))
+    {
+        addr_len =3D _countof(wins.addr);
+        wins.addr_len =3D addr_len;
+        msg(M_WARN, "Number of WINS addresses sent to service truncated to=
 %d",
+            addr_len);
+    }
+
+    for (int i =3D 0; i < addr_len; ++i)
+    {
+        wins.addr[i].ipv4.s_addr =3D htonl(tt->options.wins[i]);
+    }
+
+    msg(D_LOW, "%s WINS servers on '%s' (if_index =3D %d) using service",
+        (add ? "Setting" : "Deleting"), wins.iface.name, wins.iface.index);
+
+    if (!send_msg_iservice(pipe, &wins, sizeof(wins), &ack, "TUN"))
+    {
+        goto out;
+    }
+
+    if (ack.error_number !=3D NO_ERROR)
+    {
+        msg(M_WARN, "TUN: %s WINS failed using service: %s [status=3D%u if=
_name=3D%s]",
+            (add ? "adding" : "deleting"), strerror_win32(ack.error_number=
, &gc),
+            ack.error_number, wins.iface.name);
+        goto out;
+    }
+
+    msg(M_INFO, "WINS servers %s using service", (add ? "set" : "deleted")=
);
+    ret =3D true;
+
+out:
+    gc_free(&gc);
+    return ret;
+}
+
+static bool
 do_set_mtu_service(const struct tuntap *tt, const short family, const int =
mtu)
 {
     bool ret =3D false;
@@ -1557,6 +1623,7 @@
         do_address_service(true, AF_INET, tt);
         do_dns_service(true, AF_INET, tt);
         do_dns_domain_service(true, tt);
+        do_wins_service(true, tt);
     }
     else
     {
@@ -6979,6 +7046,7 @@
         }
         else if (tt->options.msg_channel)
         {
+            do_wins_service(false, tt);
             do_dns_domain_service(false, tt);
             do_dns_service(false, AF_INET, tt);
             do_address_service(false, AF_INET, tt);
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index d73cef0..a47db8a 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -93,6 +93,7 @@
     undo_dns6,
     undo_domain,
     undo_ring_buffer,
+    undo_wins,
     _undo_type_max
 } undo_type_t;
 typedef list_item_t *undo_lists_t[_undo_type_max];
@@ -1084,6 +1085,63 @@
 }

 /**
+ * Run the command: netsh interface ip $action wins $if_name [static] $addr
+ * @param  action      "delete", "add" or "set"
+ * @param  if_name     "name_of_interface"
+ * @param  addr        IPv4 address as a string
+ *
+ * If addr is null and action =3D "delete" all addresses are deleted.
+ * if action =3D "set" then "static" is added before $addr
+ */
+static DWORD
+netsh_wins_cmd(const wchar_t *action, const wchar_t *if_name, const wchar_=
t *addr)
+{
+    DWORD err =3D 0;
+    int timeout =3D 30000; /* in msec */
+    wchar_t argv0[MAX_PATH];
+    wchar_t *cmdline =3D NULL;
+    const wchar_t *addr_static =3D (wcscmp(action, L"set") =3D=3D 0) ? L"s=
tatic" : L"";
+
+    if (!addr)
+    {
+        if (wcscmp(action, L"delete") =3D=3D 0)
+        {
+            addr =3D L"all";
+        }
+        else /* nothing to do -- return success*/
+        {
+            goto out;
+        }
+    }
+
+    /* Path of netsh */
+    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path=
(), L"netsh.exe");
+
+    /* cmd template:
+     * netsh interface ip $action wins $if_name $static $addr
+     */
+    const wchar_t *fmt =3D L"netsh interface ip %ls wins \"%ls\" %ls %ls";
+
+    /* max cmdline length in wchars -- include room for worst case and som=
e */
+    size_t ncmdline =3D wcslen(fmt) + wcslen(if_name) + wcslen(action) + w=
cslen(addr)
+                      +wcslen(addr_static) + 32 + 1;
+    cmdline =3D malloc(ncmdline * sizeof(wchar_t));
+    if (!cmdline)
+    {
+        err =3D ERROR_OUTOFMEMORY;
+        goto out;
+    }
+
+    openvpn_swprintf(cmdline, ncmdline, fmt, action, if_name, addr_static,=
 addr);
+
+    err =3D ExecCommand(argv0, cmdline, timeout);
+
+out:
+    free(cmdline);
+    return err;
+}
+
+/**
  * Run command: wmic nicconfig (InterfaceIndex=3D$if_index) call $action (=
$data)
  * @param  if_index    "index of interface"
  * @param  action      e.g., "SetDNSDomain"
@@ -1299,6 +1357,86 @@
 }

 static DWORD
+HandleWINSConfigMessage(const wins_cfg_message_t *msg, undo_lists_t *lists)
+{
+    DWORD err =3D 0;
+    wchar_t addr[16]; /* large enough to hold string representation of an =
ipv4 */
+    int addr_len =3D msg->addr_len;
+
+    /* sanity check */
+    if (addr_len > _countof(msg->addr))
+    {
+        addr_len =3D _countof(msg->addr);
+    }
+
+    if (!msg->iface.name[0]) /* interface name is required */
+    {
+        return ERROR_MESSAGE_DATA;
+    }
+
+    /* use a non-const reference with limited scope to enforce null-termin=
ation of strings from client */
+    {
+        wins_cfg_message_t *msgptr =3D (wins_cfg_message_t *)msg;
+        msgptr->iface.name[_countof(msg->iface.name) - 1] =3D '\0';
+    }
+
+    wchar_t *wide_name =3D utf8to16(msg->iface.name); /* utf8 to wide-char=
 */
+    if (!wide_name)
+    {
+        return ERROR_OUTOFMEMORY;
+    }
+
+    /* We delete all current addresses before adding any
+     * OR if the message type is del_wins_cfg
+     */
+    if (addr_len > 0 || msg->header.type =3D=3D msg_del_wins_cfg)
+    {
+        err =3D netsh_wins_cmd(L"delete", wide_name, NULL);
+        if (err)
+        {
+            goto out;
+        }
+        free(RemoveListItem(&(*lists)[undo_wins], CmpWString, wide_name));
+    }
+
+    if (msg->header.type =3D=3D msg_del_wins_cfg)
+    {
+        goto out;  /* job done */
+    }
+
+    for (int i =3D 0; i < addr_len; ++i)
+    {
+        RtlIpv4AddressToStringW(&msg->addr[i].ipv4, addr);
+        err =3D netsh_wins_cmd(i =3D=3D 0 ? L"set" : L"add", wide_name, ad=
dr);
+        if (i =3D=3D 0 && err)
+        {
+            goto out;
+        }
+        /* We do not check for duplicate addresses, so any error in adding
+         * additional addresses is ignored.
+         */
+    }
+
+    err =3D 0;
+
+    if (addr_len > 0)
+    {
+        wchar_t *tmp_name =3D _wcsdup(wide_name);
+        if (!tmp_name || AddListItem(&(*lists)[undo_wins], tmp_name))
+        {
+            free(tmp_name);
+            netsh_wins_cmd(L"delete", wide_name, NULL);
+            err =3D ERROR_OUTOFMEMORY;
+            goto out;
+        }
+    }
+
+out:
+    free(wide_name);
+    return err;
+}
+
+static DWORD
 HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
 {
     DWORD err =3D 0;
@@ -1487,6 +1625,7 @@
         enable_dhcp_message_t dhcp;
         register_ring_buffers_message_t rrb;
         set_mtu_message_t mtu;
+        wins_cfg_message_t wins;
     } msg;
     ack_message_t ack =3D {
         .header =3D {
@@ -1547,6 +1686,11 @@
             ack.error_number =3D HandleDNSConfigMessage(&msg.dns, lists);
             break;

+        case msg_add_wins_cfg:
+        case msg_del_wins_cfg:
+            ack.error_number =3D HandleWINSConfigMessage(&msg.wins, lists);
+            break;
+
         case msg_enable_dhcp:
             if (msg.header.size =3D=3D sizeof(msg.dhcp))
             {
@@ -1608,6 +1752,10 @@
                     DeleteDNS(AF_INET6, item->data);
                     break;

+                case undo_wins:
+                    netsh_wins_cmd(L"delete", item->data, NULL);
+                    break;
+
                 case undo_domain:
                     SetDNSDomain(item->data, "", NULL);
                     break;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/321?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I47c22dcb728011dcedaae47cd03a57219e9c7607
Gerrit-Change-Number: 321
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--G8wR8GNkRk4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/321?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Set WINS servers via interactice service<br><=
br>At the moments WINS servers are set either:<br><br> - via DHCP, which wo=
rks only for tap-windows6 driver<br> - via netsh when running without inter=
actice service<br><br>This means that in 2.6 default setup (interactive ser=
vice and dco)<br>WINS is silently ignored.<br><br>Add WINS support for non-=
DHCP drivers (like dco) by passing<br>WINS settings to interactive service =
and set them there with<br>netsh call, similar approach as we use for setti=
ng DNS.<br><br>Fixes https://github.com/OpenVPN/openvpn/issues/373<br><br>C=
hange-Id: I47c22dcb728011dcedaae47cd03a57219e9c7607<br>Signed-off-by: Lev S=
tipakov &lt;lev@...515...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>Message-Id: &lt;20230728131246.694-1-lstipakov@...277...&gt;<=
br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/ms=
g26903.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>(cher=
ry picked from commit 18826de5737789cb74b48fc40a9ff5cb37d38d98)<br>---<br>M=
 include/openvpn-msg.h<br>M src/openvpn/tun.c<br>M src/openvpnserv/interact=
ive.c<br>3 files changed, 226 insertions(+), 1 deletion(-)<br><br></pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/321/4</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/include/openvpn-msg.h b/include/openvpn-msg.h</span><br><span>ind=
ex 8cd2631..a1464cd 100644</span><br><span>--- a/include/openvpn-msg.h</spa=
n><br><span>+++ b/include/openvpn-msg.h</span><br><span>@@ -40,7 +40,9 @@</=
span><br><span>     msg_register_dns,</span><br><span>     msg_enable_dhcp,=
</span><br><span>     msg_register_ring_buffers,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    msg_set_mtu</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    msg_set_mtu,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    msg_add_wins_cfg,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg_del_wins_cfg</span><br><span> } message_type_=
t;</span><br><span> </span><br><span> typedef struct {</span><br><span>@@ -=
89,6 +91,13 @@</span><br><span> typedef struct {</span><br><span>     messa=
ge_header_t header;</span><br><span>     interface_t iface;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    int addr_len;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    inet_address_t addr[4]; /* suppor=
t up to 4 dns addresses */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+} wins_cfg_message_t;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef st=
ruct {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    message_h=
eader_t header;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
interface_t iface;</span><br><span>     int disable_nbt;</span><br><span>  =
   int nbt_type;</span><br><span>     char scope_id[256];</span><br><span>d=
iff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index af9=
59bb..1f2539d 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><spa=
n>+++ b/src/openvpn/tun.c</span><br><span>@@ -282,6 +282,72 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+do_wins_service(bool add, const struct tu=
ntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ack_message_t ack;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
HANDLE pipe =3D tt-&gt;options.msg_channel;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int len =3D tt-&gt;options.wins_len;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int addr_len =3D add ? len=
 : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (addr_len =3D=3D 0 &amp;&a=
mp; add) /* no addresses to add */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    wins_cfg_message_t wins =3D=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        .header =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            (a=
dd ? msg_add_wins_cfg : msg_del_wins_cfg),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            sizeof(wins_cfg_message_t),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            0</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        .iface =3D {.index =3D tt-&gt;adapter_i=
ndex, .name =3D &quot;&quot; },</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        .addr_len =3D addr_len</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* in=
terface name is required */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    strncpy(wins.iface.name, tt-&gt;actual_name, sizeof(wins.iface.=
name));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wins.ifa=
ce.name[sizeof(wins.iface.name) - 1] =3D &#39;\0&#39;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (addr_len &gt; _countof(wins.addr))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        addr_len =3D _countof(wins.addr);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        wins.addr_len =3D ad=
dr_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_WARN, &quot;Number of WINS addresses sent to service truncated to %d&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            addr_=
len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; addr_len; ++i)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        wins.addr[i].ipv4.s_addr =3D =
htonl(tt-&gt;options.wins[i]);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;%=
s WINS servers on &#39;%s&#39; (if_index =3D %d) using service&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        (add ? &quot;Sett=
ing&quot; : &quot;Deleting&quot;), wins.iface.name, wins.iface.index);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!send_msg_iservice(pipe, &amp;win=
s, sizeof(wins), &amp;ack, &quot;TUN&quot;))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ack.error_number=
 !=3D NO_ERROR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN=
, &quot;TUN: %s WINS failed using service: %s [status=3D%u if_name=3D%s]&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            (ad=
d ? &quot;adding&quot; : &quot;deleting&quot;), strerror_win32(ack.error_nu=
mber, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        ack.error_number, wins.iface.name);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_I=
NFO, &quot;WINS servers %s using service&quot;, (add ? &quot;set&quot; : &q=
uot;deleted&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ret =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static bool</span><br><span> do_set_mtu_service(const struct tuntap *tt, c=
onst short family, const int mtu)</span><br><span> {</span><br><span>     b=
ool ret =3D false;</span><br><span>@@ -1557,6 +1623,7 @@</span><br><span>  =
       do_address_service(true, AF_INET, tt);</span><br><span>         do_d=
ns_service(true, AF_INET, tt);</span><br><span>         do_dns_domain_servi=
ce(true, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  do_wins_service(true, tt);</span><br><span>     }</span><br><span>     el=
se</span><br><span>     {</span><br><span>@@ -6979,6 +7046,7 @@</span><br><=
span>         }</span><br><span>         else if (tt-&gt;options.msg_channe=
l)</span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            do_wins_service(false, tt);</span><br><span>         =
    do_dns_domain_service(false, tt);</span><br><span>             do_dns_s=
ervice(false, AF_INET, tt);</span><br><span>             do_address_service=
(false, AF_INET, tt);</span><br><span>diff --git a/src/openvpnserv/interact=
ive.c b/src/openvpnserv/interactive.c</span><br><span>index d73cef0..a47db8=
a 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><spa=
n>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -93,6 +93,7 @@</sp=
an><br><span>     undo_dns6,</span><br><span>     undo_domain,</span><br><s=
pan>     undo_ring_buffer,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    undo_wins,</span><br><span>     _undo_type_max</span><br><span> =
} undo_type_t;</span><br><span> typedef list_item_t *undo_lists_t[_undo_typ=
e_max];</span><br><span>@@ -1084,6 +1085,63 @@</span><br><span> }</span><br=
><span> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Run the command: netsh interface ip $action wins $if_name [sta=
tic] $addr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
  action      &quot;delete&quot;, &quot;add&quot; or &quot;set&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  if_name     &qu=
ot;name_of_interface&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param  addr        IPv4 address as a string</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * If addr is null and action =3D &quot;delete&quot; all =
addresses are deleted.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * if action =3D &quot;set&quot; then &quot;static&quot; is added before=
 $addr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static DWORD</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+netsh_wins_cmd(const wchar_t *action=
, const wchar_t *if_name, const wchar_t *addr)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    DWORD err =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int timeout =3D 30000; /* in msec */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    wchar_t argv0[MAX_PATH];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    wchar_t *cmdline =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const wchar_t *addr_=
static =3D (wcscmp(action, L&quot;set&quot;) =3D=3D 0) ? L&quot;static&quot=
; : L&quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!addr)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (wcscmp(action, L&quot;delet=
e&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 addr =3D L&quot;all&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else /* nothing to do -- return success*/</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            goto out;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Path of netsh */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_swprint=
f(argv0, _countof(argv0), L&quot;%ls\\%ls&quot;, get_win_sys_path(), L&quot=
;netsh.exe&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* cmd template:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * netsh interf=
ace ip $action wins $if_name $static $addr</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const wchar_t *fmt =3D L&quot;netsh interface ip %ls wins \&=
quot;%ls\&quot; %ls %ls&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* m=
ax cmdline length in wchars -- include room for worst case and some */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t ncmdline =3D =
wcslen(fmt) + wcslen(if_name) + wcslen(action) + wcslen(addr)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                      +wcslen(add=
r_static) + 32 + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    cmdline =3D malloc(ncmdline * sizeof(wchar_t));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!cmdline)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        err =3D ERROR_OUTOFMEMORY;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    openvpn_swprintf(cmdline, ncmdline, fmt, action, if_name, addr_static,=
 addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    err =3D ExecCommand(argv0, =
cmdline, timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    free(cmdline);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return err;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span>  * Run command: wmic nicconfig (InterfaceIndex=3D$if_ind=
ex) call $action ($data)</span><br><span>  * @param  if_index    &quot;inde=
x of interface&quot;</span><br><span>  * @param  action      e.g., &quot;Se=
tDNSDomain&quot;</span><br><span>@@ -1299,6 +1357,86 @@</span><br><span> }<=
/span><br><span> </span><br><span> static DWORD</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+HandleWINSConfigMessage(const wins_cfg_message_=
t *msg, undo_lists_t *lists)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD=
 err =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wcha=
r_t addr[16]; /* large enough to hold string representation of an ipv4 */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int addr_len =3D =
msg-&gt;addr_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* sanity check *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (addr_len &=
gt; _countof(msg-&gt;addr))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  addr_len =3D _countof(msg-&gt;addr);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!msg-&=
gt;iface.name[0]) /* interface name is required */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return ERROR_MESSAGE_DATA;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* use a non-const reference with limited scope to enforce null-termin=
ation of strings from client */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      wins_cfg_message_t *msgptr =3D (wins_cfg_message_t *)msg;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msgptr-&gt;iface.name[_=
countof(msg-&gt;iface.name) - 1] =3D &#39;\0&#39;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  wchar_t *wide_name =3D utf8to16(msg-&gt;iface.name); /* utf8 to wide-char=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!wide_na=
me)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return ERROR_OUTOFMEMO=
RY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* We delete all current addresses before add=
ing any</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * OR if=
 the message type is del_wins_cfg</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (addr_len &gt; 0 || msg-&gt;header.type =3D=3D msg_del_wins_cfg)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        err =3D netsh_wins_cmd(L&qu=
ot;delete&quot;, wide_name, NULL);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (err)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  free(RemoveListItem(&amp;(*lists)[undo_wins], CmpWString, wide_name));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (msg-&gt;header.type =3D=3D msg_del_wins_cfg)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        goto out;  /* job done */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    for (int i =3D 0; i &lt; addr_len; ++i)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        RtlIpv4AddressToStringW(&amp;msg-&gt;=
addr[i].ipv4, addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        err =3D netsh_wins_cmd(i =3D=3D 0 ? L&quot;set&quot; : L&quot;add&=
quot;, wide_name, addr);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (i =3D=3D 0 &amp;&amp; err)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            goto out;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* We do not check for duplicate addresses, so any error in a=
dding</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * add=
itional addresses is ignored.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+         */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    err =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (addr_len &gt; 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        wchar_t *tmp_name =3D _wcsdup(wide_name);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (!tmp_name || AddListIt=
em(&amp;(*lists)[undo_wins], tmp_name))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            free(tmp_name);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            netsh_wins_cmd(L&quot;delete&quot;, wide_name=
, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 err =3D ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            goto out;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    free(wide_name);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return err;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static DWORD<=
/span><br><span> HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)=
</span><br><span> {</span><br><span>     DWORD err =3D 0;</span><br><span>@=
@ -1487,6 +1625,7 @@</span><br><span>         enable_dhcp_message_t dhcp;</=
span><br><span>         register_ring_buffers_message_t rrb;</span><br><spa=
n>         set_mtu_message_t mtu;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        wins_cfg_message_t wins;</span><br><span>     } msg;<=
/span><br><span>     ack_message_t ack =3D {</span><br><span>         .head=
er =3D {</span><br><span>@@ -1547,6 +1686,11 @@</span><br><span>           =
  ack.error_number =3D HandleDNSConfigMessage(&amp;msg.dns, lists);</span><=
br><span>             break;</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        case msg_add_wins_cfg:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        case msg_del_wins_cfg:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            ack.error_numb=
er =3D HandleWINSConfigMessage(&amp;msg.wins, lists);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         case msg_enable=
_dhcp:</span><br><span>             if (msg.header.size =3D=3D sizeof(msg.d=
hcp))</span><br><span>             {</span><br><span>@@ -1608,6 +1752,10 @@=
</span><br><span>                     DeleteDNS(AF_INET6, item-&gt;data);</=
span><br><span>                     break;</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                case undo_wins:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    ne=
tsh_wins_cmd(L&quot;delete&quot;, item-&gt;data, NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    break;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>               =
  case undo_domain:</span><br><span>                     SetDNSDomain(item-=
&gt;data, &quot;&quot;, NULL);</span><br><span>                     break;<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/321?usp=3Demail">change 321</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/321?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47c22dcb728011dcedaae47cd03=
a57219e9c7607 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 321 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--G8wR8GNkRk4=--

