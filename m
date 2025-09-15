From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 15 Sep 2025 07:01:46 +0000
In-Reply-To: <gerrit.1757684109000.Iff2f4ea677fe2d88659d7814dab0f792f5004fb3@...2715...>
References: <gerrit.1757684109000.Iff2f4ea677fe2d88659d7814dab0f792f5004fb3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <8f5100a45b63ffba4f6683b46701355eac504912-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3nyBJZlpzo0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: win: replace
 wmic invocation with powershell
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, d12fk <heiko@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3nyBJZlpzo0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/1183?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+1 by d12fk, Code-Review+2 by cron2


Change subject: win: replace wmic invocation with powershell
......................................................................

win: replace wmic invocation with powershell

Since wmic has been recently deprecated and is absent on new
systems, replace setting DNS domain "old-style" with powershell.

Some changes to the service implementation:

 - remove action parameter and hardcode Set-DnsClient since this is
 the only used action

 - remove support of multiple domains, since we only pass a single domain
 (tuntap_options.domain)

Github: fixes OpenVPN/openvpn#642

Change-Id: Iff2f4ea677fe2d88659d7814dab0f792f5004fb3
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1183
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250915062013.2555-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
938.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tun.c
M src/openvpn/win32.h
M src/openvpnserv/interactive.c
3 files changed, 21 insertions(+), 30 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/1183/3

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 89d5f93..99dc490 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -383,7 +383,7 @@
 }

 static void
-do_dns_domain_wmic(bool add, const struct tuntap *tt)
+do_dns_domain_pwsh(bool add, const struct tuntap *tt)
 {
     if (!tt->options.domain)
     {
@@ -391,9 +391,14 @@
     }

     struct argv argv =3D argv_new();
-    argv_printf(&argv, "%s%s nicconfig where (InterfaceIndex=3D%ld) call S=
etDNSDomain '%s'",
-                get_win_sys_path(), WMIC_PATH_SUFFIX, tt->adapter_index, a=
dd ? tt->options.domain : "");
-    exec_command("WMIC", &argv, 1, M_WARN);
+    argv_printf(&argv,
+                "%s%s -NoProfile -NonInteractive -Command Set-DnsClient -I=
nterfaceIndex %lu -ConnectionSpecificSuffix '%s'",
+                get_win_sys_path(),
+                POWERSHELL_PATH_SUFFIX,
+                tt->adapter_index,
+                add ? tt->options.domain : ""
+                );
+    exec_command("PowerShell", &argv, 1, M_WARN);

     argv_free(&argv);
 }
@@ -1269,7 +1274,7 @@

         if (!tt->did_ifconfig_setup)
         {
-            do_dns_domain_wmic(true, tt);
+            do_dns_domain_pwsh(true, tt);
         }
     }
 #else /* platforms we have no IPv6 code for */
@@ -1625,7 +1630,7 @@
                            tt->adapter_netmask, NI_IP_NETMASK | NI_OPTIONS=
);
         }

-        do_dns_domain_wmic(true, tt);
+        do_dns_domain_pwsh(true, tt);
     }


@@ -7024,7 +7029,7 @@
         {
             if (!tt->did_ifconfig_setup)
             {
-                do_dns_domain_wmic(false, tt);
+                do_dns_domain_pwsh(false, tt);
             }

             netsh_delete_address_dns(tt, true, &gc);
@@ -7050,7 +7055,7 @@
         }
         else
         {
-            do_dns_domain_wmic(false, tt);
+            do_dns_domain_pwsh(false, tt);

             if (tt->options.ip_win32_type =3D=3D IPW32_SET_NETSH)
             {
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 1b87fa3..67e6169 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -38,7 +38,7 @@
 #define WIN_ROUTE_PATH_SUFFIX "\\system32\\route.exe"
 #define WIN_IPCONFIG_PATH_SUFFIX "\\system32\\ipconfig.exe"
 #define WIN_NET_PATH_SUFFIX "\\system32\\net.exe"
-#define WMIC_PATH_SUFFIX "\\system32\\wbem\\wmic.exe"
+#define POWERSHELL_PATH_SUFFIX "\\system32\\WindowsPowerShell\\v1.0\\power=
shell.exe"

 /*
  * Win32-specific OpenVPN code, targeted at the mingw
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a25d26f..ca58596 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1150,45 +1150,31 @@
 }

 /**
- * Run command: wmic nicconfig (InterfaceIndex=3D$if_index) call $action (=
$data)
+ * Run command: powershell -NoProfile -NonInteractive -Command Set-DnsClie=
nt -InterfaceIndex %ld -ConnectionSpecificSuffix '%s'
  * @param  if_index    "index of interface"
- * @param  action      e.g., "SetDNSDomain"
  * @param  data        data if required for action
  *                     - a single word for SetDNSDomain, empty or NULL to =
delete
- *                     - comma separated values for a list
  */
 static DWORD
-wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,
-                   const wchar_t *data)
+pwsh_setdns_cmd(const NET_IFINDEX if_index, const wchar_t *data)
 {
     DWORD err =3D 0;
     wchar_t argv0[MAX_PATH];
     wchar_t *cmdline =3D NULL;
     int timeout =3D 10000; /* in msec */

-    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path=
(), L"wbem\\wmic.exe");
+    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path=
(), L"WindowsPowerShell\\v1.0\\powershell.exe");

