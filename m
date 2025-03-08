From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 8 Mar 2025 08:39:19 +0000
In-Reply-To: <gerrit.1733849609000.Ib118426c5a69256894040c69856a4003d9f4637c@...2715...>
References: <gerrit.1733849609000.Ib118426c5a69256894040c69856a4003d9f4637c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <476087e71d118f21a2d6b0a02f0f7af6d297876e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RRZncAY1b0s="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Handle missing DCO
 peer by restarting the session
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RRZncAY1b0s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/83=
1?usp=3Demail )

Change subject: Handle missing DCO peer by restarting the session
......................................................................

Handle missing DCO peer by restarting the session

Occasionally, CMD_DEL_PEER is not delivered to userspace, preventing the
openvpn process from registering the event. To handle this case, we
check if calls to the Linux DCO module return an error, and, if so, send
a SIGUSR1 signal to reset the session.

Most DCO commands that return an error already trigger a SIGUSR1 signal
or even call _exit(1). This commit extends that behavior to include
dco_get_peer_stats_multi() and dco_get_peer_stats().

Change-Id: Ib118426c5a69256894040c69856a4003d9f4637c
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250305171730.250444-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
022.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/forward.c
M src/openvpn/manage.c
M src/openvpn/multi.c
M src/openvpn/sig.c
8 files changed, 63 insertions(+), 21 deletions(-)




diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 35ceace..ed194cc 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -231,17 +231,20 @@
 /**
  * Update traffic statistics for all peers
  *
- * @param dco   DCO device context
- * @param m     the server context
+ * @param dco                   DCO device context
+ * @param m                     the server context
+ * @param raise_sigusr1_on_err  whether to raise SIGUSR1 on error
  **/
-int dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m);
+int dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
+                             const bool raise_sigusr1_on_err);

 /**
  * Update traffic statistics for single peer
  *
- * @param c   instance context of the peer
+ * @param c                     instance context of the peer
+ * @param raise_sigusr1_on_err  whether to raise SIGUSR1 on error
  **/
-int dco_get_peer_stats(struct context *c);
+int dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err);

 /**
  * Retrieve the list of ciphers supported by the current platform
@@ -373,13 +376,14 @@
 }

 static inline int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
+                         const bool raise_sigusr1_on_err)
 {
     return 0;
 }

 static inline int
-dco_get_peer_stats(struct context *c)
+dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
     return 0;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 0e536de..b8816c6 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -713,7 +713,8 @@
 }

 int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
+                         const bool raise_sigusr1_on_err)
 {

     struct ifdrv drv;
@@ -781,7 +782,7 @@
 }

 int
-dco_get_peer_stats(struct context *c)
+dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
     /* Not implemented. */
     return 0;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 68c1a8d..b0a85fd 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -952,7 +952,8 @@
 }

 int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
+                         const bool raise_sigusr1_on_err)
 {
     msg(D_DCO_DEBUG, "%s", __func__);

@@ -963,6 +964,14 @@
     int ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer_multi, m, __f=
unc__);

     nlmsg_free(nl_msg);
+
+    if (raise_sigusr1_on_err && ret < 0)
+    {
+        msg(M_WARN, "Error retrieving DCO peer stats: the underlying DCO p=
eer"
+            "may have been deleted from the kernel without notifying "
+            "userspace. Restarting the session");
+        register_signal(m->top.sig, SIGUSR1, "dco peer stats error");
+    }
     return ret;
 }

@@ -1008,9 +1017,14 @@
 }

 int
-dco_get_peer_stats(struct context *c)
+dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
-    uint32_t peer_id =3D c->c2.tls_multi->dco_peer_id;
+    int peer_id =3D c->c2.tls_multi->dco_peer_id;
+    if (peer_id =3D=3D -1)
+    {
+        return 0;
+    }
+
     msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);

     if (!c->c1.tuntap)
@@ -1030,6 +1044,14 @@

 nla_put_failure:
     nlmsg_free(nl_msg);
+
+    if (raise_sigusr1_on_err && ret < 0)
+    {
+        msg(M_WARN, "Error retrieving DCO peer stats: the underlying DCO p=
eer"
+            "may have been deleted from the kernel without notifying "
+            "userspace. Restarting the session");
+        register_signal(c->sig, SIGUSR1, "dco peer stats error");
+    }
     return ret;
 }

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 45cb919..8b47124 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -712,14 +712,15 @@
 }

 int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
+                         const bool raise_sigusr1_on_err)
 {
     /* Not implemented. */
     return 0;
 }

 int
