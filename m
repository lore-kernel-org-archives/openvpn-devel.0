From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 13:54:49 +0000
References: <gerrit.1771250081000.I4e1e8a204d1371a314b01737aedaa3d68fe28531@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bed9a6428d54b3824b2cf0cc36788735808df10b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jPUnOSgpaeE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Refactor
 management bytecount tracking
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

--jPUnOSgpaeE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1532?usp=3Demail

to review the following change.


Change subject: Refactor management bytecount tracking
......................................................................

Refactor management bytecount tracking

There are few issues with it:

 - when using DCO, the server part doesn't output BYTECOUNT_CLI
 since process_incoming_link_part1/process_outgoing_link are not called

 - when using DCO, the server part applies bytecount timer to the each
 connection, unneccessary making too many calls to the kernel and also
 uses incorect BYTECOUNT output.

 - client part outputs counters using timer, server part utilizes
 traffic activity -> inconsistency

Following changes have been made:

 - Use timer to output counters in client and server mode. Code which
 deals with bytecount on traffic activity has been removed. This unifies
 DCO and non-DCO, as well as client and server mode

 - In server mode, peers stats are fetched with the single ioctl call

 - Per-packet stats are not persisted anymore in the client mode during
   traffic activity. Instead cumulative stats (including DCO stats) are
   persisted when the session closes.

GitHub: https://github.com/OpenVPN/openvpn/issues/820

Change-Id: I4e1e8a204d1371a314b01737aedaa3d68fe28531
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/forward.c
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/multi.c
4 files changed, 77 insertions(+), 77 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/1532/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 4e9e739..0f49784 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -824,7 +824,7 @@
 #ifdef ENABLE_MANAGEMENT
     if (management)
     {
-        management_check_bytecount(c, management, &c->c2.timeval);
+        management_check_bytecount_client(c, management, &c->c2.timeval);
     }
 #endif /* ENABLE_MANAGEMENT */
 }
@@ -1006,13 +1006,6 @@
         }
 #endif
         c->c2.original_recv_size =3D c->c2.buf.len;
-#ifdef ENABLE_MANAGEMENT
-        if (management)
-        {
-            management_bytes_client(management, c->c2.buf.len, 0);
-            management_bytes_server(management, &c->c2.link_read_bytes, &c=
->c2.link_write_bytes, &c->c2.mda_context);
-        }
-#endif
     }
     else
     {
@@ -1852,13 +1845,6 @@
                     mmap_stats->link_write_bytes =3D link_write_bytes_glob=
al;
                 }
 #endif
-#ifdef ENABLE_MANAGEMENT
-                if (management)
-                {
-                    management_bytes_client(management, 0, size);
-                    management_bytes_server(management, &c->c2.link_read_b=
ytes, &c->c2.link_write_bytes, &c->c2.mda_context);
-                }
-#endif
             }
         }

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 6efe2d1..4ed0393 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -512,31 +512,27 @@
 }

 static void
-man_bytecount_output_client(struct management *man,
-                            counter_type dco_read_bytes,
-                            counter_type dco_write_bytes)
+man_bytecount_output_client(counter_type bytes_in_total, counter_type byte=
s_out_total)
 {
     char in[32];
     char out[32];

     /* do in a roundabout way to work around possible mingw or mingw-glibc=
 bug */
-    openvpn_snprintf(in, sizeof(in), counter_format, man->persist.bytes_in=
 + dco_read_bytes);
-    openvpn_snprintf(out, sizeof(out), counter_format, man->persist.bytes_=
out + dco_write_bytes);
+    openvpn_snprintf(in, sizeof(in), counter_format, bytes_in_total);
+    openvpn_snprintf(out, sizeof(out), counter_format, bytes_out_total);
     msg(M_CLIENT, ">BYTECOUNT:%s,%s", in, out);
 }

