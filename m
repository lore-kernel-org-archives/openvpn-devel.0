From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 17 May 2024 06:44:36 +0000
In-Reply-To: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
References: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., reynir@...2756...
Message-ID: <0943d9d0fe5b4f464c8eb475935da1c6cdd291a1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VMR2esAyzCA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Only schedule_exit()
 once
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: reynir <reynir@...2756...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VMR2esAyzCA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/55=
5?usp=3Demail )

Change subject: Only schedule_exit() once
......................................................................

Only schedule_exit() once

If an exit has already been scheduled we should not schedule it again.
Otherwise, the exit signal is never emitted if the peer reschedules the
exit before the timeout occurs.

schedule_exit() now only takes the context as argument. The signal is
hard coded to SIGTERM, and the interval is read directly from the
context options.

Furthermore, schedule_exit() now returns a bool signifying whether an
exit was scheduled; false if exit is already scheduled. The call sites
are updated accordingly. A notable difference is that management is only
notified *once* when an exit is scheduled - we no longer notify
management on redundant exit.

This patch was assigned a CVE number after already reviewed and ACKed,
because it was discovered that a misbehaving client can use the (now
fixed) server behaviour to avoid being disconnected by means of a
managment interface "client-kill" command - the security issue here is
"client can circumvent security policy set by management interface".

This only affects previously authenticated clients, and only management
client-kill, so normal renegotion / AUTH_FAIL ("your session ends") is not
affected.

CVE: 2024-28882

Change-Id: I9457f005f4ba970502e6b667d9dc4299a588d661
Signed-off-by: Reynir Bj=C3=B6rnsson <reynir@...2756...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240516120434.23499-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
679.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/push.c
3 files changed, 19 insertions(+), 10 deletions(-)




diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8d10f25..01165b2 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -514,17 +514,24 @@
 }

 /*
- * Schedule a signal n_seconds from now.
+ * Schedule a SIGTERM signal c->options.scheduled_exit_interval seconds fr=
om now.
  */
