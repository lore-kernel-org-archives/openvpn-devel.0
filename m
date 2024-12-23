From: "d12fk (Code Review)" <gerrit@...515...>
Date: Mon, 23 Dec 2024 16:38:14 +0000
In-Reply-To: <gerrit.1733328040000.Id2bed0908e84c19b8fb6fe806376316793e550b4@...2715...>
References: <gerrit.1733328040000.Id2bed0908e84c19b8fb6fe806376316793e550b4@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <614f60051dafaf1d6f9346e1b4bd25ec6784d11e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LV3vwNdMq5c="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: do not use
 netsh to set name server addresses
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LV3vwNdMq5c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail

to look at the new patch set (#7).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


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
1 file changed, 146 insertions(+), 115 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/825/7

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 0657fab..36ea854 100644
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
@@ -1815,11 +1740,115 @@
     return err;
 }

+/**
+ * Return the interfaces registry key for the specified address family
+ *
+ * @param family    the internet address family to open the key for
+ * @param key       PHKEY to return the key in
+ * @return BOOL to indicate success or failure
+ */
+static BOOL
+GetInterfacesKey(short family, PHKEY key)
+{
+    PCSTR itfs_key =3D family =3D=3D AF_INET6
+        ? "SYSTEM\\CurrentControlSet\\Services\\Tcpip6\\Parameters\\Interf=
aces"
+        : "SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters\\Interfa=
ces";
+
+    LSTATUS err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE, itfs_key, 0, KEY_ALL=
_ACCESS, key);
+    if (err)
+    {
+        *key =3D INVALID_HANDLE_VALUE;
+        MsgToEventLog(M_SYSERR, TEXT("GetInterfacesKey: "
+                                     "could not open interfaces registry k=
ey for family %d (%lu)"),
+                      family, err);
+    }
+
+    return err ? FALSE : TRUE;
+}
+
+/**
+ * Set the DNS name servers in a registry interface configuration
+ *
+ * @param itf_id    the interface id to set the servers for
+ * @param family    internet address family to set the servers for
+ * @param value     the value to set the name servers to
+ *
+ * @return DWORD NO_ERROR on success, a Windows error code otherwise
+ */
+static DWORD
+SetNameServersValue(PCWSTR itf_id, short family, PCSTR value)
+{
+    DWORD err;
+
+    HKEY itfs;
+    if (!GetInterfacesKey(family, &itfs))
+    {
+        return ERROR_FILE_NOT_FOUND;
+    }
+
+    HKEY itf =3D INVALID_HANDLE_VALUE;
+    err =3D RegOpenKeyExW(itfs, itf_id, 0, KEY_ALL_ACCESS, &itf);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("SetNameServersValue: "
+                                     "could not open interface key for %s =
family %d (%lu)"),
+                      itf_id, family, err);
+        goto out;
+    }
+
+    err =3D RegSetValueExA(itf, "NameServer", 0, REG_SZ, (PBYTE)value, str=
len(value) + 1);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("SetNameServersValue: "
+                                     "could not set name servers '%S' for =
%s family %d (%lu)"),
+                      value, itf_id, family, err);
+    }
+
+out:
+    if (itf !=3D INVALID_HANDLE_VALUE)
+    {
+        RegCloseKey(itf);
+    }
+    if (itfs !=3D INVALID_HANDLE_VALUE)
+    {
+        RegCloseKey(itfs);
+    }
+    return err;
+}
+
+/**
+ * Set the DNS name servers in a registry interface configuration
+ *
+ * @param itf_id    the interface id to set the servers for
+ * @param family    internet address family to set the servers for
+ * @param addrs     comma separated list of name server addresses
+ *
+ * @return DWORD NO_ERROR on success, a Windows error code otherwise
+ */
+static DWORD
+SetNameServers(PCWSTR itf_id, short family, PCSTR addrs)
+{
+    return SetNameServersValue(itf_id, family, addrs);
+}
+
+/**
+ * Delete all DNS name servers from a registry interface configuration
+ *
+ * @param itf_id    the interface id to clear the servers for
+ * @param family    internet address family to clear the servers for
+ *
+ * @return DWORD NO_ERROR on success, a Windows error code otherwise
+ */
+static DWORD
+ResetNameServers(PCWSTR itf_id, short family)
+{
+    return SetNameServersValue(itf_id, family, "");
+}
+
 static DWORD
 HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
 {
     DWORD err =3D 0;
-    wchar_t addr[46]; /* large enough to hold string representation of an =
ipv4 / ipv6 address */
     undo_type_t undo_type =3D (msg->family =3D=3D AF_INET6) ? undo_dns4 : =
undo_dns6;
     int addr_len =3D msg->addr_len;

@@ -1841,10 +1870,11 @@
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
@@ -1852,12 +1882,12 @@
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
@@ -1869,40 +1899,43 @@
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

@@ -1913,8 +1946,6 @@
     }
     ApplyDnsSettings(gpol);