-void
-man_bytecount_output_server(const counter_type *bytes_in_total,
-                            const counter_type *bytes_out_total,
+static void
+man_bytecount_output_server(const counter_type bytes_in_total, const count=
er_type bytes_out_total,
                             struct man_def_auth_context *mdac)
 {
     char in[32];
     char out[32];
     /* do in a roundabout way to work around possible mingw or mingw-glibc=
 bug */
-    openvpn_snprintf(in, sizeof(in), counter_format, *bytes_in_total);
-    openvpn_snprintf(out, sizeof(out), counter_format, *bytes_out_total);
+    openvpn_snprintf(in, sizeof(in), counter_format, bytes_in_total);
+    openvpn_snprintf(out, sizeof(out), counter_format, bytes_out_total);
     msg(M_CLIENT, ">BYTECOUNT_CLI:%lu,%s,%s", mdac->cid, in, out);
-    mdac->bytecount_last_update =3D now;
 }

 static void
@@ -4160,37 +4156,82 @@
 }

 void
-management_check_bytecount(struct context *c, struct management *man, stru=
ct timeval *timeval)
+management_check_bytecount_client(struct context *c, struct management *ma=
n, struct timeval *timeval)
 {
-    if (event_timeout_trigger(&man->connection.bytecount_update_interval,
-                              timeval, ETT_DEFAULT))
+    if (man->persist.callback.flags & MCF_SERVER)
     {
-        counter_type dco_read_bytes =3D 0;
-        counter_type dco_write_bytes =3D 0;
+        return;
+    }

-        if (dco_enabled(&c->options) && (dco_get_peer_stats(c) =3D=3D 0))
+    if (event_timeout_trigger(&man->connection.bytecount_update_interval, =
timeval, ETT_DEFAULT))
+    {
+        if (dco_enabled(&c->options))
         {
-            dco_read_bytes =3D c->c2.dco_read_bytes;
-            dco_write_bytes =3D c->c2.dco_write_bytes;
+            if (dco_get_peer_stats(c) < 0)
+            {
+                return;
+            }
         }

-        if (!(man->persist.callback.flags & MCF_SERVER))
-        {
-            man_bytecount_output_client(man, dco_read_bytes, dco_write_byt=
es);
-        }
+        man_bytecount_output_client(c->c2.dco_read_bytes + man->persist.by=
tes_in + c->c2.link_read_bytes,
+                                    c->c2.dco_write_bytes + man->persist.b=
ytes_out + c->c2.link_write_bytes);
     }
 }

-/* DCO resets stats on reconnect. Since client expects stats
- * to be preserved across reconnects, we need to save DCO
+void
+management_check_bytecount_server(struct multi_context *multi)
+{
+    if (!(management->persist.callback.flags & MCF_SERVER))
+    {
+        return;
+    }
+
+    struct timeval null;
+    CLEAR(null);
+    if (event_timeout_trigger(&management->connection.bytecount_update_int=
erval, &null, ETT_DEFAULT))
+    {
+        /* fetch counters from dco */
+        if (dco_enabled(&multi->top.options))
+        {
+            if (dco_get_peer_stats_multi(&multi->top.c1.tuntap->dco, multi=
) < 0)
+            {
+                return;
+            }
+        }
+
+        /* iterate over peers and report counters for each connected peer =
*/
+        struct hash_iterator hi;
+        struct hash_element *he;
+        hash_iterator_init(multi->hash, &hi);
+        while ((he =3D hash_iterator_next(&hi)))
+        {
+            struct multi_instance *mi =3D (struct multi_instance *)he->val=
ue;
+            struct context_2 *c2 =3D &mi->context.c2;
+
+            if ((c2->mda_context.flags & (DAF_CONNECTION_ESTABLISHED | DAF=
_CONNECTION_CLOSED)) =3D=3D DAF_CONNECTION_ESTABLISHED)
+            {
+                man_bytecount_output_server(c2->dco_read_bytes + c2->link_=
read_bytes, c2->dco_write_bytes + c2->link_write_bytes, &c2->mda_context);
+            }
+        }
+        hash_iterator_free(&hi);
+    }
+}
+
+/* context_2 stats are reset on reconnect. Since client expects stats
+ * to be preserved across reconnects, we need to save context_2
  * stats before tearing the tunnel down.
  */
 void
 man_persist_client_stats(struct management *man, struct context *c)
 {
+    man->persist.bytes_in +=3D c->c2.link_read_bytes;
+    man->persist.bytes_out +=3D c->c2.link_write_bytes;
+
+    /* no need to raise SIGUSR1 since we are already closing the instance =
*/
     if (dco_enabled(&c->options) && (dco_get_peer_stats(c) =3D=3D 0))
     {
-        management_bytes_client(man, c->c2.dco_read_bytes, c->c2.dco_write=
_bytes);
+        man->persist.bytes_in +=3D c->c2.dco_read_bytes;
+        man->persist.bytes_out +=3D c->c2.dco_write_bytes;
     }
 }

diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 1896510..d3fe84f 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -70,8 +70,6 @@
     unsigned int flags;

     unsigned int mda_key_id_counter;
-
-    time_t bytecount_last_update;
 };

 /*
@@ -516,41 +514,9 @@
  * These functions drive the bytecount in/out counters.
  */

-void
-management_check_bytecount(struct context *c,
-                           struct management *man,
-                           struct timeval *timeval);
+void management_check_bytecount_client(struct context *c, struct managemen=
t *man, struct timeval *timeval);

-static inline void
-management_bytes_client(struct management *man,
-                        const int size_in,
-                        const int size_out)
-{
-    if (!(man->persist.callback.flags & MCF_SERVER))
-    {
-        man->persist.bytes_in +=3D size_in;
-        man->persist.bytes_out +=3D size_out;
-    }
-}
-
-void
-man_bytecount_output_server(const counter_type *bytes_in_total,
-                            const counter_type *bytes_out_total,
-                            struct man_def_auth_context *mdac);
-
-static inline void
-management_bytes_server(struct management *man,
-                        const counter_type *bytes_in_total,
-                        const counter_type *bytes_out_total,
-                        struct man_def_auth_context *mdac)
-{
-    if (man->connection.bytecount_update_seconds > 0
-        && now >=3D mdac->bytecount_last_update + man->connection.bytecoun=
t_update_seconds
-        && (mdac->flags & (DAF_CONNECTION_ESTABLISHED | DAF_CONNECTION_CLO=
SED)) =3D=3D DAF_CONNECTION_ESTABLISHED)
-    {
-        man_bytecount_output_server(bytes_in_total, bytes_out_total, mdac);
-    }
-}
+void management_check_bytecount_server(struct multi_context *multi);

 void
 man_persist_client_stats(struct management *man, struct context *c);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 69497a6..8654aa5 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3840,6 +3840,13 @@
     {
         check_stale_routes(m);
     }
+
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        management_check_bytecount_server(m);
+    }
+#endif /* ENABLE_MANAGEMENT */
 }

 void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1532?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I4e1e8a204d1371a314b01737aedaa3d68fe28531
Gerrit-Change-Number: 1532
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--jPUnOSgpaeE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ralf_lici would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1532?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Refactor management bytecount tracking<br><=
br>There are few issues with it:<br><br> - when using DCO, the server part =
doesn&#39;t output BYTECOUNT_CLI<br> since process_incoming_link_part1/proc=
ess_outgoing_link are not called<br><br> - when using DCO, the server part =
applies bytecount timer to the each<br> connection, unneccessary making too=
 many calls to the kernel and also<br> uses incorect BYTECOUNT output.<br><=
