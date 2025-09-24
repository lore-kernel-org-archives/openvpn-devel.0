From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 13:35:47 +0000
References: <gerrit.1758720945000.I09209ccd785cc368b2fcf467a3d211fbd41005c6@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <743aff3a98c4a3592f27ac6956781d5fae498a04-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AtSWgl9v3ko="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AtSWgl9v3ko=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1213?usp=3Demail

to review the following change.


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
and and running without interactive service, that powershell command
will be executed.

Validation is performed in a way that value only contains following
symbols:

  [A-Za-z0-9.-_\x80-\0xff]

Reported-By: Stanislav Fort <disclosure@...2935...>
CVE: 2025-10680
Change-Id: I09209ccd785cc368b2fcf467a3d211fbd41005c6
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/Makefile.am
M src/openvpn/dns.c
M src/openvpn/dns.h
A src/openvpn/domain_helper.h
M src/openvpn/options.c
5 files changed, 89 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/1213/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--AtSWgl9v3ko=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1213?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Validate DNS parameters<br><br>This adds validation of follo=
wing DNS options:<br><br> --dns search-domains<br> --dns server N resolve-d=
omains<br> --dns server N sni<br><br> --dhcp-option DOMAIN<br> --dhcp-optio=
n ADAPTER_DOMAIN_SUFFIX<br> --dhcp-option DOMAIN-SEARCH<br><br>On Linux (an=
d similar platforms), those options are written to a tmp file,<br>which is =
later sourced by a script running as root. Since options are<br>controlled =
by the server, it is possible for a malicious server to<br>execute script i=
njection attack by pushing something like<br><br> --dns search-domains x;id=
<br><br>in which case &quot;id&quot; command will be executed as a root.<br=
><br>On Windows, the value of DOMAIN/ADAPTER_DOMAIN_SUFFIX is passed to<br>=
a powershell script. A malicious server could push:<br><br> --dhcp-option D=
OMAIN a&#39;;Restart-Computer&#39;<br><br>and if openvpn is not using DHCP =
(this is the default, with dco-win driver)<br>and and running without inter=
active service, that powershell command<br>will be executed.<br><br>Validat=
ion is performed in a way that value only contains following<br>symbols:<br=
><br>  [A-Za-z0-9.-_\x80-\0xff]<br><br>Reported-By: Stanislav Fort &lt;disc=
losure@...2935...&gt;<br>CVE: 2025-10680<br>Change-Id: I09209ccd785cc368b2f=
cf467a3d211fbd41005c6<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<=
br>---<br>M src/openvpn/Makefile.am<br>M src/openvpn/dns.c<br>M src/openvpn=
/dns.h<br>A src/openvpn/domain_helper.h<br>M src/openvpn/options.c<br>5 fil=
es changed, 89 insertions(+), 7 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/13/1213/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><br><span>index 217f89=
7..1247f11 100644</span><br><span>--- a/src/openvpn/Makefile.am</span><br><=
span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -61,6 +61,7 @@</span>=
<br><span> 	dco_win.c dco_win.h \</span><br><span> 	dhcp.c dhcp.h \</span><=
br><span> 	dns.c dns.h \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	domain_helper.h \</span><br><span> 	env_set.c env_set.h \</span><br><=
span> 	errlevel.h \</span><br><span> 	error.c error.h \</span><br><span>dif=
f --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index 2a9e6=
0b..d2ff670 100644</span><br><span>--- a/src/openvpn/dns.c</span><br><span>=
+++ b/src/openvpn/dns.c</span><br><span>@@ -30,6 +30,7 @@</span><br><span> =
#include &quot;socket_util.h&quot;</span><br><span> #include &quot;options.=
h&quot;</span><br><span> #include &quot;run_command.h&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;domain_helper.h&quot=
;</span><br><span> </span><br><span> #ifdef _WIN32</span><br><span> #includ=
e &quot;win32.h&quot;</span><br><span>@@ -143,7 +144,7 @@</span><br><span> =
    return true;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+bool</span><br><span> dns_domain_list_append(struct dns_do=
main **entry, char **domains, struct gc_arena *gc)</span><br><span> {</span=
><br><span>     /* Fast forward to the end of the list */</span><br><span>@=
@ -155,11 +156,19 @@</span><br><span>     /* Append all domains to the end =
of the list */</span><br><span>     while (*domains)</span><br><span>     {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *domai=
n =3D *domains++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (!validate_domain(domain))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>         ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, g=
c);</span><br><span>         struct dns_domain *new =3D *entry;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        new-&gt;name =3D *domains=
++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        new-&gt;=
name =3D domain;</span><br><span>         entry =3D &amp;new-&gt;next;</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</sp=
an><br><span> }</span><br><span> </span><br><span> bool</span><br><span>dif=
f --git a/src/openvpn/dns.h b/src/openvpn/dns.h</span><br><span>index 6cd98=
f2..3dd7847 100644</span><br><span>--- a/src/openvpn/dns.h</span><br><span>=
+++ b/src/openvpn/dns.h</span><br><span>@@ -141,13 +141,14 @@</span><br><sp=
an> struct dns_server *dns_server_get(struct dns_server **entry, long prior=
ity, struct gc_arena *gc);</span><br><span> </span><br><span> /**</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * Appends DNS domain parameter=
s to a linked list.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Appends safe DNS domain parameters to a linked list.</span><br><span>  *=
</span><br><span>  * @param   entry       Address of the first list entry p=
ointer</span><br><span>  * @param   domains     Address of the first domain=
 parameter</span><br><span>  * @param   gc          The gc the new list ite=
ms should be allocated in</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @return              True if domains were appended and don&#39;t c=
ontain invalid characters</span><br><span>  */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void dns_domain_list_append(struct dns_domain **en=
try, char **domains, struct gc_arena *gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool dns_domain_list_append(struct dns_domain **entr=
y, char **domains, struct gc_arena *gc);</span><br><span> </span><br><span>=
 /**</span><br><span>  * Parses a string IPv4 or IPv6 address and optional =
colon separated port,</span><br><span>diff --git a/src/openvpn/domain_helpe=
r.h b/src/openvpn/domain_helper.h</span><br><span>new file mode 100644</spa=
n><br><span>index 0000000..f1ecf86</span><br><span>--- /dev/null</span><br>=
<span>+++ b/src/openvpn/domain_helper.h</span><br><span>@@ -0,0 +1,45 @@</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to secure=
ly tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             over a single UDP port, with support for SSL/TLS-based</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session =
authentication and key exchange,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             packet encryption, packet authentication, and</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet=
 compression.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 =
Lev Stipakov &lt;lev@...515...&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  This program is free software; you can redistribute it and/or modify</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms o=
f the GNU General Public License version 2</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the =
hope that it will be useful,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY=
 or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy =
of the GNU General Public License along</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  with this program; if not, write to the Free Softwa=
re Foundation, Inc.,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static inline bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+is_allowed_domain_ascii(unsigned char c)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return (c &gt;=3D &#39;A&#39; &amp;&amp; c &lt;=3D &#39;Z&#=
39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           || (=
c &gt;=3D &#39;a&#39; &amp;&amp; c &lt;=3D &#39;z&#39;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+           || (c &gt;=3D &#39;0&#39; &a=
mp;&amp; c &lt;=3D &#39;9&#39;)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+           || c =3D=3D &#39;.&#39; || c =3D=3D &#39;-&#39; || c=
 =3D=3D &#39;_&#39; || c &gt;=3D 0x80;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline bool=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+validate_domain(con=
st char *domain)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const char *=
ch =3D domain; *ch; ++ch)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!is_allowed_domain_ascii((unsigned char)*ch))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>di=
ff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>in=
dex f801743..f35738d 100644</span><br><span>--- a/src/openvpn/options.c</sp=
an><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -61,6 +61,7 @@<=
/span><br><span> #include &quot;dco.h&quot;</span><br><span> #include &quot=
;options_util.h&quot;</span><br><span> #include &quot;tun_afunix.h&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;domain_=
helper.h&quot;</span><br><span> </span><br><span> #include &lt;ctype.h&gt;<=
/span><br><span> </span><br><span>@@ -5877,8 +5878,12 @@</span><br><span> {=
</span><br><span>     if (streq(p[1], &quot;search-domains&quot;) &amp;&amp=
; p[2])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        dns_domain_list_append(&amp;options-&gt;dns_options.search=
_domains, &amp;p[2],</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                              &amp;options-&gt;dns_options.gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!dns_domain_list_ap=
pend(&amp;options-&gt;dns_options.search_domains, &amp;p[2],</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
  &amp;options-&gt;dns_options.gc))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(msglevel, &quot;--dns %s contain invalid characters&q=
uot;, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span>     }</span><br><span>     else if (streq(p[1], &=
quot;server&quot;) &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; p[4])</span><=
br><span>     {</span><br><span>@@ -5906,7 +5911,11 @@</span><br><span>    =
     }</span><br><span>         else if (streq(p[3], &quot;resolve-domains&=
quot;))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            dns_domain_list_append(&amp;server-&gt;domains, &a=
mp;p[4], &amp;options-&gt;dns_options.gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            if (!dns_domain_list_append(&amp;server-=
&gt;domains, &amp;p[4], &amp;options-&gt;dns_options.gc))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--dns=
 server %ld: %s contain invalid characters&quot;, priority, p[3]);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span>         }</span><br><span>         else if (streq(p[3], &quot;=
dnssec&quot;) &amp;&amp; !p[5])</span><br><span>         {</span><br><span>=
@@ -5950,6 +5959,11 @@</span><br><span>         }</span><br><span>         =
else if (streq(p[3], &quot;sni&quot;) &amp;&amp; !p[5])</span><br><span>   =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (!validate_domain(p[4]))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                msg(msglevel, &quot;--dns server %ld: %s contains invalid=
 characters&quot;, priority, p[3]);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span>             server=
-&gt;sni =3D p[4];</span><br><span>         }</span><br><span>         else=
</span><br><span>@@ -8551,11 +8565,23 @@</span><br><span> </span><br><span>=
         if ((streq(p[1], &quot;DOMAIN&quot;) || streq(p[1], &quot;ADAPTER_=
DOMAIN_SUFFIX&quot;)) &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>   =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (!validate_domain(p[2]))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                msg(msglevel, &quot;--dhcp-option %s contains invalid cha=
racters&quot;, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                goto err;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>             dhcp-&gt;domain =3D p[2];</span><br><span> =
            dhcp_optional =3D true;</span><br><span>         }</span><br><s=
pan>         else if (streq(p[1], &quot;DOMAIN-SEARCH&quot;) &amp;&amp; p[2=
] &amp;&amp; !p[3])</span><br><span>         {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (!validate_domain(p[2]))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quo=
t;--dhcp-option %s contains invalid characters&quot;, p[1]);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                goto err;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             if (=
dhcp-&gt;domain_search_list_len &lt; N_SEARCH_LIST_LEN)</span><br><span>   =
          {</span><br><span>                 dhcp-&gt;domain_search_list[dh=
cp-&gt;domain_search_list_len++] =3D p[2];</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1213?us=
p=3Demail">change 1213</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1213?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09209ccd785cc368b2fcf467a3d=
211fbd41005c6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1213 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--AtSWgl9v3ko=--

