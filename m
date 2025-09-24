From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 20:36:38 +0000
In-Reply-To: <gerrit.1758720945000.I09209ccd785cc368b2fcf467a3d211fbd41005c6@...2715...>
References: <gerrit.1758720945000.I09209ccd785cc368b2fcf467a3d211fbd41005c6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <153f7a223f4c80ead17e4548d8f1735792453fb8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="v/LFgIk6kXQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Validate DNS
 parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--v/LFgIk6kXQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
13?usp=3Demail )

Change subject: Validate DNS parameters
......................................................................

Validate DNS parameters

This adds validation of following DNS options:

 --dns search-domains
 --dns server N resolve-domains
 --dns server N sni

 --dhcp-option DOMAIN
 --dhcp-option ADAPTER_DOMAIN_SUFFIX
 --dhcp-option DOMAIN-SEARCH

On Linux (and similar platforms), those options are written to a tmp file,
which is later sourced by a script running as root. Since options are
controlled by the server, it is possible for a malicious server to
execute script injection attack by pushing something like

 --dns search-domains x;id

in which case "id" command will be executed as a root.

On Windows, the value of DOMAIN/ADAPTER_DOMAIN_SUFFIX is passed to
a powershell script. A malicious server could push:

 --dhcp-option DOMAIN a';Restart-Computer'

and if openvpn is not using DHCP (this is the default, with dco-win driver)
and running without interactive service, that powershell command will be
executed.

Validation is performed in a way that value only contains following
symbols:

  [A-Za-z0-9.-_\x80-\0xff]

Reported-By: Stanislav Fort <disclosure@...2935...>
CVE: 2025-10680
Change-Id: I09209ccd785cc368b2fcf467a3d211fbd41005c6
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1213
Message-Id: <20250924201601.25304-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59238367/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/Makefile.am
M src/openvpn/dns.c
M src/openvpn/dns.h
A src/openvpn/domain_helper.h
M src/openvpn/options.c
5 files changed, 89 insertions(+), 7 deletions(-)




diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 217f897..1247f11 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -61,6 +61,7 @@
 	dco_win.c dco_win.h \
 	dhcp.c dhcp.h \
 	dns.c dns.h \
+	domain_helper.h \
 	env_set.c env_set.h \
 	errlevel.h \
 	error.c error.h \
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 2a9e60b..d2ff670 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -30,6 +30,7 @@
 #include "socket_util.h"
 #include "options.h"
 #include "run_command.h"
+#include "domain_helper.h"

 #ifdef _WIN32
 #include "win32.h"
@@ -143,7 +144,7 @@
     return true;
 }

-void
+bool
 dns_domain_list_append(struct dns_domain **entry, char **domains, struct g=
c_arena *gc)
 {
     /* Fast forward to the end of the list */
@@ -155,11 +156,19 @@
     /* Append all domains to the end of the list */
     while (*domains)
     {
+        char *domain =3D *domains++;
+        if (!validate_domain(domain))
+        {
+            return false;
+        }
+
         ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, gc);
         struct dns_domain *new =3D *entry;
-        new->name =3D *domains++;
+        new->name =3D domain;
         entry =3D &new->next;
     }
+
+    return true;
 }

 bool
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 6cd98f2..3dd7847 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -141,13 +141,14 @@
 struct dns_server *dns_server_get(struct dns_server **entry, long priority=
, struct gc_arena *gc);

 /**
- * Appends DNS domain parameters to a linked list.
+ * Appends safe DNS domain parameters to a linked list.
  *
  * @param   entry       Address of the first list entry pointer
  * @param   domains     Address of the first domain parameter
  * @param   gc          The gc the new list items should be allocated in
+ * @return              True if domains were appended and don't contain in=
valid characters
  */
