From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 16 Nov 2025 18:03:11 +0000
In-Reply-To: <gerrit.1762517501000.Id9158f477404aac1d6b08b08e672980e5a58dc35@...2715...>
References: <gerrit.1762517501000.Id9158f477404aac1d6b08b08e672980e5a58dc35@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5a7d8e1e58472a200f2667c14ea7f5bfa4d8ef6f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fH16xGRr2tE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: forward: Change
 context_reschedule_sec sec argument to time_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fH16xGRr2tE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
56?usp=3Demail )

Change subject: forward: Change context_reschedule_sec sec argument to time=
_t
......................................................................

forward: Change context_reschedule_sec sec argument to time_t

This avoids conversions at the caller sites. Since we only
replace tv_sec if the new value is smaller the cast
to tv_sec_t is also safe.

Change-Id: Id9158f477404aac1d6b08b08e672980e5a58dc35
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1356
Message-Id: <20251111155139.31642-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
319.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
1 file changed, 8 insertions(+), 7 deletions(-)




diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 90e52d2..f01fb4c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -33,6 +33,7 @@
 #include "mss.h"
 #include "event.h"
 #include "occ.h"
+#include "otime.h"
 #include "ping.h"
 #include "ps.h"
 #include "dhcp.h"
@@ -127,7 +128,7 @@
 }

 static inline void
-context_reschedule_sec(struct context *c, int sec)
+context_reschedule_sec(struct context *c, time_t sec)
 {
     if (sec < 0)
     {
@@ -135,7 +136,7 @@
     }
     if (sec < c->c2.timeval.tv_sec)
     {
-        c->c2.timeval.tv_sec =3D sec;
+        c->c2.timeval.tv_sec =3D (tv_sec_t)sec;
         c->c2.timeval.tv_usec =3D 0;
     }
 }
@@ -829,11 +830,6 @@
 #endif /* ENABLE_MANAGEMENT */
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 check_coarse_timers(struct context *c)
 {
@@ -1304,6 +1300,11 @@
 #endif /* if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARG=
ET_FREEBSD)) */
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /*
  * Output: c->c2.buf
  */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1356?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id9158f477404aac1d6b08b08e672980e5a58dc35
Gerrit-Change-Number: 1356
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fH16xGRr2tE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1356?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">forward: Change context_reschedule_sec sec argum=
ent to time_t<br><br>This avoids conversions at the caller sites. Since we =
only<br>replace tv_sec if the new value is smaller the cast<br>to tv_sec_t =
is also safe.<br><br>Change-Id: Id9158f477404aac1d6b08b08e672980e5a58dc35<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Ar=
ne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.op=
envpn.net/c/openvpn/+/1356<br>Message-Id: &lt;20251111155139.31642-1-gert@...220...=
..1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1439...=
ceforge.net/msg34319.html<br>Signed-off-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>---<br>M src/openvpn/forward.c<br>1 file changed, 8 insertions(+),=
 7 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><sp=
an>index 90e52d2..f01fb4c 100644</span><br><span>--- a/src/openvpn/forward.=
c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -33,6 +33,=
7 @@</span><br><span> #include &quot;mss.h&quot;</span><br><span> #include =
&quot;event.h&quot;</span><br><span> #include &quot;occ.h&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;otime.h&quot;</s=
pan><br><span> #include &quot;ping.h&quot;</span><br><span> #include &quot;=
ps.h&quot;</span><br><span> #include &quot;dhcp.h&quot;</span><br><span>@@ =
-127,7 +128,7 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-context=
_reschedule_sec(struct context *c, int sec)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+context_reschedule_sec(struct context *c, time_t se=
c)</span><br><span> {</span><br><span>     if (sec &lt; 0)</span><br><span>=
     {</span><br><span>@@ -135,7 +136,7 @@</span><br><span>     }</span><br=
><span>     if (sec &lt; c-&gt;c2.timeval.tv_sec)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2.timeval=
.tv_sec =3D sec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     c-&gt;c2.timeval.tv_sec =3D (tv_sec_t)sec;</span><br><span>         c-=
&gt;c2.timeval.tv_usec =3D 0;</span><br><span>     }</span><br><span> }</sp=
an><br><span>@@ -829,11 +830,6 @@</span><br><span> #endif /* ENABLE_MANAGEM=
ENT */</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ig=
nored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> static void</span><br><span> check_coarse_timers(struct context=
 *c)</span><br><span> {</span><br><span>@@ -1304,6 +1300,11 @@</span><br><s=
pan> #endif /* if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || =
defined(TARGET_FREEBSD)) */</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Output: c=
-&gt;c2.buf</span><br><span>  */</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1356?usp=3Demail"=
>change 1356</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1356?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id9158f477404aac1d6b08b08e67=
2980e5a58dc35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1356 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--fH16xGRr2tE=--

