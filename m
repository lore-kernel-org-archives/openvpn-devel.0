From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Mon, 20 Oct 2025 06:37:19 +0000
References: <gerrit.1760942237000.Ifb1c49fce75e671f699f5db5f6da7246f6e0b519@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <03a50675a7ca1ff5effcce36d151b74ebcba78d8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6Ufykqg4IAI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: management: ensure
 consistent BYTECOUNT timing on server
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

--6Ufykqg4IAI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1285?usp=3Demail

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

Change-Id: Ifb1c49fce75e671f699f5db5f6da7246f6e0b519
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/multi.c
M src/openvpn/multi.h
4 files changed, 17 insertions(+), 13 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/1285/1

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

 void man_persist_client_stats(struct management *man, struct context *c);

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e907524..f9ef781 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3809,13 +3809,6 @@
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
@@ -4166,6 +4159,19 @@
     ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
 }

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
+#endif
+}
+
 /*************************************************************************=
*/
 /**
  * Main event loop for OpenVPN in point-to-multipoint server mode.
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 97bbc4a..8e3b9ca 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -590,7 +590,7 @@
  *                      to current time.
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifb1c49fce75e671f699f5db5f6da7246f6e0b519
Gerrit-Change-Number: 1285
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--6Ufykqg4IAI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1285?usp=3Demail">V=
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
 specified interval.<br><br>Change-Id: Ifb1c49fce75e671f699f5db5f6da7246f6e=
0b519<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M src/o=
penvpn/manage.c<br>M src/openvpn/manage.h<br>M src/openvpn/multi.c<br>M src=
/openvpn/multi.h<br>4 files changed, 17 insertions(+), 13 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/85/1285/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/manage.c b/src/openvpn/=
manage.c</span><br><span>index 1cb5c63..685b137 100644</span><br><span>--- =
a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span><br=
><span>@@ -4184,16 +4184,14 @@</span><br><span> }</span><br><span> </span><=
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
git a/src/openvpn/manage.h b/src/openvpn/manage.h</span><br><span>index a31=
eb06..fe460bf 100644</span><br><span>--- a/src/openvpn/manage.h</span><br><=
span>+++ b/src/openvpn/manage.h</span><br><span>@@ -493,7 +493,7 @@</span><=
br><span> </span><br><span> void management_check_bytecount_client(struct c=
ontext *c, struct management *man, struct timeval *timeval);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void management_ch=
eck_bytecount_server(struct multi_context *multi);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void management_check_bytecount_server(struc=
t multi_context *multi, struct timeval *timeval);</span><br><span> </span><=
br><span> void man_persist_client_stats(struct management *man, struct cont=
ext *c);</span><br><span> </span><br><span>diff --git a/src/openvpn/multi.c=
 b/src/openvpn/multi.c</span><br><span>index e907524..f9ef781 100644</span>=
<br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi=
.c</span><br><span>@@ -3809,13 +3809,6 @@</span><br><span>     {</span><br>=
<span>         check_stale_routes(m);</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (management)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        management_check_bytecount_server(m);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif /* ENABLE_MANAGEMENT */</span><br><span> }</span><br><spa=
n> </span><br><span> static void</span><br><span>@@ -4166,6 +4159,19 @@</sp=
an><br><span>     ASSERT(mi-&gt;context.c2.tls_multi-&gt;peer_id &lt; m-&gt=
;max_clients);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+multi_get_timeout(struct multi_context *multi, st=
ruct timeval *timeval)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_get_t=
imeout_instance(multi, timeval);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef=
 ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        managem=
ent_check_bytecount_server(multi, timeval);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**=
************************************************************************/</=
span><br><span> /**</span><br><span>  * Main event loop for OpenVPN in poin=
t-to-multipoint server mode.</span><br><span>diff --git a/src/openvpn/multi=
.h b/src/openvpn/multi.h</span><br><span>index 97bbc4a..8e3b9ca 100644</spa=
n><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/mul=
ti.h</span><br><span>@@ -590,7 +590,7 @@</span><br><span>  *               =
       to current time.</span><br><span>  */</span><br><span> static inline=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_get_timeou=
t(struct multi_context *m, struct timeval *dest)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+multi_get_timeout_instance(struct multi_contex=
t *m, struct timeval *dest)</span><br><span> {</span><br><span>     struct =
timeval tv, current;</span><br><span> </span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1285?usp=3D=
email">change 1285</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1285?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifb1c49fce75e671f699f5db5f6d=
a7246f6e0b519 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1285 </div>
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

</body></html>=

--6Ufykqg4IAI=--

