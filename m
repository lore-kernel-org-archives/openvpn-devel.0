From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 15:28:45 +0000
In-Reply-To: <gerrit.1756460812000.I43a93f0d84f01fd808a64115e1b8c3b806706491@...2715...>
References: <gerrit.1756460812000.I43a93f0d84f01fd808a64115e1b8c3b806706491@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., ralf@...2726...,
 lstipakov@...277...
Message-ID: <f88f1e468e24b1a08dd35d2273d0e13aa399e5c0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nmloyTp2OTM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Refactor management
 bytecount tracking
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, ralf_lici <ralf@...2726...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nmloyTp2OTM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/1162?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Refactor management bytecount tracking
......................................................................

Refactor management bytecount tracking

There are few issues with it:

 - when using DCO, the server part doesn't output BYTECOUNT_CLI since
   process_incoming_link_part1/process_outgoing_link are not called

 - when using DCO, the server part applies bytecount timer to the each
   connection, unneccessary making too many calls to the kernel and also
   uses incorrect BYTECOUNT output.

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

GitHub: closes OpenVPN/openvpn#820

Change-Id: I43a93f0d84f01fd808a64115e1b8c3b806706491
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250902103606.22181-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59228150/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/multi.c
4 files changed, 73 insertions(+), 70 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/1162/4

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 75ca9d5..03b6a0c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -818,7 +818,7 @@
 #ifdef ENABLE_MANAGEMENT
     if (management)
     {
-        management_check_bytecount(c, management, &c->c2.timeval);
+        management_check_bytecount_client(c, management, &c->c2.timeval);
     }
 #endif /* ENABLE_MANAGEMENT */
 }
@@ -998,14 +998,6 @@
         }
 #endif
         c->c2.original_recv_size =3D c->c2.buf.len;
-#ifdef ENABLE_MANAGEMENT
-        if (management)
-        {
-            management_bytes_client(management, c->c2.buf.len, 0);
-            management_bytes_server(management, &c->c2.link_read_bytes, &c=
->c2.link_write_bytes,
-                                    &c->c2.mda_context);
-        }
-#endif
     }
     else
     {
@@ -1823,14 +1815,6 @@
                     mmap_stats->link_write_bytes =3D link_write_bytes_glob=
al;
                 }
 #endif
-#ifdef ENABLE_MANAGEMENT
-                if (management)
-                {
-                    management_bytes_client(management, 0, size);
-                    management_bytes_server(management, &c->c2.link_read_b=
ytes,
-                                            &c->c2.link_write_bytes, &c->c=
2.mda_context);
-                }
-#endif
             }
         }

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index aed04f5..52b0e5e 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -41,6 +41,7 @@
 #include "manage.h"
 #include "openvpn.h"
 #include "dco.h"
+#include "multi.h"

 #include "memdbg.h"

@@ -517,29 +518,27 @@
 }

 static void
-man_bytecount_output_client(struct management *man, counter_type dco_read_=
bytes,
-                            counter_type dco_write_bytes)
+man_bytecount_output_client(counter_type bytes_in_total, counter_type byte=
s_out_total)
 {
     char in[32];
     char out[32];

     /* do in a roundabout way to work around possible mingw or mingw-glibc=
 bug */
-    snprintf(in, sizeof(in), counter_format, man->persist.bytes_in + dco_r=
ead_bytes);
-    snprintf(out, sizeof(out), counter_format, man->persist.bytes_out + dc=
o_write_bytes);
+    snprintf(in, sizeof(in), counter_format, bytes_in_total);
+    snprintf(out, sizeof(out), counter_format, bytes_out_total);
     msg(M_CLIENT, ">BYTECOUNT:%s,%s", in, out);
 }

-void
-man_bytecount_output_server(const counter_type *bytes_in_total, const coun=
ter_type *bytes_out_total,
+static void
+man_bytecount_output_server(const counter_type bytes_in_total, const count=
er_type bytes_out_total,
                             struct man_def_auth_context *mdac)
 {
     char in[32];
     char out[32];
     /* do in a roundabout way to work around possible mingw or mingw-glibc=
 bug */
-    snprintf(in, sizeof(in), counter_format, *bytes_in_total);
-    snprintf(out, sizeof(out), counter_format, *bytes_out_total);
+    snprintf(in, sizeof(in), counter_format, bytes_in_total);
+    snprintf(out, sizeof(out), counter_format, bytes_out_total);
     msg(M_CLIENT, ">BYTECOUNT_CLI:%lu,%s,%s", mdac->cid, in, out);
-    mdac->bytecount_last_update =3D now;
 }

 static void
@@ -4065,42 +4064,82 @@
 }

 void
