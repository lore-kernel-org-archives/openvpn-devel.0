From: "reynir (Code Review)" <gerrit@...515...>
Date: Mon, 22 Apr 2024 19:08:25 +0000
References: <gerrit.1713812902000.I1cf589ecad82eecf167fe5cf28cda0fe4d42d42f@...2715...>
Reply-To: reynir@...2756..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <06e6119813c956c51c500ea004756c7fe47ebda4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l54QpwQccEA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Address
 schedule_exit() review comments
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

--l54QpwQccEA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/557?usp=3Demail

to review the following change.


Change subject: Address schedule_exit() review comments
......................................................................

Address schedule_exit() review comments

schedule_exit() now only takes the context as argument. The signal is
hard coded to SIGTERM, and the interval is read directly from the
context options.

Furthermore, schedule_exit() now returns a bool signifying whether an
exit was scheduled; false if exit is already scheduled. The call sites
are updated accordingly. A notable difference is that management is only
notified *once* when an exit is scheduled - we no longer notify
management on redundant exit.

Change-Id: I1cf589ecad82eecf167fe5cf28cda0fe4d42d42f
---
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/push.c
3 files changed, 14 insertions(+), 14 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/557/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 70f8e9d..937fae4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -514,22 +514,23 @@
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
-    /* don't reschedule if already scheduled; we drop the new signal, but =
it
-     * only ever seems to be SIGTERM anyway. */
+    const int n_seconds =3D c->options.scheduled_exit_interval;
+    /* don't reschedule if already scheduled. */
     if (event_timeout_defined(&c->c2.scheduled_exit)) {
-        return;
+        return false;
     }
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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/557?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1cf589ecad82eecf167fe5cf28cda0fe4d42d42f
Gerrit-Change-Number: 557
Gerrit-PatchSet: 1
Gerrit-Owner: reynir <reynir@...2756...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--l54QpwQccEA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>reynir would like plaisthos and flichtenheld to <strong>review</strong> =
this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/557?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Address schedule_exit() review comments<br><br>schedule_exit(=
) now only takes the context as argument. The signal is<br>hard coded to SI=
GTERM, and the interval is read directly from the<br>context options.<br><b=
r>Furthermore, schedule_exit() now returns a bool signifying whether an<br>=
exit was scheduled; false if exit is already scheduled. The call sites<br>a=
re updated accordingly. A notable difference is that management is only<br>=
notified *once* when an exit is scheduled - we no longer notify<br>manageme=
nt on redundant exit.<br><br>Change-Id: I1cf589ecad82eecf167fe5cf28cda0fe4d=
42d42f<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>M sr=
c/openvpn/push.c<br>3 files changed, 14 insertions(+), 14 deletions(-)<br><=
br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/557/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><=
br><span>index 70f8e9d..937fae4 100644</span><br><span>--- a/src/openvpn/fo=
rward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -514=
,22 +514,23 @@</span><br><span> }</span><br><span> </span><br><span> /*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * Schedule a signal n_se=
conds from now.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * S=
chedule a SIGTERM signal c-&gt;options.scheduled_exit_interval seconds from=
 now.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_exi=
t(struct context *c, const int n_seconds, const int signal)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+schedule_exit(struct context *c)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* don&#39;t res=
chedule if already scheduled; we drop the new signal, but it</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-     * only ever seems to be SIGTERM=
 anyway. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t int n_seconds =3D c-&gt;options.scheduled_exit_interval;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* don&#39;t reschedule if alrea=
dy scheduled. */</span><br><span>     if (event_timeout_defined(&amp;c-&gt;=
c2.scheduled_exit)) {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return false;</span><br><span>     }</span><br><span>     tls_set_singl=
e_session(c-&gt;c2.tls_multi);</span><br><span>     update_time();</span><b=
r><span>     reset_coarse_timers(c);</span><br><span>     event_timeout_ini=
t(&amp;c-&gt;c2.scheduled_exit, n_seconds, now);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    c-&gt;c2.scheduled_exit_signal =3D signal;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.schedule=
d_exit_signal =3D SIGTERM;</span><br><span>     msg(D_SCHED_EXIT, &quot;Del=
ayed exit in %d seconds&quot;, n_seconds);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return true;</span><br><span> }</span><br><span>=
 </span><br><span> /*</span><br><span>diff --git a/src/openvpn/forward.h b/=
src/openvpn/forward.h</span><br><span>index 6fb5a18..422c591 100644</span><=
br><span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/openvpn/forw=
ard.h</span><br><span>@@ -303,7 +303,7 @@</span><br><span> </span><br><span=
> void process_ip_header(struct context *c, unsigned int flags, struct buff=
er *buf);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void schedule_exit(struct context *c, const int n_seconds, const int =
signal);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool schedu=
le_exit(struct context *c);</span><br><span> </span><br><span> static inlin=
e struct link_socket_info *</span><br><span> get_link_socket_info(struct co=
ntext *c)</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/pus=
h.c</span><br><span>index 1b406b9..db1fd2e 100644</span><br><span>--- a/src=
/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@=
 -191,6 +191,7 @@</span><br><span> receive_exit_message(struct context *c)<=
/span><br><span> {</span><br><span>     dmsg(D_STREAM_ERRORS, &quot;CC-EEN =
exit message received by peer&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool notify_management =3D true;</span><br><span>    =
 /* With control channel exit notification, we want to give the session</sp=
an><br><span>      * enough time to handle retransmits and acknowledgment, =
so that eventual</span><br><span>      * retries from the client to resend =
the exit or ACKs will not trigger</span><br><span>@@ -204,14 +205,14 @@</sp=
an><br><span>      * */</span><br><span>     if (c-&gt;options.mode =3D=3D =
MODE_SERVER)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        schedule_exit(c, c-&gt;options.scheduled_exit_interva=
l, SIGTERM);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 notify_management =3D schedule_exit(c);</span><br><span>     }</span><br><=
span>     else</span><br><span>     {</span><br><span>         register_sig=
nal(c-&gt;sig, SIGUSR1, &quot;remote-exit&quot;);</span><br><span>     }</s=
pan><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (management)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (management &amp;&amp; notify_management)</span><b=
r><span>     {</span><br><span>         management_notify(management, &quot=
;info&quot;, &quot;remote-exit&quot;, &quot;EXIT&quot;);</span><br><span>  =
   }</span><br><span>@@ -391,7 +392,7 @@</span><br><span> void</span><br><s=