-dco_get_peer_stats(struct context *c)
+dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
     struct tuntap *tt =3D c->c1.tuntap;

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index b025344..fce7ac8 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -488,7 +488,7 @@
 static void
 check_inactivity_timeout(struct context *c)
 {
-    if (dco_enabled(&c->options) && dco_get_peer_stats(c) =3D=3D 0)
+    if (dco_enabled(&c->options) && dco_get_peer_stats(c, true) =3D=3D 0)
     {
         int64_t tot_bytes =3D c->c2.tun_read_bytes + c->c2.tun_write_bytes;
         int64_t new_bytes =3D tot_bytes - c->c2.inactivity_bytes;
@@ -497,7 +497,6 @@
         {
             c->c2.inactivity_bytes =3D tot_bytes;
             event_timeout_reset(&c->c2.inactivity_interval);
-
             return;
         }
     }
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 484042a..0e73942 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -4146,8 +4146,13 @@
         counter_type dco_read_bytes =3D 0;
         counter_type dco_write_bytes =3D 0;

-        if (dco_enabled(&c->options) && (dco_get_peer_stats(c) =3D=3D 0))
+        if (dco_enabled(&c->options))
         {
+            if (dco_get_peer_stats(c, true) < 0)
+            {
+                return;
+            }
+
             dco_read_bytes =3D c->c2.dco_read_bytes;
             dco_write_bytes =3D c->c2.dco_write_bytes;
         }
@@ -4166,7 +4171,8 @@
 void
 man_persist_client_stats(struct management *man, struct context *c)
 {
-    if (dco_enabled(&c->options) && (dco_get_peer_stats(c) =3D=3D 0))
+    /* no need to raise SIGUSR1 since we are already closing the instance =
*/
+    if (dco_enabled(&c->options) && (dco_get_peer_stats(c, false) =3D=3D 0=
))
     {
         management_bytes_client(man, c->c2.dco_read_bytes, c->c2.dco_write=
_bytes);
     }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 85a1712..9d244be 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -548,7 +548,10 @@
 {
     if (dco_enabled(&m->top.options))
     {
-        dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m);
+        if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m, false) < 0)
+        {
+            return;
+        }
     }

     setenv_counter(c->c2.es, "bytes_received", c->c2.link_read_bytes + c->=
c2.dco_read_bytes);
@@ -856,7 +859,10 @@

         if (dco_enabled(&m->top.options))
         {
-            dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m);
+            if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m, true) =
< 0)
+            {
+                return;
+            }
         }

         if (version =3D=3D 1)
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 8323f0d..b0f8935 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -489,7 +489,10 @@

     if (dco_enabled(&c->options))
     {
-        dco_get_peer_stats(c);
+        if (dco_get_peer_stats(c, true) < 0)
+        {
+            return;
+        }
     }

     status_printf(so, "OpenVPN STATISTICS");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/831?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib118426c5a69256894040c69856a4003d9f4637c
Gerrit-Change-Number: 831
Gerrit-PatchSet: 4
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--RRZncAY1b0s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/831?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Handle missing DCO peer by restarting the sess=
ion<br><br>Occasionally, CMD_DEL_PEER is not delivered to userspace, preven=
ting the<br>openvpn process from registering the event. To handle this case=
, we<br>check if calls to the Linux DCO module return an error, and, if so,=
 send<br>a SIGUSR1 signal to reset the session.<br><br>Most DCO commands th=
at return an error already trigger a SIGUSR1 signal<br>or even call _exit(1=
). This commit extends that behavior to include<br>dco_get_peer_stats_multi=
() and dco_get_peer_stats().<br><br>Change-Id: Ib118426c5a69256894040c69856=
a4003d9f4637c<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>Acked-=
by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;202503051=
71730.250444-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/op=
envpn-devel@lists.sourceforge.net/msg31022.html<br>Signed-off-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco.h<br>M src/openvpn/=
dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_win.c<br>M =
src/openvpn/forward.c<br>M src/openvpn/manage.c<br>M src/openvpn/multi.c<br=
>M src/openvpn/sig.c<br>8 files changed, 63 insertions(+), 21 deletions(-)<=
br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h</span><br><span>index=
 35ceace..ed194cc 100644</span><br><span>--- a/src/openvpn/dco.h</span><br>=
