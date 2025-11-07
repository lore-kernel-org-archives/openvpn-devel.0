From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 7 Nov 2025 12:11:48 +0000
References: <gerrit.1762517501000.Id9158f477404aac1d6b08b08e672980e5a58dc35@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1cdc7c6d199846dedc408fc4735749e665fbbfb5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OeZZmYsZZ84="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OeZZmYsZZ84=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1356?usp=3Demail

to review the following change.


Change subject: forward: Change context_reschedule_sec sec argument to time=
_t
......................................................................

forward: Change context_reschedule_sec sec argument to time_t

This avoids conversions at the caller sites. Since we only
replace tv_sec if the new value is smaller the cast
to tv_sec_t is also safe.

Change-Id: Id9158f477404aac1d6b08b08e672980e5a58dc35
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/forward.c
1 file changed, 8 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/1356/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index cffb310..fbef539 100644
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
@@ -822,11 +823,6 @@
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
@@ -1297,6 +1293,11 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id9158f477404aac1d6b08b08e672980e5a58dc35
Gerrit-Change-Number: 1356
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--OeZZmYsZZ84=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1356?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">forward: Change context_reschedule_sec sec =
argument to time_t<br><br>This avoids conversions at the caller sites. Sinc=
e we only<br>replace tv_sec if the new value is smaller the cast<br>to tv_s=
ec_t is also safe.<br><br>Change-Id: Id9158f477404aac1d6b08b08e672980e5a58d=
c35<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>=
M src/openvpn/forward.c<br>1 file changed, 8 insertions(+), 7 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/56/1356/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/ope=
nvpn/forward.c</span><br><span>index cffb310..fbef539 100644</span><br><spa=
n>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</=
span><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &quot;mss.h&quot=
;</span><br><span> #include &quot;event.h&quot;</span><br><span> #include &=
quot;occ.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;otime.h&quot;</span><br><span> #include &quot;ping.h&quot;</spa=
n><br><span> #include &quot;ps.h&quot;</span><br><span> #include &quot;dhcp=
.h&quot;</span><br><span>@@ -127,7 +128,7 @@</span><br><span> }</span><br><=
span> </span><br><span> static inline void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-context_reschedule_sec(struct context *c, int sec)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+context_reschedule_sec(=
struct context *c, time_t sec)</span><br><span> {</span><br><span>     if (=
sec &lt; 0)</span><br><span>     {</span><br><span>@@ -135,7 +136,7 @@</spa=
n><br><span>     }</span><br><span>     if (sec &lt; c-&gt;c2.timeval.tv_se=
c)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        c-&gt;c2.timeval.tv_sec =3D sec;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        c-&gt;c2.timeval.tv_sec =3D (tv_sec_t)sec;=
</span><br><span>         c-&gt;c2.timeval.tv_usec =3D 0;</span><br><span> =
    }</span><br><span> }</span><br><span>@@ -822,11 +823,6 @@</span><br><sp=
an> #endif /* ENABLE_MANAGEMENT */</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> check_=
coarse_timers(struct context *c)</span><br><span> {</span><br><span>@@ -129=
7,6 +1293,11 @@</span><br><span> #endif /* if defined(ENABLE_DCO) &amp;&amp=
; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD)) */</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconver=
sion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</=
span><br><span>  * Output: c-&gt;c2.buf</span><br><span>  */</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1356?usp=3Demail">change 1356</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1356?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id9158f477404aac1d6b08b08e67=
2980e5a58dc35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1356 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--OeZZmYsZZ84=--

