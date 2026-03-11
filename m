From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 11 Mar 2026 15:10:13 +0000
References: <gerrit.1773241811000.I8d6b7bc1b7744dc6d57aaed3231b8901275752f2@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c382edecf4b03172ee4ba389c9cdfbd60c0cab5e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sN0+OhoePuA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sN0+OhoePuA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1564?usp=3Demail

to review the following change.


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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1564/1

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
index b92fa43..37171c5 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -858,11 +858,6 @@
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
@@ -889,7 +884,7 @@
     if (dco->ifmode =3D=3D OVPN_MODE_P2P)
     {
         c2 =3D &dco->c->c2;
-        if (c2->tls_multi->dco_peer_id !=3D peer_id)
+        if (c2->tls_multi->dco_peer_id !=3D (int)peer_id)
         {
             return NL_SKIP;
         }
@@ -918,10 +913,6 @@
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
=20
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
=20
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
index c03e821..f825bf8 100644
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
=20
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
index 17d850b..e0108ad 100644
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
index 8daec42..861e194 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1431,7 +1431,7 @@
     SHOW_INT(cf_per);
     SHOW_INT(cf_initial_max);
     SHOW_INT(cf_initial_per);
-    SHOW_INT(max_clients);
+    SHOW_UINT(max_clients);
     SHOW_INT(max_routes_per_client);
     SHOW_STR(auth_user_pass_verify_script);
     SHOW_BOOL(auth_user_pass_verify_script_via_file);
@@ -7354,7 +7354,7 @@
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
index 3d8b505..a956a96 100644
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8d6b7bc1b7744dc6d57aaed3231b8901275752f2
Gerrit-Change-Number: 1564
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--sN0+OhoePuA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1564?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Change type of max_clients to uint32_t<br><=
br>peer_id is mostly this already (except in DCO<br>context for some reason=
), and max_peerid was<br>defined as uint32_t as well. So changing max_clien=
ts<br>to uint32_t avoids many -Wsign-compare warnings.<br><br>While here fi=
x limit for max_clients in options<br>parsing. It is not allowed to be MAX_=
PEER_ID<br>exactly.<br><br>Change-Id: I8d6b7bc1b7744dc6d57aaed3231b89012757=
52f2<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br=
>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/=
dco_win.c<br>M src/openvpn/mudp.c<br>M src/openvpn/multi.c<br>M src/openvpn=
/multi.h<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>8 files c=
hanged, 10 insertions(+), 64 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1564/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br>=
<span>index a1e373d..718cd8b 100644</span><br><span>--- a/src/openvpn/dco_f=
reebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@=
 -559,11 +559,6 @@</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</spa=
n><br><span> dco_update_peer_stat(struct multi_context *m, uint32_t peerid,=
 const nvlist_t *nvl)</span><br><span> {</span><br><span>@@ -582,10 +577,6 =
@@</span><br><span>         __func__, peerid, mi-&gt;context.c2.dco_read_by=
tes, mi-&gt;context.c2.dco_write_bytes);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> int</span><br><span> dco_read_and_process(dco_context_t *dco)</s=
pan><br><span> {</span><br><span>diff --git a/src/openvpn/dco_linux.c b/src=
/openvpn/dco_linux.c</span><br><span>index b92fa43..37171c5 100644</span><b=
r><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco=
_linux.c</span><br><span>@@ -858,11 +858,6 @@</span><br><span>     }</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> static int</span><br><span> ovpn_handle_peer(dco_context_t *dco, struct n=
lattr *attrs[])</span><br><span> {</span><br><span>@@ -889,7 +884,7 @@</spa=
n><br><span>     if (dco-&gt;ifmode =3D=3D OVPN_MODE_P2P)</span><br><span> =
    {</span><br><span>         c2 =3D &amp;dco-&gt;c-&gt;c2;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (c2-&gt;tls_multi-&gt;dco=
_peer_id !=3D peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (c2-&gt;tls_multi-&gt;dco_peer_id !=3D (int)peer_id)</span><b=
r><span>         {</span><br><span>             return NL_SKIP;</span><br><=
span>         }</span><br><span>@@ -918,10 +913,6 @@</span><br><span>     r=
eturn NL_OK;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic po=
p</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bool</span=
><br><span> ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs[])</s=
pan><br><span> {</span><br><span>diff --git a/src/openvpn/dco_win.c b/src/o=
penvpn/dco_win.c</span><br><span>index f46c24d..2e26f2a 100644</span><br><s=
pan>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c=
</span><br><span>@@ -739,11 +739,6 @@</span><br><span>     return 0;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> int</span><br><span> dco_get_peer_stats_multi(dco_context_t *dco, const b=
ool raise_sigusr1_on_err)</span><br><span> {</span><br><span>@@ -838,9 +833=
,9 @@</span><br><span>     {</span><br><span>         OVPN_PEER_STATS *stat=
 =3D &amp;peer_stats[i];</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (stat-&gt;PeerId &gt;=3D dco-&gt;c-&gt;mult=
i-&gt;max_clients)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (stat-&gt;PeerId &gt;=3D (int)dco-&gt;c-&gt;multi-&gt;max_clients=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(M_WARN, &quot;%s: received out of bound peer_id %u (=
max=3D%u)&quot;, __func__, stat-&gt;PeerId,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;%s: received out of b=
ound peer_id %d (max=3D%u)&quot;, __func__, stat-&gt;PeerId,</span><br><spa=
n>                 dco-&gt;c-&gt;multi-&gt;max_clients);</span><br><span>  =
           continue;</span><br><span>         }</span><br><span>@@ -871,10 =
+866,6 @@</span><br><span>     return ret;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> int</span><br><span> dco_get_peer_stats_fallback(struct contex=
t *c, const bool raise_sigusr1_on_err)</span><br><span> {</span><br><span>d=
iff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index b=
359750..432c79a 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><=
span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -180,11 +180,6 @@</span><b=
r><span>     return false;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Get a client inst=
ance based on real address.  If</span><br><span>  * the instance doesn&#39;=
t exist, create it while</span><br><span>@@ -217,7 +212,7 @@</span><br><spa=
n>             uint32_t peer_id =3D ((uint32_t)ptr[1] &lt;&lt; 16) | ((uint=
32_t)ptr[2] &lt;&lt; 8) | ((uint32_t)ptr[3]);</span><br><span>             =
peer_id_disabled =3D (peer_id =3D=3D MAX_PEER_ID);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!peer_id_dis=
abled &amp;&amp; (peer_id &lt; m-&gt;max_clients) &amp;&amp; (m-&gt;instanc=
es[peer_id]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (!peer_id_disabled &amp;&amp; (peer_id &lt; m-&gt;max_clients) &am=
p;&amp; m-&gt;instances[peer_id])</span><br><span>             {</span><br>=
<span>                 /* Floating on TCP will never be possible, so ensure=
 we only process</span><br><span>                  * UDP clients */</span><=
br><span>@@ -315,10 +310,6 @@</span><br><span>     return mi;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> /*</span><br><span>  * Send a packet to UDP=
 socket.</span><br><span>  */</span><br><span>diff --git a/src/openvpn/mult=
i.c b/src/openvpn/multi.c</span><br><span>index c03e821..f825bf8 100644</sp=
an><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/mu=
lti.c</span><br><span>@@ -695,11 +695,6 @@</span><br><span>     }</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsi=
gn-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*=
</span><br><span>  * Create a client instance object for a newly connected =
client.</span><br><span>  */</span><br><span>@@ -782,10 +777,6 @@</span><br=
><span>     return NULL;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</s=
pan><br><span>  * Dump tables -- triggered by SIGUSR2.</span><br><span>  * =
If status file is defined, write to file.</span><br><span>@@ -3261,7 +3252,=
7 @@</span><br><span>         return;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((peer_id &=
lt; m-&gt;max_clients) &amp;&amp; (m-&gt;instances[peer_id]))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (((uint32_t)peer_id &lt; m=
-&gt;max_clients) &amp;&amp; m-&gt;instances[peer_id])</span><br><span>    =
 {</span><br><span>         struct multi_instance *mi =3D m-&gt;instances[p=
eer_id];</span><br><span>         set_prefix(mi);</span><br><span>@@ -4085,=
18 +4076,13 @@</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> void</span><br><span> multi_assign_peer_id(struct multi_context *m, struc=
t multi_instance *mi)</span><br><span> {</span><br><span>     /* max_client=
s must be less then max peer-id value */</span><br><span>     ASSERT(m-&gt;=
max_clients &lt; MAX_PEER_ID);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; m-&gt;max_clients; =
++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (uint32=
_t i =3D 0; i &lt; m-&gt;max_clients; ++i)</span><br><span>     {</span><br=
><span>         if (!m-&gt;instances[i])</span><br><span>         {</span><=
br><span>@@ -4117,10 +4103,6 @@</span><br><span>     }</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> /**</span><br><span>  * @brief Determines the earl=
iest wakeup interval based on periodic operations.</span><br><span>  *</spa=
n><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><b=
r><span>index 17d850b..e0108ad 100644</span><br><span>--- a/src/openvpn/mul=
ti.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -182,7 +1=
82,7 @@</span><br><span>     struct multi_reap *reaper;</span><br><span>   =
  struct mroute_addr local;</span><br><span>     bool enable_c2c;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int max_clients;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t max_clients;</spa=
n><br><span>     int tcp_queue_limit;</span><br><span>     int status_file_=
version;</span><br><span>     int n_clients; /* current number of authentic=
ated clients */</span><br><span>diff --git a/src/openvpn/options.c b/src/op=
envpn/options.c</span><br><span>index 8daec42..861e194 100644</span><br><sp=
an>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c<=
/span><br><span>@@ -1431,7 +1431,7 @@</span><br><span>     SHOW_INT(cf_per)=
;</span><br><span>     SHOW_INT(cf_initial_max);</span><br><span>     SHOW_=
INT(cf_initial_per);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   SHOW_INT(max_clients);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    SHOW_UINT(max_clients);</span><br><span>     SHOW_INT(max_routes_=
per_client);</span><br><span>     SHOW_STR(auth_user_pass_verify_script);</=
span><br><span>     SHOW_BOOL(auth_user_pass_verify_script_via_file);</span=
><br><span>@@ -7354,7 +7354,7 @@</span><br><span>     else if (streq(p[0], =
&quot;max-clients&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>=
     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (!atoi_constrained(p=
[1], &amp;options-&gt;max_clients, p[0], 1, MAX_PEER_ID, msglevel))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constrain=
ed(p[1], (int *)&amp;options-&gt;max_clients, p[0], 1, MAX_PEER_ID - 1, msg=
level))</span><br><span>         {</span><br><span>             goto err;</=
span><br><span>         }</span><br><span>diff --git a/src/openvpn/options.=
h b/src/openvpn/options.h</span><br><span>index 3d8b505..a956a96 100644</sp=
an><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/=
options.h</span><br><span>@@ -530,7 +530,7 @@</span><br><span>     int cf_i=
nitial_max;</span><br><span>     int cf_initial_per;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int max_clients;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t max_clients;=
</span><br><span>     int max_routes_per_client;</span><br><span>     int s=
tale_routes_check_interval;</span><br><span>     int stale_routes_ageing_ti=
me;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1564?usp=3Demail">change 1564</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1564?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8d6b7bc1b7744dc6d57aaed3231=
b8901275752f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1564 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--sN0+OhoePuA=--

