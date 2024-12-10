From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 10 Dec 2024 16:53:32 +0000
References: <gerrit.1733849609000.Ib118426c5a69256894040c69856a4003d9f4637c@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <60542e3cbcd523a4391cc3a40577d474b02c4499-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aosOOzHyI0k="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aosOOzHyI0k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/831?usp=3Demail

to review the following change.


Change subject: Handle missing DCO peer by restarting the session
......................................................................

Handle missing DCO peer by restarting the session

Occasionally, CMD_DEL_PEER is not delivered to userspace, preventing the
openvpn process from registering the event. To handle this case, we
check if calls to the DCO module return an error, and, if so, send a
SIGUSR1 signal to reset the session.

Change-Id: Ib118426c5a69256894040c69856a4003d9f4637c
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/dco_linux.c
M src/openvpn/forward.c
M src/openvpn/manage.c
M src/openvpn/multi.c
M src/openvpn/sig.c
5 files changed, 61 insertions(+), 14 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/831/1

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b038382..3f8e206 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -979,7 +979,12 @@
 int
 dco_get_peer_stats(struct context *c)
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
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d50b24c..4c4f3f7 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -483,16 +483,27 @@
 static void
 check_inactivity_timeout(struct context *c)
 {
-    if (dco_enabled(&c->options) && dco_get_peer_stats(c) =3D=3D 0)
+    if (dco_enabled(&c->options))
     {
-        int64_t tot_bytes =3D c->c2.tun_read_bytes + c->c2.tun_write_bytes;
-        int64_t new_bytes =3D tot_bytes - c->c2.inactivity_bytes;
-
-        if (new_bytes > c->options.inactivity_minimum_bytes)
+        const int stats_request =3D dco_get_peer_stats(c);
+        if (stats_request =3D=3D 0)
         {
-            c->c2.inactivity_bytes =3D tot_bytes;
-            event_timeout_reset(&c->c2.inactivity_interval);
+            int64_t tot_bytes =3D c->c2.tun_read_bytes + c->c2.tun_write_b=
ytes;
+            int64_t new_bytes =3D tot_bytes - c->c2.inactivity_bytes;

+            if (new_bytes > c->options.inactivity_minimum_bytes)
+            {
+                c->c2.inactivity_bytes =3D tot_bytes;
+                event_timeout_reset(&c->c2.inactivity_interval);
+
+                return;
+            }
+        }
+        else if (stats_request < 0)
+        {
+            msg(M_WARN, "Error requesting peer %d DCO stats (%s). Restarti=
ng the session",
+                c->c2.tls_multi->dco_peer_id, strerror(-stats_request));
+            register_signal(c->sig, SIGUSR1, "dco peer stats error");
             return;
         }
     }
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index e79a118..be2da4a 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -4138,10 +4138,21 @@
         counter_type dco_read_bytes =3D 0;
         counter_type dco_write_bytes =3D 0;

-        if (dco_enabled(&c->options) && (dco_get_peer_stats(c) =3D=3D 0))
+        if (dco_enabled(&c->options) && c->c2.tls_multi->peer_id !=3D -1)
         {
-            dco_read_bytes =3D c->c2.dco_read_bytes;
-            dco_write_bytes =3D c->c2.dco_write_bytes;
+            const int stats_request =3D dco_get_peer_stats(c);
+            if (stats_request =3D=3D 0)
+            {
+                dco_read_bytes =3D c->c2.dco_read_bytes;
+                dco_write_bytes =3D c->c2.dco_write_bytes;
+            }
+            else if (stats_request < 0)
+            {
+                msg(D_MANAGEMENT, "MANAGEMENT: Error requesting peer %d DC=
O stats (%s). Restarting the session",
+                    c->c2.tls_multi->dco_peer_id, strerror(-stats_request)=
);
+                register_signal(c->sig, SIGUSR1, "dco peer stats error");
+                return;
+            }
         }

         if (!(man->persist.callback.flags & MCF_SERVER))
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 45b3cfa..20724a0 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -549,7 +549,13 @@
 {
     if (dco_enabled(&m->top.options))
     {
-        dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m);
+        const int stats_request =3D dco_get_peer_stats_multi(&m->top.c1.tu=
ntap->dco, m);
+        if (stats_request < 0)
+        {
+            msg(D_DCO, "Error requesting peer %d DCO stats (%s)",
+                c->c2.tls_multi->dco_peer_id, strerror(-stats_request));
+            return;
+        }
     }

     setenv_counter(c->c2.es, "bytes_received", c->c2.link_read_bytes + c->=
c2.dco_read_bytes);
@@ -855,7 +861,14 @@

         if (dco_enabled(&m->top.options))
         {
-            dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m);
+            const int stats_request =3D dco_get_peer_stats_multi(&m->top.c=
1.tuntap->dco, m);
+            if (stats_request =3D=3D -ENOENT)
+            {
+                msg(M_WARN, "Error requesting peer DCO stats (%s)",
+                    strerror(-stats_request));
+                register_signal(m->top.sig, SIGUSR1, "dco peer stats error=
");
+                return;
+            }
         }

         if (version =3D=3D 1)
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 8323f0d..3654033 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -489,7 +489,14 @@

     if (dco_enabled(&c->options))
     {
-        dco_get_peer_stats(c);
+        const int stats_request =3D dco_get_peer_stats(c);
+        if (stats_request < 0)
+        {
+            msg(M_WARN, "Error requesting peer %d DCO stats (%s). Restarti=
ng the session",
+                c->c2.tls_multi->dco_peer_id, strerror(-stats_request));
+            register_signal(c->sig, SIGUSR1, "dco peer stats error");
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
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--aosOOzHyI0k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/831?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Handle missing DCO peer by restarting the session<br><br>Occa=
sionally, CMD_DEL_PEER is not delivered to userspace, preventing the<br>ope=
nvpn process from registering the event. To handle this case, we<br>check i=
f calls to the DCO module return an error, and, if so, send a<br>SIGUSR1 si=
gnal to reset the session.<br><br>Change-Id: Ib118426c5a69256894040c69856a4=
003d9f4637c<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M=
 src/openvpn/dco_linux.c<br>M src/openvpn/forward.c<br>M src/openvpn/manage=
.c<br>M src/openvpn/multi.c<br>M src/openvpn/sig.c<br>5 files changed, 61 i=
nsertions(+), 14 deletions(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/31/831/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_lin=
ux.c b/src/openvpn/dco_linux.c</span><br><span>index b038382..3f8e206 10064=
4</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/o=
penvpn/dco_linux.c</span><br><span>@@ -979,7 +979,12 @@</span><br><span> in=
t</span><br><span> dco_get_peer_stats(struct context *c)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t peer_id =
=3D c-&gt;c2.tls_multi-&gt;dco_peer_id;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int peer_id =3D c-&gt;c2.tls_multi-&gt;dco_peer_id;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (peer_id =3D=
=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     msg(D_DCO_DEBUG, &q=
uot;%s: peer-id %d&quot;, __func__, peer_id);</span><br><span> </span><br><=
span>     if (!c-&gt;c1.tuntap)</span><br><span>diff --git a/src/openvpn/fo=
rward.c b/src/openvpn/forward.c</span><br><span>index d50b24c..4c4f3f7 1006=
44</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/op=
envpn/forward.c</span><br><span>@@ -483,16 +483,27 @@</span><br><span> stat=
ic void</span><br><span> check_inactivity_timeout(struct context *c)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (d=
co_enabled(&amp;c-&gt;options) &amp;&amp; dco_get_peer_stats(c) =3D=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(&=
amp;c-&gt;options))</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        int64_t tot_bytes =3D c-&gt;c2.tun_read_bytes =
+ c-&gt;c2.tun_write_bytes;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        int64_t new_bytes =3D tot_bytes - c-&gt;c2.inactivity_bytes;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (new_bytes &gt; c-&gt;options.in=
activity_minimum_bytes)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        const int stats_request =3D dco_get_peer_stats(c);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (stats_request =3D=3D=
 0)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            c-&gt;c2.inactivity_bytes =3D tot_bytes;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            event_timeout_reset(&am=
p;c-&gt;c2.inactivity_interval);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            int64_t tot_bytes =3D c-&gt;c2.tun_read_bytes + c-=
&gt;c2.tun_write_bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            int64_t new_bytes =3D tot_bytes - c-&gt;c2.inactivity_bytes=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if (new_bytes &gt; c-&gt;options.inactivity_minimum_bytes)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2.inact=
ivity_bytes =3D tot_bytes;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                event_timeout_reset(&amp;c-&gt;c2.inactivity_interva=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                return;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        else if (stats_request &lt; 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;Error re=
questing peer %d DCO stats (%s). Restarting the session&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2.tls_mul=
ti-&gt;dco_peer_id, strerror(-stats_request));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            register_signal(c-&gt;sig, SIGUSR1, =
&quot;dco peer stats error&quot;);</span><br><span>             return;</sp=
an><br><span>         }</span><br><span>     }</span><br><span>diff --git a=
/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index e79a118.=
.be2da4a 100644</span><br><span>--- a/src/openvpn/manage.c</span><br><span>=
+++ b/src/openvpn/manage.c</span><br><span>@@ -4138,10 +4138,21 @@</span><b=
r><span>         counter_type dco_read_bytes =3D 0;</span><br><span>       =
  counter_type dco_write_bytes =3D 0;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (dco_enabled(&amp;c-&gt;option=
s) &amp;&amp; (dco_get_peer_stats(c) =3D=3D 0))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (dco_enabled(&amp;c-&gt;options) &am=
p;&amp; c-&gt;c2.tls_multi-&gt;peer_id !=3D -1)</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            dco_read_b=
ytes =3D c-&gt;c2.dco_read_bytes;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            dco_write_bytes =3D c-&gt;c2.dco_write_bytes;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            const int sta=
ts_request =3D dco_get_peer_stats(c);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (stats_request =3D=3D 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                dco_read_bytes =3D c-&gt;=
c2.dco_read_bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               dco_write_bytes =3D c-&gt;c2.dco_write_bytes;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            else if (stats_request &lt; =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_M=
ANAGEMENT, &quot;MANAGEMENT: Error requesting peer %d DCO stats (%s). Resta=
rting the session&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    c-&gt;c2.tls_multi-&gt;dco_peer_id, strerror(-stat=
s_request));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         register_signal(c-&gt;sig, SIGUSR1, &quot;dco peer stats error&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span>         }</span><br><span> </span><br><span>         if=
 (!(man-&gt;persist.callback.flags &amp; MCF_SERVER))</span><br><span>diff =
--git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 45b=
3cfa..20724a0 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><s=
pan>+++ b/src/openvpn/multi.c</span><br><span>@@ -549,7 +549,13 @@</span><b=
r><span> {</span><br><span>     if (dco_enabled(&amp;m-&gt;top.options))</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       dco_get_peer_stats_multi(&amp;m-&gt;top.c1.tuntap-&gt;dco, m);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        const int stats_r=
equest =3D dco_get_peer_stats_multi(&amp;m-&gt;top.c1.tuntap-&gt;dco, m);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (stats_req=
uest &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D=
_DCO, &quot;Error requesting peer %d DCO stats (%s)&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2.tls_multi-&=
gt;dco_peer_id, strerror(-stats_request));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            return;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> </=
span><br><span>     setenv_counter(c-&gt;c2.es, &quot;bytes_received&quot;,=
 c-&gt;c2.link_read_bytes + c-&gt;c2.dco_read_bytes);</span><br><span>@@ -8=
55,7 +861,14 @@</span><br><span> </span><br><span>         if (dco_enabled(=
&amp;m-&gt;top.options))</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            dco_get_peer_stats_multi(&amp;m=
-&gt;top.c1.tuntap-&gt;dco, m);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            const int stats_request =3D dco_get_peer_stats_mult=
i(&amp;m-&gt;top.c1.tuntap-&gt;dco, m);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (stats_request =3D=3D -ENOENT)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                msg(M_WARN, &quot;E=
rror requesting peer DCO stats (%s)&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    strerror(-stats_request));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                register_=
signal(m-&gt;top.sig, SIGUSR1, &quot;dco peer stats error&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                return;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span>         }</span><br><span> </span><br><span>         if (version =3D=
=3D 1)</span><br><span>diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c</=
span><br><span>index 8323f0d..3654033 100644</span><br><span>--- a/src/open=
vpn/sig.c</span><br><span>+++ b/src/openvpn/sig.c</span><br><span>@@ -489,7=
 +489,14 @@</span><br><span> </span><br><span>     if (dco_enabled(&amp;c-&=
gt;options))</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        dco_get_peer_stats(c);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const int stats_request =3D dco_get_peer_s=
tats(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(stats_request &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(M_WARN, &quot;Error requesting peer %d DCO stats (%s). Restarting =
the session&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               c-&gt;c2.tls_multi-&gt;dco_peer_id, strerror(-stats_request)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            regis=
ter_signal(c-&gt;sig, SIGUSR1, &quot;dco peer stats error&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            return;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>   =
  }</span><br><span> </span><br><span>     status_printf(so, &quot;OpenVPN =
STATISTICS&quot;);</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/831?usp=3Demail">change 831</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/831?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib118426c5a69256894040c69856=
a4003d9f4637c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 831 </div>
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


--aosOOzHyI0k=--

