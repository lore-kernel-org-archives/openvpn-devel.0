From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 25 Jul 2025 13:15:21 +0000
References: <gerrit.1753449319000.Ic0035d52e0ea123398318870d2f4d21af927a602@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4365f7d00e085c8673f7f7f4e9ce98c669e7bac7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Rp3LM7nb1dQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: management: resync
 timer on bytecount interval change
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

--Rp3LM7nb1dQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1113?usp=3Demail

to review the following change.


Change subject: management: resync timer on bytecount interval change
......................................................................

management: resync timer on bytecount interval change

coarse_timer_wakeup tracks when the next timer-driven task will occur.
When a user issues `bytecount n` on the management interface but the
existing wakeup is more than n seconds ahead, bandwidth logging won=E2=80=
=99t
run until that original timer fires, delaying logs.

Introduce a flag to detect when the bytecount interval changes and,
when set, recalculate coarse_timer_wakeup so logging fires exactly
n seconds after the command. This guarantees bytecount adheres to the
user-specified interval.

Change-Id: Ic0035d52e0ea123398318870d2f4d21af927a602
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/manage.c
M src/openvpn/manage.h
3 files changed, 15 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/1113/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index a4f260a..192fff4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -838,6 +838,19 @@
 static void
 check_coarse_timers(struct context *c)
 {
+#ifdef ENABLE_MANAGEMENT
+    /* The 'bytecount' command starts a timer at runtime, but it would not=
 be
+     * processed if coarse_timer_wakeup was previously set to a higher val=
ue.
+     * Therefore, if the command has arrived, we reset coarse_timer_wakeup=
 in
+     * to order to update it accordingly.
+     */
+    if (management && management->connection.bytecount_interval_changed)
+    {
+        reset_coarse_timers(c);
+        management->connection.bytecount_interval_changed =3D false;
+    }
+#endif /* ENABLE_MANAGEMENT */
+
     if (now < c->c2.coarse_timer_wakeup)
     {
         context_reschedule_sec(c, c->c2.coarse_timer_wakeup - now);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 8836e79..0df78ee 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -503,6 +503,7 @@
         man->connection.bytecount_update_seconds =3D 0;
         event_timeout_clear(&man->connection.bytecount_update_interval);
     }
+    man->connection.bytecount_interval_changed =3D true;
     msg(M_CLIENT, "SUCCESS: bytecount interval changed");
 }

diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index eb19a4e..00e3931 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -318,6 +318,7 @@
     bool state_realtime;
     bool log_realtime;
     bool echo_realtime;
+    bool bytecount_interval_changed;
     int bytecount_update_seconds;
     struct event_timeout bytecount_update_interval;


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1113?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic0035d52e0ea123398318870d2f4d21af927a602
Gerrit-Change-Number: 1113
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--Rp3LM7nb1dQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1113?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">management: resync timer on bytecount interval change<br><br=
>coarse_timer_wakeup tracks when the next timer-driven task will occur.<br>=
When a user issues `bytecount n` on the management interface but the<br>exi=
sting wakeup is more than n seconds ahead, bandwidth logging won=E2=80=99t<=
br>run until that original timer fires, delaying logs.<br><br>Introduce a f=
lag to detect when the bytecount interval changes and,<br>when set, recalcu=
late coarse_timer_wakeup so logging fires exactly<br>n seconds after the co=
mmand. This guarantees bytecount adheres to the<br>user-specified interval.=
<br><br>Change-Id: Ic0035d52e0ea123398318870d2f4d21af927a602<br>Signed-off-=
by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M src/openvpn/forward.c<br>=
M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>3 files changed, 15 ins=
ertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/13/1113/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c=
 b/src/openvpn/forward.c</span><br><span>index a4f260a..192fff4 100644</spa=
n><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/f=
orward.c</span><br><span>@@ -838,6 +838,19 @@</span><br><span> static void<=
/span><br><span> check_coarse_timers(struct context *c)</span><br><span> {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGE=
MENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The &#39=
;bytecount&#39; command starts a timer at runtime, but it would not be</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * processed if coar=
se_timer_wakeup was previously set to a higher value.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * Therefore, if the command has arri=
ved, we reset coarse_timer_wakeup in</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * to order to update it accordingly.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (management &amp;&amp; management-&gt;con=
nection.bytecount_interval_changed)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        reset_coarse_timers(c);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        management-&gt;connection.bytecount_interval_changed =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_MANAGE=
MENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     if (now &lt; c-&gt;c2.coarse_timer_wakeup)</span><br><span>     {=
</span><br><span>         context_reschedule_sec(c, c-&gt;c2.coarse_timer_w=
akeup - now);</span><br><span>diff --git a/src/openvpn/manage.c b/src/openv=
pn/manage.c</span><br><span>index 8836e79..0df78ee 100644</span><br><span>-=
-- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span>=
<br><span>@@ -503,6 +503,7 @@</span><br><span>         man-&gt;connection.b=
ytecount_update_seconds =3D 0;</span><br><span>         event_timeout_clear=
(&amp;man-&gt;connection.bytecount_update_interval);</span><br><span>     }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    man-&gt;connect=
ion.bytecount_interval_changed =3D true;</span><br><span>     msg(M_CLIENT,=
 &quot;SUCCESS: bytecount interval changed&quot;);</span><br><span> }</span=
><br><span> </span><br><span>diff --git a/src/openvpn/manage.h b/src/openvp=
n/manage.h</span><br><span>index eb19a4e..00e3931 100644</span><br><span>--=
- a/src/openvpn/manage.h</span><br><span>+++ b/src/openvpn/manage.h</span><=
br><span>@@ -318,6 +318,7 @@</span><br><span>     bool state_realtime;</spa=
n><br><span>     bool log_realtime;</span><br><span>     bool echo_realtime=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool bytecount=
_interval_changed;</span><br><span>     int bytecount_update_seconds;</span=
><br><span>     struct event_timeout bytecount_update_interval;</span><br><=
span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1113?usp=3Demail">change 1113</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1113?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic0035d52e0ea123398318870d2f=
4d21af927a602 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1113 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
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


--Rp3LM7nb1dQ=--

