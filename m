From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 13:54:52 +0000
References: <gerrit.1771250081000.I65c7225fe48c24a4734fc1b9df64b9580f6f6e5f@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <89d1b4d6d5f0fe02b88ef3a580ea5da80466324e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LkRnJiqzt40="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: management:
 ensure consistent BYTECOUNT timing on server
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

--LkRnJiqzt40=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1534?usp=3Demail

to review the following change.


Change subject: management: ensure consistent BYTECOUNT timing on server
......................................................................

management: ensure consistent BYTECOUNT timing on server

The BYTECOUNT notification is expected to be emitted every N seconds
when a management client issues the 'bytecount N' command. However, the
server currently relies on timeouts from unrelated periodic operations,
resulting in irregular notification timing.

This issue is especially noticeable with low bytecount intervals and DCO
enabled, as openvpn handles less traffic in userspace, causing the main
loop to run less frequently.

To address this, refactor the timeout logic and pass the timeval
reference to management_check_bytecount_server so that the timeout is
correctly set and notifications adhere to the specified interval.

Change-Id: I65c7225fe48c24a4734fc1b9df64b9580f6f6e5f
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/multi.c
M src/openvpn/multi.h
4 files changed, 33 insertions(+), 18 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/1534/1

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 48b87e9..7bed8b8 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -4186,16 +4186,14 @@
 }
=20
 void
-management_check_bytecount_server(struct multi_context *multi)
+management_check_bytecount_server(struct multi_context *multi, struct time=
val *timeval)
 {
     if (!(management->persist.callback.flags & MCF_SERVER))
     {
         return;
     }

-    struct timeval null;
-    CLEAR(null);
-    if (event_timeout_trigger(&management->connection.bytecount_update_int=
erval, &null, ETT_DEFAULT))
+    if (event_timeout_trigger(&management->connection.bytecount_update_int=
erval, timeval, ETT_DEFAULT))
     {
         /* fetch counters from dco */
         if (dco_enabled(&multi->top.options))
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index d3fe84f..96d053a 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -516,7 +516,7 @@

 void management_check_bytecount_client(struct context *c, struct managemen=
t *man, struct timeval *timeval);

-void management_check_bytecount_server(struct multi_context *multi);
+void management_check_bytecount_server(struct multi_context *multi, struct=
 timeval *timeval);

 void
 man_persist_client_stats(struct management *man, struct context *c);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 8654aa5..0032292 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3840,13 +3840,6 @@
     {
         check_stale_routes(m);
     }
-
-#ifdef ENABLE_MANAGEMENT
-    if (management)
-    {
-        management_check_bytecount_server(m);
-    }
-#endif /* ENABLE_MANAGEMENT */
 }

 void
@@ -4199,6 +4192,28 @@
     ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
 }

+/**
+ * @brief Determines the earliest wakeup interval based on periodic operat=
ions.
+ *
+ * Updates the \c timeval to reflect the next scheduled wakeup time.
+ * Also sets \c multi->earliest_wakeup to the instance with the earliest w=
akeup.
+ *
+ * @param multi     Pointer to the multi context
+ * @param timeval   Pointer to the timeval structure to be updated with the
+ *                  next wakeup time
+ */
+void
+multi_get_timeout(struct multi_context *multi, struct timeval *timeval)
+{
+    multi_get_timeout_instance(multi, timeval);
+
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        management_check_bytecount_server(multi, timeval);
+    }
+#endif /* ENABLE_MANAGEMENT */
+}

 /*
  * Top level event loop.
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 7167639..1f2d882 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -577,6 +577,7 @@
 void multi_reap_process_dowork(const struct multi_context *m);

 void multi_process_per_second_timers_dowork(struct multi_context *m);
+void multi_get_timeout(struct multi_context *multi, struct timeval *timeva=
l);

 static inline void
 multi_reap_process(const struct multi_context *m)
@@ -598,15 +599,16 @@
 }

 /*
- * Compute earliest timeout expiry from the set of
- * all instances.  Output:
+ * Updates \c dest with the earliest timeout as a delta relative to the cu=
rrent
+ * time and sets \c m->earliest_wakeup to the \c multi_instance with the
+ * soonest scheduled wakeup.
  *
- * m->earliest_wakeup : instance needing the earliest service.
- * dest               : earliest timeout as a delta in relation
- *                      to current time.
+ * @param m     Pointer to the multi context
+ * @param dest  Pointer to a timeval struct that will hold the earliest ti=
meout
+ *              delta.
  */
 static inline void
