From: "d12fk (Code Review)" <gerrit@...515...>
Date: Wed, 4 Dec 2024 16:00:42 +0000
References: <gerrit.1733328040000.Id2bed0908e84c19b8fb6fe806376316793e550b4@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <51a3e4271eccec02ef4ecdd0031cd84457832677-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gYURjvbaWVQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns: do not use
 netsh to set name server addresses
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gYURjvbaWVQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail

to review the following change.


Change subject: dns: do not use netsh to set name server addresses
......................................................................

dns: do not use netsh to set name server addresses

Instead of spawning a netsh process, set the name server addresses
directly in the registry hive of the VPN interface.

This is a first step to get rid of the use of command line tools in the
service and move to a more API driven style of modifying the VPN adapter
configuration.

Change-Id: Id2bed0908e84c19b8fb6fe806376316793e550b4
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/interactive.c
1 file changed, 41 insertions(+), 115 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/825/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index cad8b02..8d000f1 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1024,65 +1024,6 @@
 }

 /**
- * Run the command: netsh interface $proto $action dns $if_name $addr [val=
idate=3Dno]
- * @param  action      "delete" or "add"
- * @param  proto       "ipv6" or "ip"
- * @param  if_name     "name_of_interface"
- * @param  addr         IPv4 (for proto =3D ip) or IPv6 address as a string
- *
- * If addr is null and action =3D "delete" all addresses are deleted.
- */
-static DWORD
-netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *=
if_name, const wchar_t *addr)
-{
-    DWORD err =3D 0;
-    int timeout =3D 30000; /* in msec */
-    wchar_t argv0[MAX_PATH];
-    wchar_t *cmdline =3D NULL;
-
-    if (!addr)
-    {
-        if (wcscmp(action, L"delete") =3D=3D 0)
-        {
-            addr =3D L"all";
-        }
-        else /* nothing to do -- return success*/
-        {
-            goto out;
-        }
-    }
-
-    /* Path of netsh */
-    swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"ne=
tsh.exe");
-
-    /* cmd template:
-     * netsh interface $proto $action dns $if_name $addr [validate=3Dno]
-     */
-    const wchar_t *fmt =3D L"netsh interface %ls %ls dns \"%ls\" %ls";
-
-    /* max cmdline length in wchars -- include room for worst case and som=
e */
-    size_t ncmdline =3D wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 =
+ 1;
-    cmdline =3D malloc(ncmdline*sizeof(wchar_t));
-    if (!cmdline)
-    {
-        err =3D ERROR_OUTOFMEMORY;
-        goto out;
-    }
-
-    swprintf(cmdline, ncmdline, fmt, proto, action, if_name, addr);
-
-    if (IsWindows7OrGreater())
-    {
-        wcscat_s(cmdline, ncmdline, L" validate=3Dno");
-    }
-    err =3D ExecCommand(argv0, cmdline, timeout);
-
-out:
-    free(cmdline);
-    return err;
-}
-
-/**
  * Run the command: netsh interface ip $action wins $if_name [static] $addr
  * @param  action      "delete", "add" or "set"
  * @param  if_name     "name_of_interface"
@@ -1139,22 +1080,6 @@
     return err;
 }

-/* Delete all IPv4 or IPv6 dns servers for an interface */
-static DWORD
-DeleteDNS(short family, wchar_t *if_name)
-{
-    wchar_t *proto =3D (family =3D=3D AF_INET6) ? L"ipv6" : L"ip";
-    return netsh_dns_cmd(L"delete", proto, if_name, NULL);
-}
-
-/* Add an IPv4 or IPv6 dns server to an interface */
-static DWORD
-AddDNS(short family, wchar_t *if_name, wchar_t *addr)
-{
-    wchar_t *proto =3D (family =3D=3D AF_INET6) ? L"ipv6" : L"ip";
-    return netsh_dns_cmd(L"add", proto, if_name, addr);
-}
-
 static BOOL
 CmpWString(LPVOID item, LPVOID str)
 {
@@ -1810,7 +1735,6 @@
 HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
 {
     DWORD err =3D 0;
-    wchar_t addr[46]; /* large enough to hold string representation of an =
ipv4 / ipv6 address */
     undo_type_t undo_type =3D (msg->family =3D=3D AF_INET6) ? undo_dns4 : =
undo_dns6;
     int addr_len =3D msg->addr_len;

@@ -1832,10 +1756,11 @@
         msgptr->domains[_countof(msg->domains)-1] =3D '\0';
     }

-    wchar_t *wide_name =3D utf8to16(msg->iface.name); /* utf8 to wide-char=
 */
-    if (!wide_name)
+    WCHAR iid[64];
+    err =3D InterfaceIdString(msg->iface.name, iid, _countof(iid));
+    if (err)
     {
-        return ERROR_OUTOFMEMORY;
+        return err;
     }

     /* We delete all current addresses before adding any
@@ -1843,12 +1768,12 @@
      */
     if (addr_len > 0 || msg->header.type =3D=3D msg_del_dns_cfg)
     {
-        err =3D DeleteDNS(msg->family, wide_name);
+        err =3D ResetNameServers(iid, msg->family);
         if (err)
         {
-            goto out;
+            return err;
         }
-        free(RemoveListItem(&(*lists)[undo_type], CmpWString, wide_name));
+        free(RemoveListItem(&(*lists)[undo_type], CmpAny, iid));
     }

     if (msg->header.type =3D=3D msg_del_dns_cfg)
@@ -1860,40 +1785,43 @@
             err =3D SetDnsSearchDomains(msg->iface.name, NULL, &gpol, list=
s);
         }
         ApplyDnsSettings(gpol);
