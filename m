From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 12 Sep 2025 14:18:24 +0000
In-Reply-To: <gerrit.1757684109000.Iff2f4ea677fe2d88659d7814dab0f792f5004fb3@...2715...>
References: <gerrit.1757684109000.Iff2f4ea677fe2d88659d7814dab0f792f5004fb3@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <72fe24165dc690ad839020160fb3ef341bff7820-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gd/KXwN8o6w="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gd/KXwN8o6w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1183?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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

GitHub: https://github.com/OpenVPN/openvpn/issues/642

Change-Id: Iff2f4ea677fe2d88659d7814dab0f792f5004fb3
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/tun.c
M src/openvpn/win32.h
M src/openvpnserv/interactive.c
3 files changed, 21 insertions(+), 30 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/1183/2

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 92e71a3..7c8a351 100644
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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--gd/KXwN8o6w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1183?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">win: replace wmic invocation with powershell<=
br><br>Since wmic has been recently deprecated and is absent on new<br>syst=
ems, replace setting DNS domain &quot;old-style&quot; with powershell.<br><=
br>Some changes to the service implementation:<br><br> - remove action para=
meter and hardcode Set-DnsClient since this is<br> the only used action<br>=
<br> - remove support of multiple domains, since we only pass a single doma=
in<br> (tuntap_options.domain)<br><br>GitHub: https://github.com/OpenVPN/op=
envpn/issues/642<br><br>Change-Id: Iff2f4ea677fe2d88659d7814dab0f792f5004fb=
3<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/open=
vpn/tun.c<br>M src/openvpn/win32.h<br>M src/openvpnserv/interactive.c<br>3 =
files changed, 21 insertions(+), 30 deletions(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/83/1183/2</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 92e71a3..7c8a3=
51 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src=
/openvpn/tun.c</span><br><span>@@ -383,7 +383,7 @@</span><br><span> }</span=
><br><span> </span><br><span> static void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-do_dns_domain_wmic(bool add, const struct tuntap *tt)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_dns_domain_pwsh(bo=
ol add, const struct tuntap *tt)</span><br><span> {</span><br><span>     if=
 (!tt-&gt;options.domain)</span><br><span>     {</span><br><span>@@ -391,9 =
+391,14 @@</span><br><span>     }</span><br><span> </span><br><span>     st=
ruct argv argv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    argv_printf(&amp;argv, &quot;%s%s nicconfig where (InterfaceIn=
dex=3D%ld) call SetDNSDomain &#39;%s&#39;&quot;,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                get_win_sys_path(), WMIC_PATH_SU=
FFIX, tt-&gt;adapter_index, add ? tt-&gt;options.domain : &quot;&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    exec_command(&quot;W=
MIC&quot;, &amp;argv, 1, M_WARN);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    argv_printf(&amp;argv,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                &quot;%s%s -NoProfile -NonInteractive =
-Command Set-DnsClient -InterfaceIndex %lu -ConnectionSpecificSuffix &#39;%=
s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          get_win_sys_path(),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                POWERSHELL_PATH_SUFFIX,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                tt-&gt;adapter_index,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                add ? tt-&g=
t;options.domain : &quot;&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                );</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    exec_command(&quot;PowerShell&quot;, &amp;argv, 1, M_WARN);<=
/span><br><span> </span><br><span>     argv_free(&amp;argv);</span><br><spa=
n> }</span><br><span>@@ -1269,7 +1274,7 @@</span><br><span> </span><br><spa=
n>         if (!tt-&gt;did_ifconfig_setup)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            do_dns_domain_w=
mic(true, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       do_dns_domain_pwsh(true, tt);</span><br><span>         }</span><br><=
span>     }</span><br><span> #else /* platforms we have no IPv6 code for */=
</span><br><span>@@ -1625,7 +1630,7 @@</span><br><span>                    =
        tt-&gt;adapter_netmask, NI_IP_NETMASK | NI_OPTIONS);</span><br><spa=
