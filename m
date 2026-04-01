From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 1 Apr 2026 11:12:32 +0000
In-Reply-To: <gerrit.1771008284000.I701452496bb47c58b9728b08104dd5cb7823a94f@...2715...>
References: <gerrit.1771008284000.I701452496bb47c58b9728b08104dd5cb7823a94f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <22fe75d51dc2d7a71329bee9c337c3fe48dc42d2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X5drm9fmOWc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: Change all
 users of positive_atoll to uint64_t
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

--X5drm9fmOWc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1526?usp=3Demail

to look at the new patch set (#9).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: options: Change all users of positive_atoll to uint64_t
......................................................................

options: Change all users of positive_atoll to uint64_t

Generally this makes more sense for the usages. There
is really no reason to make them signed just to have
-1 as the default value. 0 works fine for that.

Avoids some existing sign-compare warnings.

Change-Id: I701452496bb47c58b9728b08104dd5cb7823a94f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/openvpn.h
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/options_util.c
M src/openvpn/options_util.h
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
M tests/unit_tests/openvpn/test_misc.c
10 files changed, 23 insertions(+), 32 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/1526/9

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 27cfd36..e3ba0ed 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -482,11 +482,11 @@
     if (dco_enabled(&c->options) && dco_get_peer_stats(c, true) =3D=3D 0)
     {
 #ifdef TARGET_FREEBSD
-        int64_t tot_bytes =3D c->c2.dco_read_bytes + c->c2.dco_write_bytes;
+        counter_type tot_bytes =3D c->c2.dco_read_bytes + c->c2.dco_write_=
bytes;
 #else
-        int64_t tot_bytes =3D c->c2.tun_read_bytes + c->c2.tun_write_bytes;
+        counter_type tot_bytes =3D c->c2.tun_read_bytes + c->c2.tun_write_=
bytes;
 #endif
-        int64_t new_bytes =3D tot_bytes - c->c2.inactivity_bytes;
+        counter_type new_bytes =3D tot_bytes - c->c2.inactivity_bytes;

         if (new_bytes > c->options.inactivity_minimum_bytes)
         {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 0d3e492..bedad67 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -347,7 +347,7 @@
 }

 static inline void
-register_activity(struct context *c, const int64_t size)
+register_activity(struct context *c, const uint64_t size)
 {
     if (c->options.inactivity_timeout)
     {
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index fa00822..864c160 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -285,7 +285,7 @@

     /* --inactive */
     struct event_timeout inactivity_interval;
-    int64_t inactivity_bytes;
+    counter_type inactivity_bytes;

     struct event_timeout session_interval;

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 713dcf4..0d32b23 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -864,9 +864,9 @@
     o->replay_time =3D DEFAULT_TIME_BACKTRACK;
     o->key_direction =3D KEY_DIRECTION_BIDIRECTIONAL;
     o->tls_timeout =3D 2;
-    o->renegotiate_bytes =3D -1;
+    o->renegotiate_bytes =3D 0;
     o->renegotiate_seconds =3D 3600;
-    o->renegotiate_seconds_min =3D -1;
+    o->renegotiate_seconds_min =3D 0;
     o->handshake_window =3D 60;
     o->transition_window =3D 3600;
     o->tls_cert_profile =3D NULL;
@@ -955,7 +955,7 @@
     SHOW_PARM(var, o->var##_inline ? "[INLINE]" : (o->var ? o->var : "[UND=
EF]"), "'%s'")
 #define SHOW_INT(var)      SHOW_PARM(var, o->var, "%d")
 #define SHOW_UINT(var)     SHOW_PARM(var, o->var, "%u")
-#define SHOW_INT64(var)    SHOW_PARM(var, o->var, "%" PRIi64)
+#define SHOW_UINT64(var)   SHOW_PARM(var, o->var, "%" PRIu64)
 #define SHOW_UNSIGNED(var) SHOW_PARM(var, o->var, "0x%08x")
 #define SHOW_BOOL(var)     SHOW_PARM(var, (o->var ? "ENABLED" : "DISABLED"=
), "%s");

@@ -1715,7 +1715,7 @@
     SHOW_INT(keepalive_timeout);
     SHOW_INT(inactivity_timeout);
     SHOW_INT(session_timeout);
-    SHOW_INT64(inactivity_minimum_bytes);
+    SHOW_UINT64(inactivity_minimum_bytes);
     SHOW_INT(ping_send_timeout);
     SHOW_INT(ping_rec_timeout);
     SHOW_INT(ping_rec_timeout_action);
@@ -1892,8 +1892,8 @@

     SHOW_INT(tls_timeout);

-    SHOW_INT64(renegotiate_bytes);
-    SHOW_INT64(renegotiate_packets);
+    SHOW_UINT64(renegotiate_bytes);
+    SHOW_UINT64(renegotiate_packets);
     SHOW_INT(renegotiate_seconds);

     SHOW_INT(handshake_window);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 422820c..02b1e98 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -341,7 +341,7 @@
     int keepalive_timeout;

     int inactivity_timeout; /* --inactive */
-    int64_t inactivity_minimum_bytes;
+    uint64_t inactivity_minimum_bytes;

     int session_timeout;    /* Force-kill session after n seconds */

@@ -639,8 +639,8 @@
     int tls_timeout;

     /* Data channel key renegotiation parameters */
-    int64_t renegotiate_bytes;
-    int64_t renegotiate_packets;
+    uint64_t renegotiate_bytes;
+    uint64_t renegotiate_packets;
     int renegotiate_seconds;
     int renegotiate_seconds_min;

diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 47fe0bc..6ea0c7b 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -132,7 +132,7 @@
 }

 bool
-positive_atoll(const char *str, int64_t *value, const char *name, msglvl_t=
 msglevel)
+positive_atoll(const char *str, uint64_t *value, const char *name, msglvl_=
t msglevel)
 {
     char *endptr;
     long long ll =3D strtoll(str, &endptr, 10);
@@ -143,7 +143,7 @@
         return false;
     }

-    *value =3D (int64_t)ll;
+    *value =3D (uint64_t)ll;
     return true;
 }

diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 1d4ea9b..1b007fe 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -48,7 +48,7 @@
  *
  * @return \c true if the integer has been parsed and stored in value, \c =
false otherwise
  */
-bool positive_atoll(const char *str, int64_t *value, const char *name, msg=
lvl_t msglevel);
+bool positive_atoll(const char *str, uint64_t *value, const char *name, ms=
glvl_t msglevel);

 /**
  * Converts a str to an integer if the string can be represented as an
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 576157d..cf8d644 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -103,11 +103,11 @@
  *                      May *not* be NULL.
  */
 static void
-tls_limit_reneg_bytes(const char *ciphername, int64_t *reneg_bytes)
+tls_limit_reneg_bytes(const char *ciphername, uint64_t *reneg_bytes)
 {
     if (cipher_kt_insecure(ciphername))
     {
-        if (*reneg_bytes =3D=3D -1) /* Not user-specified */
+        if (*reneg_bytes =3D=3D 0) /* Not user-specified */
         {
             msg(M_WARN, "WARNING: cipher with small block size in use, "
                         "reducing reneg-bytes to 64MB to mitigate SWEET32 =
attacks.");
@@ -2916,11 +2916,6 @@
     return true;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /**
  * Determines if a renegotiation should be triggerred based on the various
  * factors that can trigger one
@@ -2942,7 +2937,7 @@
     }

     /* Packet limit */
-    if (session->opt->renegotiate_packets && ks->n_packets >=3D session->o=
pt->renegotiate_packets)
+    if (session->opt->renegotiate_packets > 0 && ks->n_packets >=3D sessio=
n->opt->renegotiate_packets)
     {
         return true;
     }
@@ -3000,10 +2995,6 @@
     return false;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * This is the primary routine for processing TLS stuff inside the
  * the main event loop.  When this routine exits
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 6f310a5..7b35ef3 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -342,8 +342,8 @@
     int transition_window;
     int handshake_window;
     interval_t packet_timeout;
-    int64_t renegotiate_bytes;
-    int64_t renegotiate_packets;
+    uint64_t renegotiate_bytes;
+    uint64_t renegotiate_packets;
     /** limit for AEAD cipher when not running in epoch data key mode,
      *  this is the sum of packets + blocks that are allowed to be used */
     uint64_t aead_usage_limit;
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index a9ae33f..19303a9 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -359,7 +359,7 @@
     assert_true(atoi_constrained("-1194", &parameter, "test", INT_MIN, INT=
_MAX, msglevel));
     assert_int_equal(parameter, -1194);

-    int64_t parameter64 =3D 0;
+    uint64_t parameter64 =3D 0;
     assert_true(positive_atoll("1234", &parameter64, "test", msglevel));
     assert_int_equal(parameter64, 1234);
     assert_true(positive_atoll("0", &parameter64, "test", msglevel));

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1526?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I701452496bb47c58b9728b08104dd5cb7823a94f
Gerrit-Change-Number: 1526
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--X5drm9fmOWc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #9</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1526?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">options: Change all users of positi=
ve_atoll to uint64_t<br><br>Generally this makes more sense for the usages.=
 There<br>is really no reason to make them signed just to have<br>-1 as the=
 default value. 0 works fine for that.<br><br>Avoids some existing sign-com=
pare warnings.<br><br>Change-Id: I701452496bb47c58b9728b08104dd5cb7823a94f<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M sr=
c/openvpn/forward.c<br>M src/openvpn/forward.h<br>M src/openvpn/openvpn.h<b=
r>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/optio=
ns_util.c<br>M src/openvpn/options_util.h<br>M src/openvpn/ssl.c<br>M src/o=
penvpn/ssl_common.h<br>M tests/unit_tests/openvpn/test_misc.c<br>10 files c=
hanged, 23 insertions(+), 32 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/1526/9</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>in=
dex 27cfd36..e3ba0ed 100644</span><br><span>--- a/src/openvpn/forward.c</sp=
an><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -482,11 +482,11=
 @@</span><br><span>     if (dco_enabled(&amp;c-&gt;options) &amp;&amp; dco=
_get_peer_stats(c, true) =3D=3D 0)</span><br><span>     {</span><br><span> =
#ifdef TARGET_FREEBSD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        int64_t tot_bytes =3D c-&gt;c2.dco_read_bytes + c-&gt;c2.dco_write_=
bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        count=
er_type tot_bytes =3D c-&gt;c2.dco_read_bytes + c-&gt;c2.dco_write_bytes;</=
span><br><span> #else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        int64_t tot_bytes =3D c-&gt;c2.tun_read_bytes + c-&gt;c2.tun_write_=
bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        count=
er_type tot_bytes =3D c-&gt;c2.tun_read_bytes + c-&gt;c2.tun_write_bytes;</=
span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        int64_t new_bytes =3D tot_bytes - c-&gt;c2.inactivity_bytes;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        counter_type new_=
bytes =3D tot_bytes - c-&gt;c2.inactivity_bytes;</span><br><span> </span><b=
r><span>         if (new_bytes &gt; c-&gt;options.inactivity_minimum_bytes)=
</span><br><span>         {</span><br><span>diff --git a/src/openvpn/forwar=
d.h b/src/openvpn/forward.h</span><br><span>index 0d3e492..bedad67 100644</=
span><br><span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/openvp=
n/forward.h</span><br><span>@@ -347,7 +347,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> static inline void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-register_activity(struct context *c, const int64_t =
size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+register_activ=
ity(struct context *c, const uint64_t size)</span><br><span> {</span><br><s=
pan>     if (c-&gt;options.inactivity_timeout)</span><br><span>     {</span=
><br><span>diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h</span=
><br><span>index fa00822..864c160 100644</span><br><span>--- a/src/openvpn/=
openvpn.h</span><br><span>+++ b/src/openvpn/openvpn.h</span><br><span>@@ -2=
85,7 +285,7 @@</span><br><span> </span><br><span>     /* --inactive */</spa=
n><br><span>     struct event_timeout inactivity_interval;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int64_t inactivity_bytes;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    counter_type inactivity_=
bytes;</span><br><span> </span><br><span>     struct event_timeout session_=
interval;</span><br><span> </span><br><span>diff --git a/src/openvpn/option=
s.c b/src/openvpn/options.c</span><br><span>index 713dcf4..0d32b23 100644</=
span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvp=
n/options.c</span><br><span>@@ -864,9 +864,9 @@</span><br><span>     o-&gt;=
replay_time =3D DEFAULT_TIME_BACKTRACK;</span><br><span>     o-&gt;key_dire=
ction =3D KEY_DIRECTION_BIDIRECTIONAL;</span><br><span>     o-&gt;tls_timeo=
ut =3D 2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o-&gt;re=
negotiate_bytes =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    o-&gt;renegotiate_bytes =3D 0;</span><br><span>     o-&gt;renegotia=
te_seconds =3D 3600;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   o-&gt;renegotiate_seconds_min =3D -1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    o-&gt;renegotiate_seconds_min =3D 0;</span><br><sp=
an>     o-&gt;handshake_window =3D 60;</span><br><span>     o-&gt;transitio=
n_window =3D 3600;</span><br><span>     o-&gt;tls_cert_profile =3D NULL;</s=
pan><br><span>@@ -955,7 +955,7 @@</span><br><span>     SHOW_PARM(var, o-&gt=
;var##_inline ? &quot;[INLINE]&quot; : (o-&gt;var ? o-&gt;var : &quot;[UNDE=
F]&quot;), &quot;&#39;%s&#39;&quot;)</span><br><span> #define SHOW_INT(var)=
      SHOW_PARM(var, o-&gt;var, &quot;%d&quot;)</span><br><span> #define SH=
OW_UINT(var)     SHOW_PARM(var, o-&gt;var, &quot;%u&quot;)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define SHOW_INT64(var)    SHOW_PARM(v=
ar, o-&gt;var, &quot;%&quot; PRIi64)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define SHOW_UINT64(var)   SHOW_PARM(var, o-&gt;var, &quot=
;%&quot; PRIu64)</span><br><span> #define SHOW_UNSIGNED(var) SHOW_PARM(var,=
 o-&gt;var, &quot;0x%08x&quot;)</span><br><span> #define SHOW_BOOL(var)    =
 SHOW_PARM(var, (o-&gt;var ? &quot;ENABLED&quot; : &quot;DISABLED&quot;), &=
quot;%s&quot;);</span><br><span> </span><br><span>@@ -1715,7 +1715,7 @@</sp=
an><br><span>     SHOW_INT(keepalive_timeout);</span><br><span>     SHOW_IN=
T(inactivity_timeout);</span><br><span>     SHOW_INT(session_timeout);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT64(inactivity_=
minimum_bytes);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
SHOW_UINT64(inactivity_minimum_bytes);</span><br><span>     SHOW_INT(ping_s=
end_timeout);</span><br><span>     SHOW_INT(ping_rec_timeout);</span><br><s=
pan>     SHOW_INT(ping_rec_timeout_action);</span><br><span>@@ -1892,8 +189=
2,8 @@</span><br><span> </span><br><span>     SHOW_INT(tls_timeout);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_I=
NT64(renegotiate_bytes);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    SHOW_INT64(renegotiate_packets);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    SHOW_UINT64(renegotiate_bytes);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SHOW_UINT64(renegotiate_packets);</=
span><br><span>     SHOW_INT(renegotiate_seconds);</span><br><span> </span>=
<br><span>     SHOW_INT(handshake_window);</span><br><span>diff --git a/src=
/openvpn/options.h b/src/openvpn/options.h</span><br><span>index 422820c..0=
2b1e98 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+=
++ b/src/openvpn/options.h</span><br><span>@@ -341,7 +341,7 @@</span><br><s=
pan>     int keepalive_timeout;</span><br><span> </span><br><span>     int =
inactivity_timeout; /* --inactive */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int64_t inactivity_minimum_bytes;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint64_t inactivity_minimum_bytes;</s=
pan><br><span> </span><br><span>     int session_timeout;    /* Force-kill =
session after n seconds */</span><br><span> </span><br><span>@@ -639,8 +639=
,8 @@</span><br><span>     int tls_timeout;</span><br><span> </span><br><sp=
an>     /* Data channel key renegotiation parameters */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int64_t renegotiate_bytes;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int64_t renegotiate_packets;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t renego=
tiate_bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t64_t renegotiate_packets;</span><br><span>     int renegotiate_seconds;</s=
pan><br><span>     int renegotiate_seconds_min;</span><br><span> </span><br=
><span>diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c=
</span><br><span>index 47fe0bc..6ea0c7b 100644</span><br><span>--- a/src/op=
envpn/options_util.c</span><br><span>+++ b/src/openvpn/options_util.c</span=
><br><span>@@ -132,7 +132,7 @@</span><br><span> }</span><br><span> </span><=
br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-positiv=
e_atoll(const char *str, int64_t *value, const char *name, msglvl_t msgleve=
l)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+positive_atoll(co=
nst char *str, uint64_t *value, const char *name, msglvl_t msglevel)</span>=
<br><span> {</span><br><span>     char *endptr;</span><br><span>     long l=
ong ll =3D strtoll(str, &amp;endptr, 10);</span><br><span>@@ -143,7 +143,7 =
@@</span><br><span>         return false;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *value =3D=
 (int64_t)ll;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *v=
alue =3D (uint64_t)ll;</span><br><span>     return true;</span><br><span> }=
</span><br><span> </span><br><span>diff --git a/src/openvpn/options_util.h =
b/src/openvpn/options_util.h</span><br><span>index 1d4ea9b..1b007fe 100644<=
/span><br><span>--- a/src/openvpn/options_util.h</span><br><span>+++ b/src/=
openvpn/options_util.h</span><br><span>@@ -48,7 +48,7 @@</span><br><span>  =
*</span><br><span>  * @return \c true if the integer has been parsed and st=
ored in value, \c false otherwise</span><br><span>  */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-bool positive_atoll(const char *str, int64=
_t *value, const char *name, msglvl_t msglevel);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool positive_atoll(const char *str, uint64_t =
*value, const char *name, msglvl_t msglevel);</span><br><span> </span><br><=
span> /**</span><br><span>  * Converts a str to an integer if the string ca=
n be represented as an</span><br><span>diff --git a/src/openvpn/ssl.c b/src=
/openvpn/ssl.c</span><br><span>index 576157d..cf8d644 100644</span><br><spa=
n>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br=
><span>@@ -103,11 +103,11 @@</span><br><span>  *                      May *=
not* be NULL.</span><br><span>  */</span><br><span> static void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-tls_limit_reneg_bytes(const char =
*ciphername, int64_t *reneg_bytes)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+tls_limit_reneg_bytes(const char *ciphername, uint64_t *rene=
g_bytes)</span><br><span> {</span><br><span>     if (cipher_kt_insecure(cip=
hername))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (*reneg_bytes =3D=3D -1) /* Not user-specified */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (*reneg_byte=
s =3D=3D 0) /* Not user-specified */</span><br><span>         {</span><br><=
span>             msg(M_WARN, &quot;WARNING: cipher with small block size i=
n use, &quot;</span><br><span>                         &quot;reducing reneg=
-bytes to 64MB to mitigate SWEET32 attacks.&quot;);</span><br><span>@@ -291=
6,11 +2916,6 @@</span><br><span>     return true;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><spa=
n>  * Determines if a renegotiation should be triggerred based on the vario=
us</span><br><span>  * factors that can trigger one</span><br><span>@@ -294=
2,7 +2937,7 @@</span><br><span>     }</span><br><span> </span><br><span>   =
  /* Packet limit */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (session-&gt;opt-&gt;renegotiate_packets &amp;&amp; ks-&gt;n_packets =
&gt;=3D session-&gt;opt-&gt;renegotiate_packets)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt;renegotiate_packet=
s &gt; 0 &amp;&amp; ks-&gt;n_packets &gt;=3D session-&gt;opt-&gt;renegotiat=
e_packets)</span><br><span>     {</span><br><span>         return true;</sp=
an><br><span>     }</span><br><span>@@ -3000,10 +2995,6 @@</span><br><span>=
     return false;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><b=
r><span>  * This is the primary routine for processing TLS stuff inside the=
</span><br><span>  * the main event loop.  When this routine exits</span><b=
r><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h</s=
pan><br><span>index 6f310a5..7b35ef3 100644</span><br><span>--- a/src/openv=
pn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</span><br><s=
pan>@@ -342,8 +342,8 @@</span><br><span>     int transition_window;</span><=
br><span>     int handshake_window;</span><br><span>     interval_t packet_=
timeout;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int64_t r=
enegotiate_bytes;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int64_t renegotiate_packets;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint64_t renegotiate_bytes;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint64_t renegotiate_packets;</span><br><span>    =
 /** limit for AEAD cipher when not running in epoch data key mode,</span><=
br><span>      *  this is the sum of packets + blocks that are allowed to b=
e used */</span><br><span>     uint64_t aead_usage_limit;</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn=
/test_misc.c</span><br><span>index a9ae33f..19303a9 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/test_misc.c</span><br><span>+++ b/tests/unit=
_tests/openvpn/test_misc.c</span><br><span>@@ -359,7 +359,7 @@</span><br><s=
pan>     assert_true(atoi_constrained(&quot;-1194&quot;, &amp;parameter, &q=
uot;test&quot;, INT_MIN, INT_MAX, msglevel));</span><br><span>     assert_i=
nt_equal(parameter, -1194);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int64_t parameter64 =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint64_t parameter64 =3D 0;</span><b=
r><span>     assert_true(positive_atoll(&quot;1234&quot;, &amp;parameter64,=
 &quot;test&quot;, msglevel));</span><br><span>     assert_int_equal(parame=
ter64, 1234);</span><br><span>     assert_true(positive_atoll(&quot;0&quot;=
, &amp;parameter64, &quot;test&quot;, msglevel));</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1526?usp=3Demail">change 1526</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/152=
6?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I701452496bb47c58b9728b08104=
dd5cb7823a94f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1526 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--X5drm9fmOWc=--

