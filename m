From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 3 Nov 2025 13:08:50 +0000
In-Reply-To: <gerrit.1761942169000.I5cf45cfe0567da8fb5d47118a432a35b358f3809@...2715...>
References: <gerrit.1761942169000.I5cf45cfe0567da8fb5d47118a432a35b358f3809@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <5954d2ac82210ec40535a4d97bb5a4ccc43aa126-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hDeEvzkLVoQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: iservice: use
 interface index with netsh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hDeEvzkLVoQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
37?usp=3Demail )

Change subject: iservice: use interface index with netsh
......................................................................

iservice: use interface index with netsh

We use the interface index with netsh everywhere else, so convert the
remaining invocations of netsh to index use as well.

Change-Id: I5cf45cfe0567da8fb5d47118a432a35b358f3809
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1337
Message-Id: <20251103091525.22108-1-gert@...1296...>
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 50 insertions(+), 57 deletions(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index c12d34f..b35005c 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1035,16 +1035,16 @@
 }

 /**
- * Run the command: netsh interface $proto $action dns $if_name $addr [val=
idate=3Dno]
+ * Run the command: netsh interface $proto $action dns $if_index $addr [va=
lidate=3Dno]
  * @param  action      "delete" or "add"
  * @param  proto       "ipv6" or "ip"
- * @param  if_name     "name_of_interface"
+ * @param  if_index     index of the interface to modify DNS for
  * @param  addr         IPv4 (for proto =3D ip) or IPv6 address as a string
  *
  * If addr is null and action =3D "delete" all addresses are deleted.
  */
 static DWORD
-netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *=
if_name, const wchar_t *addr)
+netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, int if_index, c=
onst wchar_t *addr)
 {
     DWORD err =3D 0;
     int timeout =3D 30000; /* in msec */
@@ -1069,10 +1069,10 @@
     /* cmd template:
      * netsh interface $proto $action dns $if_name $addr [validate=3Dno]
      */
-    const wchar_t *fmt =3D L"netsh interface %ls %ls dns \"%ls\" %ls";
+    const wchar_t *fmt =3D L"netsh interface %ls %ls dns %d %ls";

     /* max cmdline length in wchars -- include room for worst case and som=
e */
-    size_t ncmdline =3D wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 =
+ 1;
+    size_t ncmdline =3D wcslen(fmt) + 11 /*if_index*/ + wcslen(addr) + 32 =
+ 1;
     cmdline =3D malloc(ncmdline*sizeof(wchar_t));
     if (!cmdline)
     {
@@ -1080,7 +1080,7 @@
         goto out;
     }

-    openvpn_swprintf(cmdline, ncmdline, fmt, proto, action, if_name, addr);
+    openvpn_swprintf(cmdline, ncmdline, fmt, proto, action, if_index, addr=
);

     if (IsWindows7OrGreater())
     {
@@ -1094,16 +1094,16 @@
 }

 /**
- * Run the command: netsh interface ip $action wins $if_name [static] $addr
+ * Run the command: netsh interface ip $action wins $if_index [static] $ad=
dr
  * @param  action      "delete", "add" or "set"
- * @param  if_name     "name_of_interface"
+ * @param  if_index    index of the interface to modify WINS for
  * @param  addr        IPv4 address as a string
  *
  * If addr is null and action =3D "delete" all addresses are deleted.
  * if action =3D "set" then "static" is added before $addr
  */
 static DWORD
-netsh_wins_cmd(const wchar_t *action, const wchar_t *if_name, const wchar_=
t *addr)
+netsh_wins_cmd(const wchar_t *action, int if_index, const wchar_t *addr)
 {
     DWORD err =3D 0;
     int timeout =3D 30000; /* in msec */
@@ -1129,11 +1129,11 @@
     /* cmd template:
      * netsh interface ip $action wins $if_name $static $addr
      */
-    const wchar_t *fmt =3D L"netsh interface ip %ls wins \"%ls\" %ls %ls";
+    const wchar_t *fmt =3D L"netsh interface ip %ls wins %d %ls %ls";

     /* max cmdline length in wchars -- include room for worst case and som=
e */
-    size_t ncmdline =3D wcslen(fmt) + wcslen(if_name) + wcslen(action) + w=
cslen(addr)
-                      +wcslen(addr_static) + 32 + 1;
+    size_t ncmdline =3D wcslen(fmt) + 11 /*if_index*/ + wcslen(action) + w=
cslen(addr)
+                      + wcslen(addr_static) + 32 + 1;
     cmdline =3D malloc(ncmdline * sizeof(wchar_t));
     if (!cmdline)
     {
@@ -1141,7 +1141,7 @@
         goto out;
     }

-    openvpn_swprintf(cmdline, ncmdline, fmt, action, if_name, addr_static,=
 addr);
+    openvpn_swprintf(cmdline, ncmdline, fmt, action, if_index, addr_static=
, addr);

     err =3D ExecCommand(argv0, cmdline, timeout);

@@ -1184,18 +1184,18 @@

 /* Delete all IPv4 or IPv6 dns servers for an interface */
 static DWORD
-DeleteDNS(short family, wchar_t *if_name)
+DeleteDNS(short family, int if_index)
 {
     wchar_t *proto =3D (family =3D=3D AF_INET6) ? L"ipv6" : L"ip";
-    return netsh_dns_cmd(L"delete", proto, if_name, NULL);
+    return netsh_dns_cmd(L"delete", proto, if_index, NULL);
 }

 /* Add an IPv4 or IPv6 dns server to an interface */
 static DWORD
-AddDNS(short family, wchar_t *if_name, wchar_t *addr)
+AddDNS(short family, int if_index, wchar_t *addr)
 {
     wchar_t *proto =3D (family =3D=3D AF_INET6) ? L"ipv6" : L"ip";
-    return netsh_dns_cmd(L"add", proto, if_name, addr);
+    return netsh_dns_cmd(L"add", proto, if_index, addr);
 }

 static BOOL
@@ -1295,12 +1295,12 @@
      */
     if (addr_len > 0 || msg->header.type =3D=3D msg_del_dns_cfg)
     {
-        err =3D DeleteDNS(msg->family, wide_name);
+        err =3D DeleteDNS(msg->family, msg->iface.index);
         if (err)
         {
             goto out;
         }
-        free(RemoveListItem(&(*lists)[undo_type], CmpWString, wide_name));
+        free(RemoveListItem(&(*lists)[undo_type], CmpAny, NULL));
     }

     if (msg->header.type =3D=3D msg_del_dns_cfg)
@@ -1323,7 +1323,7 @@
         {
             RtlIpv4AddressToStringW(&msg->addr[i].ipv4, addr);
         }
-        err =3D AddDNS(msg->family, wide_name, addr);
+        err =3D AddDNS(msg->family, msg->iface.index, addr);
         if (i =3D=3D 0 && err)
         {
             goto out;
@@ -1337,11 +1337,15 @@

     if (msg->addr_len > 0)
     {
-        wchar_t *tmp_name =3D _wcsdup(wide_name);
-        if (!tmp_name || AddListItem(&(*lists)[undo_type], tmp_name))
+        int *tmp_index =3D malloc(sizeof(msg->iface.index));
+        if (tmp_index)
         {
-            free(tmp_name);
-            DeleteDNS(msg->family, wide_name);
+            *tmp_index =3D msg->iface.index;
+        }
+        if (!tmp_index || AddListItem(&(*lists)[undo_type], tmp_index))
+        {
+            free(tmp_index);
+            DeleteDNS(msg->family, msg->iface.index);
             err =3D ERROR_OUTOFMEMORY;
             goto out;
         }
@@ -1360,7 +1364,7 @@
 static DWORD
 HandleWINSConfigMessage(const wins_cfg_message_t *msg, undo_lists_t *lists)
 {
-    DWORD err =3D 0;
+    DWORD err =3D NO_ERROR;
     wchar_t addr[16]; /* large enough to hold string representation of an =
ipv4 */
     int addr_len =3D msg->addr_len;

@@ -1370,37 +1374,25 @@
         addr_len =3D _countof(msg->addr);
     }

-    if (!msg->iface.name[0]) /* interface name is required */
+    if (!msg->iface.index) /* interface index is required */
     {
         return ERROR_MESSAGE_DATA;
     }

-    /* use a non-const reference with limited scope to enforce null-termin=
ation of strings from client */
-    {
-        wins_cfg_message_t *msgptr =3D (wins_cfg_message_t *)msg;
-        msgptr->iface.name[_countof(msg->iface.name) - 1] =3D '\0';
-    }
-
-    wchar_t *wide_name =3D utf8to16(msg->iface.name); /* utf8 to wide-char=
 */
-    if (!wide_name)
-    {
-        return ERROR_OUTOFMEMORY;
-    }
-
     /* We delete all current addresses before adding any
      * OR if the message type is del_wins_cfg
      */
     if (addr_len > 0 || msg->header.type =3D=3D msg_del_wins_cfg)
     {
-        err =3D netsh_wins_cmd(L"delete", wide_name, NULL);
+        err =3D netsh_wins_cmd(L"delete", msg->iface.index, NULL);
         if (err)
         {
             goto out;
         }
-        free(RemoveListItem(&(*lists)[undo_wins], CmpWString, wide_name));
+        free(RemoveListItem(&(*lists)[undo_wins], CmpAny, NULL));
     }

-    if (msg->header.type =3D=3D msg_del_wins_cfg)
+    if (addr_len =3D=3D 0 || msg->header.type =3D=3D msg_del_wins_cfg)
     {
         goto out;  /* job done */
     }
@@ -1408,7 +1400,7 @@
     for (int i =3D 0; i < addr_len; ++i)
     {
         RtlIpv4AddressToStringW(&msg->addr[i].ipv4, addr);
-        err =3D netsh_wins_cmd(i =3D=3D 0 ? L"set" : L"add", wide_name, ad=
dr);
+        err =3D netsh_wins_cmd(i =3D=3D 0 ? L"set" : L"add", msg->iface.in=
dex, addr);
         if (i =3D=3D 0 && err)
         {
             goto out;
@@ -1418,22 +1410,23 @@
          */
     }

-    err =3D 0;
-
-    if (addr_len > 0)
+    int *if_index =3D malloc(sizeof(msg->iface.index));
+    if (if_index)
     {
-        wchar_t *tmp_name =3D _wcsdup(wide_name);
-        if (!tmp_name || AddListItem(&(*lists)[undo_wins], tmp_name))
-        {
-            free(tmp_name);
-            netsh_wins_cmd(L"delete", wide_name, NULL);
-            err =3D ERROR_OUTOFMEMORY;
-            goto out;
-        }
+        *if_index =3D msg->iface.index;
     }

+    if (!if_index || AddListItem(&(*lists)[undo_wins], if_index))
+    {
+        free(if_index);
+        netsh_wins_cmd(L"delete", msg->iface.index, NULL);
+        err =3D ERROR_OUTOFMEMORY;
+        goto out;
+    }
+
+    err =3D 0;
+
 out:
-    free(wide_name);
     return err;
 }

@@ -1734,15 +1727,15 @@
                     break;

                 case undo_dns4:
-                    DeleteDNS(AF_INET, item->data);
+                    DeleteDNS(AF_INET, *(int *)item->data);
                     break;

                 case undo_dns6:
-                    DeleteDNS(AF_INET6, item->data);
+                    DeleteDNS(AF_INET6, *(int *)item->data);
                     break;

                 case undo_wins:
-                    netsh_wins_cmd(L"delete", item->data, NULL);
+                    netsh_wins_cmd(L"delete", *(int *)item->data, NULL);
                     break;

                 case undo_domain:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1337?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I5cf45cfe0567da8fb5d47118a432a35b358f3809
Gerrit-Change-Number: 1337
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hDeEvzkLVoQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1337?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">iservice: use interface index with netsh<br><br>=
We use the interface index with netsh everywhere else, so convert the<br>re=
maining invocations of netsh to index use as well.<br><br>Change-Id: I5cf45=
cfe0567da8fb5d47118a432a35b358f3809<br>Signed-off-by: Heiko Hund &lt;heiko@=
...2662...&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Ger=
rit URL: https://gerrit.openvpn.net/c/openvpn/+/1337<br>Message-Id: &lt;202=
51103091525.22108-1-gert@...1296...&gt;<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file cha=
nged, 50 insertions(+), 57 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index c12d34f..b35005c 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -1035,16 +1035,16 @@</span><br><span> }</span><br><sp=
an> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * Run the command: netsh interface $proto $action dns $if_name $addr [=
validate=3Dno]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Ru=
n the command: netsh interface $proto $action dns $if_index $addr [validate=
=3Dno]</span><br><span>  * @param  action      &quot;delete&quot; or &quot;=
add&quot;</span><br><span>  * @param  proto       &quot;ipv6&quot; or &quot=
;ip&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  i=
f_name     &quot;name_of_interface&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param  if_index     index of the interface to modi=
fy DNS for</span><br><span>  * @param  addr         IPv4 (for proto =3D ip)=
 or IPv6 address as a string</span><br><span>  *</span><br><span>  * If add=
r is null and action =3D &quot;delete&quot; all addresses are deleted.</spa=
n><br><span>  */</span><br><span> static DWORD</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-netsh_dns_cmd(const wchar_t *action, const wchar_t=
 *proto, const wchar_t *if_name, const wchar_t *addr)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+netsh_dns_cmd(const wchar_t *action, cons=
t wchar_t *proto, int if_index, const wchar_t *addr)</span><br><span> {</sp=
an><br><span>     DWORD err =3D 0;</span><br><span>     int timeout =3D 300=
00; /* in msec */</span><br><span>@@ -1069,10 +1069,10 @@</span><br><span> =
    /* cmd template:</span><br><span>      * netsh interface $proto $action=
 dns $if_name $addr [validate=3Dno]</span><br><span>      */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const wchar_t *fmt =3D L&quot;ne=
tsh interface %ls %ls dns \&quot;%ls\&quot; %ls&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const wchar_t *fmt =3D L&quot;netsh =
interface %ls %ls dns %d %ls&quot;;</span><br><span> </span><br><span>     =
/* max cmdline length in wchars -- include room for worst case and some */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t ncmdline =
=3D wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 + 1;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    size_t ncmdline =3D wcslen(fmt) =
+ 11 /*if_index*/ + wcslen(addr) + 32 + 1;</span><br><span>     cmdline =3D=
 malloc(ncmdline*sizeof(wchar_t));</span><br><span>     if (!cmdline)</span=
><br><span>     {</span><br><span>@@ -1080,7 +1080,7 @@</span><br><span>   =
      goto out;</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    openvpn_swprintf(cmdline, ncmdline, =
fmt, proto, action, if_name, addr);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    openvpn_swprintf(cmdline, ncmdline, fmt, proto, action,=
 if_index, addr);</span><br><span> </span><br><span>     if (IsWindows7OrGr=
eater())</span><br><span>     {</span><br><span>@@ -1094,16 +1094,16 @@</sp=
an><br><span> }</span><br><span> </span><br><span> /**</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * Run the command: netsh interface ip $ac=
tion wins $if_name [static] $addr</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Run the command: netsh interface ip $action wins $if_index=
 [static] $addr</span><br><span>  * @param  action      &quot;delete&quot;,=
 &quot;add&quot; or &quot;set&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * @param  if_name     &quot;name_of_interface&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  if_index    index=
 of the interface to modify WINS for</span><br><span>  * @param  addr      =
  IPv4 address as a string</span><br><span>  *</span><br><span>  * If addr =
is null and action =3D &quot;delete&quot; all addresses are deleted.</span>=
<br><span>  * if action =3D &quot;set&quot; then &quot;static&quot; is adde=
d before $addr</span><br><span>  */</span><br><span> static DWORD</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-netsh_wins_cmd(const wchar_t *a=
ction, const wchar_t *if_name, const wchar_t *addr)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+netsh_wins_cmd(const wchar_t *action, int=
 if_index, const wchar_t *addr)</span><br><span> {</span><br><span>     DWO=
RD err =3D 0;</span><br><span>     int timeout =3D 30000; /* in msec */</sp=
an><br><span>@@ -1129,11 +1129,11 @@</span><br><span>     /* cmd template:<=
/span><br><span>      * netsh interface ip $action wins $if_name $static $a=
ddr</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const wchar_t *fmt =3D L&quot;netsh interface ip %ls wins \&quot=
;%ls\&quot; %ls %ls&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const wchar_t *fmt =3D L&quot;netsh interface ip %ls wins %d %ls=
 %ls&quot;;</span><br><span> </span><br><span>     /* max cmdline length in=
 wchars -- include room for worst case and some */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    size_t ncmdline =3D wcslen(fmt) + wcslen(i=
f_name) + wcslen(action) + wcslen(addr)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                      +wcslen(addr_static) + 32 + 1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t ncmdline =3D =
wcslen(fmt) + 11 /*if_index*/ + wcslen(action) + wcslen(addr)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                      + wcslen(ad=
dr_static) + 32 + 1;</span><br><span>     cmdline =3D malloc(ncmdline * siz=
eof(wchar_t));</span><br><span>     if (!cmdline)</span><br><span>     {</s=
pan><br><span>@@ -1141,7 +1141,7 @@</span><br><span>         goto out;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    openvpn_swprintf(cmdline, ncmdline, fmt, action, if_name=
, addr_static, addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    openvpn_swprintf(cmdline, ncmdline, fmt, action, if_index, addr_stati=
c, addr);</span><br><span> </span><br><span>     err =3D ExecCommand(argv0,=
 cmdline, timeout);</span><br><span> </span><br><span>@@ -1184,18 +1184,18 =
@@</span><br><span> </span><br><span> /* Delete all IPv4 or IPv6 dns server=
s for an interface */</span><br><span> static DWORD</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-DeleteDNS(short family, wchar_t *if_name)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+DeleteDNS(short famil=
y, int if_index)</span><br><span> {</span><br><span>     wchar_t *proto =3D=
 (family =3D=3D AF_INET6) ? L&quot;ipv6&quot; : L&quot;ip&quot;;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return netsh_dns_cmd(L&quot;=
delete&quot;, proto, if_name, NULL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return netsh_dns_cmd(L&quot;delete&quot;, proto, if_in=
dex, NULL);</span><br><span> }</span><br><span> </span><br><span> /* Add an=
 IPv4 or IPv6 dns server to an interface */</span><br><span> static DWORD</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-AddDNS(short family, wc=
har_t *if_name, wchar_t *addr)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+AddDNS(short family, int if_index, wchar_t *addr)</span><br><spa=
n> {</span><br><span>     wchar_t *proto =3D (family =3D=3D AF_INET6) ? L&q=
uot;ipv6&quot; : L&quot;ip&quot;;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return netsh_dns_cmd(L&quot;add&quot;, proto, if_name, addr=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return netsh_=
dns_cmd(L&quot;add&quot;, proto, if_index, addr);</span><br><span> }</span>=
<br><span> </span><br><span> static BOOL</span><br><span>@@ -1295,12 +1295,=
12 @@</span><br><span>      */</span><br><span>     if (addr_len &gt; 0 || =
msg-&gt;header.type =3D=3D msg_del_dns_cfg)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D DeleteDNS(msg-=
&gt;family, wide_name);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        err =3D DeleteDNS(msg-&gt;family, msg-&gt;iface.index);</span><=
br><span>         if (err)</span><br><span>         {</span><br><span>     =
        goto out;</span><br><span>         }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        free(RemoveListItem(&amp;(*lists)[undo_type]=
, CmpWString, wide_name));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        free(RemoveListItem(&amp;(*lists)[undo_type], CmpAny, NULL))=
;</span><br><span>     }</span><br><span> </span><br><span>     if (msg-&gt=
;header.type =3D=3D msg_del_dns_cfg)</span><br><span>@@ -1323,7 +1323,7 @@<=
/span><br><span>         {</span><br><span>             RtlIpv4AddressToStr=
ingW(&amp;msg-&gt;addr[i].ipv4, addr);</span><br><span>         }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D AddDNS(msg-&gt;=
family, wide_name, addr);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        err =3D AddDNS(msg-&gt;family, msg-&gt;iface.index, addr);</s=
pan><br><span>         if (i =3D=3D 0 &amp;&amp; err)</span><br><span>     =
    {</span><br><span>             goto out;</span><br><span>@@ -1337,11 +1=
337,15 @@</span><br><span> </span><br><span>     if (msg-&gt;addr_len &gt; =
0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        wchar_t *tmp_name =3D _wcsdup(wide_name);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!tmp_name || AddListItem(&amp;(=
*lists)[undo_type], tmp_name))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        int *tmp_index =3D malloc(sizeof(msg-&gt;iface.index));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tmp_inde=
x)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            free(tmp_name);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            DeleteDNS(msg-&gt;family, wide_name);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            *tmp_index =3D msg-=
&gt;iface.index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
tmp_index || AddListItem(&amp;(*lists)[undo_type], tmp_index))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            free(tmp_index);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            DeleteDNS(msg-&gt;fa=
mily, msg-&gt;iface.index);</span><br><span>             err =3D ERROR_OUTO=
FMEMORY;</span><br><span>             goto out;</span><br><span>         }<=
/span><br><span>@@ -1360,7 +1364,7 @@</span><br><span> static DWORD</span><=
br><span> HandleWINSConfigMessage(const wins_cfg_message_t *msg, undo_lists=
_t *lists)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    DWORD err =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    DWORD err =3D NO_ERROR;</span><br><span>     wchar_t addr[16];=
 /* large enough to hold string representation of an ipv4 */</span><br><spa=
n>     int addr_len =3D msg-&gt;addr_len;</span><br><span> </span><br><span=
>@@ -1370,37 +1374,25 @@</span><br><span>         addr_len =3D _countof(msg=
-&gt;addr);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!msg-&gt;iface.name[0]) /* interfac=
e name is required */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!msg-&gt;iface.index) /* interface index is required */</span><br=
><span>     {</span><br><span>         return ERROR_MESSAGE_DATA;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    /* use a non-const reference with limited scope to enforce nu=
ll-termination of strings from client */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        wins_cfg_message_t *msgptr =3D (wins_cfg_message_t *)msg;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        msgptr-&gt;iface.nam=
e[_countof(msg-&gt;iface.name) - 1] =3D &#39;\0&#39;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    w=
char_t *wide_name =3D utf8to16(msg-&gt;iface.name); /* utf8 to wide-char */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!wide_name)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        return ERROR_OUTOFMEMORY;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* We delete all curr=
ent addresses before adding any</span><br><span>      * OR if the message t=
ype is del_wins_cfg</span><br><span>      */</span><br><span>     if (addr_=
len &gt; 0 || msg-&gt;header.type =3D=3D msg_del_wins_cfg)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D=
 netsh_wins_cmd(L&quot;delete&quot;, wide_name, NULL);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        err =3D netsh_wins_cmd(L&quot;de=
lete&quot;, msg-&gt;iface.index, NULL);</span><br><span>         if (err)</=
span><br><span>         {</span><br><span>             goto out;</span><br>=
<span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   free(RemoveListItem(&amp;(*lists)[undo_wins], CmpWString, wide_name));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(RemoveLi=
stItem(&amp;(*lists)[undo_wins], CmpAny, NULL));</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(msg-&gt;header.type =3D=3D msg_del_wins_cfg)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (addr_len =3D=3D 0 || msg-&gt;header.type =
=3D=3D msg_del_wins_cfg)</span><br><span>     {</span><br><span>         go=
to out;  /* job done */</span><br><span>     }</span><br><span>@@ -1408,7 +=
1400,7 @@</span><br><span>     for (int i =3D 0; i &lt; addr_len; ++i)</spa=
n><br><span>     {</span><br><span>         RtlIpv4AddressToStringW(&amp;ms=
g-&gt;addr[i].ipv4, addr);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        err =3D netsh_wins_cmd(i =3D=3D 0 ? L&quot;set&quot; : L&quot;=
add&quot;, wide_name, addr);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        err =3D netsh_wins_cmd(i =3D=3D 0 ? L&quot;set&quot; : L&q=
uot;add&quot;, msg-&gt;iface.index, addr);</span><br><span>         if (i =
=3D=3D 0 &amp;&amp; err)</span><br><span>         {</span><br><span>       =
      goto out;</span><br><span>@@ -1418,22 +1410,23 @@</span><br><span>   =
       */</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    err =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (addr_len &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int *if_index =3D malloc(sizeof(msg-&gt;iface.index));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (if_index)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        wch=
ar_t *tmp_name =3D _wcsdup(wide_name);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (!tmp_name || AddListItem(&amp;(*lists)[undo_wi=
ns], tmp_name))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            free(t=
mp_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
netsh_wins_cmd(L&quot;delete&quot;, wide_name, NULL);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            err =3D ERROR_OUTOFMEMORY;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto out;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        *if_index =3D msg-&gt;iface.=
index;</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!if_index || AddListItem(&amp;(*lists)[=
undo_wins], if_index))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fre=
e(if_index);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 netsh_wins_cmd(L&quot;delete&quot;, msg-&gt;iface.index, NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        err =3D ERROR_OUTOFMEM=
ORY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto ou=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    err =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> out:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    free(wide_name);</span><br><span>     return err;<=
/span><br><span> }</span><br><span> </span><br><span>@@ -1734,15 +1727,15 @=
@</span><br><span>                     break;</span><br><span> </span><br><=
span>                 case undo_dns4:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    DeleteDNS(AF_INET, item-&gt;data);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    Dele=
teDNS(AF_INET, *(int *)item-&gt;data);</span><br><span>                    =
 break;</span><br><span> </span><br><span>                 case undo_dns6:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    De=
leteDNS(AF_INET6, item-&gt;data);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    DeleteDNS(AF_INET6, *(int *)item-&gt;data=
);</span><br><span>                     break;</span><br><span> </span><br>=
<span>                 case undo_wins:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    netsh_wins_cmd(L&quot;delete&quot;, it=
em-&gt;data, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    netsh_wins_cmd(L&quot;delete&quot;, *(int *)item-&gt;da=
ta, NULL);</span><br><span>                     break;</span><br><span> </s=
pan><br><span>                 case undo_domain:</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
337?usp=3Demail">change 1337</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1337=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5cf45cfe0567da8fb5d47118a43=
2a35b358f3809 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1337 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--hDeEvzkLVoQ=--