-void
-schedule_exit(struct context *c, const int n_seconds, const int signal)
+bool
+schedule_exit(struct context *c)
 {
+    const int n_seconds =3D c->options.scheduled_exit_interval;
+    /* don't reschedule if already scheduled. */
+    if (event_timeout_defined(&c->c2.scheduled_exit))
+    {
+        return false;
+    }
     tls_set_single_session(c->c2.tls_multi);
     update_time();
     reset_coarse_timers(c);
     event_timeout_init(&c->c2.scheduled_exit, n_seconds, now);
-    c->c2.scheduled_exit_signal =3D signal;
+    c->c2.scheduled_exit_signal =3D SIGTERM;
     msg(D_SCHED_EXIT, "Delayed exit in %d seconds", n_seconds);
+    return true;
 }

 /*
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 6fb5a18..422c591 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -303,7 +303,7 @@

 void process_ip_header(struct context *c, unsigned int flags, struct buffe=
r *buf);

-void schedule_exit(struct context *c, const int n_seconds, const int signa=
l);
+bool schedule_exit(struct context *c);

 static inline struct link_socket_info *
 get_link_socket_info(struct context *c)
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 1b406b9..d220eeb 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -204,7 +204,11 @@
      * */
     if (c->options.mode =3D=3D MODE_SERVER)
     {
-        schedule_exit(c, c->options.scheduled_exit_interval, SIGTERM);
+        if (!schedule_exit(c))
+        {
+            /* Return early when we don't need to notify management */
+            return;
+        }
     }
     else
     {
@@ -391,7 +395,7 @@
 void
 send_auth_failed(struct context *c, const char *client_reason)
 {
-    if (event_timeout_defined(&c->c2.scheduled_exit))
+    if (!schedule_exit(c))
     {
         msg(D_TLS_DEBUG, "exit already scheduled for context");
         return;
@@ -401,8 +405,6 @@
     static const char auth_failed[] =3D "AUTH_FAILED";
     size_t len;

-    schedule_exit(c, c->options.scheduled_exit_interval, SIGTERM);
-
     len =3D (client_reason ? strlen(client_reason)+1 : 0) + sizeof(auth_fa=
iled);
     if (len > PUSH_BUNDLE_SIZE)
     {
@@ -492,7 +494,7 @@
 void
 send_restart(struct context *c, const char *kill_msg)
 {
-    schedule_exit(c, c->options.scheduled_exit_interval, SIGTERM);
+    schedule_exit(c);
     send_control_channel_string(c, kill_msg ? kill_msg : "RESTART", D_PUSH=
);
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9457f005f4ba970502e6b667d9dc4299a588d661
Gerrit-Change-Number: 555
Gerrit-PatchSet: 4
Gerrit-Owner: reynir <reynir@...2756...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: reynir <reynir@...2756...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--VMR2esAyzCA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/555?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Only schedule_exit() once<br><br>If an exit ha=
s already been scheduled we should not schedule it again.<br>Otherwise, the=
 exit signal is never emitted if the peer reschedules the<br>exit before th=
e timeout occurs.<br><br>schedule_exit() now only takes the context as argu=
ment. The signal is<br>hard coded to SIGTERM, and the interval is read dire=
ctly from the<br>context options.<br><br>Furthermore, schedule_exit() now r=
eturns a bool signifying whether an<br>exit was scheduled; false if exit is=
 already scheduled. The call sites<br>are updated accordingly. A notable di=
fference is that management is only<br>notified *once* when an exit is sche=
duled - we no longer notify<br>management on redundant exit.<br><br>This pa=
tch was assigned a CVE number after already reviewed and ACKed,<br>because =
it was discovered that a misbehaving client can use the (now<br>fixed) serv=
er behaviour to avoid being disconnected by means of a<br>managment interfa=
ce &quot;client-kill&quot; command - the security issue here is<br>&quot;cl=
ient can circumvent security policy set by management interface&quot;.<br><=
br>This only affects previously authenticated clients, and only management<=
br>client-kill, so normal renegotion / AUTH_FAIL (&quot;your session ends&q=
uot;) is not<br>affected.<br><br>CVE: 2024-28882<br><br>Change-Id: I9457f00=
5f4ba970502e6b667d9dc4299a588d661<br>Signed-off-by: Reynir Bj=C3=B6rnsson &=
lt;reynir@...2756...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1830...=
...&gt;<br>Message-Id: &lt;20240516120434.23499-1-gert@...1296...&gt;<br>UR=
L: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg2867=
9.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M s=
rc/openvpn/forward.c<br>M src/openvpn/forward.h<br>M src/openvpn/push.c<br>=
3 files changed, 19 insertions(+), 10 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><sp=
an>index 8d10f25..01165b2 100644</span><br><span>--- a/src/openvpn/forward.=
c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -514,17 +5=
14,24 @@</span><br><span> }</span><br><span> </span><br><span> /*</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * Schedule a signal n_seconds =
from now.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Schedul=
e a SIGTERM signal c-&gt;options.scheduled_exit_interval seconds from now.<=
/span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_exit(stru=
ct context *c, const int n_seconds, const int signal)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+schedule_exit(struct context *c)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int n_seconds =
=3D c-&gt;options.scheduled_exit_interval;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* don&#39;t reschedule if already scheduled. */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (event_timeo=
ut_defined(&amp;c-&gt;c2.scheduled_exit))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span>     tls_set_single_session(c-&gt;c2.tls_mu=
lti);</span><br><span>     update_time();</span><br><span>     reset_coarse=
_timers(c);</span><br><span>     event_timeout_init(&amp;c-&gt;c2.scheduled=
_exit, n_seconds, now);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    c-&gt;c2.scheduled_exit_signal =3D signal;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    c-&gt;c2.scheduled_exit_signal =3D SIGTERM=
;</span><br><span>     msg(D_SCHED_EXIT, &quot;Delayed exit in %d seconds&q=
uot;, n_seconds);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return true;</span><br><span> }</span><br><span> </span><br><span> /*</sp=
an><br><span>diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h</sp=
an><br><span>index 6fb5a18..422c591 100644</span><br><span>--- a/src/openvp=
n/forward.h</span><br><span>+++ b/src/openvpn/forward.h</span><br><span>@@ =
-303,7 +303,7 @@</span><br><span> </span><br><span> void process_ip_header(=
struct context *c, unsigned int flags, struct buffer *buf);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void schedule_exit(=
struct context *c, const int n_seconds, const int signal);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool schedule_exit(struct context *c=
);</span><br><span> </span><br><span> static inline struct link_socket_info=
 *</span><br><span> get_link_socket_info(struct context *c)</span><br><span=
>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>index=
 1b406b9..d220eeb 100644</span><br><span>--- a/src/openvpn/push.c</span><br=
><span>+++ b/src/openvpn/push.c</span><br><span>@@ -204,7 +204,11 @@</span>=
<br><span>      * */</span><br><span>     if (c-&gt;options.mode =3D=3D MOD=
E_SERVER)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        schedule_exit(c, c-&gt;options.scheduled_exit_interval, =
SIGTERM);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (!schedule_exit(c))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   /* Return early when we don&#39;t need to notify management */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            return;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>   =
  }</span><br><span>     else</span><br><span>     {</span><br><span>@@ -39=
1,7 +395,7 @@</span><br><span> void</span><br><span> send_auth_failed(struc=
t context *c, const char *client_reason)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (event_timeout_defined(&amp;c-=
&gt;c2.scheduled_exit))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!schedule_exit(c))</span><br><span>     {</span><br><span>     =
    msg(D_TLS_DEBUG, &quot;exit already scheduled for context&quot;);</span=
><br><span>         return;</span><br><span>@@ -401,8 +405,6 @@</span><br><=
span>     static const char auth_failed[] =3D &quot;AUTH_FAILED&quot;;</spa=
n><br><span>     size_t len;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    schedule_exit(c, c-&gt;options.scheduled_exit_=
interval, SIGTERM);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span>     len =3D (client_reason ? strlen(client_reason)+1 : 0) +=
 sizeof(auth_failed);</span><br><span>     if (len &gt; PUSH_BUNDLE_SIZE)</=
span><br><span>     {</span><br><span>@@ -492,7 +494,7 @@</span><br><span> =
void</span><br><span> send_restart(struct context *c, const char *kill_msg)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  schedule_exit(c, c-&gt;options.scheduled_exit_interval, SIGTERM);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    schedule_exit(c);</span=
><br><span>     send_control_channel_string(c, kill_msg ? kill_msg : &quot;=
RESTART&quot;, D_PUSH);</span><br><span> }</span><br><span> </span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/555?usp=3Demail">change 555</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/555?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9457f005f4ba970502e6b667d9d=
c4299a588d661 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 555 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: reynir &lt;reynir@...2756...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: reynir &lt;reynir@...2756...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--VMR2esAyzCA=--

