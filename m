From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 3 Nov 2023 17:18:11 +0000
References: <gerrit.1699031887000.I199f83e2db5fc7c48a0ac9280cdbf9fa45f42300@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b2d901499ea1824b28165c8a3122d2becd6f971b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HQz8N6JPS9A="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: allow to
 disable NTLM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HQz8N6JPS9A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/378?usp=3Demail

to review the following change.


Change subject: configure: allow to disable NTLM
......................................................................

configure: allow to disable NTLM

Since we want to get rid of it, might be useful to
allow users to remove the support completely.

Change-Id: I199f83e2db5fc7c48a0ac9280cdbf9fa45f42300
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M config.h.cmake.in
M configure.ac
M src/openvpn/options.c
M src/openvpn/proxy.c
M src/openvpn/syshead.h
5 files changed, 17 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/378/1

diff --git a/config.h.cmake.in b/config.h.cmake.in
index f2cdd39..6334d56 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -35,6 +35,9 @@
 /* Enable LZO compression library */
 #cmakedefine ENABLE_LZO

+/* Enable NTLMv2 proxy support */
+#define ENABLE_NTLM 1
+
 /* Enable management server capability */
 #define ENABLE_MANAGEMENT 1

diff --git a/configure.ac b/configure.ac
index 7e5763d..56fcb4b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -109,6 +109,13 @@
 )

 AC_ARG_ENABLE(
+	[ntlm],
+	[AS_HELP_STRING([--disable-ntlm], [disable NTLMv2 proxy support @<:@defau=
lt=3Dyes@:>@])],
+	,
+	[enable_ntlm=3D"yes"]
+)
+
+AC_ARG_ENABLE(
 	[plugins],
 	[AS_HELP_STRING([--disable-plugins], [disable plug-in support @<:@default=
=3Dyes@:>@])],
 	,
@@ -1302,6 +1309,7 @@
 test "${enable_fragment}" =3D "yes" && AC_DEFINE([ENABLE_FRAGMENT], [1], [=
Enable internal fragmentation support])
 test "${enable_port_share}" =3D "yes" && AC_DEFINE([ENABLE_PORT_SHARE], [1=
], [Enable TCP Server port sharing])

+test "${enable_ntlm}" =3D "yes" && AC_DEFINE([ENABLE_NTLM], [1], [Enable N=
TLMv2 proxy support])
 test "${enable_crypto_ofb_cfb}" =3D "yes" && AC_DEFINE([ENABLE_OFB_CFB_MOD=
E], [1], [Enable OFB and CFB cipher modes])
 if test "${have_export_keying_material}" =3D "yes"; then
 	AC_DEFINE(
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d238269..fbf54ef 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6760,8 +6760,7 @@
         if (p[3])
         {
             /* auto -- try to figure out proxy addr, port, and type automa=
tically */
-            /* semiauto -- given proxy addr:port, try to figure out type a=
utomatically */
-            /* (auto|semiauto)-nct -- disable proxy auth cleartext protoco=
ls (i.e. basic auth) */
+            /* auto-nct -- disable proxy auth cleartext protocols (i.e. ba=
sic auth) */
             if (streq(p[3], "auto"))
             {
                 ho->auth_retry =3D PAR_ALL;
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 76e27cb..3b6f7df 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -638,8 +638,6 @@
 {
     struct gc_arena gc =3D gc_new();
     char buf[512];
-    char buf2[129];
-    char get[80];
     int status;
     int nparms;
     bool ret =3D false;
@@ -758,6 +756,7 @@
         {
 #if NTLM
             /* look for the phase 2 response */
+            char buf2[129];

             while (true)
             {
@@ -768,7 +767,8 @@
                 chomp(buf);
                 msg(D_PROXY, "HTTP proxy returned: '%s'", buf);
=20
-                openvpn_snprintf(get, sizeof get, "%%*s NTLM %%%ds", (int)=
 sizeof(buf2) - 1);
+                char get[80];
+                openvpn_snprintf(get, sizeof(get), "%%*s NTLM %%%zus", siz=
eof(buf2) - 1);
                 nparms =3D sscanf(buf, get, buf2);
                 buf2[128] =3D 0; /* we only need the beginning - ensure it=
's null terminated. */

diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 7181b94..a021c91 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -472,7 +472,9 @@
 /*
  * Should we include NTLM proxy functionality
  */
+#ifdef ENABLE_NTLM
 #define NTLM 1
+#endif

 /*
  * Should we include proxy digest auth functionality

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/378?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I199f83e2db5fc7c48a0ac9280cdbf9fa45f42300
Gerrit-Change-Number: 378
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--HQz8N6JPS9A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/378?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">configure: allow to disable NTLM<br><br>Since we want to get =
rid of it, might be useful to<br>allow users to remove the support complete=
ly.<br><br>Change-Id: I199f83e2db5fc7c48a0ac9280cdbf9fa45f42300<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M config.h.cmak=
e.in<br>M configure.ac<br>M src/openvpn/options.c<br>M src/openvpn/proxy.c<=
br>M src/openvpn/syshead.h<br>5 files changed, 17 insertions(+), 5 deletion=
s(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/78/378/1</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</span>=
<br><span>index f2cdd39..6334d56 100644</span><br><span>--- a/config.h.cmak=
e.in</span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -35,6 +35,9=
 @@</span><br><span> /* Enable LZO compression library */</span><br><span> =
#cmakedefine ENABLE_LZO</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Enable NTLMv2 proxy support */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define ENABLE_NTLM 1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Enable managemen=
t server capability */</span><br><span> #define ENABLE_MANAGEMENT 1</span><=
br><span> </span><br><span>diff --git a/configure.ac b/configure.ac</span><=
br><span>index 7e5763d..56fcb4b 100644</span><br><span>--- a/configure.ac</=
span><br><span>+++ b/configure.ac</span><br><span>@@ -109,6 +109,13 @@</spa=
n><br><span> )</span><br><span> </span><br><span> AC_ARG_ENABLE(</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	[ntlm],</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	[AS_HELP_STRING([--disable-ntlm], [disab=
le NTLMv2 proxy support @&lt;:@default=3Dyes@:&gt;@])],</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	[enable_ntlm=3D&quot;yes&quot;]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_=
ARG_ENABLE(</span><br><span> 	[plugins],</span><br><span> 	[AS_HELP_STRING(=
[--disable-plugins], [disable plug-in support @&lt;:@default=3Dyes@:&gt;@])=
],</span><br><span> 	,</span><br><span>@@ -1302,6 +1309,7 @@</span><br><spa=
n> test &quot;${enable_fragment}&quot; =3D &quot;yes&quot; &amp;&amp; AC_DE=
FINE([ENABLE_FRAGMENT], [1], [Enable internal fragmentation support])</span=
><br><span> test &quot;${enable_port_share}&quot; =3D &quot;yes&quot; &amp;=
&amp; AC_DEFINE([ENABLE_PORT_SHARE], [1], [Enable TCP Server port sharing])=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est &quot;${enable_ntlm}&quot; =3D &quot;yes&quot; &amp;&amp; AC_DEFINE([EN=
ABLE_NTLM], [1], [Enable NTLMv2 proxy support])</span><br><span> test &quot=
;${enable_crypto_ofb_cfb}&quot; =3D &quot;yes&quot; &amp;&amp; AC_DEFINE([E=
NABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])</span><br><spa=
n> if test &quot;${have_export_keying_material}&quot; =3D &quot;yes&quot;; =
then</span><br><span> 	AC_DEFINE(</span><br><span>diff --git a/src/openvpn/=
options.c b/src/openvpn/options.c</span><br><span>index d238269..fbf54ef 10=
0644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/=
openvpn/options.c</span><br><span>@@ -6760,8 +6760,7 @@</span><br><span>   =
      if (p[3])</span><br><span>         {</span><br><span>             /* =
auto -- try to figure out proxy addr, port, and type automatically */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* semiauto -- =
given proxy addr:port, try to figure out type automatically */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            /* (auto|semiauto)-nct=
 -- disable proxy auth cleartext protocols (i.e. basic auth) */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            /* auto-nct -- disa=
ble proxy auth cleartext protocols (i.e. basic auth) */</span><br><span>   =
          if (streq(p[3], &quot;auto&quot;))</span><br><span>             {=
</span><br><span>                 ho-&gt;auth_retry =3D PAR_ALL;</span><br>=
<span>diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><spa=
n>index 76e27cb..3b6f7df 100644</span><br><span>--- a/src/openvpn/proxy.c</=
span><br><span>+++ b/src/openvpn/proxy.c</span><br><span>@@ -638,8 +638,6 @=
@</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();<=
/span><br><span>     char buf[512];</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    char buf2[129];</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    char get[80];</span><br><span>     int status;</span><br><s=
pan>     int nparms;</span><br><span>     bool ret =3D false;</span><br><sp=
an>@@ -758,6 +756,7 @@</span><br><span>         {</span><br><span> #if NTLM=
</span><br><span>             /* look for the phase 2 response */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            char buf2[129];</=
span><br><span> </span><br><span>             while (true)</span><br><span>=
             {</span><br><span>@@ -768,7 +767,8 @@</span><br><span>        =
         chomp(buf);</span><br><span>                 msg(D_PROXY, &quot;HT=
TP proxy returned: &#39;%s&#39;&quot;, buf);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                openvpn_snprintf(g=
et, sizeof get, &quot;%%*s NTLM %%%ds&quot;, (int) sizeof(buf2) - 1);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                char get[=
80];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 openvpn_snprintf(get, sizeof(get), &quot;%%*s NTLM %%%zus&quot;, sizeof(bu=
f2) - 1);</span><br><span>                 nparms =3D sscanf(buf, get, buf2=
);</span><br><span>                 buf2[128] =3D 0; /* we only need the be=
ginning - ensure it&#39;s null terminated. */</span><br><span> </span><br><=
span>diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h</span><br><=
span>index 7181b94..a021c91 100644</span><br><span>--- a/src/openvpn/syshea=
d.h</span><br><span>+++ b/src/openvpn/syshead.h</span><br><span>@@ -472,7 +=
472,9 @@</span><br><span> /*</span><br><span>  * Should we include NTLM pro=
xy functionality</span><br><span>  */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifdef ENABLE_NTLM</span><br><span> #define NTLM 1</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </=
span><br><span> /*</span><br><span>  * Should we include proxy digest auth =
functionality</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/378?usp=3Demail">change 378</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/378?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I199f83e2db5fc7c48a0ac9280cd=
bf9fa45f42300 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 378 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--HQz8N6JPS9A=--

