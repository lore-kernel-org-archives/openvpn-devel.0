From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 18:53:27 +0000
In-Reply-To: <gerrit.1760942237000.Ifb1c49fce75e671f699f5db5f6da7246f6e0b519@...2715...>
References: <gerrit.1760942237000.Ifb1c49fce75e671f699f5db5f6da7246f6e0b519@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...,
 lstipakov@...277...
Message-ID: <eaf9dce7db3dc6f4eca09e26f65021d5bee5c286-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LpVSyY+TTOk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: management: ensure
 consistent BYTECOUNT timing on server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LpVSyY+TTOk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
85?usp=3Demail )

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

Change-Id: Ifb1c49fce75e671f699f5db5f6da7246f6e0b519
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20251021070825.20773-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
812.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/multi.c
M src/openvpn/multi.h
4 files changed, 33 insertions(+), 18 deletions(-)




diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 1cb5c63..685b137 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -4184,16 +4184,14 @@
 }

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
index a31eb06..fe460bf 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -493,7 +493,7 @@

 void management_check_bytecount_client(struct context *c, struct managemen=
t *man, struct timeval *timeval);

-void management_check_bytecount_server(struct multi_context *multi);
+void management_check_bytecount_server(struct multi_context *multi, struct=
 timeval *timeval);
=20
 void man_persist_client_stats(struct management *man, struct context *c);

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f60944d..11e4d8c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3797,13 +3797,6 @@
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

 static void
@@ -4154,6 +4147,29 @@
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
+static void
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
+
 /*************************************************************************=
*/
 /**
  * Main event loop for OpenVPN in point-to-multipoint server mode.
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 594ea3a..50f8d10 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -581,15 +581,16 @@
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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1285?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifb1c49fce75e671f699f5db5f6da7246f6e0b519
Gerrit-Change-Number: 1285
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LpVSyY+TTOk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1285?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">management: ensure consistent BYTECOUNT timing o=
n server<br><br>The BYTECOUNT notification is expected to be emitted every =
N seconds<br>when a management client issues the &#39;bytecount N&#39; comm=
and. However, the<br>server currently relies on timeouts from unrelated per=
iodic operations,<br>resulting in irregular notification timing.<br><br>Thi=
s issue is especially noticeable with low bytecount intervals and DCO<br>en=
abled, as openvpn handles less traffic in userspace, causing the main<br>lo=
op to run less frequently.<br><br>To address this, refactor the timeout log=
ic and pass the timeval<br>reference to management_check_bytecount_server s=
o that the timeout is<br>correctly set and notifications adhere to the spec=
ified interval.<br><br>Change-Id: Ifb1c49fce75e671f699f5db5f6da7246f6e0b519=
<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>Acked-by: Lev Stipa=
kov &lt;lstipakov@...277...&gt;<br>Message-Id: &lt;20251021070825.20773-1-g=
ert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg33812.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>M =
src/openvpn/multi.c<br>M src/openvpn/multi.h<br>4 files changed, 33 inserti=
ons(+), 18 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span=
>index 1cb5c63..685b137 100644</span><br><span>--- a/src/openvpn/manage.c</=
span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -4184,16 +4184=
,14 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-management_check_bytecount_serv=
er(struct multi_context *multi)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+management_check_bytecount_server(struct multi_context *multi, =
struct timeval *timeval)</span><br><span> {</span><br><span>     if (!(mana=
gement-&gt;persist.callback.flags &amp; MCF_SERVER))</span><br><span>     {=
</span><br><span>         return;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval nul=
l;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(null);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (event_timeout_tr=
igger(&amp;management-&gt;connection.bytecount_update_interval, &amp;null, =
ETT_DEFAULT))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (event_timeout_trigger(&amp;management-&gt;connection.bytecount_update_int=
erval, timeval, ETT_DEFAULT))</span><br><span>     {</span><br><span>      =
   /* fetch counters from dco */</span><br><span>         if (dco_enabled(&=
amp;multi-&gt;top.options))</span><br><span>diff --git a/src/openvpn/manage=
.h b/src/openvpn/manage.h</span><br><span>index a31eb06..fe460bf 100644</sp=
an><br><span>--- a/src/openvpn/manage.h</span><br><span>+++ b/src/openvpn/m=
anage.h</span><br><span>@@ -493,7 +493,7 @@</span><br><span> </span><br><sp=
an> void management_check_bytecount_client(struct context *c, struct manage=
ment *man, struct timeval *timeval);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void management_check_bytecount_server(str=
uct multi_context *multi);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void management_check_bytecount_server(struct multi_context *multi, =
struct timeval *timeval);</span><br><span> </span><br><span> void man_persi=
st_client_stats(struct management *man, struct context *c);</span><br><span=
> </span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</=
span><br><span>index f60944d..11e4d8c 100644</span><br><span>--- a/src/open=
vpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3=
797,13 +3797,6 @@</span><br><span>     {</span><br><span>         check_sta=
le_routes(m);</span><br><span>     }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (management)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        management_ch=
eck_bytecount_server(m);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENA=
BLE_MANAGEMENT */</span><br><span> }</span><br><span> </span><br><span> sta=
tic void</span><br><span>@@ -4154,6 +4147,29 @@</span><br><span>     ASSERT=
(mi-&gt;context.c2.tls_multi-&gt;peer_id &lt; m-&gt;max_clients);</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brie=
f Determines the earliest wakeup interval based on periodic operations.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Updates the \c timeval to reflect the=
 next scheduled wakeup time.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Also sets \c multi-&gt;earliest_wakeup to the instance with the=
 earliest wakeup.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param multi    =
 Pointer to the multi context</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param timeval   Pointer to the timeval structure to be update=
d with the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
           next wakeup time</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_timeou=
t(struct multi_context *multi, struct timeval *timeval)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    multi_get_timeout_instance(multi, timeval);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (management)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        management_check_bytecount_server(multi, timeva=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_MANAGEMENT */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /******************=
********************************************************/</span><br><span> =
/**</span><br><span>  * Main event loop for OpenVPN in point-to-multipoint =
server mode.</span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn=
/multi.h</span><br><span>index 594ea3a..50f8d10 100644</span><br><span>--- =
a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><=
span>@@ -581,15 +581,16 @@</span><br><span> }</span><br><span> </span><br><=
span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Compute ea=
rliest timeout expiry from the set of</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * all instances.  Output:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Updates \c dest with the earliest timeout as a de=
lta relative to the current</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * time and sets \c m-&gt;earliest_wakeup to the \c multi_instance =
with the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * soonest =
scheduled wakeup.</span><br><span>  *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * m-&gt;earliest_wakeup : instance needing the earliest se=
rvice.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * dest        =
       : earliest timeout as a delta in relation</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *                      to current time.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m     Pointer to =
the multi context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param dest  Pointer to a timeval struct that will hold the earliest timeo=
ut</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *              d=
elta.</span><br><span>  */</span><br><span> static inline void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-multi_get_timeout(struct multi_con=
text *m, struct timeval *dest)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+multi_get_timeout_instance(struct multi_context *m, struct timev=
al *dest)</span><br><span> {</span><br><span>     struct timeval tv, curren=
t;</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1285?usp=3Demail">change 1285=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1285?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifb1c49fce75e671f699f5db5f6d=
a7246f6e0b519 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1285 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--LpVSyY+TTOk=--

