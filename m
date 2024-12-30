From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 30 Dec 2024 09:53:24 +0000
In-Reply-To: <gerrit.1732212459000.Iea4538cee075d50de836d1ef7652985186b2527c@...2715...>
References: <gerrit.1732212459000.Iea4538cee075d50de836d1ef7652985186b2527c@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <9a017e49fb8b92b01a81e818979a96710a0310a6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1xta2cLayL0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1xta2cLayL0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/812?usp=3Demail

to look at the new patch set (#6).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: dco-win: enable mode server on supported configuration
......................................................................

dco-win: enable mode server on supported configuration

Enable dco-win with mode server if driver supports it.

Disable for proto TCP or older drivers.

Change-Id: Iea4538cee075d50de836d1ef7652985186b2527c
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco.c
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
3 files changed, 27 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/812/6

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index dcc80d3..512da25 100644
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
Gerrit-PatchSet: 6
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--1xta2cLayL0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos, s=
tipa. </p>
<p>stipa <strong>uploaded patch set #6</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/812?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco-win: enable mode server on supported configurati=
on<br><br>Enable dco-win with mode server if driver supports it.<br><br>Dis=
able for proto TCP or older drivers.<br><br>Change-Id: Iea4538cee075d50de83=
6d1ef7652985186b2527c<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<=
br>---<br>M src/openvpn/dco.c<br>M src/openvpn/dco_win.c<br>M src/openvpn/d=
co_win.h<br>3 files changed, 27 insertions(+), 7 deletions(-)<br><br></pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/812/6</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index dc=
c80d3..512da25 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><sp=
an>+++ b/src/openvpn/dco.c</span><br><span>@@ -43,6 +43,10 @@</span><br><sp=
an> #include &quot;tun.h&quot;</span><br><span> #include &quot;tun_afunix.h=
&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;dco_win.h&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> #ifdef HAVE_LIBCAPNG</span><br><span> #include &lt;cap=
-ng.h&gt;</span><br><span> #endif</span><br><span>@@ -235,7 +239,7 @@</span=
><br><span> }</span><br><span> </span><br><span> static bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-dco_check_option_ce(const struct con=
nection_entry *ce, int msglevel)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+dco_check_option_ce(const struct connection_entry *ce, int msg=
level, int mode)</span><br><span> {</span><br><span>     if (ce-&gt;fragmen=
t)</span><br><span>     {</span><br><span>@@ -264,9 +268,15 @@</span><br><s=
pan> #endif</span><br><span> </span><br><span> #if defined(_WIN32)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (!ce-&gt;remote)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!proto_is_udp(ce-&=
gt;proto) &amp;&amp; mode =3D=3D MODE_SERVER)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;=
NOTE: --remote is not defined, disabling data channel offload.&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &q=
uot;NOTE: TCP transport disables data channel offload on Windows in server =
mode.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!ce-&gt;remote &amp;&amp; !dc=
o_win_supports_multipeer())</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(msglevel, &quot;NOTE: --remote is not defined. This DCO version doesn=
&#39;t support multipeer. Disabling Data Channel Offload&quot;);</span><br>=
<span>         return false;</span><br><span>     }</span><br><span> #endif=
</span><br><span>@@ -316,7 +326,7 @@</span><br><span>         const struct =
connection_list *l =3D o-&gt;connection_list;</span><br><span>         for =
(int i =3D 0; i &lt; l-&gt;len; ++i)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            if (!dco_check_option=
_ce(l-&gt;array[i], msglevel))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (!dco_check_option_ce(l-&gt;array[i], msglevel, o=
-&gt;mode))</span><br><span>             {</span><br><span>                =
 return false;</span><br><span>             }</span><br><span>@@ -324,16 +3=
34,16 @@</span><br><span>     }</span><br><span>     else</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!dco=
_check_option_ce(&amp;o-&gt;ce, msglevel))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!dco_check_option_ce(&amp;o-&gt;ce, msgl=
evel, o-&gt;mode))</span><br><span>         {</span><br><span>             =
return false;</span><br><span>         }</span><br><span>     }</span><br><=
span> </span><br><span> #if defined(_WIN32)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (o-&gt;mode =3D=3D MODE_SERVER)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if ((o-&gt;mode =3D=3D MODE_SE=
RVER) &amp;&amp; !dco_win_supports_multipeer())</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quo=
t;--mode server is set. Disabling Data Channel Offload&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;--mo=
de server is set. This DCO version doesn&#39;t support multipeer. Disabling=
 Data Channel Offload&quot;);</span><br><span>         return false;</span>=
<br><span>     }</span><br><span> </span><br><span>diff --git a/src/openvpn=
/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index f59bf8c..46b2d03 1=
00644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src=
/openvpn/dco_win.c</span><br><span>@@ -523,4 +523,11 @@</span><br><span>   =
  }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+dco_win_supports_multipeer(void)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    OVPN_VERSION ver =3D { 0 };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return dco_get_version(&amp;ver) &amp;&amp; ver.Major &gt;=
=3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* def=
ined(_WIN32) */</span><br><span>diff --git a/src/openvpn/dco_win.h b/src/op=
envpn/dco_win.h</span><br><span>index 4883629..7688516 100644</span><br><sp=
an>--- a/src/openvpn/dco_win.h</span><br><span>+++ b/src/openvpn/dco_win.h<=
/span><br><span>@@ -48,6 +48,9 @@</span><br><span> void</span><br><span> dc=
o_start_tun(struct tuntap *tt);</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+dco_win_supports_multipeer(void);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> #else /* if defined(ENABLE_D=
CO) &amp;&amp; defined(_WIN32) */</span><br><span> </span><br><span> static=
 inline void</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/812?usp=3Demail">change 812</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/812?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iea4538cee075d50de836d1ef765=
2985186b2527c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 812 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--1xta2cLayL0=--

