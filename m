From: "reynir (Code Review)" <gerrit@...515...>
Date: Wed, 24 Apr 2024 10:40:15 +0000
In-Reply-To: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
References: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
Reply-To: reynir@...2756..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <977829409664bfc1e4ea8530361dc17a1eb0ec48-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iPCBDlW2Jbw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--iPCBDlW2Jbw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, reynir.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by reynir


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

Change-Id: I9457f005f4ba970502e6b667d9dc4299a588d661
Signed-off-by: Reynir Bj=C3=B6rnsson <reynir@...2756...>
---
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/push.c
3 files changed, 16 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/555/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8d10f25..937fae4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -514,17 +514,23 @@
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
+    if (event_timeout_defined(&c->c2.scheduled_exit)) {
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
index 1b406b9..db1fd2e 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -191,6 +191,7 @@
 receive_exit_message(struct context *c)
 {
     dmsg(D_STREAM_ERRORS, "CC-EEN exit message received by peer");
+    bool notify_management =3D true;
     /* With control channel exit notification, we want to give the session
      * enough time to handle retransmits and acknowledgment, so that event=
ual
      * retries from the client to resend the exit or ACKs will not trigger
@@ -204,14 +205,14 @@
      * */
     if (c->options.mode =3D=3D MODE_SERVER)
     {
-        schedule_exit(c, c->options.scheduled_exit_interval, SIGTERM);
+        notify_management =3D schedule_exit(c);
     }
     else
     {
         register_signal(c->sig, SIGUSR1, "remote-exit");
     }
 #ifdef ENABLE_MANAGEMENT
-    if (management)
+    if (management && notify_management)
     {
         management_notify(management, "info", "remote-exit", "EXIT");
     }
@@ -391,7 +392,7 @@
 void
 send_auth_failed(struct context *c, const char *client_reason)
 {
-    if (event_timeout_defined(&c->c2.scheduled_exit))
+    if (!schedule_exit(c))
     {
         msg(D_TLS_DEBUG, "exit already scheduled for context");
         return;
@@ -401,8 +402,6 @@
     static const char auth_failed[] =3D "AUTH_FAILED";
     size_t len;

-    schedule_exit(c, c->options.scheduled_exit_interval, SIGTERM);
-
     len =3D (client_reason ? strlen(client_reason)+1 : 0) + sizeof(auth_fa=
iled);
     if (len > PUSH_BUNDLE_SIZE)
     {
@@ -492,7 +491,7 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: reynir <reynir@...2756...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: reynir <reynir@...2756...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: reynir <reynir@...2756...>
Gerrit-MessageType: newpatchset

--iPCBDlW2Jbw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, reynir. </p>
<p>reynir <strong>uploaded patch set #2</strong> to this change.</p><p><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by reynir</p><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Only schedule_exit() once<br><br>If an exit has alr=
eady been scheduled we should not schedule it again.<br>Otherwise, the exit=
 signal is never emitted if the peer reschedules the<br>exit before the tim=
eout occurs.<br><br>schedule_exit() now only takes the context as argument.=
 The signal is<br>hard coded to SIGTERM, and the interval is read directly =
from the<br>context options.<br><br>Furthermore, schedule_exit() now return=
s a bool signifying whether an<br>exit was scheduled; false if exit is alre=
ady scheduled. The call sites<br>are updated accordingly. A notable differe=
nce is that management is only<br>notified *once* when an exit is scheduled=
 - we no longer notify<br>management on redundant exit.<br><br>Change-Id: I=
9457f005f4ba970502e6b667d9dc4299a588d661<br>Signed-off-by: Reynir Bj=C3=B6r=
nsson &lt;reynir@...2756...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/=
openvpn/forward.h<br>M src/openvpn/push.c<br>3 files changed, 16 insertions=
(+), 11 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/55/555/2</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/=
openvpn/forward.c</span><br><span>index 8d10f25..937fae4 100644</span><br><=
span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.=
c</span><br><span>@@ -514,17 +514,23 @@</span><br><span> }</span><br><span>=
 </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * Schedule a signal n_seconds from now.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Schedule a SIGTERM signal c-&gt;options.scheduled_e=
xit_interval seconds from now.</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-schedule_exit(struct context *c, const int n_seconds, const =
int signal)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_exit(struct co=
ntext *c)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const int n_seconds =3D c-&gt;options.scheduled_exit_interval;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* don&#39;t re=
schedule if already scheduled. */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (event_timeout_defined(&amp;c-&gt;c2.scheduled_exit)) =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span>     tls_set_single_session(c-&gt;c2.tls_multi);</span><br><span>    =
 update_time();</span><br><span>     reset_coarse_timers(c);</span><br><spa=
n>     event_timeout_init(&amp;c-&gt;c2.scheduled_exit, n_seconds, now);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2.scheduled_e=
xit_signal =3D signal;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    c-&gt;c2.scheduled_exit_signal =3D SIGTERM;</span><br><span>     msg=
(D_SCHED_EXIT, &quot;Delayed exit in %d seconds&quot;, n_seconds);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><=
span> }</span><br><span> </span><br><span> /*</span><br><span>diff --git a/=
src/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>index 6fb5a18=
..422c591 100644</span><br><span>--- a/src/openvpn/forward.h</span><br><spa=
n>+++ b/src/openvpn/forward.h</span><br><span>@@ -303,7 +303,7 @@</span><br=
><span> </span><br><span> void process_ip_header(struct context *c, unsigne=
d int flags, struct buffer *buf);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void schedule_exit(struct context *c, const=
 int n_seconds, const int signal);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool schedule_exit(struct context *c);</span><br><span> </sp=
an><br><span> static inline struct link_socket_info *</span><br><span> get_=
link_socket_info(struct context *c)</span><br><span>diff --git a/src/openvp=
n/push.c b/src/openvpn/push.c</span><br><span>index 1b406b9..db1fd2e 100644=
</span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn=
/push.c</span><br><span>@@ -191,6 +191,7 @@</span><br><span> receive_exit_m=
essage(struct context *c)</span><br><span> {</span><br><span>     dmsg(D_ST=
REAM_ERRORS, &quot;CC-EEN exit message received by peer&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bool notify_management =3D =
true;</span><br><span>     /* With control channel exit notification, we wa=
nt to give the session</span><br><span>      * enough time to handle retran=
smits and acknowledgment, so that eventual</span><br><span>      * retries =
from the client to resend the exit or ACKs will not trigger</span><br><span=
>@@ -204,14 +205,14 @@</span><br><span>      * */</span><br><span>     if (=
c-&gt;options.mode =3D=3D MODE_SERVER)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        schedule_exit(c, c-&gt;opti=
ons.scheduled_exit_interval, SIGTERM);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        notify_management =3D schedule_exit(c);</span><b=
r><span>     }</span><br><span>     else</span><br><span>     {</span><br><=
span>         register_signal(c-&gt;sig, SIGUSR1, &quot;remote-exit&quot;);=
</span><br><span>     }</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (management)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (management &amp;&amp; n=
otify_management)</span><br><span>     {</span><br><span>         managemen=
t_notify(management, &quot;info&quot;, &quot;remote-exit&quot;, &quot;EXIT&=
quot;);</span><br><span>     }</span><br><span>@@ -391,7 +392,7 @@</span><b=
r><span> void</span><br><span> send_auth_failed(struct context *c, const ch=
ar *client_reason)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (event_timeout_defined(&amp;c-&gt;c2.scheduled_exit)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!schedule_=
exit(c))</span><br><span>     {</span><br><span>         msg(D_TLS_DEBUG, &=
quot;exit already scheduled for context&quot;);</span><br><span>         re=
turn;</span><br><span>@@ -401,8 +402,6 @@</span><br><span>     static const=
 char auth_failed[] =3D &quot;AUTH_FAILED&quot;;</span><br><span>     size_=
t len;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    schedule_exit(c, c-&gt;options.scheduled_exit_interval, SIGTERM);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     le=
n =3D (client_reason ? strlen(client_reason)+1 : 0) + sizeof(auth_failed);<=
/span><br><span>     if (len &gt; PUSH_BUNDLE_SIZE)</span><br><span>     {<=
/span><br><span>@@ -492,7 +491,7 @@</span><br><span> void</span><br><span> =
send_restart(struct context *c, const char *kill_msg)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    schedule_exit(c, c-&=
gt;options.scheduled_exit_interval, SIGTERM);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    schedule_exit(c);</span><br><span>     send_c=
ontrol_channel_string(c, kill_msg ? kill_msg : &quot;RESTART&quot;, D_PUSH)=
;</span><br><span> }</span><br><span> </span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/555?usp=3De=
mail">change 555</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9457f005f4ba970502e6b667d9d=
c4299a588d661 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 555 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: reynir &lt;reynir@...2756...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--iPCBDlW2Jbw=--