-    const wchar_t *fmt;
-    /* comma separated list must be enclosed in parenthesis */
-    if (data && wcschr(data, L','))
-    {
-        fmt =3D L"wmic nicconfig where (InterfaceIndex=3D%ld) call %ls (%l=
s)";
-    }
-    else
-    {
-        fmt =3D L"wmic nicconfig where (InterfaceIndex=3D%ld) call %ls \"%=
ls\"";
-    }
+    const wchar_t *fmt =3D L"-NoProfile -NonInteractive -Command Set-DnsCl=
ient -InterfaceIndex %lu -ConnectionSpecificSuffix '%s'";

-    size_t ncmdline =3D wcslen(fmt) + 20 + wcslen(action) /* max 20 for if=
index */
-                      + (data ? wcslen(data) + 1 : 1);
+    size_t ncmdline =3D wcslen(fmt) + 20 + /* max 20 for ifindex */ (data =
? wcslen(data) + 1 : 1);
     cmdline =3D malloc(ncmdline*sizeof(wchar_t));
     if (!cmdline)
     {
         return ERROR_OUTOFMEMORY;
     }

-    openvpn_swprintf(cmdline, ncmdline, fmt, if_index, action,
-                     data ? data : L"");
+    openvpn_swprintf(cmdline, ncmdline, fmt, if_index, data ? data : L"");
     err =3D ExecCommand(argv0, cmdline, timeout);

     free(cmdline);
@@ -1248,7 +1234,7 @@
         free(RemoveListItem(&(*lists)[undo_domain], CmpWString, (void *)if=
_name));
     }

-    err =3D wmic_nicconfig_cmd(L"SetDNSDomain", if_index, wdomain);
+    err =3D pwsh_setdns_cmd(if_index, wdomain);

     /* Add to undo list if domain is non-empty */
     if (err =3D=3D 0 && wdomain[0] && lists)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1183?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Iff2f4ea677fe2d88659d7814dab0f792f5004fb3
Gerrit-Change-Number: 1183
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--3nyBJZlpzo0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1183=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+1 by d12fk, Code-Review+2 by cron2</p><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">win: replace wmic invocation=
 with powershell<br><br>Since wmic has been recently deprecated and is abse=
nt on new<br>systems, replace setting DNS domain &quot;old-style&quot; with=
 powershell.<br><br>Some changes to the service implementation:<br><br> - r=
emove action parameter and hardcode Set-DnsClient since this is<br> the onl=
y used action<br><br> - remove support of multiple domains, since we only p=
ass a single domain<br> (tuntap_options.domain)<br><br>Github: fixes OpenVP=
N/openvpn#642<br><br>Change-Id: Iff2f4ea677fe2d88659d7814dab0f792f5004fb3<b=
r>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1183<br>Signed-off-by:=
 Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>Message-Id: &lt;20250915062013.2555-1-gert@...1296...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