-void dns_domain_list_append(struct dns_domain **entry, char **domains, str=
uct gc_arena *gc);
+bool dns_domain_list_append(struct dns_domain **entry, char **domains, str=
uct gc_arena *gc);

 /**
  * Parses a string IPv4 or IPv6 address and optional colon separated port,
diff --git a/src/openvpn/domain_helper.h b/src/openvpn/domain_helper.h
new file mode 100644
index 0000000..f1ecf86
--- /dev/null
+++ b/src/openvpn/domain_helper.h
@@ -0,0 +1,45 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2025 Lev Stipakov <lev@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+static inline bool
+is_allowed_domain_ascii(unsigned char c)
+{
+    return (c >=3D 'A' && c <=3D 'Z')
+           || (c >=3D 'a' && c <=3D 'z')
+           || (c >=3D '0' && c <=3D '9')
+           || c =3D=3D '.' || c =3D=3D '-' || c =3D=3D '_' || c >=3D 0x80;
+}
+
+static inline bool
+validate_domain(const char *domain)
+{
+    for (const char *ch =3D domain; *ch; ++ch)
+    {
+        if (!is_allowed_domain_ascii((unsigned char)*ch))
+        {
+            return false;
+        }
+    }
+
+    return true;
+}
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f801743..f35738d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -61,6 +61,7 @@
 #include "dco.h"
 #include "options_util.h"
 #include "tun_afunix.h"
+#include "domain_helper.h"

 #include <ctype.h>

@@ -5877,8 +5878,12 @@
 {
     if (streq(p[1], "search-domains") && p[2])
     {
-        dns_domain_list_append(&options->dns_options.search_domains, &p[2],
-                               &options->dns_options.gc);
+        if (!dns_domain_list_append(&options->dns_options.search_domains, =
&p[2],
+                                    &options->dns_options.gc))
+        {
+            msg(msglevel, "--dns %s contain invalid characters", p[1]);
+            return false;
+        }
     }
     else if (streq(p[1], "server") && p[2] && p[3] && p[4])
     {
@@ -5906,7 +5911,11 @@
         }
         else if (streq(p[3], "resolve-domains"))
         {
-            dns_domain_list_append(&server->domains, &p[4], &options->dns_=
options.gc);
+            if (!dns_domain_list_append(&server->domains, &p[4], &options-=
>dns_options.gc))
+            {
+                msg(msglevel, "--dns server %ld: %s contain invalid charac=
ters", priority, p[3]);
+                return false;
+            }
         }
         else if (streq(p[3], "dnssec") && !p[5])
         {
@@ -5950,6 +5959,11 @@
         }
         else if (streq(p[3], "sni") && !p[5])
         {
+            if (!validate_domain(p[4]))
+            {
+                msg(msglevel, "--dns server %ld: %s contains invalid chara=
cters", priority, p[3]);
+                return false;
+            }
             server->sni =3D p[4];
         }
         else
@@ -8551,11 +8565,23 @@

         if ((streq(p[1], "DOMAIN") || streq(p[1], "ADAPTER_DOMAIN_SUFFIX")=
) && p[2] && !p[3])
         {
+            if (!validate_domain(p[2]))
+            {
+                msg(msglevel, "--dhcp-option %s contains invalid character=
s", p[1]);
+                goto err;
+            }
+
             dhcp->domain =3D p[2];
             dhcp_optional =3D true;
         }
         else if (streq(p[1], "DOMAIN-SEARCH") && p[2] && !p[3])
         {
+            if (!validate_domain(p[2]))
+            {
+                msg(msglevel, "--dhcp-option %s contains invalid character=
s", p[1]);
+                goto err;
+            }
+
             if (dhcp->domain_search_list_len < N_SEARCH_LIST_LEN)
             {
                 dhcp->domain_search_list[dhcp->domain_search_list_len++] =
=3D p[2];

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1213?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09209ccd785cc368b2fcf467a3d211fbd41005c6
Gerrit-Change-Number: 1213
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--v/LFgIk6kXQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1213?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Validate DNS parameters<br><br>This adds vali=
dation of following DNS options:<br><br> --dns search-domains<br> --dns ser=
ver N resolve-domains<br> --dns server N sni<br><br> --dhcp-option DOMAIN<b=
r> --dhcp-option ADAPTER_DOMAIN_SUFFIX<br> --dhcp-option DOMAIN-SEARCH<br><=
br>On Linux (and similar platforms), those options are written to a tmp fil=
e,<br>which is later sourced by a script running as root. Since options are=
<br>controlled by the server, it is possible for a malicious server to<br>e=
xecute script injection attack by pushing something like<br><br> --dns sear=
ch-domains x;id<br><br>in which case &quot;id&quot; command will be execute=
d as a root.<br><br>On Windows, the value of DOMAIN/ADAPTER_DOMAIN_SUFFIX i=
s passed to<br>a powershell script. A malicious server could push:<br><br> =
--dhcp-option DOMAIN a&#39;;Restart-Computer&#39;<br><br>and if openvpn is =
not using DHCP (this is the default, with dco-win driver)<br>and running wi=
thout interactive service, that powershell command will be<br>executed.<br>=
<br>Validation is performed in a way that value only contains following<br>=
symbols:<br><br>  [A-Za-z0-9.-_\x80-\0xff]<br><br>Reported-By: Stanislav Fo=
rt &lt;disclosure@...2935...&gt;<br>CVE: 2025-10680<br>Change-Id: I09209ccd=
785cc368b2fcf467a3d211fbd41005c6<br>Signed-off-by: Lev Stipakov &lt;lev@...493...=
515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL:=
 https://gerrit.openvpn.net/c/openvpn/+/1213<br>Message-Id: &lt;20250924201=
601.25304-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/m=
ailman/message/59238367/<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M src/openvpn/Makefile.am<br>M src/openvpn/dns.c<br>M src/op=
envpn/dns.h<br>A src/openvpn/domain_helper.h<br>M src/openvpn/options.c<br>=
5 files changed, 89 insertions(+), 7 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><br=
><span>index 217f897..1247f11 100644</span><br><span>--- a/src/openvpn/Make=
file.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -6=
1,6 +61,7 @@</span><br><span> 	dco_win.c dco_win.h \</span><br><span> 	dhcp=
.c dhcp.h \</span><br><span> 	dns.c dns.h \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	domain_helper.h \</span><br><span> 	env_set.c env_=
set.h \</span><br><span> 	errlevel.h \</span><br><span> 	error.c error.h \<=
/span><br><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><b=
r><span>index 2a9e60b..d2ff670 100644</span><br><span>--- a/src/openvpn/dns=
.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -30,6 +30,7 @=
@</span><br><span> #include &quot;socket_util.h&quot;</span><br><span> #inc=
lude &quot;options.h&quot;</span><br><span> #include &quot;run_command.h&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;d=
omain_helper.h&quot;</span><br><span> </span><br><span> #ifdef _WIN32</span=
><br><span> #include &quot;win32.h&quot;</span><br><span>@@ -143,7 +144,7 @=
@</span><br><span>     return true;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span> dns_domain_list_a=
ppend(struct dns_domain **entry, char **domains, struct gc_arena *gc)</span=
><br><span> {</span><br><span>     /* Fast forward to the end of the list *=
/</span><br><span>@@ -155,11 +156,19 @@</span><br><span>     /* Append all =
domains to the end of the list */</span><br><span>     while (*domains)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        char *domain =3D *domains++;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (!validate_domain(domain))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            return false;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>         ALLOC_OBJ_CLEAR_GC(*entry, s=
truct dns_domain, gc);</span><br><span>         struct dns_domain *new =3D =
*entry;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        new-&g=
t;name =3D *domains++;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        new-&gt;name =3D domain;</span><br><span>         entry =3D &amp=
;new-&gt;next;</span><br><span>     }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return true;</span><br><span> }</span><br><span> </span><br><span> bool<=
/span><br><span>diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h</span><b=
r><span>index 6cd98f2..3dd7847 100644</span><br><span>--- a/src/openvpn/dns=
.h</span><br><span>+++ b/src/openvpn/dns.h</span><br><span>@@ -141,13 +141,=
14 @@</span><br><span> struct dns_server *dns_server_get(struct dns_server =
**entry, long priority, struct gc_arena *gc);</span><br><span> </span><br><=
span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Appends D=
NS domain parameters to a linked list.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Appends safe DNS domain parameters to a linked list.<=
/span><br><span>  *</span><br><span>  * @param   entry       Address of the=
 first list entry pointer</span><br><span>  * @param   domains     Address =