-out:
-    free(wide_name);
     return err;
 }

@@ -2295,11 +2326,11 @@
                     break;

                 case undo_dns4:
-                    DeleteDNS(AF_INET, item->data);
+                    ResetNameServers(item->data, AF_INET);
                     break;

                 case undo_dns6:
-                    DeleteDNS(AF_INET6, item->data);
+                    ResetNameServers(item->data, AF_INET6);
                     break;

                 case undo_domains:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id2bed0908e84c19b8fb6fe806376316793e550b4
Gerrit-Change-Number: 825
Gerrit-PatchSet: 7
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-MessageType: newpatchset

--LV3vwNdMq5c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p>d12fk <strong>uploaded patch set #7</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail">View Change</a=
></p><p>The change is no longer submittable: checks~ChecksSubmitRule is uns=
atisfied now.</p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dns: do not use netsh to set name server addresses<br><br>Ins=
tead of spawning a netsh process, set the name server addresses<br>directly=
 in the registry hive of the VPN interface.<br><br>This is a first step to =
get rid of the use of command line tools in the<br>service and move to a mo=
re API driven style of modifying the VPN adapter<br>configuration.<br><br>C=
hange-Id: Id2bed0908e84c19b8fb6fe806376316793e550b4<br>Signed-off-by: Heiko=
 Hund &lt;heiko@...2662...&gt;<br>---<br>M src/openvpnserv/interactive.c<br=
>1 file changed, 146 insertions(+), 115 deletions(-)<br><br></pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit.openvpn.net:29418/openvpn refs/changes/25/825/7</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><=
br><span>index 0657fab..36ea854 100644</span><br><span>--- a/src/openvpnser=
v/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><=
br><span>@@ -1024,65 +1024,6 @@</span><br><span> }</span><br><span> </span>=
<br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Run =
the command: netsh interface $proto $action dns $if_name $addr [validate=3D=
no]</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  action =
     &quot;delete&quot; or &quot;add&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * @param  proto       &quot;ipv6&quot; or &quot;ip&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  if_name=
     &quot;name_of_interface&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * @param  addr         IPv4 (for proto =3D ip) or IPv6 addres=
