From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 12 Apr 2026 16:06:45 +0000
In-Reply-To: <gerrit.1773241811000.I8d6b7bc1b7744dc6d57aaed3231b8901275752f2@...2715...>
References: <gerrit.1773241811000.I8d6b7bc1b7744dc6d57aaed3231b8901275752f2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <aa77544e79edb899db61d720cad99c3b949514f9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9RM3JUYWrvQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change type of
 max_clients to uint32_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9RM3JUYWrvQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
64?usp=3Demail )

Change subject: Change type of max_clients to uint32_t
......................................................................

Change type of max_clients to uint32_t

peer_id is mostly this already (except in DCO
context for some reason), and max_peerid was
defined as uint32_t as well. So changing max_clients
to uint32_t avoids many -Wsign-compare warnings.

While here fix limit for max_clients in options
parsing. It is not allowed to be MAX_PEER_ID
exactly.

Change-Id: I8d6b7bc1b7744dc6d57aaed3231b8901275752f2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1564
Message-Id: <20260407112434.5588-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
535.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/options.c
M src/openvpn/options.h
8 files changed, 10 insertions(+), 64 deletions(-)




diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index a1e373d..718cd8b 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -559,11 +559,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static void
 dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlis=
t_t *nvl)
 {
@@ -582,10 +577,6 @@
         __func__, peerid, mi->context.c2.dco_read_bytes, mi->context.c2.dc=
o_write_bytes);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 dco_read_and_process(dco_context_t *dco)
 {
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 4c896f6..40746bd 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -859,11 +859,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static int
 ovpn_handle_peer(dco_context_t *dco, struct nlattr *attrs[])
 {
@@ -890,7 +885,7 @@
     if (dco->ifmode =3D=3D OVPN_MODE_P2P)
     {
         c2 =3D &dco->c->c2;
-        if (c2->tls_multi->dco_peer_id !=3D peer_id)
+        if (c2->tls_multi->dco_peer_id !=3D (int)peer_id)
         {
             return NL_SKIP;
         }
@@ -919,10 +914,6 @@
     return NL_OK;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static bool
 ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs[])
 {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index f46c24d..2e26f2a 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -739,11 +739,6 @@
     return 0;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 int
 dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_e=
rr)
 {
@@ -838,9 +833,9 @@
     {
         OVPN_PEER_STATS *stat =3D &peer_stats[i];

-        if (stat->PeerId >=3D dco->c->multi->max_clients)
+        if (stat->PeerId >=3D (int)dco->c->multi->max_clients)
         {
-            msg(M_WARN, "%s: received out of bound peer_id %u (max=3D%u)",=
 __func__, stat->PeerId,
+            msg(M_WARN, "%s: received out of bound peer_id %d (max=3D%u)",=
 __func__, stat->PeerId,
                 dco->c->multi->max_clients);
             continue;
         }
@@ -871,10 +866,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 dco_get_peer_stats_fallback(struct context *c, const bool raise_sigusr1_on=
_err)
 {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index b359750..432c79a 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -180,11 +180,6 @@
     return false;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * Get a client instance based on real address.  If
  * the instance doesn't exist, create it while
@@ -217,7 +212,7 @@
             uint32_t peer_id =3D ((uint32_t)ptr[1] << 16) | ((uint32_t)ptr=
[2] << 8) | ((uint32_t)ptr[3]);
             peer_id_disabled =3D (peer_id =3D=3D MAX_PEER_ID);

-            if (!peer_id_disabled && (peer_id < m->max_clients) && (m->ins=
tances[peer_id]))
+            if (!peer_id_disabled && (peer_id < m->max_clients) && m->inst=
ances[peer_id])
             {
                 /* Floating on TCP will never be possible, so ensure we on=
ly process
                  * UDP clients */
@@ -315,10 +310,6 @@
     return mi;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Send a packet to UDP socket.
  */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c7a91ab..fe210ee 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -695,11 +695,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * Create a client instance object for a newly connected client.
  */
@@ -782,10 +777,6 @@
     return NULL;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Dump tables -- triggered by SIGUSR2.
  * If status file is defined, write to file.
@@ -3261,7 +3252,7 @@
         return;
     }

-    if ((peer_id < m->max_clients) && (m->instances[peer_id]))
+    if (((uint32_t)peer_id < m->max_clients) && m->instances[peer_id])
     {
         struct multi_instance *mi =3D m->instances[peer_id];
         set_prefix(mi);
@@ -4085,18 +4076,13 @@
 #endif /* ifdef ENABLE_MANAGEMENT */
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 void
 multi_assign_peer_id(struct multi_context *m, struct multi_instance *mi)
 {
     /* max_clients must be less then max peer-id value */
     ASSERT(m->max_clients < MAX_PEER_ID);

-    for (int i =3D 0; i < m->max_clients; ++i)
+    for (uint32_t i =3D 0; i < m->max_clients; ++i)
     {
         if (!m->instances[i])
         {
@@ -4117,10 +4103,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  * @brief Determines the earliest wakeup interval based on periodic operat=
ions.
  *
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 935bda1..3ed08d4 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -182,7 +182,7 @@
     struct multi_reap *reaper;
     struct mroute_addr local;
     bool enable_c2c;
-    int max_clients;
+    uint32_t max_clients;
     int tcp_queue_limit;
     int status_file_version;
     int n_clients; /* current number of authenticated clients */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b8d0f5a..70af6d2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1428,7 +1428,7 @@
     SHOW_INT(cf_per);
     SHOW_INT(cf_initial_max);
     SHOW_INT(cf_initial_per);
-    SHOW_INT(max_clients);
+    SHOW_UINT(max_clients);
     SHOW_INT(max_routes_per_client);
     SHOW_STR(auth_user_pass_verify_script);
     SHOW_BOOL(auth_user_pass_verify_script_via_file);
@@ -7378,7 +7378,7 @@
     else if (streq(p[0], "max-clients") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (!atoi_constrained(p[1], &options->max_clients, p[0], 1, MAX_PE=
ER_ID, msglevel))
+        if (!atoi_constrained(p[1], (int *)&options->max_clients, p[0], 1,=
 MAX_PEER_ID - 1, msglevel))
         {
             goto err;
         }
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 422820c..a111cf8 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -530,7 +530,7 @@
     int cf_initial_max;
     int cf_initial_per;

-    int max_clients;
+    uint32_t max_clients;
     int max_routes_per_client;
     int stale_routes_check_interval;
     int stale_routes_ageing_time;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1564?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8d6b7bc1b7744dc6d57aaed3231b8901275752f2
Gerrit-Change-Number: 1564
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9RM3JUYWrvQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1564?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Change type of max_clients to uint32_t<br><br>pe=
er_id is mostly this already (except in DCO<br>context for some reason), an=
d max_peerid was<br>defined as uint32_t as well. So changing max_clients<br=
>to uint32_t avoids many -Wsign-compare warnings.<br><br>While here fix lim=
it for max_clients in options<br>parsing. It is not allowed to be MAX_PEER_=
ID<br>exactly.<br><br>Change-Id: I8d6b7bc1b7744dc6d57aaed3231b8901275752f2<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: G=
ert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.n=
et/c/openvpn/+/1564<br>Message-Id: &lt;20260407112434.5588-1-gert@...2132...=
.&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...290...=
net/msg36535.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>---<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/o=
penvpn/dco_win.c<br>M src/openvpn/mudp.c<br>M src/openvpn/multi.c<br>M src/=
openvpn/multi.h<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>8 =
files changed, 10 insertions(+), 64 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span=
><br><span>index a1e373d..718cd8b 100644</span><br><span>--- a/src/openvpn/=
dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><sp=
an>@@ -559,11 +559,6 @@</span><br><span>     return ret;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compar=
e&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void=
</span><br><span> dco_update_peer_stat(struct multi_context *m, uint32_t pe=
erid, const nvlist_t *nvl)</span><br><span> {</span><br><span>@@ -582,10 +5=
77,6 @@</span><br><span>         __func__, peerid, mi-&gt;context.c2.dco_re=
ad_bytes, mi-&gt;context.c2.dco_write_bytes);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> int</span><br><span> dco_read_and_process(dco_context_t *dc=
o)</span><br><span> {</span><br><span>diff --git a/src/openvpn/dco_linux.c =
b/src/openvpn/dco_linux.c</span><br><span>index 4c896f6..40746bd 100644</sp=
an><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvp=
n/dco_linux.c</span><br><span>@@ -859,11 +859,6 @@</span><br><span>     }</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &q=
uot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> static int</span><br><span> ovpn_handle_peer(dco_context_t *dco, stru=
ct nlattr *attrs[])</span><br><span> {</span><br><span>@@ -890,7 +885,7 @@<=
/span><br><span>     if (dco-&gt;ifmode =3D=3D OVPN_MODE_P2P)</span><br><sp=
an>     {</span><br><span>         c2 =3D &amp;dco-&gt;c-&gt;c2;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (c2-&gt;tls_multi-&gt=
;dco_peer_id !=3D peer_id)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (c2-&gt;tls_multi-&gt;dco_peer_id !=3D (int)peer_id)</spa=
n><br><span>         {</span><br><span>             return NL_SKIP;</span><=
br><span>         }</span><br><span>@@ -919,10 +914,6 @@</span><br><span>  =
   return NL_OK;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bool</=
span><br><span> ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs[]=
)</span><br><span> {</span><br><span>diff --git a/src/openvpn/dco_win.c b/s=
rc/openvpn/dco_win.c</span><br><span>index f46c24d..2e26f2a 100644</span><b=
r><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_w=
in.c</span><br><span>@@ -739,11 +739,6 @@</span><br><span>     return 0;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &qu=
ot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> int</span><br><span> dco_get_peer_stats_multi(dco_context_t *dco, cons=
t bool raise_sigusr1_on_err)</span><br><span> {</span><br><span>@@ -838,9 +=
833,9 @@</span><br><span>     {</span><br><span>         OVPN_PEER_STATS *s=
tat =3D &amp;peer_stats[i];</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (stat-&gt;PeerId &gt;=3D dco-&gt;c-&gt;m=
ulti-&gt;max_clients)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (stat-&gt;PeerId &gt;=3D (int)dco-&gt;c-&gt;multi-&gt;max_clie=
nts)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            msg(M_WARN, &quot;%s: received out of bound peer_id %=
u (max=3D%u)&quot;, __func__, stat-&gt;PeerId,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;%s: received out o=
f bound peer_id %d (max=3D%u)&quot;, __func__, stat-&gt;PeerId,</span><br><=
span>                 dco-&gt;c-&gt;multi-&gt;max_clients);</span><br><span=
>             continue;</span><br><span>         }</span><br><span>@@ -871,=
10 +866,6 @@</span><br><span>     return ret;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> int</span><br><span> dco_get_peer_stats_fallback(struct con=
text *c, const bool raise_sigusr1_on_err)</span><br><span> {</span><br><spa=
n>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>inde=
x b359750..432c79a 100644</span><br><span>--- a/src/openvpn/mudp.c</span><b=
r><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -180,11 +180,6 @@</span=
><br><span>     return false;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma =
GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Get a client in=
stance based on real address.  If</span><br><span>  * the instance doesn&#3=
9;t exist, create it while</span><br><span>@@ -217,7 +212,7 @@</span><br><s=
pan>             uint32_t peer_id =3D ((uint32_t)ptr[1] &lt;&lt; 16) | ((ui=
nt32_t)ptr[2] &lt;&lt; 8) | ((uint32_t)ptr[3]);</span><br><span>           =
  peer_id_disabled =3D (peer_id =3D=3D MAX_PEER_ID);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!peer_id_d=
isabled &amp;&amp; (peer_id &lt; m-&gt;max_clients) &amp;&amp; (m-&gt;insta=
nces[peer_id]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (!peer_id_disabled &amp;&amp; (peer_id &lt; m-&gt;max_clients) &=
amp;&amp; m-&gt;instances[peer_id])</span><br><span>             {</span><b=
r><span>                 /* Floating on TCP will never be possible, so ensu=
re we only process</span><br><span>                  * UDP clients */</span=
><br><span>@@ -315,10 +310,6 @@</span><br><span>     return mi;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Send a packet to =
UDP socket.</span><br><span>  */</span><br><span>diff --git a/src/openvpn/m=
ulti.c b/src/openvpn/multi.c</span><br><span>index c7a91ab..fe210ee 100644<=
/span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn=
/multi.c</span><br><span>@@ -695,11 +695,6 @@</span><br><span>     }</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> /*</span><br><span>  * Create a client instance object for a newly connec=
ted client.</span><br><span>  */</span><br><span>@@ -782,10 +777,6 @@</span=
><br><span>     return NULL;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /=
*</span><br><span>  * Dump tables -- triggered by SIGUSR2.</span><br><span>=
  * If status file is defined, write to file.</span><br><span>@@ -3261,7 +3=
252,7 @@</span><br><span>         return;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((peer_=
id &lt; m-&gt;max_clients) &amp;&amp; (m-&gt;instances[peer_id]))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (((uint32_t)peer_id &l=
t; m-&gt;max_clients) &amp;&amp; m-&gt;instances[peer_id])</span><br><span>=
     {</span><br><span>         struct multi_instance *mi =3D m-&gt;instanc=
es[peer_id];</span><br><span>         set_prefix(mi);</span><br><span>@@ -4=
085,18 +4076,13 @@</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &qu=
ot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> void</span><br><span> multi_assign_peer_id(struct multi_context *m, st=
ruct multi_instance *mi)</span><br><span> {</span><br><span>     /* max_cli=
ents must be less then max peer-id value */</span><br><span>     ASSERT(m-&=
gt;max_clients &lt; MAX_PEER_ID);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; m-&gt;max_clie=
nts; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (u=
int32_t i =3D 0; i &lt; m-&gt;max_clients; ++i)</span><br><span>     {</spa=
n><br><span>         if (!m-&gt;instances[i])</span><br><span>         {</s=
pan><br><span>@@ -4117,10 +4103,6 @@</span><br><span>     }</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> /**</span><br><span>  * @brief Determines the=
 earliest wakeup interval based on periodic operations.</span><br><span>  *=
</span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</sp=
an><br><span>index 935bda1..3ed08d4 100644</span><br><span>--- a/src/openvp=
n/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -182=
,7 +182,7 @@</span><br><span>     struct multi_reap *reaper;</span><br><spa=
n>     struct mroute_addr local;</span><br><span>     bool enable_c2c;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int max_clients;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t max_clients;=
</span><br><span>     int tcp_queue_limit;</span><br><span>     int status_=
file_version;</span><br><span>     int n_clients; /* current number of auth=
enticated clients */</span><br><span>diff --git a/src/openvpn/options.c b/s=
rc/openvpn/options.c</span><br><span>index b8d0f5a..70af6d2 100644</span><b=
r><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/optio=
ns.c</span><br><span>@@ -1428,7 +1428,7 @@</span><br><span>     SHOW_INT(cf=
_per);</span><br><span>     SHOW_INT(cf_initial_max);</span><br><span>     =
SHOW_INT(cf_initial_per);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    SHOW_INT(max_clients);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    SHOW_UINT(max_clients);</span><br><span>     SHOW_INT(max_ro=
utes_per_client);</span><br><span>     SHOW_STR(auth_user_pass_verify_scrip=
t);</span><br><span>     SHOW_BOOL(auth_user_pass_verify_script_via_file);<=
/span><br><span>@@ -7378,7 +7378,7 @@</span><br><span>     else if (streq(p=
[0], &quot;max-clients&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><=
span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!atoi_constrai=
ned(p[1], &amp;options-&gt;max_clients, p[0], 1, MAX_PEER_ID, msglevel))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_cons=
trained(p[1], (int *)&amp;options-&gt;max_clients, p[0], 1, MAX_PEER_ID - 1=
, msglevel))</span><br><span>         {</span><br><span>             goto e=
rr;</span><br><span>         }</span><br><span>diff --git a/src/openvpn/opt=
ions.h b/src/openvpn/options.h</span><br><span>index 422820c..a111cf8 10064=
4</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/ope=
nvpn/options.h</span><br><span>@@ -530,7 +530,7 @@</span><br><span>     int=
 cf_initial_max;</span><br><span>     int cf_initial_per;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int max_clients;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t max_cli=
ents;</span><br><span>     int max_routes_per_client;</span><br><span>     =
int stale_routes_check_interval;</span><br><span>     int stale_routes_agei=
ng_time;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1564?usp=3Demail">change 1564</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1564?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8d6b7bc1b7744dc6d57aaed3231=
b8901275752f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1564 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--9RM3JUYWrvQ=--