938.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 src/openvpn/tun.c<br>M src/openvpn/win32.h<br>M src/openvpnserv/interactiv=
e.c<br>3 files changed, 21 insertions(+), 30 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/1183/3</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 89d5f=
93..99dc490 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>=
+++ b/src/openvpn/tun.c</span><br><span>@@ -383,7 +383,7 @@</span><br><span=
> }</span><br><span> </span><br><span> static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-do_dns_domain_wmic(bool add, const struct tunt=
ap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_dns_domai=
n_pwsh(bool add, const struct tuntap *tt)</span><br><span> {</span><br><spa=
n>     if (!tt-&gt;options.domain)</span><br><span>     {</span><br><span>@=
@ -391,9 +391,14 @@</span><br><span>     }</span><br><span> </span><br><spa=
n>     struct argv argv =3D argv_new();</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s%s nicconfig where (In=
terfaceIndex=3D%ld) call SetDNSDomain &#39;%s&#39;&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                get_win_sys_path(), WMI=
C_PATH_SUFFIX, tt-&gt;adapter_index, add ? tt-&gt;options.domain : &quot;&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exec_comman=
d(&quot;WMIC&quot;, &amp;argv, 1, M_WARN);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    argv_printf(&amp;argv,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                &quot;%s%s -NoProfile -NonInt=
eractive -Command Set-DnsClient -InterfaceIndex %lu -ConnectionSpecificSuff=
ix &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                get_win_sys_path(),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                POWERSHELL_PATH_SUFFIX,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                tt-&gt;adapter_index=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ad=
d ? tt-&gt;options.domain : &quot;&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                );</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    exec_command(&quot;PowerShell&quot;, &amp;argv, 1, =
M_WARN);</span><br><span> </span><br><span>     argv_free(&amp;argv);</span=
><br><span> }</span><br><span>@@ -1269,7 +1274,7 @@</span><br><span> </span=
><br><span>         if (!tt-&gt;did_ifconfig_setup)</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            do_dns=
_domain_wmic(true, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            do_dns_domain_pwsh(true, tt);</span><br><span>         }</s=
pan><br><span>     }</span><br><span> #else /* platforms we have no IPv6 co=
de for */</span><br><span>@@ -1625,7 +1630,7 @@</span><br><span>           =
                 tt-&gt;adapter_netmask, NI_IP_NETMASK | NI_OPTIONS);</span=