br> - client part outputs counters using timer, server part utilizes<br> tr=
affic activity -&gt; inconsistency<br><br>Following changes have been made:=
<br><br> - Use timer to output counters in client and server mode. Code whi=
ch<br> deals with bytecount on traffic activity has been removed. This unif=
ies<br> DCO and non-DCO, as well as client and server mode<br><br> - In ser=
ver mode, peers stats are fetched with the single ioctl call<br><br> - Per-=
packet stats are not persisted anymore in the client mode during<br>   traf=
fic activity. Instead cumulative stats (including DCO stats) are<br>   pers=
isted when the session closes.<br><br>GitHub: https://github.com/OpenVPN/op=
envpn/issues/820<br><br>Change-Id: I4e1e8a204d1371a314b01737aedaa3d68fe2853=
1<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/open=
vpn/forward.c<br>M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>M src/=
openvpn/multi.c<br>4 files changed, 77 insertions(+), 77 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/32/1532/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/=
forward.c</span><br><span>index 4e9e739..0f49784 100644</span><br><span>---=
 a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span>=
<br><span>@@ -824,7 +824,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</sp=
an><br><span>     if (management)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        management_check_bytecount(c, ma=
nagement, &amp;c-&gt;c2.timeval);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        management_check_bytecount_client(c, management, &amp=
;c-&gt;c2.timeval);</span><br><span>     }</span><br><span> #endif /* ENABL=
E_MANAGEMENT */</span><br><span> }</span><br><span>@@ -1006,13 +1006,6 @@</=
span><br><span>         }</span><br><span> #endif</span><br><span>         =
c-&gt;c2.original_recv_size =3D c-&gt;c2.buf.len;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (management)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            management_bytes_client(management, c-&gt=
;c2.buf.len, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       management_bytes_server(management, &amp;c-&gt;c2.link_read_bytes, &=
amp;c-&gt;c2.link_write_bytes, &amp;c-&gt;c2.mda_context);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span>     }</span><br><span>    =
 else</span><br><span>     {</span><br><span>@@ -1852,13 +1845,6 @@</span><=
br><span>                     mmap_stats-&gt;link_write_bytes =3D link_writ=
e_bytes_global;</span><br><span>                 }</span><br><span> #endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEME=
NT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if =
(management)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       management_bytes_client(management, 0, size);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    management_bytes_server=
(management, &amp;c-&gt;c2.link_read_bytes, &amp;c-&gt;c2.link_write_bytes,=
 &amp;c-&gt;c2.mda_context);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span>             }</span><br><span>         }</span><=