-multi_get_timeout(struct multi_context *m, struct timeval *dest)
+multi_get_timeout_instance(struct multi_context *m, struct timeval *dest)
 {
     struct timeval tv, current;


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1534?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I65c7225fe48c24a4734fc1b9df64b9580f6f6e5f
Gerrit-Change-Number: 1534
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--LkRnJiqzt40=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ralf_lici would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1534?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">management: ensure consistent BYTECOUNT tim=
ing on server<br><br>The BYTECOUNT notification is expected to be emitted e=
very N seconds<br>when a management client issues the &#39;bytecount N&#39;=
 command. However, the<br>server currently relies on timeouts from unrelate=
d periodic operations,<br>resulting in irregular notification timing.<br><b=
r>This issue is especially noticeable with low bytecount intervals and DCO<=
br>enabled, as openvpn handles less traffic in userspace, causing the main<=
br>loop to run less frequently.<br><br>To address this, refactor the timeou=
t logic and pass the timeval<br>reference to management_check_bytecount_ser=
ver so that the timeout is<br>correctly set and notifications adhere to the=
 specified interval.<br><br>Change-Id: I65c7225fe48c24a4734fc1b9df64b9580f6=
f6e5f<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M src/o=
penvpn/manage.c<br>M src/openvpn/manage.h<br>M src/openvpn/multi.c<br>M src=
/openvpn/multi.h<br>4 files changed, 33 insertions(+), 18 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/34/1534/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/manage.c b/src/openvpn/=
manage.c</span><br><span>index 48b87e9..7bed8b8 100644</span><br><span>--- =
a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span><br=
><span>@@ -4186,16 +4186,14 @@</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-managem=
ent_check_bytecount_server(struct multi_context *multi)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+management_check_bytecount_server(struc=
t multi_context *multi, struct timeval *timeval)</span><br><span> {</span><=
br><span>     if (!(management-&gt;persist.callback.flags &amp; MCF_SERVER)=
)</span><br><span>     {</span><br><span>         return;</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct timeval null;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    CLEAR(null);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (event_timeout_trigger(&amp;management-&gt;connection.bytecount_upda=
te_interval, &amp;null, ETT_DEFAULT))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (event_timeout_trigger(&amp;management-&gt;connect=
ion.bytecount_update_interval, timeval, ETT_DEFAULT))</span><br><span>     =
{</span><br><span>         /* fetch counters from dco */</span><br><span>  =
       if (dco_enabled(&amp;multi-&gt;top.options))</span><br><span>diff --=
git a/src/openvpn/manage.h b/src/openvpn/manage.h</span><br><span>index d3f=
e84f..96d053a 100644</span><br><span>--- a/src/openvpn/manage.h</span><br><=
span>+++ b/src/openvpn/manage.h</span><br><span>@@ -516,7 +516,7 @@</span><=
br><span> </span><br><span> void management_check_bytecount_client(struct c=
ontext *c, struct management *man, struct timeval *timeval);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void management_ch=
eck_bytecount_server(struct multi_context *multi);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void management_check_bytecount_server(struc=
t multi_context *multi, struct timeval *timeval);</span><br><span> </span><=
br><span> void</span><br><span> man_persist_client_stats(struct management =
*man, struct context *c);</span><br><span>diff --git a/src/openvpn/multi.c =
b/src/openvpn/multi.c</span><br><span>index 8654aa5..0032292 100644</span><=
br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.=
c</span><br><span>@@ -3840,13 +3840,6 @@</span><br><span>     {</span><br><=
span>         check_stale_routes(m);</span><br><span>     }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (management)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        management_check_bytecount_server(m);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif /* ENABLE_MANAGEMENT */</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span>@@ -4199,6 +4192,28 @@</span><br><=
span>     ASSERT(mi-&gt;context.c2.tls_multi-&gt;peer_id &lt; m-&gt;max_cli=
ents);</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @brief Determines the earliest wakeup interval based on periodic=
 operations.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Updates the \c timeva=
l to reflect the next scheduled wakeup time.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Also sets \c multi-&gt;earliest_wakeup to the i=
nstance with the earliest wakeup.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param multi     Pointer to the multi context</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param timeval   Pointer to the timeval struct=
ure to be updated with the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *                  next wakeup time</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_g=
et_timeout(struct multi_context *multi, struct timeval *timeval)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    multi_get_timeout_instance(multi, timeval);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (management)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        management_check_bytecount_server(multi,=
 timeval);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_MANAGE=
MENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span> </span><br><span> /*</span><br><span>  * Top level event loop.</span=
><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br=
><span>index 7167639..1f2d882 100644</span><br><span>--- a/src/openvpn/mult=
i.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -577,6 +57=
7,7 @@</span><br><span> void multi_reap_process_dowork(const struct multi_c=
ontext *m);</span><br><span> </span><br><span> void multi_process_per_secon=
d_timers_dowork(struct multi_context *m);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void multi_get_timeout(struct multi_context *multi, s=
truct timeval *timeval);</span><br><span> </span><br><span> static inline v=
oid</span><br><span> multi_reap_process(const struct multi_context *m)</spa=
n><br><span>@@ -598,15 +599,16 @@</span><br><span> }</span><br><span> </spa=
n><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Com=
pute earliest timeout expiry from the set of</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * all instances.  Output:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Updates \c dest with the earliest timeout =
as a delta relative to the current</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * time and sets \c m-&gt;earliest_wakeup to the \c multi_in=
stance with the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * s=
oonest scheduled wakeup.</span><br><span>  *</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * m-&gt;earliest_wakeup : instance needing the earl=
iest service.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * dest =
              : earliest timeout as a delta in relation</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *                      to current time.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m     Poin=
ter to the multi context</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param dest  Pointer to a timeval struct that will hold the earlies=
t timeout</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
      delta.</span><br><span>  */</span><br><span> static inline void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_get_timeout(struct mu=
lti_context *m, struct timeval *dest)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+multi_get_timeout_instance(struct multi_context *m, struc=
t timeval *dest)</span><br><span> {</span><br><span>     struct timeval tv,=
 current;</span><br><span> </span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1534?usp=3Demail">chan=
ge 1534</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1534?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I65c7225fe48c24a4734fc1b9df6=
4b9580f6f6e5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1534 </div>
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

--LkRnJiqzt40=--