s as a string</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * If addr is null and acti=
on =3D &quot;delete&quot; all addresses are deleted.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar=
_t *if_name, const wchar_t *addr)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWOR=
D err =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int t=
imeout =3D 30000; /* in msec */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    wchar_t argv0[MAX_PATH];</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    wchar_t *cmdline =3D NULL;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!addr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (wcscmp=
(action, L&quot;delete&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            addr =3D L&quot;all&quot;;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        else /* nothing to do -- return success*/</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            goto out;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Path of netsh *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    swprintf(argv0, =
_countof(argv0), L&quot;%ls\\%ls&quot;, get_win_sys_path(), L&quot;netsh.ex=
e&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* cmd template:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     * netsh interface $proto $act=
ion dns $if_name $addr [validate=3Dno]</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const wchar_t *fmt =3D L&quot;netsh interface %ls %ls dns \&quot;%ls=
\&quot; %ls&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* max cmdline lengt=
h in wchars -- include room for worst case and some */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    size_t ncmdline =3D wcslen(fmt) + wcsl=
en(if_name) + wcslen(addr) + 32 + 1;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    cmdline =3D malloc(ncmdline*sizeof(wchar_t));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!cmdline)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        err =3D ERROR_OUTOFMEMORY;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        goto out;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
wprintf(cmdline, ncmdline, fmt, proto, action, if_name, addr);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (IsWindows7OrGreater())</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        wcscat_s(cmdline, ncmdline, L&quot; validate=3Dno&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    err =3D ExecCommand(argv0, cmd=
line, timeout);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-out:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    free(cmdline);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return err;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><spa=
n>  * Run the command: netsh interface ip $action wins $if_name [static] $a=
ddr</span><br><span>  * @param  action      &quot;delete&quot;, &quot;add&q=
uot; or &quot;set&quot;</span><br><span>  * @param  if_name     &quot;name_=
of_interface&quot;</span><br><span>@@ -1139,22 +1080,6 @@</span><br><span> =
    return err;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* Delete all IPv4 or IPv6 dns servers for =
an interface */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-DeleteDNS(short=
 family, wchar_t *if_name)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t *pr=
oto =3D (family =3D=3D AF_INET6) ? L&quot;ipv6&quot; : L&quot;ip&quot;;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return netsh_dns_cmd(=
L&quot;delete&quot;, proto, if_name, NULL);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Add an IPv4 or I=
Pv6 dns server to an interface */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-AddDNS(short family, wchar_t *if_name, wchar_t *addr)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    wchar_t *proto =3D (family =3D=3D AF_INET6) ? L&quot;ipv=
6&quot; : L&quot;ip&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return netsh_dns_cmd(L&quot;add&quot;, proto, if_name, addr);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> static BOOL</span><br><span>=
 CmpWString(LPVOID item, LPVOID str)</span><br><span> {</span><br><span>@@ =
-1815,11 +1740,115 @@</span><br><span>     return err;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the inter=
faces registry key for the specified address family</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param family    the internet address family to open th=
e key for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
key       PHKEY to return the key in</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return BOOL to indicate success or failure</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+GetInterfacesKey(short family, PHKEY key)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    PCSTR itfs_key =3D family =3D=3D AF_INET6</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        ? &quot;SYSTEM\\C=
urrentControlSet\\Services\\Tcpip6\\Parameters\\Interfaces&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        : &quot;SYSTEM\\Curren=
tControlSet\\Services\\Tcpip\\Parameters\\Interfaces&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    LSTATUS err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE, =
itfs_key, 0, KEY_ALL_ACCESS, key);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (err)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  *key =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        MsgToEventLog(M_SYSERR, TEXT(&quot;GetInterfacesKey: &=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                       &quot;could not open interfaces registry key for fam=
ily %d (%lu)&quot;),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                      family, err);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return err ?=
 FALSE : TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Set the DNS name servers in a registry interface confi=
guration</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param itf_id    the inte=
rface id to set the servers for</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param family    internet address family to set the servers =
for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param value =
    the value to set the name servers to</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @return DWORD NO_ERROR on success, a Windows error code otherwise</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static DWORD</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+SetNameServersValue(PCWSTR itf_id, short fami=
ly, PCSTR value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD err;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    HKEY itfs;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!GetInterfacesKey(family, &amp;itfs))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return ERROR_FILE_NOT_FOUND;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    HKEY itf =3D INVALID_HANDLE_VALUE;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    err =3D RegOpenKeyExW(itfs, itf=
_id, 0, KEY_ALL_ACCESS, &amp;itf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (err)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  MsgToEventLog(M_SYSERR, TEXT(&quot;SetNameServersValue: &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
       &quot;could not open interface key for %s family %d (%lu)&quot;),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
itf_id, family, err);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    err =3D RegSetValueExA(itf, &=
quot;NameServer&quot;, 0, REG_SZ, (PBYTE)value, strlen(value) + 1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (err)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, TEXT(&quot;SetNa=
meServersValue: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                     &quot;could not set name servers &#=
39;%S&#39; for %s family %d (%lu)&quot;),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                      value, itf_id, family, err);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+out:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (itf !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        RegCloseKey(itf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (itfs !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        RegCloseKey(itfs);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Set the DNS name servers in a registry interface conf=
iguration</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param itf_id    the int=
erface id to set the servers for</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param family    internet address family to set the servers=
 for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param addrs=
     comma separated list of name server addresses</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return DWORD NO_ERROR on success, a Windows error code ot=
herwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static DWORD</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+SetNameServers(PCWSTR itf_id, short=
 family, PCSTR addrs)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return SetNa=
meServersValue(itf_id, family, addrs);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Delete all DNS name servers fro=
m a registry interface configuration</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param itf_id    the interface id to clear the servers for</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param family    internet addr=
ess family to clear the servers for</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return DWORD NO_ERROR on success, a Windows error code otherwise</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static DWORD</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ResetNameServers(PCWSTR itf_id, short family)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return SetNameServersValue(itf_id, f=
amily, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> static DWORD</span><br><span> HandleDNSConfigMessage(const dns_cfg_messag=
e_t *msg, undo_lists_t *lists)</span><br><span> {</span><br><span>     DWOR=
D err =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar=
_t addr[46]; /* large enough to hold string representation of an ipv4 / ipv=
6 address */</span><br><span>     undo_type_t undo_type =3D (msg-&gt;family=
 =3D=3D AF_INET6) ? undo_dns4 : undo_dns6;</span><br><span>     int addr_le=
n =3D msg-&gt;addr_len;</span><br><span> </span><br><span>@@ -1841,10 +1870=
,11 @@</span><br><span>         msgptr-&gt;domains[_countof(msg-&gt;domains=
)-1] =3D &#39;\0&#39;;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t *wide_name =3D utf8to=
16(msg-&gt;iface.name); /* utf8 to wide-char */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (!wide_name)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    WCHAR iid[64];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    err =3D InterfaceIdString(msg-&gt;iface.name, =
iid, _countof(iid));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (err)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        return ERROR_OUTOFMEMORY;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return err;</span><br><span>     }</sp=
an><br><span> </span><br><span>     /* We delete all current addresses befo=
re adding any</span><br><span>@@ -1852,12 +1882,12 @@</span><br><span>     =
 */</span><br><span>     if (addr_len &gt; 0 || msg-&gt;header.type =3D=3D =
msg_del_dns_cfg)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        err =3D DeleteDNS(msg-&gt;family, wide_name);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D ResetNa=
meServers(iid, msg-&gt;family);</span><br><span>         if (err)</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return err;</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        free(RemoveListItem(&amp;(*lists)[undo_t=
ype], CmpWString, wide_name));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        free(RemoveListItem(&amp;(*lists)[undo_type], CmpAny, ii=
d));</span><br><span>     }</span><br><span> </span><br><span>     if (msg-=
&gt;header.type =3D=3D msg_del_dns_cfg)</span><br><span>@@ -1869,40 +1899,4=
3 @@</span><br><span>             err =3D SetDnsSearchDomains(msg-&gt;iface=
.name, NULL, &amp;gpol, lists);</span><br><span>         }</span><br><span>=
         ApplyDnsSettings(gpol);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        goto out;  /* job done */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return err;  /* job done */</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    for (int i =3D 0; i &lt; addr_len; ++i)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (msg-&gt;family =3D=3D AF_INET6)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            RtlIpv6AddressToStringW(&amp;msg-&gt;addr[=
i].ipv6, addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            RtlIpv4AddressToStringW(&am=
p;msg-&gt;addr[i].ipv4, addr);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     err =3D AddDNS(msg-&gt;family, wide_name, addr);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (i =3D=3D 0 &amp;&amp; err)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            goto out;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        /* We do not check for duplicate addresses=
, so any error in adding</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-         * additional addresses is ignored.</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (msg=
-&gt;addr_len &gt; 0)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        wchar_t *tmp_name =3D _wcsdup(wide_name);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!tmp_name ||=
 AddListItem(&amp;(*lists)[undo_type], tmp_name))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* prepare the comma separated addres=
s list */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CH=
AR addrs[256]; /* large enough to hold four IPv4 / IPv6 address strings */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t offse=
t =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for=
 (int i =3D 0; i &lt; addr_len; ++i)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            free(tmp_name);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            DeleteDNS(msg-&=
gt;family, wide_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            err =3D ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            goto out;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (i !=3D 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                addrs[offset++] =3D &#39;,&#39;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (msg-&gt;family =
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
</span><br><span>@@ -1913,8 +1946,6 @@</span><br><span>     }</span><br><sp=
an>     ApplyDnsSettings(gpol);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-out:</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    free(wide_name);</span><br><span>     return err;</span><br>=
<span> }</span><br><span> </span><br><span>@@ -2295,11 +2326,11 @@</span><b=
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
           case undo_domains:</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail">cha=
nge 825</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id2bed0908e84c19b8fb6fe80637=
6316793e550b4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 825 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--LV3vwNdMq5c=--