n>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        do_dns_domain_wmic(true, tt);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        do_dns_domain_pwsh(true, tt);</span><br>=
<span>     }</span><br><span> </span><br><span> </span><br><span>@@ -7024,7=
 +7029,7 @@</span><br><span>         {</span><br><span>             if (!tt=
-&gt;did_ifconfig_setup)</span><br><span>             {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                do_dns_domain_wmic(false,=
 tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  do_dns_domain_pwsh(false, tt);</span><br><span>             }</span><br><=
span> </span><br><span>             netsh_delete_address_dns(tt, true, &amp=
;gc);</span><br><span>@@ -7050,7 +7055,7 @@</span><br><span>         }</spa=
n><br><span>         else</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            do_dns_domain_wmic(false, tt);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            do_dns_d=
omain_pwsh(false, tt);</span><br><span> </span><br><span>             if (t=
t-&gt;options.ip_win32_type =3D=3D IPW32_SET_NETSH)</span><br><span>       =
      {</span><br><span>diff --git a/src/openvpn/win32.h b/src/openvpn/win3=
2.h</span><br><span>index 1b87fa3..67e6169 100644</span><br><span>--- a/src=
/openvpn/win32.h</span><br><span>+++ b/src/openvpn/win32.h</span><br><span>=
@@ -38,7 +38,7 @@</span><br><span> #define WIN_ROUTE_PATH_SUFFIX &quot;\\sy=
stem32\\route.exe&quot;</span><br><span> #define WIN_IPCONFIG_PATH_SUFFIX &=
quot;\\system32\\ipconfig.exe&quot;</span><br><span> #define WIN_NET_PATH_S=
UFFIX &quot;\\system32\\net.exe&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define WMIC_PATH_SUFFIX &quot;\\system32\\wbem\\wmic.exe&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define POWERSH=
ELL_PATH_SUFFIX &quot;\\system32\\WindowsPowerShell\\v1.0\\powershell.exe&q=
uot;</span><br><span> </span><br><span> /*</span><br><span>  * Win32-specif=
ic OpenVPN code, targeted at the mingw</span><br><span>diff --git a/src/ope=
nvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><span>inde=
x a25d26f..ca58596 100644</span><br><span>--- a/src/openvpnserv/interactive=
.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -=
1150,45 +1150,31 @@</span><br><span> }</span><br><span> </span><br><span> /=
**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Run command: wmi=
c nicconfig (InterfaceIndex=3D$if_index) call $action ($data)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Run command: powershell -NoPro=
file -NonInteractive -Command Set-DnsClient -InterfaceIndex %ld -Connection=
SpecificSuffix &#39;%s&#39;</span><br><span>  * @param  if_index    &quot;i=
ndex of interface&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * @param  action      e.g., &quot;SetDNSDomain&quot;</span><br><span>  *=
 @param  data        data if required for action</span><br><span>  *       =
              - a single word for SetDNSDomain, empty or NULL to delete</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *                     - =
comma separated values for a list</span><br><span>  */</span><br><span> sta=
tic DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-wmic_nicconf=
ig_cmd(const wchar_t *action, const NET_IFINDEX if_index,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                   const wchar_t *data)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pwsh_setdns_cmd(con=
st NET_IFINDEX if_index, const wchar_t *data)</span><br><span> {</span><br>=
<span>     DWORD err =3D 0;</span><br><span>     wchar_t argv0[MAX_PATH];</=
span><br><span>     wchar_t *cmdline =3D NULL;</span><br><span>     int tim=
eout =3D 10000; /* in msec */</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    openvpn_swprintf(argv0, _countof(argv0), L&qu=
ot;%ls\\%ls&quot;, get_win_sys_path(), L&quot;wbem\\wmic.exe&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_swprintf(argv0=
, _countof(argv0), L&quot;%ls\\%ls&quot;, get_win_sys_path(), L&quot;Window=
sPowerShell\\v1.0\\powershell.exe&quot;);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    const wchar_t *fmt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* comma separated list must be=
 enclosed in parenthesis */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (data &amp;&amp; wcschr(data, L&#39;,&#39;))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        fmt =3D L&quot;wmic nicconfig where (InterfaceI=
ndex=3D%ld) call %ls (%ls)&quot;;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        fmt =3D L&quot;wmic nicco=
nfig where (InterfaceIndex=3D%ld) call %ls \&quot;%ls\&quot;&quot;;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const wchar_t *fmt =3D L&quot;-NoProf=
ile -NonInteractive -Command Set-DnsClient -InterfaceIndex %lu -ConnectionS=
pecificSuffix &#39;%s&#39;&quot;;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    size_t ncmdline =3D wcslen(fmt) + 20 + =
wcslen(action) /* max 20 for ifindex */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                      + (data ? wcslen(data) + 1 : 1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t ncmdline =
=3D wcslen(fmt) + 20 + /* max 20 for ifindex */ (data ? wcslen(data) + 1 : =
1);</span><br><span>     cmdline =3D malloc(ncmdline*sizeof(wchar_t));</spa=
n><br><span>     if (!cmdline)</span><br><span>     {</span><br><span>     =
    return ERROR_OUTOFMEMORY;</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_swprintf(cmdli=
ne, ncmdline, fmt, if_index, action,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                     data ? data : L&quot;&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_swprintf(cmdline,=
 ncmdline, fmt, if_index, data ? data : L&quot;&quot;);</span><br><span>   =
  err =3D ExecCommand(argv0, cmdline, timeout);</span><br><span> </span><br=
><span>     free(cmdline);</span><br><span>@@ -1248,7 +1234,7 @@</span><br>=
<span>         free(RemoveListItem(&amp;(*lists)[undo_domain], CmpWString, =
(void *)if_name));</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    err =3D wmic_nicconfig_cmd(L&quot=
;SetDNSDomain&quot;, if_index, wdomain);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    err =3D pwsh_setdns_cmd(if_index, wdomain);</span>=
<br><span> </span><br><span>     /* Add to undo list if domain is non-empty=
 */</span><br><span>     if (err =3D=3D 0 &amp;&amp; wdomain[0] &amp;&amp; =
lists)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1183?usp=3Demail">change 1183</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1183?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff2f4ea677fe2d88659d7814dab=
0f792f5004fb3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1183 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--gd/KXwN8o6w=--