><br><span>         }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        do_dns_domain_wmic(true, tt);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        do_dns_domain_pwsh(true, tt);</=
span><br><span>     }</span><br><span> </span><br><span> </span><br><span>@=
@ -7024,7 +7029,7 @@</span><br><span>         {</span><br><span>           =
  if (!tt-&gt;did_ifconfig_setup)</span><br><span>             {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                do_dns_domain_wm=
ic(false, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           do_dns_domain_pwsh(false, tt);</span><br><span>             }</s=
pan><br><span> </span><br><span>             netsh_delete_address_dns(tt, t=
rue, &amp;gc);</span><br><span>@@ -7050,7 +7055,7 @@</span><br><span>      =
   }</span><br><span>         else</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            do_dns_domain_wmic(fals=
e, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
do_dns_domain_pwsh(false, tt);</span><br><span> </span><br><span>          =
   if (tt-&gt;options.ip_win32_type =3D=3D IPW32_SET_NETSH)</span><br><span=
>             {</span><br><span>diff --git a/src/openvpn/win32.h b/src/open=
vpn/win32.h</span><br><span>index 1b87fa3..67e6169 100644</span><br><span>-=
-- a/src/openvpn/win32.h</span><br><span>+++ b/src/openvpn/win32.h</span><b=
r><span>@@ -38,7 +38,7 @@</span><br><span> #define WIN_ROUTE_PATH_SUFFIX &q=
uot;\\system32\\route.exe&quot;</span><br><span> #define WIN_IPCONFIG_PATH_=
SUFFIX &quot;\\system32\\ipconfig.exe&quot;</span><br><span> #define WIN_NE=
T_PATH_SUFFIX &quot;\\system32\\net.exe&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define WMIC_PATH_SUFFIX &quot;\\system32\\wbem\\wm=
ic.exe&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 POWERSHELL_PATH_SUFFIX &quot;\\system32\\WindowsPowerShell\\v1.0\\powershe=
ll.exe&quot;</span><br><span> </span><br><span> /*</span><br><span>  * Win3=
2-specific OpenVPN code, targeted at the mingw</span><br><span>diff --git a=
/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><s=
pan>index a25d26f..ca58596 100644</span><br><span>--- a/src/openvpnserv/int=
eractive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><s=
pan>@@ -1150,45 +1150,31 @@</span><br><span> }</span><br><span> </span><br>=
<span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Run comm=
and: wmic nicconfig (InterfaceIndex=3D$if_index) call $action ($data)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Run command: powershel=
l -NoProfile -NonInteractive -Command Set-DnsClient -InterfaceIndex %ld -Co=
nnectionSpecificSuffix &#39;%s&#39;</span><br><span>  * @param  if_index   =
 &quot;index of interface&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param  action      e.g., &quot;SetDNSDomain&quot;</span><br><=
span>  * @param  data        data if required for action</span><br><span>  =
*                     - a single word for SetDNSDomain, empty or NULL to de=
lete</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *               =
      - comma separated values for a list</span><br><span>  */</span><br><s=
pan> static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-wmic=
_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                   const wchar_=
t *data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pwsh_setdns=
_cmd(const NET_IFINDEX if_index, const wchar_t *data)</span><br><span> {</s=
pan><br><span>     DWORD err =3D 0;</span><br><span>     wchar_t argv0[MAX_=
PATH];</span><br><span>     wchar_t *cmdline =3D NULL;</span><br><span>    =
 int timeout =3D 10000; /* in msec */</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    openvpn_swprintf(argv0, _countof(argv=
0), L&quot;%ls\\%ls&quot;, get_win_sys_path(), L&quot;wbem\\wmic.exe&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_swprin=
tf(argv0, _countof(argv0), L&quot;%ls\\%ls&quot;, get_win_sys_path(), L&quo=
t;WindowsPowerShell\\v1.0\\powershell.exe&quot;);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    const wchar_t *fmt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* comma separated list=
 must be enclosed in parenthesis */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (data &amp;&amp; wcschr(data, L&#39;,&#39;))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        fmt =3D L&quot;wmic nicconfig where (In=
terfaceIndex=3D%ld) call %ls (%ls)&quot;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        fmt =3D L&quot;wm=
ic nicconfig where (InterfaceIndex=3D%ld) call %ls \&quot;%ls\&quot;&quot;;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const wchar_t *fmt =3D L&quot;-=
NoProfile -NonInteractive -Command Set-DnsClient -InterfaceIndex %lu -Conne=
ctionSpecificSuffix &#39;%s&#39;&quot;;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    size_t ncmdline =3D wcslen(fmt) + 2=
0 + wcslen(action) /* max 20 for ifindex */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                      + (data ? wcslen(data) + 1 : 1)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t ncmdlin=
e =3D wcslen(fmt) + 20 + /* max 20 for ifindex */ (data ? wcslen(data) + 1 =
: 1);</span><br><span>     cmdline =3D malloc(ncmdline*sizeof(wchar_t));</s=
pan><br><span>     if (!cmdline)</span><br><span>     {</span><br><span>   =
      return ERROR_OUTOFMEMORY;</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_swprintf(cmd=
line, ncmdline, fmt, if_index, action,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                     data ? data : L&quot;&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_swprintf(cmdlin=
e, ncmdline, fmt, if_index, data ? data : L&quot;&quot;);</span><br><span> =
    err =3D ExecCommand(argv0, cmdline, timeout);</span><br><span> </span><=
br><span>     free(cmdline);</span><br><span>@@ -1248,7 +1234,7 @@</span><b=
r><span>         free(RemoveListItem(&amp;(*lists)[undo_domain], CmpWString=
, (void *)if_name));</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    err =3D wmic_nicconfig_cmd(L&qu=
ot;SetDNSDomain&quot;, if_index, wdomain);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    err =3D pwsh_setdns_cmd(if_index, wdomain);</spa=
n><br><span> </span><br><span>     /* Add to undo list if domain is non-emp=
ty */</span><br><span>     if (err =3D=3D 0 &amp;&amp; wdomain[0] &amp;&amp=
; lists)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1183?usp=3Demail">change 1183</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1183?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff2f4ea677fe2d88659d7814dab=
0f792f5004fb3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1183 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--3nyBJZlpzo0=--