-management_check_bytecount(struct context *c, struct management *man, stru=
ct timeval *timeval)
+management_check_bytecount_client(struct context *c, struct management *ma=
n, struct timeval *timeval)
 {
+    if (man->persist.callback.flags & MCF_SERVER)
+    {
+        return;
+    }
+
     if (event_timeout_trigger(&man->connection.bytecount_update_interval, =
timeval, ETT_DEFAULT))
     {
-        counter_type dco_read_bytes =3D 0;
-        counter_type dco_write_bytes =3D 0;
-
         if (dco_enabled(&c->options))
         {
             if (dco_get_peer_stats(c, true) < 0)
             {
                 return;
             }
-
-            dco_read_bytes =3D c->c2.dco_read_bytes;
-            dco_write_bytes =3D c->c2.dco_write_bytes;
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
+            if (dco_get_peer_stats_multi(&multi->top.c1.tuntap->dco, true)=
 < 0)
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
-    /* no need to raise SIGUSR1 since we are already closing the instance =
*/
+    man->persist.bytes_in +=3D c->c2.link_read_bytes;
+    man->persist.bytes_out +=3D c->c2.link_write_bytes;
+
+    /* no need to raise SIGUSR1 on error since we are already closing the =
instance */
     if (dco_enabled(&c->options) && (dco_get_peer_stats(c, false) =3D=3D 0=
))
     {
-        management_bytes_client(man, c->c2.dco_read_bytes, c->c2.dco_write=
_bytes);
+        man->persist.bytes_in +=3D c->c2.dco_read_bytes;
+        man->persist.bytes_out +=3D c->c2.dco_write_bytes;
     }
 }

diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index e9e1f95..0b064cf 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -70,8 +70,6 @@
     unsigned int flags;

     unsigned int mda_key_id_counter;
-
-    time_t bytecount_last_update;
 };

 /*
@@ -492,34 +490,9 @@
  * These functions drive the bytecount in/out counters.
  */

-void management_check_bytecount(struct context *c, struct management *man,=
 struct timeval *timeval);
+void management_check_bytecount_client(struct context *c, struct managemen=
t *man, struct timeval *timeval);

-static inline void
-management_bytes_client(struct management *man, const int size_in, const i=
nt size_out)
-{
-    if (!(man->persist.callback.flags & MCF_SERVER))
-    {
-        man->persist.bytes_in +=3D size_in;
-        man->persist.bytes_out +=3D size_out;
-    }
-}
-
-void man_bytecount_output_server(const counter_type *bytes_in_total,
-                                 const counter_type *bytes_out_total,
-                                 struct man_def_auth_context *mdac);
-
-static inline void
-management_bytes_server(struct management *man, const counter_type *bytes_=
in_total,
-                        const counter_type *bytes_out_total, struct man_de=
f_auth_context *mdac)
-{
-    if (man->connection.bytecount_update_seconds > 0
-        && now >=3D mdac->bytecount_last_update + man->connection.bytecoun=
t_update_seconds
-        && (mdac->flags & (DAF_CONNECTION_ESTABLISHED | DAF_CONNECTION_CLO=
SED))
-               =3D=3D DAF_CONNECTION_ESTABLISHED)
-    {
-        man_bytecount_output_server(bytes_in_total, bytes_out_total, mdac);
-    }
-}
+void management_check_bytecount_server(struct multi_context *multi);

 void man_persist_client_stats(struct management *man, struct context *c);

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e1ce32a..f1abdbe 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3812,6 +3812,13 @@
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

 static void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1162?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I43a93f0d84f01fd808a64115e1b8c3b806706491
Gerrit-Change-Number: 1162
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: ralf_lici <ralf@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--nmloyTp2OTM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1162=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Refactor management bytecount tracking<br><br>There =
are few issues with it:<br><br> - when using DCO, the server part doesn&#39=
;t output BYTECOUNT_CLI since<br>   process_incoming_link_part1/process_out=
going_link are not called<br><br> - when using DCO, the server part applies=
 bytecount timer to the each<br>   connection, unneccessary making too many=
 calls to the kernel and also<br>   uses incorrect BYTECOUNT output.<br><br=
> - client part outputs counters using timer, server part utilizes<br>   tr=
affic activity -&gt; inconsistency<br><br>Following changes have been made:=
<br><br> - Use timer to output counters in client and server mode. Code whi=
ch<br>   deals with bytecount on traffic activity has been removed. This un=
ifies<br>   DCO and non-DCO, as well as client and server mode<br><br> - In=
 server mode, peers stats are fetched with the single ioctl call<br><br> - =
Per-packet stats are not persisted anymore in the client mode during<br>   =
traffic activity. Instead cumulative stats (including DCO stats) are<br>   =
persisted when the session closes.<br><br>GitHub: closes OpenVPN/openvpn#82=
0<br><br>Change-Id: I43a93f0d84f01fd808a64115e1b8c3b806706491<br>Signed-off=
-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@=
...1296...&gt;<br>Message-Id: &lt;20250902103606.22181-1-gert@...1296...&gt=
;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/59228150/<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/f=
orward.c<br>M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>M src/openv=
pn/multi.c<br>4 files changed, 73 insertions(+), 70 deletions(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/1162/4</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><s=
pan>index 75ca9d5..03b6a0c 100644</span><br><span>--- a/src/openvpn/forward=
.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -818,7 +8=
18,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     if (=
management)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        management_check_bytecount(c, management, &amp;c-&gt;c=
2.timeval);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
management_check_bytecount_client(c, management, &amp;c-&gt;c2.timeval);</s=
pan><br><span>     }</span><br><span> #endif /* ENABLE_MANAGEMENT */</span>=
<br><span> }</span><br><span>@@ -998,14 +998,6 @@</span><br><span>         =
}</span><br><span> #endif</span><br><span>         c-&gt;c2.original_recv_s=
ize =3D c-&gt;c2.buf.len;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (management)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         management_bytes_client(management, c-&gt;c2.buf.len, 0);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            management_bytes_s=
erver(management, &amp;c-&gt;c2.link_read_bytes, &amp;c-&gt;c2.link_write_b=
ytes,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                    &amp;c-&gt;c2.mda_context);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span>     }</span><br><span>     else</span=
><br><span>     {</span><br><span>@@ -1823,14 +1815,6 @@</span><br><span>  =
                   mmap_stats-&gt;link_write_bytes =3D link_write_bytes_glo=
bal;</span><br><span>                 }</span><br><span> #endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                if (management=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    mana=
gement_bytes_client(management, 0, size);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    management_bytes_server(management,=
 &amp;c-&gt;c2.link_read_bytes,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                            &amp;c-&gt;c2.link_wr=
ite_bytes, &amp;c-&gt;c2.mda_context);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span>             }</span><br><span>        =
 }</span><br><span> </span><br><span>diff --git a/src/openvpn/manage.c b/sr=
