From: "d12fk (Code Review)" <gerrit@...515...>
Date: Wed, 4 Dec 2024 16:01:30 +0000
In-Reply-To: <gerrit.1733328040000.Id2bed0908e84c19b8fb6fe806376316793e550b4@...2715...>
References: <gerrit.1733328040000.Id2bed0908e84c19b8fb6fe806376316793e550b4@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <77ebd54a58bf8c40286627c9460a49dbbb3c9533-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="whxWMTyJPYw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--whxWMTyJPYw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail

to look at the new patch set (#2).


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/825/2

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index cad8b02..fc8cf8d 100644
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
@@ -1806,11 +1731,115 @@
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

@@ -1832,10 +1861,11 @@
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
@@ -1843,12 +1873,12 @@
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
@@ -1860,40 +1890,43 @@
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

@@ -1904,8 +1937,6 @@
     }
     ApplyDnsSettings(gpol);

-out:
-    free(wide_name);
     return err;
 }

@@ -2286,11 +2317,11 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--whxWMTyJPYw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">dns: do not use netsh to set name server addresses<br><br>Instead of spaw=
ning a netsh process, set the name server addresses<br>directly in the regi=
stry hive of the VPN interface.<br><br>This is a first step to get rid of t=
he use of command line tools in the<br>service and move to a more API drive=
n style of modifying the VPN adapter<br>configuration.<br><br>Change-Id: Id=
2bed0908e84c19b8fb6fe806376316793e550b4<br>Signed-off-by: Heiko Hund &lt;he=
iko@...2662...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file chan=
ged, 146 insertions(+), 115 deletions(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/25/825/2</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><span>index=
 cad8b02..fc8cf8d 100644</span><br><span>--- a/src/openvpnserv/interactive.=
c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -1=
024,65 +1024,6 @@</span><br><span> }</span><br><span> </span><br><span> /**=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Run the command: n=
etsh interface $proto $action dns $if_name $addr [validate=3Dno]</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * @param  action      &quot;del=
ete&quot; or &quot;add&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * @param  proto       &quot;ipv6&quot; or &quot;ip&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * @param  if_name     &quot;nam=
e_of_interface&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* @param  addr         IPv4 (for proto =3D ip) or IPv6 address as a string<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * If addr is null and action =3D &quot;d=
elete&quot; all addresses are deleted.</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-netsh_dns_=
cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *if_name, co=
nst wchar_t *addr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD err =3D 0;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int timeout =3D 3000=
0; /* in msec */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    w=
char_t argv0[MAX_PATH];</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    wchar_t *cmdline =3D NULL;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!a=
ddr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (wcscmp(action, L&quot=
;delete&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   addr =3D L&quot;all&quot;;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    else /* nothing to do -- return success*/</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            goto out;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /* Path of netsh */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    swprintf(argv0, _countof(argv0)=
, L&quot;%ls\\%ls&quot;, get_win_sys_path(), L&quot;netsh.exe&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* cmd template:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     * netsh interface $proto $action dns $if_nam=
e $addr [validate=3Dno]</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const wc=
har_t *fmt =3D L&quot;netsh interface %ls %ls dns \&quot;%ls\&quot; %ls&quo=
t;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* max cmdline length in wchars -- =
include room for worst case and some */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    size_t ncmdline =3D wcslen(fmt) + wcslen(if_name) + w=
cslen(addr) + 32 + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    cmdline =3D malloc(ncmdline*sizeof(wchar_t));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (!cmdline)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        err =3D ERROR_OUTOFMEMORY;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        goto out;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    swprintf(cmdline=
, ncmdline, fmt, proto, action, if_name, addr);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (IsWindows7OrGreater())</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      wcscat_s(cmdline, ncmdline, L&quot; validate=3Dno&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    err =3D ExecCommand(argv0, cmdline, timeout);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-out:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    free(cmdline);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return err;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span>  * Run the co=
mmand: netsh interface ip $action wins $if_name [static] $addr</span><br><s=
pan>  * @param  action      &quot;delete&quot;, &quot;add&quot; or &quot;se=
t&quot;</span><br><span>  * @param  if_name     &quot;name_of_interface&quo=
t;</span><br><span>@@ -1139,22 +1080,6 @@</span><br><span>     return err;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/* Delete all IPv4 or IPv6 dns servers for an interface */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-static DWORD</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-DeleteDNS(short family, wchar_t =
*if_name)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t *proto =3D (family =
=3D=3D AF_INET6) ? L&quot;ipv6&quot; : L&quot;ip&quot;;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return netsh_dns_cmd(L&quot;delete&qu=
ot;, proto, if_name, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/* Add an IPv4 or IPv6 dns server t=
o an interface */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AddDNS(short =
family, wchar_t *if_name, wchar_t *addr)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   wchar_t *proto =3D (family =3D=3D AF_INET6) ? L&quot;ipv6&quot; : L&quot=
;ip&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
netsh_dns_cmd(L&quot;add&quot;, proto, if_name, addr);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> static BOOL</span><br><span> CmpWString(LPVO=
ID item, LPVOID str)</span><br><span> {</span><br><span>@@ -1806,11 +1731,1=
15 @@</span><br><span>     return err;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Return the interfaces registry k=
ey for the specified address family</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param family    the internet address family to open the key for</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param key       PHKEY to=
 return the key in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return BOOL to indicate success or failure</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+GetInterfacesKey(short family, PHKEY key)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    PCSTR itfs_key =3D family =3D=3D AF_INET6</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ? &quot;SYSTEM\\CurrentControlSet=
\\Services\\Tcpip6\\Parameters\\Interfaces&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        : &quot;SYSTEM\\CurrentControlSet\\Ser=
vices\\Tcpip\\Parameters\\Interfaces&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    LSTATUS err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE, itfs_key, 0, KEY=
_ALL_ACCESS, key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        *key =3D INVAL=
ID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     MsgToEventLog(M_SYSERR, TEXT(&quot;GetInterfacesKey: &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
       &quot;could not open interfaces registry key for family %d (%lu)&quo=
t;),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
       family, err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return err ? FALSE : TRUE;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Set the DNS name servers in a registry interface configuration</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param itf_id    the interface id to set t=
he servers for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram family    internet address family to set the servers for</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param value     the value to =
set the name servers to</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return DW=
ORD NO_ERROR on success, a Windows error code otherwise</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static DWORD</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+SetNameServersValue(PCWSTR itf_id, short family, PCSTR value)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    DWORD err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    HKEY itfs;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!GetInterfacesKey(family, &amp;itfs))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return ERROR_FILE_NOT_FOUND;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    HKEY itf =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    err =3D RegOpenKeyExW(itfs, itf_id, 0, KEY_ALL=
_ACCESS, &amp;itf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog=
(M_SYSERR, TEXT(&quot;SetNameServersValue: &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                     &quot;co=
uld not open interface key for %s family %d (%lu)&quot;),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                      itf_id, family,=
 err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto =
out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    err =3D RegSetValueExA(itf, &quot;NameServer=
&quot;, 0, REG_SZ, (PBYTE)value, strlen(value) + 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (err)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        MsgToEventLog(M_SYSERR, TEXT(&quot;SetNameServersValue=
: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                          &quot;could not set name servers &#39;%S&#39; for=
 %s family %d (%lu)&quot;),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                      value, itf_id, family, err);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+out:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (i=
tf !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    RegCloseKey(itf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (itfs=
 !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  RegCloseKey(itfs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return er=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Set the DNS name servers in a registry interface configuration</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param itf_id    the interface id to s=
et the servers for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param family    internet address family to set the servers for</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param addrs     comma sep=
arated list of name server addresses</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @return DWORD NO_ERROR on success, a Windows error code otherwise</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static DWORD</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+SetNameServers(PCWSTR itf_id, short family, PCST=
R addrs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return SetNameServersValu=
e(itf_id, family, addrs);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Delete all DNS name servers from a registry =
interface configuration</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param itf=
_id    the interface id to clear the servers for</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param family    internet address family to=
 clear the servers for</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return DWO=
RD NO_ERROR on success, a Windows error code otherwise</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static DWORD</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ResetNameServers(PCWSTR itf_id, short family)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return SetNameServersValue(itf_id, family, &quot;&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static DWORD<=
/span><br><span> HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_=
lists_t *lists)</span><br><span> {</span><br><span>     DWORD err =3D 0;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t addr[46]; /*=
 large enough to hold string representation of an ipv4 / ipv6 address */</s=
pan><br><span>     undo_type_t undo_type =3D (msg-&gt;family =3D=3D AF_INET=
6) ? undo_dns4 : undo_dns6;</span><br><span>     int addr_len =3D msg-&gt;a=
ddr_len;</span><br><span> </span><br><span>@@ -1832,10 +1861,11 @@</span><b=
r><span>         msgptr-&gt;domains[_countof(msg-&gt;domains)-1] =3D &#39;\=
0&#39;;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    wchar_t *wide_name =3D utf8to16(msg-&gt;ifac=
e.name); /* utf8 to wide-char */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!wide_name)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    WCHAR iid[64];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    err =3D InterfaceIdString(msg-&gt;iface.name, iid, _countof(i=
id));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (err)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        return ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return err;</span><br><span>     }</span><br><span> <=
/span><br><span>     /* We delete all current addresses before adding any</=
span><br><span>@@ -1843,12 +1873,12 @@</span><br><span>      */</span><br><=
span>     if (addr_len &gt; 0 || msg-&gt;header.type =3D=3D msg_del_dns_cfg=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        err =3D DeleteDNS(msg-&gt;family, wide_name);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        err =3D ResetNameServers(iid, =
msg-&gt;family);</span><br><span>         if (err)</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto ou=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n err;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        free(RemoveListItem(&amp;(*lists)[undo_type], CmpWStrin=
g, wide_name));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    free(RemoveListItem(&amp;(*lists)[undo_type], CmpAny, iid));</span><br>=
<span>     }</span><br><span> </span><br><span>     if (msg-&gt;header.type=
 =3D=3D msg_del_dns_cfg)</span><br><span>@@ -1860,40 +1890,43 @@</span><br>=
<span>             err =3D SetDnsSearchDomains(msg-&gt;iface.name, NULL, &a=
mp;gpol, lists);</span><br><span>         }</span><br><span>         ApplyD=
nsSettings(gpol);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    goto out;  /* job done */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return err;  /* job done */</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i=
nt i =3D 0; i &lt; addr_len; ++i)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (msg-&gt;family =3D=3D AF_INET6)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            RtlIpv6AddressToStringW(&amp;msg-&gt;addr[i].ipv6, addr);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            RtlIpv4AddressToStringW(&amp;msg-&gt;addr[=
i].ipv4, addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D Ad=
dDNS(msg-&gt;family, wide_name, addr);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (i =3D=3D 0 &amp;&amp; err)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            goto out;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        /* We do not check for duplicate addresses, so any error =
in adding</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * a=
dditional addresses is ignored.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    err =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (msg-&gt;addr_len =
&gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        wchar_t *tmp_name =3D _wcsdup(wide_name);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (!tmp_name || AddListItem(&=
amp;(*lists)[undo_type], tmp_name))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* prepare the comma separated address list */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        CHAR addrs[256];=
 /* large enough to hold four IPv4 / IPv6 address strings */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        size_t offset =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0;=
 i &lt; addr_len; ++i)</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            free(tmp_name);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            DeleteDNS(msg-&gt;family, wid=
e_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            e=
rr =3D ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            goto out;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (i !=3D 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                addrs[offset++] =3D &#39;,&#39;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (msg-&gt;family =3D=3D AF_INET6=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                RtlIpv6A=
ddressToStringA(&amp;msg-&gt;addr[i].ipv6, addrs + offset);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                RtlIpv4AddressToStringA(&amp;msg-&=
gt;addr[i].ipv4, addrs + offset);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            offset +=3D strlen(addrs);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      err =3D SetNameServers(iid, msg-&gt;family, addrs);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (err)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            return err;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        wchar_t *tmp_iid =3D _wcsdup(iid);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!tmp_iid || AddListItem(&amp;(*lists)[un=
do_type], tmp_iid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  free(tmp_iid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         ResetNameServers(iid, msg-&gt;family);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            return ERROR_OUTOFMEMORY;</span><br=
><span>         }</span><br><span>     }</span><br><span> </span><br><span>=
@@ -1904,8 +1937,6 @@</span><br><span>     }</span><br><span>     ApplyDnsS=
ettings(gpol);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-out:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fr=
ee(wide_name);</span><br><span>     return err;</span><br><span> }</span><b=
r><span> </span><br><span>@@ -2286,11 +2317,11 @@</span><br><span>         =
            break;</span><br><span> </span><br><span>                 case =
undo_dns4:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         DeleteDNS(AF_INET, item-&gt;data);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    ResetNameServers(item-&gt;data,=
 AF_INET);</span><br><span>                     break;</span><br><span> </s=
pan><br><span>                 case undo_dns6:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    DeleteDNS(AF_INET6, item-&gt;d=
ata);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      ResetNameServers(item-&gt;data, AF_INET6);</span><br><span>          =
           break;</span><br><span> </span><br><span>                     br=
eak;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/825?usp=3Demail">change 825</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/825?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id2bed0908e84c19b8fb6fe80637=
6316793e550b4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 825 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--whxWMTyJPYw=--

