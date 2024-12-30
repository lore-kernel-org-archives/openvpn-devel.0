From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 30 Dec 2024 21:44:37 +0000
In-Reply-To: <gerrit.1732212459000.Iea4538cee075d50de836d1ef7652985186b2527c@...2715...>
References: <gerrit.1732212459000.Iea4538cee075d50de836d1ef7652985186b2527c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <3bc7a19bb1946c9581fd0006f9605b56235ba77a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9jZe7ULUTn8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco-win: enable mode
 server on supported configuration
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9jZe7ULUTn8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/812?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dco-win: enable mode server on supported configuration
......................................................................

dco-win: enable mode server on supported configuration

Enable dco-win with mode server if driver supports it.

Disable for proto TCP or older drivers.

Change-Id: Iea4538cee075d50de836d1ef7652985186b2527c
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241230193204.9897-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
317.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
3 files changed, 27 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/812/7

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 8f2adb5..b5a2136 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -43,6 +43,10 @@
 #include "tun.h"
 #include "tun_afunix.h"

+#if defined(_WIN32)
+#include "dco_win.h"
+#endif
+
 #ifdef HAVE_LIBCAPNG
 #include <cap-ng.h>
 #endif
@@ -235,7 +239,7 @@
 }

 static bool
-dco_check_option_ce(const struct connection_entry *ce, int msglevel)
+dco_check_option_ce(const struct connection_entry *ce, int msglevel, int m=
ode)
 {
     if (ce->fragment)
     {
@@ -264,9 +268,15 @@
 #endif

 #if defined(_WIN32)
-    if (!ce->remote)
+    if (!proto_is_udp(ce->proto) && mode =3D=3D MODE_SERVER)
     {
-        msg(msglevel, "NOTE: --remote is not defined, disabling data chann=
el offload.");
+        msg(msglevel, "NOTE: TCP transport disables data channel offload o=
n Windows in server mode.");
+        return false;
+    }
+
+    if (!ce->remote && !dco_win_supports_multipeer())
+    {
+        msg(msglevel, "NOTE: --remote is not defined. This DCO version doe=
sn't support multipeer. Disabling Data Channel Offload");
         return false;
     }
 #endif
@@ -316,7 +326,7 @@
         const struct connection_list *l =3D o->connection_list;
         for (int i =3D 0; i < l->len; ++i)
         {
-            if (!dco_check_option_ce(l->array[i], msglevel))
+            if (!dco_check_option_ce(l->array[i], msglevel, o->mode))
             {
                 return false;
             }
@@ -324,16 +334,16 @@
     }
     else
     {
-        if (!dco_check_option_ce(&o->ce, msglevel))
+        if (!dco_check_option_ce(&o->ce, msglevel, o->mode))
         {
             return false;
         }
     }

 #if defined(_WIN32)
-    if (o->mode =3D=3D MODE_SERVER)
+    if ((o->mode =3D=3D MODE_SERVER) && !dco_win_supports_multipeer())
     {
-        msg(msglevel, "--mode server is set. Disabling Data Channel Offloa=
d");
+        msg(msglevel, "--mode server is set. This DCO version doesn't supp=
ort multipeer. Disabling Data Channel Offload");
         return false;
     }

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index f59bf8c..46b2d03 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -523,4 +523,11 @@
     }
 }

+bool
+dco_win_supports_multipeer(void)
+{
+    OVPN_VERSION ver =3D { 0 };
+    return dco_get_version(&ver) && ver.Major >=3D 2;
+}
+
 #endif /* defined(_WIN32) */
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 4883629..7688516 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -48,6 +48,9 @@
 void
 dco_start_tun(struct tuntap *tt);

+bool
+dco_win_supports_multipeer(void);
+
 #else /* if defined(ENABLE_DCO) && defined(_WIN32) */

 static inline void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/812?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iea4538cee075d50de836d1ef7652985186b2527c
Gerrit-Change-Number: 812
Gerrit-PatchSet: 7
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--9jZe7ULUTn8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #7</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/812?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco-win: enable mode server on supported configurati=
on<br><br>Enable dco-win with mode server if driver supports it.<br><br>Dis=
able for proto TCP or older drivers.<br><br>Change-Id: Iea4538cee075d50de83=
6d1ef7652985186b2527c<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<=
br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;202412=
30193204.9897-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/op=
envpn-devel@lists.sourceforge.net/msg30317.html<br>Signed-off-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco.c<br>M src/openvpn/=
dco_win.c<br>M src/openvpn/dco_win.h<br>3 files changed, 27 insertions(+), =
7 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/12/812/7</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.c b/src/openvpn/dc=
o.c</span><br><span>index 8f2adb5..b5a2136 100644</span><br><span>--- a/src=
/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -=
43,6 +43,10 @@</span><br><span> #include &quot;tun.h&quot;</span><br><span>=
 #include &quot;tun_afunix.h&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;dco_win.h&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef HAVE_LIBCAPNG</s=
pan><br><span> #include &lt;cap-ng.h&gt;</span><br><span> #endif</span><br>=
<span>@@ -235,7 +239,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_c=
heck_option_ce(const struct connection_entry *ce, int msglevel)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+dco_check_option_ce(const struc=
t connection_entry *ce, int msglevel, int mode)</span><br><span> {</span><b=
r><span>     if (ce-&gt;fragment)</span><br><span>     {</span><br><span>@@=
 -264,9 +268,15 @@</span><br><span> #endif</span><br><span> </span><br><spa=
n> #if defined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (!ce-&gt;remote)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!proto_is_udp(ce-&gt;proto) &amp;&amp; mode =3D=3D MODE_SERVER=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(msglevel, &quot;NOTE: --remote is not defined, disabling dat=
a channel offload.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(msglevel, &quot;NOTE: TCP transport disables data channe=
l offload on Windows in server mode.&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!ce-&gt;remote &amp;&amp; !dco_win_supports_multipeer())</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;NOTE: --remote is not =
defined. This DCO version doesn&#39;t support multipeer. Disabling Data Cha=
nnel Offload&quot;);</span><br><span>         return false;</span><br><span=
>     }</span><br><span> #endif</span><br><span>@@ -316,7 +326,7 @@</span><=
br><span>         const struct connection_list *l =3D o-&gt;connection_list=
;</span><br><span>         for (int i =3D 0; i &lt; l-&gt;len; ++i)</span><=
br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          if (!dco_check_option_ce(l-&gt;array[i], msglevel))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (!dco_check_option=
_ce(l-&gt;array[i], msglevel, o-&gt;mode))</span><br><span>             {</=
span><br><span>                 return false;</span><br><span>             =
}</span><br><span>@@ -324,16 +334,16 @@</span><br><span>     }</span><br><s=
pan>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (!dco_check_option_ce(&amp;o-&gt;ce, msglevel))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!dco_chec=
k_option_ce(&amp;o-&gt;ce, msglevel, o-&gt;mode))</span><br><span>         =
{</span><br><span>             return false;</span><br><span>         }</sp=
an><br><span>     }</span><br><span> </span><br><span> #if defined(_WIN32)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;mode =3D=
=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if ((o-&gt;mode =3D=3D MODE_SERVER) &amp;&amp; !dco_win_supports_multipeer=
())</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        msg(msglevel, &quot;--mode server is set. Disabling Data Chann=
el Offload&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(msglevel, &quot;--mode server is set. This DCO version doesn&#39=
;t support multipeer. Disabling Data Channel Offload&quot;);</span><br><spa=
n>         return false;</span><br><span>     }</span><br><span> </span><br=
><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br=
><span>index f59bf8c..46b2d03 100644</span><br><span>--- a/src/openvpn/dco_=
win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -523,4=
 +523,11 @@</span><br><span>     }</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+dco_win_supports_multipeer(void)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_VERSION ver =3D { 0 };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return dco_get_version(&a=
mp;ver) &amp;&amp; ver.Major &gt;=3D 2;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> #endif /* defined(_WIN32) */</span><br><span>diff --git=
 a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h</span><br><span>index 4883=
629..7688516 100644</span><br><span>--- a/src/openvpn/dco_win.h</span><br><=
span>+++ b/src/openvpn/dco_win.h</span><br><span>@@ -48,6 +48,9 @@</span><b=
r><span> void</span><br><span> dco_start_tun(struct tuntap *tt);</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+dco_win_supports_multipeer(=
void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> #else /* if defined(ENABLE_DCO) &amp;&amp; defined(_WIN32) */</span><b=
r><span> </span><br><span> static inline void</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/812?=
usp=3Demail">change 812</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/812?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iea4538cee075d50de836d1ef765=
2985186b2527c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 812 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--9jZe7ULUTn8=--