c/openvpn/manage.c</span><br><span>index aed04f5..52b0e5e 100644</span><br>=
<span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c=
</span><br><span>@@ -41,6 +41,7 @@</span><br><span> #include &quot;manage.h=
&quot;</span><br><span> #include &quot;openvpn.h&quot;</span><br><span> #in=
clude &quot;dco.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;multi.h&quot;</span><br><span> </span><br><span> #includ=
e &quot;memdbg.h&quot;</span><br><span> </span><br><span>@@ -517,29 +518,27=
 @@</span><br><span> }</span><br><span> </span><br><span> static void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-man_bytecount_output_client=
(struct management *man, counter_type dco_read_bytes,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                            counter_type dc=
o_write_bytes)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_b=
ytecount_output_client(counter_type bytes_in_total, counter_type bytes_out_=
total)</span><br><span> {</span><br><span>     char in[32];</span><br><span=
>     char out[32];</span><br><span> </span><br><span>     /* do in a round=
about way to work around possible mingw or mingw-glibc bug */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    snprintf(in, sizeof(in), counte=
r_format, man-&gt;persist.bytes_in + dco_read_bytes);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    snprintf(out, sizeof(out), counter_form=
at, man-&gt;persist.bytes_out + dco_write_bytes);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    snprintf(in, sizeof(in), counter_format, =
bytes_in_total);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 snprintf(out, sizeof(out), counter_format, bytes_out_total);</span><br><sp=
an>     msg(M_CLIENT, &quot;&gt;BYTECOUNT:%s,%s&quot;, in, out);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_bytecoun=
t_output_server(const counter_type *bytes_in_total, const counter_type *byt=
es_out_total,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_bytecount_=
output_server(const counter_type bytes_in_total, const counter_type bytes_o=
ut_total,</span><br><span>                             struct man_def_auth_=
context *mdac)</span><br><span> {</span><br><span>     char in[32];</span><=
br><span>     char out[32];</span><br><span>     /* do in a roundabout way =
to work around possible mingw or mingw-glibc bug */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    snprintf(in, sizeof(in), counter_format=
, *bytes_in_total);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  snprintf(out, sizeof(out), counter_format, *bytes_out_total);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(in, sizeof(in), co=
unter_format, bytes_in_total);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    snprintf(out, sizeof(out), counter_format, bytes_out_total);=
</span><br><span>     msg(M_CLIENT, &quot;&gt;BYTECOUNT_CLI:%lu,%s,%s&quot;=
, mdac-&gt;cid, in, out);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    mdac-&gt;bytecount_last_update =3D now;</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br><span>@@ -4065,42 +4064,82=
 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-management_check_bytecount(struct =
context *c, struct management *man, struct timeval *timeval)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+management_check_bytecount_client(=
struct context *c, struct management *man, struct timeval *timeval)</span><=
br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
man-&gt;persist.callback.flags &amp; MCF_SERVER)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     if (event_timeout_trigger(&amp;man-&gt;connection.byteco=
unt_update_interval, timeval, ETT_DEFAULT))</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        counter_type dco_read_=
bytes =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
ounter_type dco_write_bytes =3D 0;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span>         if (dco_enabled(&amp;c-&gt;options))=
</span><br><span>         {</span><br><span>             if (dco_get_peer_s=
tats(c, true) &lt; 0)</span><br><span>             {</span><br><span>      =
           return;</span><br><span>             }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            dco_read_bytes =3D c-&gt;c2.dco_read_bytes;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            dco_write_bytes =3D c-=
&gt;c2.dco_write_bytes;</span><br><span>         }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!(man-&gt;persis=
t.callback.flags &amp; MCF_SERVER))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            man_bytecount_output_client(man, dco_read_bytes, dco_write_by=
tes);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        man_bytecount_outp=
ut_client(c-&gt;c2.dco_read_bytes + man-&gt;persist.bytes_in + c-&gt;c2.lin=
k_read_bytes,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                              c-&gt;c2.dco_write_bytes + man-&gt;persist.by=
tes_out + c-&gt;c2.link_write_bytes);</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/* DCO resets stats on reconnect. Since client expects stats</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * to be preserved across reconnect=
s, we need to save DCO</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_c=
heck_bytecount_server(struct multi_context *multi)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!(management-&gt;persist.callback.flags &amp; MCF_SERV=
ER))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct timeval null;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    CLEAR(null);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (event_timeout_trigger(&amp;management-&gt;connection.byt=
ecount_update_interval, &amp;null, ETT_DEFAULT))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* fetch counters from dco */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (dco_enabled(&amp;multi-&gt;to=
p.options))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (dc=
o_get_peer_stats_multi(&amp;multi-&gt;top.c1.tuntap-&gt;dco, true) &lt; 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                return;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /* iterate over peers and report counters for eac=
h connected peer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        struct hash_iterator hi;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        struct hash_element *he;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        hash_iterator_init(multi-&gt;hash, &amp;h=
i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        while ((=
he =3D hash_iterator_next(&amp;hi)))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            struct multi_instance *mi =3D (struct multi_instance *)h=
e-&gt;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     struct context_2 *c2 =3D &amp;mi-&gt;context.c2;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if ((c2-&gt;mda_context.flags &amp; (DAF_CONNECT=
ION_ESTABLISHED | DAF_CONNECTION_CLOSED)) =3D=3D DAF_CONNECTION_ESTABLISHED=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                man_byte=
count_output_server(c2-&gt;dco_read_bytes + c2-&gt;link_read_bytes, c2-&gt;=
dco_write_bytes + c2-&gt;link_write_bytes, &amp;c2-&gt;mda_context);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        hash_iterator_free(&amp;hi);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* context_2 stats are reset on reconnect. Since client expects stats</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to be preserved across=
 reconnects, we need to save context_2</span><br><span>  * stats before tea=
ring the tunnel down.</span><br><span>  */</span><br><span> void</span><br>=
<span> man_persist_client_stats(struct management *man, struct context *c)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /* no need to raise SIGUSR1 since we are already closing the instance */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    man-&gt;persist.b=
ytes_in +=3D c-&gt;c2.link_read_bytes;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    man-&gt;persist.bytes_out +=3D c-&gt;c2.link_write_b=
ytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* no need to raise SIGUSR1 o=
n error since we are already closing the instance */</span><br><span>     i=
f (dco_enabled(&amp;c-&gt;options) &amp;&amp; (dco_get_peer_stats(c, false)=
 =3D=3D 0))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        management_bytes_client(man, c-&gt;c2.dco_read_bytes, =
c-&gt;c2.dco_write_bytes);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        man-&gt;persist.bytes_in +=3D c-&gt;c2.dco_read_bytes;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        man-&gt;persist.b=
ytes_out +=3D c-&gt;c2.dco_write_bytes;</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span>diff --git a/src/openvpn/manage.h =
b/src/openvpn/manage.h</span><br><span>index e9e1f95..0b064cf 100644</span>=
<br><span>--- a/src/openvpn/manage.h</span><br><span>+++ b/src/openvpn/mana=
ge.h</span><br><span>@@ -70,8 +70,6 @@</span><br><span>     unsigned int fl=
ags;</span><br><span> </span><br><span>     unsigned int mda_key_id_counter=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    time_t bytecount_last_update;</span><=
br><span> };</span><br><span> </span><br><span> /*</span><br><span>@@ -492,=
34 +490,9 @@</span><br><span>  * These functions drive the bytecount in/out=
 counters.</span><br><span>  */</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void management_check_bytecount(struct context =
*c, struct management *man, struct timeval *timeval);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void management_check_bytecount_client(st=
ruct context *c, struct management *man, struct timeval *timeval);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inlin=
e void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_byte=
s_client(struct management *man, const int size_in, const int size_out)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!(man-&gt;persist.callback.flags &a=
mp; MCF_SERVER))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        man-&gt;persi=
st.bytes_in +=3D size_in;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        man-&gt;persist.bytes_out +=3D size_out;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void man_bytecount_output=
_server(const counter_type *bytes_in_total,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                 const counter_type *=
bytes_out_total,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                            struct man_def_auth_context *mdac);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-management_bytes_server(struct management *man, const cou=
nter_type *bytes_in_total,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                        const counter_type *bytes_out_total, struct ma=
n_def_auth_context *mdac)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (man-&gt;=
connection.bytecount_update_seconds &gt; 0</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        &amp;&amp; now &gt;=3D mdac-&gt;bytecount_last=
_update + man-&gt;connection.bytecount_update_seconds</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; (mdac-&gt;flags &amp; (D=
AF_CONNECTION_ESTABLISHED | DAF_CONNECTION_CLOSED))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-               =3D=3D DAF_CONNECTION_ESTABL=
ISHED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        man_bytecount_output_se=
rver(bytes_in_total, bytes_out_total, mdac);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void manage=
ment_check_bytecount_server(struct multi_context *multi);</span><br><span> =
</span><br><span> void man_persist_client_stats(struct management *man, str=
uct context *c);</span><br><span> </span><br><span>diff --git a/src/openvpn=
/multi.c b/src/openvpn/multi.c</span><br><span>index e1ce32a..f1abdbe 10064=
4</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openv=
pn/multi.c</span><br><span>@@ -3812,6 +3812,13 @@</span><br><span>     {</s=
pan><br><span>         check_stale_routes(m);</span><br><span>     }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (management)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        management_check_bytecount_server(m);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_MANAGEMENT */</span><br>=
<span> }</span><br><span> </span><br><span> static void</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1162?usp=3Demail">change 1162</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1162?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I43a93f0d84f01fd808a64115e1b=
8c3b806706491 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1162 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--nmloyTp2OTM=--