-        goto out;  /* job done */
+        return err;  /* job done */
     }

-    for (int i =3D 0; i < addr_len; ++i)
-    {
-        if (msg->family =3D=3D AF_INET6)
-        {
-            RtlIpv6AddressToStringW(&msg->addr[i].ipv6, addr);
-        }
-        else
-        {
-            RtlIpv4AddressToStringW(&msg->addr[i].ipv4, addr);
-        }
-        err =3D AddDNS(msg->family, wide_name, addr);
-        if (i =3D=3D 0 && err)
-        {
-            goto out;
-        }
-        /* We do not check for duplicate addresses, so any error in adding
-         * additional addresses is ignored.
-         */
-    }
-
-    err =3D 0;
-
     if (msg->addr_len > 0)
     {
-        wchar_t *tmp_name =3D _wcsdup(wide_name);
-        if (!tmp_name || AddListItem(&(*lists)[undo_type], tmp_name))
+        /* prepare the comma separated address list */
+        CHAR addrs[256]; /* large enough to hold four IPv4 / IPv6 address =
strings */
+        size_t offset =3D 0;
+        for (int i =3D 0; i < addr_len; ++i)
         {
-            free(tmp_name);
-            DeleteDNS(msg->family, wide_name);
-            err =3D ERROR_OUTOFMEMORY;
-            goto out;
+            if (i !=3D 0)
+            {
+                addrs[offset++] =3D ',';
+            }
+            if (msg->family =3D=3D AF_INET6)
+            {
+                RtlIpv6AddressToStringA(&msg->addr[i].ipv6, addrs + offset=
);
+            }
+            else
+            {
+                RtlIpv4AddressToStringA(&msg->addr[i].ipv4, addrs + offset=
);
+            }
+            offset +=3D strlen(addrs);
+        }
+
+        err =3D SetNameServers(iid, msg->family, addrs);
+        if (err)
+        {
+            return err;
+        }
+
+        wchar_t *tmp_iid =3D _wcsdup(iid);
+        if (!tmp_iid || AddListItem(&(*lists)[undo_type], tmp_iid))
+        {
+            free(tmp_iid);
+            ResetNameServers(iid, msg->family);
+            return ERROR_OUTOFMEMORY;
         }
     }

@@ -1904,8 +1832,6 @@
     }
     ApplyDnsSettings(gpol);

-out:
-    free(wide_name);
     return err;
 }

@@ -2286,11 +2212,11 @@
                     break;

                 case undo_dns4:
-                    DeleteDNS(AF_INET, item->data);
+                    ResetNameServers(item->data, AF_INET);
                     break;

                 case undo_dns6:
-                    DeleteDNS(AF_INET6, item->data);
+                    ResetNameServers(item->data, AF_INET6);
                     break;

                     break;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id2bed0908e84c19b8fb6fe806376316793e550b4
Gerrit-Change-Number: 825
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--gYURjvbaWVQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dns: do not use netsh to set name server addresses<br><br>Ins=
tead of spawning a netsh process, set the name server addresses<br>directly=
 in the registry hive of the VPN interface.<br><br>This is a first step to =
get rid of the use of command line tools in the<br>service and move to a mo=
re API driven style of modifying the VPN adapter<br>configuration.<br><br>C=
hange-Id: Id2bed0908e84c19b8fb6fe806376316793e550b4<br>Signed-off-by: Heiko=
 Hund &lt;heiko@...2662...&gt;<br>---<br>M src/openvpnserv/interactive.c<br=
