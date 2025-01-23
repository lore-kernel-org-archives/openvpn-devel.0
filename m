From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Thu, 23 Jan 2025 16:43:25 +0000
In-Reply-To: <gerrit.1733849609000.Ib118426c5a69256894040c69856a4003d9f4637c@...2715...>
References: <gerrit.1733849609000.Ib118426c5a69256894040c69856a4003d9f4637c@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <6a02f0526c863563cc956f05e51e142343d0a664-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a5SLh1Wisys="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--a5SLh1Wisys=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ralf_lici.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/831?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


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
---
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/forward.c
M src/openvpn/manage.c
M src/openvpn/multi.c
M src/openvpn/sig.c
8 files changed, 63 insertions(+), 22 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/831/2

diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 035474f..97453e3 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -230,17 +230,20 @@
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
@@ -363,13 +366,14 @@
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
index f4c3b02..4b8d72f 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -713,7 +713,8 @@
 }
=20
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
index b038382..bfe8cc2 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -921,7 +921,8 @@
 }

 int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
+                         const bool raise_sigusr1_on_err)
 {
     msg(D_DCO_DEBUG, "%s", __func__);

@@ -932,6 +933,14 @@
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

@@ -977,9 +986,14 @@
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
@@ -999,6 +1013,14 @@

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
index 46b2d03..5687dda 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -459,14 +459,15 @@
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
index f3f3503..80ec43a 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -488,16 +488,14 @@
 static void
 check_inactivity_timeout(struct context *c)
 {
-    if (dco_enabled(&c->options) && dco_get_peer_stats(c) =3D=3D 0)
+    if (dco_enabled(&c->options) && dco_get_peer_stats(c, true) =3D=3D 0)
     {
         int64_t tot_bytes =3D c->c2.tun_read_bytes + c->c2.tun_write_bytes;
         int64_t new_bytes =3D tot_bytes - c->c2.inactivity_bytes;
-
         if (new_bytes > c->options.inactivity_minimum_bytes)
         {
             c->c2.inactivity_bytes =3D tot_bytes;
             event_timeout_reset(&c->c2.inactivity_interval);
-
             return;
         }
     }
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0c77f85..ccdfd264 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -4139,8 +4139,13 @@
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
@@ -4159,7 +4164,8 @@
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
index f426b46..95b5e04 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -549,7 +549,10 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-MessageType: newpatchset

--a5SLh1Wisys=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ralf_lici. <=
/p>
<p>ralf_lici <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/831?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Handle missing DCO peer by restarting the session<br=
><br>Occasionally, CMD_DEL_PEER is not delivered to userspace, preventing t=
he<br>openvpn process from registering the event. To handle this case, we<b=
r>check if calls to the Linux DCO module return an error, and, if so, send<=
br>a SIGUSR1 signal to reset the session.<br><br>Most DCO commands that ret=
urn an error already trigger a SIGUSR1 signal<br>or even call _exit(1). Thi=
s commit extends that behavior to include<br>dco_get_peer_stats_multi() and=
 dco_get_peer_stats().<br><br>Change-Id: Ib118426c5a69256894040c69856a4003d=
9f4637c<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M src=
/openvpn/dco.h<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_linux.c<=
br>M src/openvpn/dco_win.c<br>M src/openvpn/forward.c<br>M src/openvpn/mana=
ge.c<br>M src/openvpn/multi.c<br>M src/openvpn/sig.c<br>8 files changed, 63=
 insertions(+), 22 deletions(-)<br><br></pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/31/831/2</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.h=
 b/src/openvpn/dco.h</span><br><span>index 035474f..97453e3 100644</span><b=
r><span>--- a/src/openvpn/dco.h</span><br><span>+++ b/src/openvpn/dco.h</sp=
an><br><span>@@ -230,17 +230,20 @@</span><br><span> /**</span><br><span>  *=
 Update traffic statistics for all peers</span><br><span>  *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @param dco   DCO device context</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param m     the ser=
ver context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m dco                   DCO device context</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param m                     the server context</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param raise_sigus=
r1_on_err  whether to raise SIGUSR1 on error</span><br><span>  **/</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-int dco_get_peer_stats_multi(d=
co_context_t *dco, struct multi_context *m);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+int dco_get_peer_stats_multi(dco_context_t *dco, s=
truct multi_context *m,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                             const bool raise_sigusr1_on_err);</span><b=
r><span> </span><br><span> /**</span><br><span>  * Update traffic statistic=
s for single peer</span><br><span>  *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @param c   instance context of the peer</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param c                     inst=
ance context of the peer</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param raise_sigusr1_on_err  whether to raise SIGUSR1 on error</spa=
n><br><span>  **/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int =
dco_get_peer_stats(struct context *c);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+int dco_get_peer_stats(struct context *c, const bool rai=
se_sigusr1_on_err);</span><br><span> </span><br><span> /**</span><br><span>=
  * Retrieve the list of ciphers supported by the current platform</span><b=
r><span>@@ -363,13 +366,14 @@</span><br><span> }</span><br><span> </span><b=
r><span> static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_peer_stats_m=
ulti(dco_context_t *dco, struct multi_context *m,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                         const bool raise_sig=
usr1_on_err)</span><br><span> {</span><br><span>     return 0;</span><br><s=
pan> }</span><br><span> </span><br><span> static inline int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-dco_get_peer_stats(struct context *c)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_peer_stats(=
struct context *c, const bool raise_sigusr1_on_err)</span><br><span> {</spa=
n><br><span>     return 0;</span><br><span> }</span><br><span>diff --git a/=
src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index=
 f4c3b02..4b8d72f 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</s=
pan><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -713,7 +71=
3,8 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-dco_get_peer_stats_multi(dco_con=
text_t *dco, struct multi_context *m)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dco_get_peer_stats_multi(dco_context_t *dco, struct multi=
_context *m,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                  const bool raise_sigusr1_on_err)</span><br><span> {</span=
><br><span> </span><br><span>     struct ifdrv drv;</span><br><span>@@ -781=
,7 +782,7 @@</span><br><span> }</span><br><span> </span><br><span> int</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_get_peer_stats(struct =
context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_=
peer_stats(struct context *c, const bool raise_sigusr1_on_err)</span><br><s=
pan> {</span><br><span>     /* Not implemented. */</span><br><span>     ret=
urn 0;</span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/d=
co_linux.c</span><br><span>index b038382..bfe8cc2 100644</span><br><span>--=
- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</=
span><br><span>@@ -921,7 +921,8 @@</span><br><span> }</span><br><span> </sp=
an><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_=
get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_peer_stats_multi(dco_=
context_t *dco, struct multi_context *m,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                         const bool raise_sigusr1_on_e=
rr)</span><br><span> {</span><br><span>     msg(D_DCO_DEBUG, &quot;%s&quot;=
, __func__);</span><br><span> </span><br><span>@@ -932,6 +933,14 @@</span><=
br><span>     int ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer_mult=
i, m, __func__);</span><br><span> </span><br><span>     nlmsg_free(nl_msg);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (raise_sigusr1_on_err &amp;&amp=
; ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, =
&quot;Error retrieving DCO peer stats: the underlying DCO peer&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;may have=
 been deleted from the kernel without notifying &quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &quot;userspace. Restarting =
the session&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        register_signal(m-&gt;top.sig, SIGUSR1, &quot;dco peer stats error&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span>     return ret;</span><br><span> }</span><br><span> </span><br><=
span>@@ -977,9 +986,14 @@</span><br><span> }</span><br><span> </span><br><s=
pan> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_get_peer_=
stats(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  uint32_t peer_id =3D c-&gt;c2.tls_multi-&gt;dco_peer_id;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int peer_id =3D c-&gt;c2.tls_mul=
ti-&gt;dco_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (peer_id =3D=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     m=
sg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peer_id);</span><br><=
span> </span><br><span>     if (!c-&gt;c1.tuntap)</span><br><span>@@ -999,6=
 +1013,14 @@</span><br><span> </span><br><span> nla_put_failure:</span><br>=
<span>     nlmsg_free(nl_msg);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
raise_sigusr1_on_err &amp;&amp; ret &lt; 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(M_WARN, &quot;Error retrieving DCO peer stats: the un=
derlying DCO peer&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            &quot;may have been deleted from the kernel without notifyi=
ng &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  &quot;userspace. Restarting the session&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        register_signal(c-&gt;sig, SIGUSR1, &=
quot;dco peer stats error&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span>     return ret;</span><br><span> }</sp=
an><br><span> </span><br><span>diff --git a/src/openvpn/dco_win.c b/src/ope=
nvpn/dco_win.c</span><br><span>index 46b2d03..5687dda 100644</span><br><spa=
n>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</=
span><br><span>@@ -459,14 +459,15 @@</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dc=
o_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_peer_stats_multi(dc=
o_context_t *dco, struct multi_context *m,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                         const bool raise_sigusr1_on=
_err)</span><br><span> {</span><br><span>     /* Not implemented. */</span>=
<br><span>     return 0;</span><br><span> }</span><br><span> </span><br><sp=
an> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_get_peer_s=
tats(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)<=
/span><br><span> {</span><br><span>     struct tuntap *tt =3D c-&gt;c1.tunt=
ap;</span><br><span> </span><br><span>diff --git a/src/openvpn/forward.c b/=
src/openvpn/forward.c</span><br><span>index f3f3503..80ec43a 100644</span><=
br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forw=
ard.c</span><br><span>@@ -488,16 +488,14 @@</span><br><span> static void</s=
pan><br><span> check_inactivity_timeout(struct context *c)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco_enabled=
(&amp;c-&gt;options) &amp;&amp; dco_get_peer_stats(c) =3D=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(&amp;c-&gt;=
options) &amp;&amp; dco_get_peer_stats(c, true) =3D=3D 0)</span><br><span> =
    {</span><br><span>         int64_t tot_bytes =3D c-&gt;c2.tun_read_byte=
s + c-&gt;c2.tun_write_bytes;</span><br><span>         int64_t new_bytes =
=3D tot_bytes - c-&gt;c2.inactivity_bytes;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span>         if (new_bytes &gt; c-&gt;opt=
ions.inactivity_minimum_bytes)</span><br><span>         {</span><br><span> =
            c-&gt;c2.inactivity_bytes =3D tot_bytes;</span><br><span>      =
       event_timeout_reset(&amp;c-&gt;c2.inactivity_interval);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>             retu=
rn;</span><br><span>         }</span><br><span>     }</span><br><span>diff =
--git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index 0=
c77f85..ccdfd264 100644</span><br><span>--- a/src/openvpn/manage.c</span><b=
r><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -4139,8 +4139,13 @@</=
span><br><span>         counter_type dco_read_bytes =3D 0;</span><br><span>=
         counter_type dco_write_bytes =3D 0;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (dco_enabled(&amp;c-&gt=
;options) &amp;&amp; (dco_get_peer_stats(c) =3D=3D 0))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (dco_enabled(&amp;c-&gt;optio=
ns))</span><br><span>         {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (dco_get_peer_stats(c, true) &lt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                return;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             dco_read_=
bytes =3D c-&gt;c2.dco_read_bytes;</span><br><span>             dco_write_b=
ytes =3D c-&gt;c2.dco_write_bytes;</span><br><span>         }</span><br><sp=
an>@@ -4159,7 +4164,8 @@</span><br><span> void</span><br><span> man_persist=
_client_stats(struct management *man, struct context *c)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco_enabled(&=
amp;c-&gt;options) &amp;&amp; (dco_get_peer_stats(c) =3D=3D 0))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* no need to raise SIGUSR1=
 since we are already closing the instance */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (dco_enabled(&amp;c-&gt;options) &amp;&amp=
; (dco_get_peer_stats(c, false) =3D=3D 0))</span><br><span>     {</span><br=
><span>         management_bytes_client(man, c-&gt;c2.dco_read_bytes, c-&gt=
;c2.dco_write_bytes);</span><br><span>     }</span><br><span>diff --git a/s=
rc/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index f426b46..95b=
5e04 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b=
/src/openvpn/multi.c</span><br><span>@@ -549,7 +549,10 @@</span><br><span> =
{</span><br><span>     if (dco_enabled(&amp;m-&gt;top.options))</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dc=
o_get_peer_stats_multi(&amp;m-&gt;top.c1.tuntap-&gt;dco, m);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (dco_get_peer_stats_mul=
ti(&amp;m-&gt;top.c1.tuntap-&gt;dco, m, false) &lt; 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            return;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> =
</span><br><span>     setenv_counter(c-&gt;c2.es, &quot;bytes_received&quot=
;, c-&gt;c2.link_read_bytes + c-&gt;c2.dco_read_bytes);</span><br><span>@@ =
-856,7 +859,10 @@</span><br><span> </span><br><span>         if (dco_enable=
d(&amp;m-&gt;top.options))</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            dco_get_peer_stats_multi(&amp;m=
-&gt;top.c1.tuntap-&gt;dco, m);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (dco_get_peer_stats_multi(&amp;m-&gt;top.c1.tunt=
ap-&gt;dco, m, true) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                return;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span>         }</span><br><span> </span><br=
><span>         if (version =3D=3D 1)</span><br><span>diff --git a/src/open=
vpn/sig.c b/src/openvpn/sig.c</span><br><span>index 8323f0d..b0f8935 100644=
</span><br><span>--- a/src/openvpn/sig.c</span><br><span>+++ b/src/openvpn/=
sig.c</span><br><span>@@ -489,7 +489,10 @@</span><br><span> </span><br><spa=
n>     if (dco_enabled(&amp;c-&gt;options))</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        dco_get_peer_stats(c);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (dco_get=
_peer_stats(c, true) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span>     }</span><br><span> </span><br><span>     stat=
us_printf(so, &quot;OpenVPN STATISTICS&quot;);</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/831=
?usp=3Demail">change 831</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/831?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib118426c5a69256894040c69856=
a4003d9f4637c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 831 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--a5SLh1Wisys=--

