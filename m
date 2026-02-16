From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 13:54:47 +0000
References: <gerrit.1771250081000.Ibea20c0f2c3df9f1f6509d662ab2b5fb4ce5e18d@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d4adcc3510bf85bc7129e227f68b72370de2fe36-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NoUru1YBW84="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: management:
 resync timer on bytecount interval change
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

--NoUru1YBW84=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1531?usp=3Demail

to review the following change.


Change subject: management: resync timer on bytecount interval change
......................................................................

management: resync timer on bytecount interval change

coarse_timer_wakeup tracks when the next timer-driven task will occur.
If a user issues `bytecount n` via the management interface, but the
next scheduled wakeup is more than n seconds away, bandwidth logging
will be delayed until that timer fires.

To ensure timely logging, reset the timer whenever a new `bytecount`
command is received. This guarantees that logging begins exactly n
seconds after the command, matching the user-defined interval.

Change-Id: Ibea20c0f2c3df9f1f6509d662ab2b5fb4ce5e18d
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/manage.c
1 file changed, 23 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/1531/1

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0e4afa2..6efe2d1 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -42,6 +42,7 @@
 #include "manage.h"
 #include "openvpn.h"
 #include "dco.h"
+#include "multi.h"

 #include "memdbg.h"

@@ -485,6 +486,28 @@
         man->connection.bytecount_update_seconds =3D 0;
         event_timeout_clear(&man->connection.bytecount_update_interval);
     }
+
+    /* The newly received bytecount interval may be sooner than the existi=
ng
+     * coarse timer wakeup. Reset the timer to ensure it fires at the corr=
ect,
+     * earlier time.
+     */
+    if (man->persist.callback.arg)
+    {
+        struct context *c;
+
+        if (man->settings.flags & MF_SERVER)
+        {
+            struct multi_context *m =3D man->persist.callback.arg;
+            c =3D &m->top;
+        }
+        else
+        {
+            c =3D man->persist.callback.arg;
+        }
+
+        reset_coarse_timers(c);
+    }
+
     msg(M_CLIENT, "SUCCESS: bytecount interval changed");
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1531?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ibea20c0f2c3df9f1f6509d662ab2b5fb4ce5e18d
Gerrit-Change-Number: 1531
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--NoUru1YBW84=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ralf_lici would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1531?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">management: resync timer on bytecount inter=
val change<br><br>coarse_timer_wakeup tracks when the next timer-driven tas=
k will occur.<br>If a user issues `bytecount n` via the management interfac=
e, but the<br>next scheduled wakeup is more than n seconds away, bandwidth =
logging<br>will be delayed until that timer fires.<br><br>To ensure timely =
logging, reset the timer whenever a new `bytecount`<br>command is received.=
 This guarantees that logging begins exactly n<br>seconds after the command=
, matching the user-defined interval.<br><br>Change-Id: Ibea20c0f2c3df9f1f6=
509d662ab2b5fb4ce5e18d<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<=
br>---<br>M src/openvpn/manage.c<br>1 file changed, 23 insertions(+), 0 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/31/1531/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage.c =
b/src/openvpn/manage.c</span><br><span>index 0e4afa2..6efe2d1 100644</span>=
<br><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/mana=
ge.c</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;mana=
ge.h&quot;</span><br><span> #include &quot;openvpn.h&quot;</span><br><span>=
 #include &quot;dco.h&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;multi.h&quot;</span><br><span> </span><br><span> #in=
clude &quot;memdbg.h&quot;</span><br><span> </span><br><span>@@ -485,6 +486=
,28 @@</span><br><span>         man-&gt;connection.bytecount_update_seconds=
 =3D 0;</span><br><span>         event_timeout_clear(&amp;man-&gt;connectio=
n.bytecount_update_interval);</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* The newly received bytecount interval may be sooner t=
han the existing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * coarse timer wakeup. Reset the timer to ensure it fires at the correct,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * earlier time=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (man-&gt;persist.callba=
ck.arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct context *c;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt;settings.flags &am=
p; MF_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            stru=
ct multi_context *m =3D man-&gt;persist.callback.arg;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            c =3D &amp;m-&gt;top;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            c =3D man-&gt;persist.callback.arg;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        reset_coarse_timers(c);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     msg(M_CLIENT, &quot;SUCCESS: byte=
count interval changed&quot;);</span><br><span> }</span><br><span> </span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1531?usp=3Demail">change 1531</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1531?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibea20c0f2c3df9f1f6509d662ab=
2b5fb4ce5e18d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1531 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--NoUru1YBW84=--