>1 file changed, 41 insertions(+), 115 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/25/825/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br>=
<span>index cad8b02..8d000f1 100644</span><br><span>--- a/src/openvpnserv/i=
nteractive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br>=
<span>@@ -1024,65 +1024,6 @@</span><br><span> }</span><br><span> </span><br=
><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Run the=
 command: netsh interface $proto $action dns $if_name $addr [validate=3Dno]=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  action    =
  &quot;delete&quot; or &quot;add&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * @param  proto       &quot;ipv6&quot; or &quot;ip&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  if_name   =
  &quot;name_of_interface&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param  addr         IPv4 (for proto =3D ip) or IPv6 address a=
s a string</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * If addr is null and action =
=3D &quot;delete&quot; all addresses are deleted.</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *=
if_name, const wchar_t *addr)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD er=
r =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int timeo=
ut =3D 30000; /* in msec */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    wchar_t argv0[MAX_PATH];</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    wchar_t *cmdline =3D NULL;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (!addr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (wcscmp(act=
ion, L&quot;delete&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            addr =3D L&quot;all&quot;;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        else /* nothing to do -- return success*/</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            goto out;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Path of netsh */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    swprintf(argv0, _cou=
ntof(argv0), L&quot;%ls\\%ls&quot;, get_win_sys_path(), L&quot;netsh.exe&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /* cmd template:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * netsh interface $proto $action =
dns $if_name $addr [validate=3Dno]</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   const wchar_t *fmt =3D L&quot;netsh interface %ls %ls dns \&quot;%ls\&qu=
ot; %ls&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* max cmdline length in=
 wchars -- include room for worst case and some */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    size_t ncmdline =3D wcslen(fmt) + wcslen(i=
f_name) + wcslen(addr) + 32 + 1;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    cmdline =3D malloc(ncmdline*sizeof(wchar_t));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (!cmdline)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        err =3D ERROR_OUTOFMEMORY;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        goto out;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    swpri=
ntf(cmdline, ncmdline, fmt, proto, action, if_name, addr);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (IsWindows7OrGreater())</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        wcscat_s(cmdline, ncmdline, L&quot; validate=3Dno&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    err =3D ExecCommand(argv0, cmdline=
, timeout);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-out:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    free(cmdline);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return err;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span>  *=
 Run the command: netsh interface ip $action wins $if_name [static] $addr</=
span><br><span>  * @param  action      &quot;delete&quot;, &quot;add&quot; =
or &quot;set&quot;</span><br><span>  * @param  if_name     &quot;name_of_in=
terface&quot;</span><br><span>@@ -1139,22 +1080,6 @@</span><br><span>     r=
eturn err;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-/* Delete all IPv4 or IPv6 dns servers for an int=
erface */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static DWORD=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-DeleteDNS(short famil=
y, wchar_t *if_name)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t *proto =
=3D (family =3D=3D AF_INET6) ? L&quot;ipv6&quot; : L&quot;ip&quot;;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return netsh_dns_cmd(L&qu=
ot;delete&quot;, proto, if_name, NULL);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Add an IPv4 or IPv6 =
dns server to an interface */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-A=
ddDNS(short family, wchar_t *if_name, wchar_t *addr)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    wchar_t *proto =3D (family =3D=3D AF_INET6) ? L&quot;ipv6&q=
uot; : L&quot;ip&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    return netsh_dns_cmd(L&quot;add&quot;, proto, if_name, addr);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> static BOOL</span><br><span> Cm=
pWString(LPVOID item, LPVOID str)</span><br><span> {</span><br><span>@@ -18=
10,7 +1735,6 @@</span><br><span> HandleDNSConfigMessage(const dns_cfg_messa=
ge_t *msg, undo_lists_t *lists)</span><br><span> {</span><br><span>     DWO=
RD err =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wcha=
r_t addr[46]; /* large enough to hold string representation of an ipv4 / ip=
v6 address */</span><br><span>     undo_type_t undo_type =3D (msg-&gt;famil=
y =3D=3D AF_INET6) ? undo_dns4 : undo_dns6;</span><br><span>     int addr_l=
en =3D msg-&gt;addr_len;</span><br><span> </span><br><span>@@ -1832,10 +175=
6,11 @@</span><br><span>         msgptr-&gt;domains[_countof(msg-&gt;domain=
s)-1] =3D &#39;\0&#39;;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t *wide_name =3D utf8t=
o16(msg-&gt;iface.name); /* utf8 to wide-char */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (!wide_name)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    WCHAR iid[64];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    err =3D InterfaceIdString(msg-&gt;iface.name,=
 iid, _countof(iid));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (err)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return ERROR_OUTOFMEMORY;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return err;</span><br><span>     }</s=
pan><br><span> </span><br><span>     /* We delete all current addresses bef=
ore adding any</span><br><span>@@ -1843,12 +1768,12 @@</span><br><span>    =
  */</span><br><span>     if (addr_len &gt; 0 || msg-&gt;header.type =3D=3D=
 msg_del_dns_cfg)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        err =3D DeleteDNS(msg-&gt;family, wide_name);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D ResetN=
ameServers(iid, msg-&gt;family);</span><br><span>         if (err)</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return err;</span><br><span>         }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        free(RemoveListItem(&amp;(*lists)[undo_=
type], CmpWString, wide_name));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        free(RemoveListItem(&amp;(*lists)[undo_type], CmpAny, i=
id));</span><br><span>     }</span><br><span> </span><br><span>     if (msg=
-&gt;header.type =3D=3D msg_del_dns_cfg)</span><br><span>@@ -1860,40 +1785,=
43 @@</span><br><span>             err =3D SetDnsSearchDomains(msg-&gt;ifac=
e.name, NULL, &amp;gpol, lists);</span><br><span>         }</span><br><span=
>         ApplyDnsSettings(gpol);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        goto out;  /* job done */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return err;  /* job done */</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    for (int i =3D 0; i &lt; addr_len; ++i)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (msg-&gt;family =3D=3D AF_INET6)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            RtlIpv6AddressToStringW(&amp;msg-&gt;addr=
[i].ipv6, addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            RtlIpv4AddressToStringW(&a=
mp;msg-&gt;addr[i].ipv4, addr);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      err =3D AddDNS(msg-&gt;family, wide_name, addr);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (i =3D=3D 0 &amp;&amp; err)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            goto out;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        /* We do not check for duplicate addresse=
s, so any error in adding</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-         * additional addresses is ignored.</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D 0;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (ms=
g-&gt;addr_len &gt; 0)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        wchar_t *tmp_name =3D _wcsdup(wide_name);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!tmp_name |=
| AddListItem(&amp;(*lists)[undo_type], tmp_name))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* prepare the comma separated addre=
ss list */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        C=
HAR addrs[256]; /* large enough to hold four IPv4 / IPv6 address strings */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t offs=
et =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fo=
r (int i =3D 0; i &lt; addr_len; ++i)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            free(tmp_name);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            DeleteDNS(msg-=
&gt;family, wide_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            err =3D ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            goto out;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (i !=3D 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                addrs[offset++] =3D &#39;,&#39;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (msg-&gt;family =
=3D=3D AF_INET6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       RtlIpv6AddressToStringA(&amp;msg-&gt;addr[i].ipv6, addrs + offset);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                RtlIpv4AddressToStr=
ingA(&amp;msg-&gt;addr[i].ipv4, addrs + offset);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            offset +=3D strlen(addrs);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        err =3D SetNameServers(iid, msg-&gt;family, addrs);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (err)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            return err;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        wchar_t *tmp_iid =3D _wcsdup(iid);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (!tmp_iid || AddListItem=
(&amp;(*lists)[undo_type], tmp_iid))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            free(tmp_iid);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            ResetNameServers(iid, msg-&gt;family);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return ERROR_OUTOF=
MEMORY;</span><br><span>         }</span><br><span>     }</span><br><span> =
</span><br><span>@@ -1904,8 +1832,6 @@</span><br><span>     }</span><br><sp=
an>     ApplyDnsSettings(gpol);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-out:</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    free(wide_name);</span><br><span>     return err;</span><br>=
<span> }</span><br><span> </span><br><span>@@ -2286,11 +2212,11 @@</span><b=
r><span>                     break;</span><br><span> </span><br><span>     =
            case undo_dns4:</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    DeleteDNS(AF_INET, item-&gt;data);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    ResetNameServe=
rs(item-&gt;data, AF_INET);</span><br><span>                     break;</sp=
an><br><span> </span><br><span>                 case undo_dns6:</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    DeleteDNS(AF_=
INET6, item-&gt;data);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    ResetNameServers(item-&gt;data, AF_INET6);</span><br=
><span>                     break;</span><br><span> </span><br><span>      =
               break;</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail">change 825<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id2bed0908e84c19b8fb6fe80637=
6316793e550b4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 825 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--gYURjvbaWVQ=--