br><span> </span><br><span>diff --git a/src/openvpn/manage.c b/src/openvpn/=
manage.c</span><br><span>index 6efe2d1..4ed0393 100644</span><br><span>--- =
a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span><br=
><span>@@ -512,31 +512,27 @@</span><br><span> }</span><br><span> </span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ma=
n_bytecount_output_client(struct management *man,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                            counter_type dco_re=
ad_bytes,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                counter_type dco_write_bytes)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+man_bytecount_output_client(counter_type bytes_in=
_total, counter_type bytes_out_total)</span><br><span> {</span><br><span>  =
   char in[32];</span><br><span>     char out[32];</span><br><span> </span>=
<br><span>     /* do in a roundabout way to work around possible mingw or m=
ingw-glibc bug */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
openvpn_snprintf(in, sizeof(in), counter_format, man-&gt;persist.bytes_in +=
 dco_read_bytes);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
openvpn_snprintf(out, sizeof(out), counter_format, man-&gt;persist.bytes_ou=
t + dco_write_bytes);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    openvpn_snprintf(in, sizeof(in), counter_format, bytes_in_total);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_snprintf(ou=
t, sizeof(out), counter_format, bytes_out_total);</span><br><span>     msg(=
M_CLIENT, &quot;&gt;BYTECOUNT:%s,%s&quot;, in, out);</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-man_bytecount_output_ser=
ver(const counter_type *bytes_in_total,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                            const counter_type *bytes_out=
_total,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_bytecount_output=
_server(const counter_type bytes_in_total, const counter_type bytes_out_tot=
al,</span><br><span>                             struct man_def_auth_contex=
t *mdac)</span><br><span> {</span><br><span>     char in[32];</span><br><sp=
an>     char out[32];</span><br><span>     /* do in a roundabout way to wor=
k around possible mingw or mingw-glibc bug */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    openvpn_snprintf(in, sizeof(in), counter_format=
, *bytes_in_total);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  openvpn_snprintf(out, sizeof(out), counter_format, *bytes_out_total);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_snprintf(in=
, sizeof(in), counter_format, bytes_in_total);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    openvpn_snprintf(out, sizeof(out), counter_f=
ormat, bytes_out_total);</span><br><span>     msg(M_CLIENT, &quot;&gt;BYTEC=
OUNT_CLI:%lu,%s,%s&quot;, mdac-&gt;cid, in, out);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    mdac-&gt;bytecount_last_update =3D now;</sp=
an><br><span> }</span><br><span> </span><br><span> static void</span><br><s=
pan>@@ -4160,37 +4156,82 @@</span><br><span> }</span><br><span> </span><br>=
<span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management=
_check_bytecount(struct context *c, struct management *man, struct timeval =
*timeval)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management=
_check_bytecount_client(struct context *c, struct management *man, struct t=
imeval *timeval)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (event_timeout_trigger(&amp;man-&gt;connection.bytecou=
nt_update_interval,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                            timeval, ETT_DEFAULT))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (man-&gt;persist.callback.flags &amp;=
 MCF_SERVER)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        counter_type dco_read_bytes =3D 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        counter_type dco_write_bytes =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (dco_en=
abled(&amp;c-&gt;options) &amp;&amp; (dco_get_peer_stats(c) =3D=3D 0))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (event_timeout_tr=
igger(&amp;man-&gt;connection.bytecount_update_interval, timeval, ETT_DEFAU=
LT))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (dco_enabled(&amp;=
c-&gt;options))</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            dco_read_bytes =3D c-&gt;c2.dco_read_bytes=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            dco_writ=
e_bytes =3D c-&gt;c2.dco_write_bytes;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (dco_get_peer_stats(c) &lt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                return;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>   =
      }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (!(man-&gt;persist.callback.flags &amp; MCF_SERVER))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            man_bytecount_output_client(m=
an, dco_read_bytes, dco_write_bytes);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        man_bytecount_output_client(c-&gt;c2.dco_read_bytes + man-&gt=
;persist.bytes_in + c-&gt;c2.link_read_bytes,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                    c-&gt;c2.dco_=
write_bytes + man-&gt;persist.bytes_out + c-&gt;c2.link_write_bytes);</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/* DCO resets stats on reconnect. Since cl=
ient expects stats</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
to be preserved across reconnects, we need to save DCO</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+management_check_bytecount_server(struct multi_context =
*multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!(management-&gt;persi=
st.callback.flags &amp; MCF_SERVER))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct timeval null;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(null);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (event_timeout_trigger(&a=
mp;management-&gt;connection.bytecount_update_interval, &amp;null, ETT_DEFA=
ULT))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* fetch counters fr=
om dco */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (dco_enabled(&amp;multi-&gt;top.options))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if (dco_get_peer_stats_multi(&amp;multi-&gt;top.c1=
.tuntap-&gt;dco, multi) &lt; 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* iterate over p=
eers and report counters for each connected peer */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct hash_iterator hi;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        struct hash_element =
*he;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hash_it=
erator_init(multi-&gt;hash, &amp;hi);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        while ((he =3D hash_iterator_next(&amp;hi)))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            struct multi_instance =
*mi =3D (struct multi_instance *)he-&gt;value;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            struct context_2 *c2 =3D &amp;mi-&gt=
;context.c2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if ((c2-&gt;md=
a_context.flags &amp; (DAF_CONNECTION_ESTABLISHED | DAF_CONNECTION_CLOSED))=
 =3D=3D DAF_CONNECTION_ESTABLISHED)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                man_bytecount_output_server(c2-&gt;dco_read_bytes=
 + c2-&gt;link_read_bytes, c2-&gt;dco_write_bytes + c2-&gt;link_write_bytes=
, &amp;c2-&gt;mda_context);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
hash_iterator_free(&amp;hi);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* context_2 stats are reset on reconnect=
. Since client expects stats</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * to be preserved across reconnects, we need to save context_2</s=
pan><br><span>  * stats before tearing the tunnel down.</span><br><span>  *=
/</span><br><span> void</span><br><span> man_persist_client_stats(struct ma=
nagement *man, struct context *c)</span><br><span> {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    man-&gt;persist.bytes_in +=3D c-&gt;c=
2.link_read_bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   man-&gt;persist.bytes_out +=3D c-&gt;c2.link_write_bytes;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* no need to raise SIGUSR1 since we are already =
closing the instance */</span><br><span>     if (dco_enabled(&amp;c-&gt;opt=
ions) &amp;&amp; (dco_get_peer_stats(c) =3D=3D 0))</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        management_byte=
s_client(man, c-&gt;c2.dco_read_bytes, c-&gt;c2.dco_write_bytes);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        man-&gt;persist.bytes=
_in +=3D c-&gt;c2.dco_read_bytes;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        man-&gt;persist.bytes_out +=3D c-&gt;c2.dco_write_byt=
es;</span><br><span>     }</span><br><span> }</span><br><span> </span><br><=
span>diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h</span><br><sp=
an>index 1896510..d3fe84f 100644</span><br><span>--- a/src/openvpn/manage.h=
</span><br><span>+++ b/src/openvpn/manage.h</span><br><span>@@ -70,8 +70,6 =
@@</span><br><span>     unsigned int flags;</span><br><span> </span><br><sp=
an>     unsigned int mda_key_id_counter;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  time_t bytecount_last_update;</span><br><span> };</span><br><span> </span=
><br><span> /*</span><br><span>@@ -516,41 +514,9 @@</span><br><span>  * The=
se functions drive the bytecount in/out counters.</span><br><span>  */</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-management_check_bytecoun=
t(struct context *c,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                          struct management *man,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                           struct timeval *time=
val);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void managemen=
t_check_bytecount_client(struct context *c, struct management *man, struct =
timeval *timeval);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-management_bytes_client(struct management *man,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                        const int siz=
e_in,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
        const int size_out)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(man-=
&gt;persist.callback.flags &amp; MCF_SERVER))</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        man-&gt;persist.bytes_in +=3D size_in;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        man-&gt;persist.bytes_out +=3D siz=
e_out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_bytecount_=
output_server(const counter_type *bytes_in_total,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                            const counter_type =
*bytes_out_total,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                        struct man_def_auth_context *mdac);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-management_bytes_server(struct management *man,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        const count=
er_type *bytes_in_total,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        const counter_type *bytes_out_total,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                        struct ma=
n_def_auth_context *mdac)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (man-&gt;=
connection.bytecount_update_seconds &gt; 0</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        &amp;&amp; now &gt;=3D mdac-&gt;bytecount_last=
_update + man-&gt;connection.bytecount_update_seconds</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; (mdac-&gt;flags &amp; (D=
AF_CONNECTION_ESTABLISHED | DAF_CONNECTION_CLOSED)) =3D=3D DAF_CONNECTION_E=
STABLISHED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        man_bytecount_outp=
ut_server(bytes_in_total, bytes_out_total, mdac);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void m=
anagement_check_bytecount_server(struct multi_context *multi);</span><br><s=
pan> </span><br><span> void</span><br><span> man_persist_client_stats(struc=
t management *man, struct context *c);</span><br><span>diff --git a/src/ope=
nvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 69497a6..8654aa5 1=
00644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/o=
penvpn/multi.c</span><br><span>@@ -3840,6 +3840,13 @@</span><br><span>     =
{</span><br><span>         check_stale_routes(m);</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (management)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        management_check_bytecount_server(m);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_MANAGEMENT */</span><=
br><span> }</span><br><span> </span><br><span> void</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1532?usp=3Demail">change 1532</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
532?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4e1e8a204d1371a314b01737aed=
aa3d68fe28531 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1532 </div>
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

--jPUnOSgpaeE=--