pan> send_auth_failed(struct context *c, const char *client_reason)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ev=
ent_timeout_defined(&amp;c-&gt;c2.scheduled_exit))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!schedule_exit(c))</span><br><span> =
    {</span><br><span>         msg(D_TLS_DEBUG, &quot;exit already schedule=
d for context&quot;);</span><br><span>         return;</span><br><span>@@ -=
401,8 +402,6 @@</span><br><span>     static const char auth_failed[] =3D &q=
uot;AUTH_FAILED&quot;;</span><br><span>     size_t len;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    schedule_exit(c, c-=
&gt;options.scheduled_exit_interval, SIGTERM);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span>     len =3D (client_reason ? str=
len(client_reason)+1 : 0) + sizeof(auth_failed);</span><br><span>     if (l=
en &gt; PUSH_BUNDLE_SIZE)</span><br><span>     {</span><br><span>@@ -492,7 =
+491,7 @@</span><br><span> void</span><br><span> send_restart(struct contex=
t *c, const char *kill_msg)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    schedule_exit(c, c-&gt;options.scheduled_exit_=
interval, SIGTERM);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    schedule_exit(c);</span><br><span>     send_control_channel_string(c, k=
ill_msg ? kill_msg : &quot;RESTART&quot;, D_PUSH);</span><br><span> }</span=
><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/557?usp=3Demail">change 557</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/557?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1cf589ecad82eecf167fe5cf28c=
da0fe4d42d42f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 557 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: reynir &lt;reynir@...2756...&gt;=
 </div>
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


--l54QpwQccEA=--