of the first domain parameter</span><br><span>  * @param   gc          The =
gc the new list items should be allocated in</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @return              True if domains were appen=
ded and don&#39;t contain invalid characters</span><br><span>  */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-void dns_domain_list_append(str=
uct dns_domain **entry, char **domains, struct gc_arena *gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+bool dns_domain_list_append(struc=
t dns_domain **entry, char **domains, struct gc_arena *gc);</span><br><span=
> </span><br><span> /**</span><br><span>  * Parses a string IPv4 or IPv6 ad=
dress and optional colon separated port,</span><br><span>diff --git a/src/o=
penvpn/domain_helper.h b/src/openvpn/domain_helper.h</span><br><span>new fi=
le mode 100644</span><br><span>index 0000000..f1ecf86</span><br><span>--- /=
dev/null</span><br><span>+++ b/src/openvpn/domain_helper.h</span><br><span>=
@@ -0,0 +1,45 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An ap=
plication to securely tunnel IP networks</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             over a single UDP port, with support fo=
r SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
           session authentication and key exchange,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet =
authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             packet compression.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  Copyright (C) 2025 Lev Stipakov &lt;lev@...515...&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  This program is free software; you can redistribute =
it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 it under the terms of the GNU General Public License version 2</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free So=
ftware Foundation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s distributed in the hope that it will be useful,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Lice=
nse for more details.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should =
have received a copy of the GNU General Public License along</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, wri=
te to the Free Software Foundation, Inc.,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110=
-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+is_allowed_domain_ascii(unsigned char c)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return (c &gt;=3D &#39;A&#39; &amp;&a=
mp; c &lt;=3D &#39;Z&#39;)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+           || (c &gt;=3D &#39;a&#39; &amp;&amp; c &lt;=3D &#39;z&#39=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           || (c =
&gt;=3D &#39;0&#39; &amp;&amp; c &lt;=3D &#39;9&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           || c =3D=3D &#39;.&#39; || c =
=3D=3D &#39;-&#39; || c =3D=3D &#39;_&#39; || c &gt;=3D 0x80;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+validate_domain(const char *domain)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    for (const char *ch =3D domain; *ch; ++ch)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!is_allowed_domain_ascii((unsigned char)*ch))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/optio=
ns.c</span><br><span>index f801743..f35738d 100644</span><br><span>--- a/sr=
c/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><=
span>@@ -61,6 +61,7 @@</span><br><span> #include &quot;dco.h&quot;</span><b=
r><span> #include &quot;options_util.h&quot;</span><br><span> #include &quo=
t;tun_afunix.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;domain_helper.h&quot;</span><br><span> </span><br><span> #i=
nclude &lt;ctype.h&gt;</span><br><span> </span><br><span>@@ -5877,8 +5878,1=
2 @@</span><br><span> {</span><br><span>     if (streq(p[1], &quot;search-d=
omains&quot;) &amp;&amp; p[2])</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        dns_domain_list_append(&amp;options=
-&gt;dns_options.search_domains, &amp;p[2],</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                               &amp;options-&gt;dns_o=
ptions.gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!dns_domain_list_append(&amp;options-&gt;dns_options.search_domains, &a=
mp;p[2],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                         &amp;options-&gt;dns_options.gc))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--dns %s conta=
in invalid characters&quot;, p[1]);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span>    =
 else if (streq(p[1], &quot;server&quot;) &amp;&amp; p[2] &amp;&amp; p[3] &=
amp;&amp; p[4])</span><br><span>     {</span><br><span>@@ -5906,7 +5911,11 =
@@</span><br><span>         }</span><br><span>         else if (streq(p[3],=
 &quot;resolve-domains&quot;))</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            dns_domain_list_append(&amp=
;server-&gt;domains, &amp;p[4], &amp;options-&gt;dns_options.gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (!dns_domain_l=
ist_append(&amp;server-&gt;domains, &amp;p[4], &amp;options-&gt;dns_options=
.gc))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(=
msglevel, &quot;--dns server %ld: %s contain invalid characters&quot;, prio=
rity, p[3]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span>         }</span><br><span>         else i=
f (streq(p[3], &quot;dnssec&quot;) &amp;&amp; !p[5])</span><br><span>      =
   {</span><br><span>@@ -5950,6 +5959,11 @@</span><br><span>         }</spa=
n><br><span>         else if (streq(p[3], &quot;sni&quot;) &amp;&amp; !p[5]=
)</span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (!validate_domain(p[4]))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--dns server %ld=
: %s contains invalid characters&quot;, priority, p[3]);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n>             server-&gt;sni =3D p[4];</span><br><span>         }</span><b=
r><span>         else</span><br><span>@@ -8551,11 +8565,23 @@</span><br><sp=
an> </span><br><span>         if ((streq(p[1], &quot;DOMAIN&quot;) || streq=
(p[1], &quot;ADAPTER_DOMAIN_SUFFIX&quot;)) &amp;&amp; p[2] &amp;&amp; !p[3]=
)</span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (!validate_domain(p[2]))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--dhcp-option %s=
 contains invalid characters&quot;, p[1]);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                goto err;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>             dhcp-&gt;domain =3D p[=
2];</span><br><span>             dhcp_optional =3D true;</span><br><span>  =
       }</span><br><span>         else if (streq(p[1], &quot;DOMAIN-SEARCH&=
quot;) &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>         {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!validate_d=
omain(p[2]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   msg(msglevel, &quot;--dhcp-option %s contains invalid characters&quot;, =
p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>             if (dhcp-&gt;domain_search_list_len &lt; N_SEARCH_LIST_LEN=
)</span><br><span>             {</span><br><span>                 dhcp-&gt;=
domain_search_list[dhcp-&gt;domain_search_list_len++] =3D p[2];</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1213?usp=3Demail">change 1213</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
213?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09209ccd785cc368b2fcf467a3d=
211fbd41005c6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1213 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--v/LFgIk6kXQ=--