<span>+++ b/src/openvpn/dco.h</span><br><span>@@ -231,17 +231,20 @@</span><=
br><span> /**</span><br><span>  * Update traffic statistics for all peers</=
span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
@param dco   DCO device context</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param m     the server context</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param dco                   DCO device context=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m        =
             the server context</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param raise_sigusr1_on_err  whether to raise SIGUSR1 on err=
or</span><br><span>  **/</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-int dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_get_peer_=
stats_multi(dco_context_t *dco, struct multi_context *m,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                             const boo=
l raise_sigusr1_on_err);</span><br><span> </span><br><span> /**</span><br><=
span>  * Update traffic statistics for single peer</span><br><span>  *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param c   instance con=
text of the peer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param c                     instance context of the peer</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param raise_sigusr1_on_err  wheth=
er to raise SIGUSR1 on error</span><br><span>  **/</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-int dco_get_peer_stats(struct context *c);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_get_peer_stats(=
struct context *c, const bool raise_sigusr1_on_err);</span><br><span> </spa=
n><br><span> /**</span><br><span>  * Retrieve the list of ciphers supported=
 by the current platform</span><br><span>@@ -373,13 +376,14 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static inline int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-dco_get_peer_stats_multi(dco_context_=
t *dco, struct multi_context *m)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_cont=
ext *m,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
             const bool raise_sigusr1_on_err)</span><br><span> {</span><br>=
<span>     return 0;</span><br><span> }</span><br><span> </span><br><span> =
static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_=
get_peer_stats(struct context *c)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+dco_get_peer_stats(struct context *c, const bool raise_sigusr=
1_on_err)</span><br><span> {</span><br><span>     return 0;</span><br><span=
> }</span><br><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dc=
o_freebsd.c</span><br><span>index 0e536de..b8816c6 100644</span><br><span>-=
-- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebs=
d.c</span><br><span>@@ -713,7 +713,8 @@</span><br><span> }</span><br><span>=
 </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_peer_stats_multi=
(dco_context_t *dco, struct multi_context *m,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                         const bool raise_sigusr1=
_on_err)</span><br><span> {</span><br><span> </span><br><span>     struct i=
fdrv drv;</span><br><span>@@ -781,7 +782,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-dco_get_peer_stats(struct context *c)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+dco_get_peer_stats(struct context *c, const bool r=
aise_sigusr1_on_err)</span><br><span> {</span><br><span>     /* Not impleme=
nted. */</span><br><span>     return 0;</span><br><span>diff --git a/src/op=
envpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index 68c1a8d..=
b0a85fd 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><spa=
n>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -952,7 +952,8 @@</span><=
br><span> }</span><br><span> </span><br><span> int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-dco_get_peer_stats_multi(dco_context_t *dco, s=
truct multi_context *m)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
    const bool raise_sigusr1_on_err)</span><br><span> {</span><br><span>   =
  msg(D_DCO_DEBUG, &quot;%s&quot;, __func__);</span><br><span> </span><br><=
span>@@ -963,6 +964,14 @@</span><br><span>     int ret =3D ovpn_nl_msg_send=
(dco, nl_msg, dco_parse_peer_multi, m, __func__);</span><br><span> </span><=
br><span>     nlmsg_free(nl_msg);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (raise_sigusr1_on_err &amp;&amp; ret &lt; 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_WARN, &quot;Error retrieving DCO peer stats: the=
 underlying DCO peer&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            &quot;may have been deleted from the kernel without noti=
fying &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;userspace. Restarting the session&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        register_signal(m-&gt;top.sig, SI=
GUSR1, &quot;dco peer stats error&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span>     return ret;</span><br><spa=
n> }</span><br><span> </span><br><span>@@ -1008,9 +1017,14 @@</span><br><sp=
an> }</span><br><span> </span><br><span> int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-dco_get_peer_stats(struct context *c)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+dco_get_peer_stats(struct context =
*c, const bool raise_sigusr1_on_err)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    uint32_t peer_id =3D c-&gt;c2.tls_mul=
ti-&gt;dco_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int peer_id =3D c-&gt;c2.tls_multi-&gt;dco_peer_id;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (peer_id =3D=3D -1)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer-id %d&qu=
ot;, __func__, peer_id);</span><br><span> </span><br><span>     if (!c-&gt;=
c1.tuntap)</span><br><span>@@ -1030,6 +1044,14 @@</span><br><span> </span><=
br><span> nla_put_failure:</span><br><span>     nlmsg_free(nl_msg);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (raise_sigusr1_on_err &amp;&amp; ret &l=
t; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Er=
ror retrieving DCO peer stats: the underlying DCO peer&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &quot;may have been de=
leted from the kernel without notifying &quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            &quot;userspace. Restarting the sess=
ion&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
register_signal(c-&gt;sig, SIGUSR1, &quot;dco peer stats error&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>  =
   return ret;</span><br><span> }</span><br><span> </span><br><span>diff --=
git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index 4=
5cb919..8b47124 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><b=
r><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -712,14 +712,15 @@</=
span><br><span> }</span><br><span> </span><br><span> int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-dco_get_peer_stats_multi(dco_context_t *=
dco, struct multi_context *m)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context=
 *m,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
          const bool raise_sigusr1_on_err)</span><br><span> {</span><br><sp=
an>     /* Not implemented. */</span><br><span>     return 0;</span><br><sp=
an> }</span><br><span> </span><br><span> int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-dco_get_peer_stats(struct context *c)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+dco_get_peer_stats(struct context =
*c, const bool raise_sigusr1_on_err)</span><br><span> {</span><br><span>   =
  struct tuntap *tt =3D c-&gt;c1.tuntap;</span><br><span> </span><br><span>=
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>=
index b025344..fce7ac8 100644</span><br><span>--- a/src/openvpn/forward.c</=
span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -488,7 +488,7=
 @@</span><br><span> static void</span><br><span> check_inactivity_timeout(=
struct context *c)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (dco_enabled(&amp;c-&gt;options) &amp;&amp; dco_get_=
peer_stats(c) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (dco_enabled(&amp;c-&gt;options) &amp;&amp; dco_get_peer_stats(c=
, true) =3D=3D 0)</span><br><span>     {</span><br><span>         int64_t t=
ot_bytes =3D c-&gt;c2.tun_read_bytes + c-&gt;c2.tun_write_bytes;</span><br>=
<span>         int64_t new_bytes =3D tot_bytes - c-&gt;c2.inactivity_bytes;=
</span><br><span>@@ -497,7 +497,6 @@</span><br><span>         {</span><br><=
span>             c-&gt;c2.inactivity_bytes =3D tot_bytes;</span><br><span>=
             event_timeout_reset(&amp;c-&gt;c2.inactivity_interval);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>           =
  return;</span><br><span>         }</span><br><span>     }</span><br><span=
>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>i=
ndex 484042a..0e73942 100644</span><br><span>--- a/src/openvpn/manage.c</sp=
an><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -4146,8 +4146,13=
 @@</span><br><span>         counter_type dco_read_bytes =3D 0;</span><br><=
span>         counter_type dco_write_bytes =3D 0;</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (dco_enabled(&amp;=
c-&gt;options) &amp;&amp; (dco_get_peer_stats(c) =3D=3D 0))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (dco_enabled(&amp;c-&gt;=
options))</span><br><span>         {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (dco_get_peer_stats(c, true) &lt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                return;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             dco_=
read_bytes =3D c-&gt;c2.dco_read_bytes;</span><br><span>             dco_wr=
ite_bytes =3D c-&gt;c2.dco_write_bytes;</span><br><span>         }</span><b=
r><span>@@ -4166,7 +4171,8 @@</span><br><span> void</span><br><span> man_pe=
rsist_client_stats(struct management *man, struct context *c)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco_enab=
led(&amp;c-&gt;options) &amp;&amp; (dco_get_peer_stats(c) =3D=3D 0))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* no need to raise SI=
GUSR1 since we are already closing the instance */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (dco_enabled(&amp;c-&gt;options) &amp=
;&amp; (dco_get_peer_stats(c, false) =3D=3D 0))</span><br><span>     {</spa=
n><br><span>         management_bytes_client(man, c-&gt;c2.dco_read_bytes, =
c-&gt;c2.dco_write_bytes);</span><br><span>     }</span><br><span>diff --gi=
t a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 85a1712=
..9d244be 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>=
+++ b/src/openvpn/multi.c</span><br><span>@@ -548,7 +548,10 @@</span><br><s=
pan> {</span><br><span>     if (dco_enabled(&amp;m-&gt;top.options))</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   dco_get_peer_stats_multi(&amp;m-&gt;top.c1.tuntap-&gt;dco, m);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (dco_get_peer_stat=
s_multi(&amp;m-&gt;top.c1.tuntap-&gt;dco, m, false) &lt; 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><s=
pan> </span><br><span>     setenv_counter(c-&gt;c2.es, &quot;bytes_received=
&quot;, c-&gt;c2.link_read_bytes + c-&gt;c2.dco_read_bytes);</span><br><spa=
n>@@ -856,7 +859,10 @@</span><br><span> </span><br><span>         if (dco_e=
nabled(&amp;m-&gt;top.options))</span><br><span>         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            dco_get_peer_stats_multi(&=
amp;m-&gt;top.c1.tuntap-&gt;dco, m);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (dco_get_peer_stats_multi(&amp;m-&gt;top.c1=
.tuntap-&gt;dco, m, true) &lt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                return;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span>         }</span><br><span> </spa=
n><br><span>         if (version =3D=3D 1)</span><br><span>diff --git a/src=
/openvpn/sig.c b/src/openvpn/sig.c</span><br><span>index 8323f0d..b0f8935 1=
00644</span><br><span>--- a/src/openvpn/sig.c</span><br><span>+++ b/src/ope=
nvpn/sig.c</span><br><span>@@ -489,7 +489,10 @@</span><br><span> </span><br=
><span>     if (dco_enabled(&amp;c-&gt;options))</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_get_peer_stat=
s(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (dc=
o_get_peer_stats(c, true) &lt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            return;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span>     }</span><br><span> </span><br><span>    =
 status_printf(so, &quot;OpenVPN STATISTICS&quot;);</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/831?usp=3Demail">change 831</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/831?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib118426c5a69256894040c69856=
a4003d9f4637c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 831 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--RRZncAY1b0s=--

