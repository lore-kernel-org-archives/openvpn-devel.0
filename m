From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Thu, 11 Dec 2025 10:29:20 +0000
References: <gerrit.1765448957000.I7f3b95cacdf359536e827f176f2b81da4b00f22f@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7d15b50287f096a221990e90a4ff36af20c48836-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AHsq87kx5sM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: parse
 stats in PEER_DEL notification if available
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

--AHsq87kx5sM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1434?usp=3Demail

to review the following change.


Change subject: dco_linux: parse stats in PEER_DEL notification if available
......................................................................

dco_linux: parse stats in PEER_DEL notification if available

Upon receiving a PEER_DEL notification, update the peer's statistics
counters if such information is present in the message. This allows
openvpn to avoid issuing a PEER_GET request-reply, eliminating issues
caused by overlapping traffic on the netlink socket when multiple
PEER_DEL notifications are received simultaneously.

Since we cannot assume the kernel module will always send a PEER_DEL
with statistics, introduce a boolean flag to track whether the counters
were already updated or if a PEER_GET request is still required.

Change-Id: I7f3b95cacdf359536e827f176f2b81da4b00f22f
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/dco.c
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_freebsd.h
M src/openvpn/dco_linux.c
M src/openvpn/dco_linux.h
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
M src/openvpn/multi.c
9 files changed, 82 insertions(+), 45 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/1434/1

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7abdad3..3329ff9 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -778,4 +778,10 @@
 #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_=
WIN32) */
 }

+bool
+dco_del_peer_stats_updated(dco_context_t *dco)
+{
+    return dco->dco_del_peer_stats_updated;
+}
+
 #endif /* defined(ENABLE_DCO) */
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index cd6e32a..a81a968 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -242,6 +242,16 @@
 int dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err);

 /**
+ * Check if the peer stats were already updated while parsing a PEER_DEL
+ * notification. This is simply a getter for the internal
+ * dco->dco_del_peer_stats_updated field.
+ *
+ * @param dco       DCO device context
+ * @return          value of dco->dco_del_peer_stats_updated
+ */
+bool dco_del_peer_stats_updated(dco_context_t *dco);
+
+/**
  * Retrieve the list of ciphers supported by the current platform
  *
  * @return                   list of colon-separated ciphers
@@ -377,6 +387,12 @@
     return 0;
 }

+static inline bool
+dco_del_peer_stats_updated(dco_context_t *dco)
+{
+    return false;
+}
+
 static inline const char *
 dco_get_supported_ciphers(void)
 {
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index d1ad092..e47ddd2 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -559,13 +559,13 @@
     return ret;
 }

-static void
+static bool
 dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlis=
t_t *nvl)
 {
     if (peerid >=3D m->max_clients || !m->instances[peerid])
     {
         msg(M_WARN, "dco_update_peer_stat: invalid peer ID %u returned by =
kernel", peerid);
-        return;
+        return false;
     }
=20
     struct multi_instance *mi =3D m->instances[peerid];
@@ -575,6 +575,7 @@

     msg(D_DCO_DEBUG, "%s: peer-id %u, dco_read_bytes: " counter_format " d=
co_write_bytes: " counter_format,
         __func__, peerid, mi->context.c2.dco_read_bytes, mi->context.c2.dc=
o_write_bytes);
+    return true;
 }

 int
@@ -620,6 +621,7 @@
     {
         case OVPN_NOTIF_DEL_PEER:
             dco->dco_del_peer_reason =3D OVPN_DEL_PEER_REASON_EXPIRED;
+            dco->dco_del_peer_stats_updated =3D false;

             if (nvlist_exists_number(nvl, "del_reason"))
             {
@@ -642,12 +644,13 @@

                 if (dco->c->mode =3D=3D CM_TOP)
                 {
-                    dco_update_peer_stat(dco->c->multi, dco->dco_message_p=
eer_id, bytes);
+                    dco->dco_del_peer_stats_updated =3D dco_update_peer_st=
at(dco->c->multi, dco->dco_message_peer_id, bytes);
                 }
                 else
                 {
                     dco->c->c2.dco_read_bytes =3D nvlist_get_number(bytes,=
 "in");
                     dco->c->c2.dco_write_bytes =3D nvlist_get_number(bytes=
, "out");
+                    dco->dco_del_peer_stats_updated =3D true;
                 }
             }

diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index 5e2a552..72056b0 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -60,6 +60,7 @@
     int dco_message_type;
     int dco_message_peer_id;
     int dco_del_peer_reason;
+    bool dco_del_peer_stats_updated;
     struct sockaddr_storage dco_float_peer_ss;

     struct context *c;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 2664029..743eb5c 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -49,10 +49,10 @@
 #include <netlink/genl/family.h>
 #include <netlink/genl/ctrl.h>

-/* When parsing multiple DEL_PEER notifications, openvpn tries to request =
stats
- * for each DEL_PEER message (see setenv_stats). This triggers a GET_PEER
- * request-reply while we are still parsing the rest of the initial
- * notifications, which can lead to NLE_BUSY or even NLE_NOMEM.
+/* When parsing multiple DEL_PEER notifications that do not include stats,
+ * openvpn tries to request them for each DEL_PEER message (see setenv_sta=
ts).
+ * This triggers a GET_PEER request-reply while we are still parsing the r=
est
+ * of the initial notifications, which can lead to NLE_BUSY or even NLE_NO=
MEM.
  *
  * This basic lock ensures we don't bite our own tail by issuing a dco_get=
_peer
  * while still busy receiving and parsing other messages.
@@ -814,9 +814,38 @@
     }
 }

-static void
-dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t i=
d)
+static bool
+dco_update_peer_stat(dco_context_t *dco, struct nlattr *tb[], uint32_t id)
 {
+    struct context_2 *c2;
+
+    if (dco->ifmode =3D=3D OVPN_MODE_P2P)
+    {
+        c2 =3D &dco->c->c2;
+        if (c2->tls_multi->dco_peer_id !=3D id)
+        {
+            return false;
+        }
+    }
+    else
+    {
+        if (id >=3D dco->c->multi->max_clients)
+        {
+            msg(M_WARN, "%s: received out of bound id %u (max=3D%u)", __fu=
nc__, id,
+                dco->c->multi->max_clients);
+            return false;
+        }
+
+        struct multi_instance *mi =3D dco->c->multi->instances[id];
+        if (!mi)
+        {
+            msg(M_WARN | M_NOIPREFIX, "%s: received data for a non-existin=
g peer %u", __func__, id);
+            return false;
+        }
+
+        c2 =3D &mi->context.c2;
+    }
+
     if (tb[OVPN_A_PEER_LINK_RX_BYTES])
     {
         c2->dco_read_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_RX_BY=
TES]);
@@ -824,7 +853,8 @@
     }
     else
     {
-        msg(M_WARN, "%s: no link RX bytes provided in reply for peer %u", =
__func__, id);
+        msg(M_WARN, "%s: no link RX bytes provided for peer %u", __func__,=
 id);
+        return false;
     }

     if (tb[OVPN_A_PEER_LINK_TX_BYTES])
@@ -834,7 +864,8 @@
     }
     else
     {
-        msg(M_WARN, "%s: no link TX bytes provided in reply for peer %u", =
__func__, id);
+        msg(M_WARN, "%s: no link TX bytes provided for peer %u", __func__,=
 id);
+        return false;
     }

     if (tb[OVPN_A_PEER_VPN_RX_BYTES])
@@ -844,7 +875,8 @@
     }
     else
     {
-        msg(M_WARN, "%s: no VPN RX bytes provided in reply for peer %u", _=
_func__, id);
+        msg(M_WARN, "%s: no VPN RX bytes provided for peer %u", __func__, =
id);
+        return false;
     }

     if (tb[OVPN_A_PEER_VPN_TX_BYTES])
@@ -854,8 +886,11 @@
     }
     else
     {
-        msg(M_WARN, "%s: no VPN TX bytes provided in reply for peer %u", _=
_func__, id);
+        msg(M_WARN, "%s: no VPN TX bytes provided for peer %u", __func__, =
id);
+        return false;
     }
+
+    return true;
 }

 static int
@@ -877,40 +912,10 @@
     }

     uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
-    struct context_2 *c2;

     msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: parsing message for peer %u...", _=
_func__, peer_id);

-    if (dco->ifmode =3D=3D OVPN_MODE_P2P)
-    {
-        c2 =3D &dco->c->c2;
-        if (c2->tls_multi->dco_peer_id !=3D peer_id)
-        {
-            return NL_SKIP;
-        }
-    }
-    else
-    {
-        if (peer_id >=3D dco->c->multi->max_clients)
-        {
-            msg(M_WARN, "%s: received out of bound peer_id %u (max=3D%u)",=
 __func__, peer_id,
-                dco->c->multi->max_clients);
-            return NL_SKIP;
-        }
-
-        struct multi_instance *mi =3D dco->c->multi->instances[peer_id];
-        if (!mi)
-        {
-            msg(M_WARN | M_NOIPREFIX, "%s: received data for a non-existin=
g peer %u", __func__, peer_id);
-            return NL_SKIP;
-        }
-
-        c2 =3D &mi->context.c2;
-    }
-
-    dco_update_peer_stat(c2, tb_peer, peer_id);
-
-    return NL_OK;
+    return dco_update_peer_stat(dco, tb_peer, peer_id) ? NL_OK : NL_SKIP;
 }

 static bool
@@ -976,6 +981,9 @@
     dco->dco_del_peer_reason =3D reason;
     dco->dco_message_type =3D OVPN_CMD_PEER_DEL_NTF;

+    /* parse stats if available */
+    dco->dco_del_peer_stats_updated =3D dco_update_peer_stat(dco, dp_attrs=
, peerid);
+
     return NL_OK;
 }

diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index efd5b27..e275061 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -80,6 +80,7 @@
     int dco_message_peer_id;
     int dco_message_key_id;
     int dco_del_peer_reason;
+    bool dco_del_peer_stats_updated;
     struct sockaddr_storage dco_float_peer_ss;
 } dco_context_t;

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 94f043f..030d353 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -681,6 +681,7 @@
         dco->dco_message_peer_id =3D dco->notif_buf.PeerId;
         dco->dco_message_type =3D dco->notif_buf.Cmd;
         dco->dco_del_peer_reason =3D dco->notif_buf.DelPeerReason;
+        dco->dco_del_peer_stats_updated =3D false;
         dco->dco_float_peer_ss =3D dco->notif_buf.FloatAddress;
     }
     else
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 02b8389..599f41d 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -53,6 +53,7 @@
     int dco_message_peer_id;
     int dco_message_type;
     int dco_del_peer_reason;
+    bool dco_del_peer_stats_updated;
     struct sockaddr_storage dco_float_peer_ss;

     struct context *c;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 153695c..4c7d3e2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -510,7 +510,7 @@
 static void
 setenv_stats(struct multi_context *m, struct context *c)
 {
-    if (dco_enabled(&m->top.options))
+    if (dco_enabled(&m->top.options) && !dco_del_peer_stats_updated(&m->to=
p.c1.tuntap->dco))
     {
         if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, false) < 0)
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1434?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7f3b95cacdf359536e827f176f2b81da4b00f22f
Gerrit-Change-Number: 1434
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--AHsq87kx5sM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ralf_lici would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1434?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dco_linux: parse stats in PEER_DEL notifica=
tion if available<br><br>Upon receiving a PEER_DEL notification, update the=
 peer&#39;s statistics<br>counters if such information is present in the me=
ssage. This allows<br>openvpn to avoid issuing a PEER_GET request-reply, el=
iminating issues<br>caused by overlapping traffic on the netlink socket whe=
n multiple<br>PEER_DEL notifications are received simultaneously.<br><br>Si=
nce we cannot assume the kernel module will always send a PEER_DEL<br>with =
statistics, introduce a boolean flag to track whether the counters<br>were =
already updated or if a PEER_GET request is still required.<br><br>Change-I=
d: I7f3b95cacdf359536e827f176f2b81da4b00f22f<br>Signed-off-by: Ralf Lici &l=
t;ralf@...2726...&gt;<br>---<br>M src/openvpn/dco.c<br>M src/openvpn/dco.h<=
br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_freebsd.h<br>M src/open=
vpn/dco_linux.c<br>M src/openvpn/dco_linux.h<br>M src/openvpn/dco_win.c<br>=
M src/openvpn/dco_win.h<br>M src/openvpn/multi.c<br>9 files changed, 82 ins=
ertions(+), 45 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/34/1434/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index 7abdad3..3329ff9 1=
00644</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/ope=
nvpn/dco.c</span><br><span>@@ -778,4 +778,10 @@</span><br><span> #endif /* =
if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dco_del_peer_stats_updated(dco_context_t *dco)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return dco-&gt;dco_del_peer_stats_updated;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> #endif /* defined(ENABLE_DCO) */</span=
><br><span>diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h</span><br><sp=
an>index cd6e32a..a81a968 100644</span><br><span>--- a/src/openvpn/dco.h</s=
pan><br><span>+++ b/src/openvpn/dco.h</span><br><span>@@ -242,6 +242,16 @@<=
/span><br><span> int dco_get_peer_stats(struct context *c, const bool raise=
_sigusr1_on_err);</span><br><span> </span><br><span> /**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Check if the peer stats were alread=
y updated while parsing a PEER_DEL</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * notification. This is simply a getter for the internal</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * dco-&gt;dco_del_pee=
r_stats_updated field.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dco =
      DCO device context</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return          value of dco-&gt;dco_del_peer_stats_updated</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool dco_del_peer_stats_updated(dco_conte=
xt_t *dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Ret=
rieve the list of ciphers supported by the current platform</span><br><span=
>  *</span><br><span>  * @return                   list of colon-separated =
ciphers</span><br><span>@@ -377,6 +387,12 @@</span><br><span>     return 0;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+dco_del_peer_stats_updated(dco_context_t *dco)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> static inline const char *</span><br><span> dco_get=
_supported_ciphers(void)</span><br><span> {</span><br><span>diff --git a/sr=
c/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index d=
1ad092..e47ddd2 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</spa=
n><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -559,13 +559=
,13 @@</span><br><span>     return ret;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span>=
 dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlis=
t_t *nvl)</span><br><span> {</span><br><span>     if (peerid &gt;=3D m-&gt;=
max_clients || !m-&gt;instances[peerid])</span><br><span>     {</span><br><=
span>         msg(M_WARN, &quot;dco_update_peer_stat: invalid peer ID %u re=
turned by kernel&quot;, peerid);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        return;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return false;</span><br><span>     }</span><br><span> </span=
><br><span>     struct multi_instance *mi =3D m-&gt;instances[peerid];</spa=
n><br><span>@@ -575,6 +575,7 @@</span><br><span> </span><br><span>     msg(=
D_DCO_DEBUG, &quot;%s: peer-id %u, dco_read_bytes: &quot; counter_format &q=
uot; dco_write_bytes: &quot; counter_format,</span><br><span>         __fun=
c__, peerid, mi-&gt;context.c2.dco_read_bytes, mi-&gt;context.c2.dco_write_=
bytes);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return t=
rue;</span><br><span> }</span><br><span> </span><br><span> int</span><br><s=
pan>@@ -620,6 +621,7 @@</span><br><span>     {</span><br><span>         cas=
e OVPN_NOTIF_DEL_PEER:</span><br><span>             dco-&gt;dco_del_peer_re=
ason =3D OVPN_DEL_PEER_REASON_EXPIRED;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            dco-&gt;dco_del_peer_stats_updated =3D false=
;</span><br><span> </span><br><span>             if (nvlist_exists_number(n=
vl, &quot;del_reason&quot;))</span><br><span>             {</span><br><span=
>@@ -642,12 +644,13 @@</span><br><span> </span><br><span>                 i=
f (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><br><span>                 {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    dco_u=
pdate_peer_stat(dco-&gt;c-&gt;multi, dco-&gt;dco_message_peer_id, bytes);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    d=
co-&gt;dco_del_peer_stats_updated =3D dco_update_peer_stat(dco-&gt;c-&gt;mu=
lti, dco-&gt;dco_message_peer_id, bytes);</span><br><span>                 =
}</span><br><span>                 else</span><br><span>                 {<=
/span><br><span>                     dco-&gt;c-&gt;c2.dco_read_bytes =3D nv=
list_get_number(bytes, &quot;in&quot;);</span><br><span>                   =
  dco-&gt;c-&gt;c2.dco_write_bytes =3D nvlist_get_number(bytes, &quot;out&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       dco-&gt;dco_del_peer_stats_updated =3D true;</span><br><span>       =
          }</span><br><span>             }</span><br><span> </span><br><spa=
n>diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h</span>=
<br><span>index 5e2a552..72056b0 100644</span><br><span>--- a/src/openvpn/d=
co_freebsd.h</span><br><span>+++ b/src/openvpn/dco_freebsd.h</span><br><spa=
n>@@ -60,6 +60,7 @@</span><br><span>     int dco_message_type;</span><br><s=
pan>     int dco_message_peer_id;</span><br><span>     int dco_del_peer_rea=
son;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool dco_de=
l_peer_stats_updated;</span><br><span>     struct sockaddr_storage dco_floa=
t_peer_ss;</span><br><span> </span><br><span>     struct context *c;</span>=
<br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</s=
pan><br><span>index 2664029..743eb5c 100644</span><br><span>--- a/src/openv=
pn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><spa=
n>@@ -49,10 +49,10 @@</span><br><span> #include &lt;netlink/genl/family.h&g=
t;</span><br><span> #include &lt;netlink/genl/ctrl.h&gt;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* When parsing multip=
le DEL_PEER notifications, openvpn tries to request stats</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * for each DEL_PEER message (see seten=
v_stats). This triggers a GET_PEER</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * request-reply while we are still parsing the rest of the in=
itial</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * notifications=
, which can lead to NLE_BUSY or even NLE_NOMEM.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* When parsing multiple DEL_PEER notifications=
 that do not include stats,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * openvpn tries to request them for each DEL_PEER message (see set=
env_stats).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This =
triggers a GET_PEER request-reply while we are still parsing the rest</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * of the initial notific=
ations, which can lead to NLE_BUSY or even NLE_NOMEM.</span><br><span>  *</=
span><br><span>  * This basic lock ensures we don&#39;t bite our own tail b=
y issuing a dco_get_peer</span><br><span>  * while still busy receiving and=
 parsing other messages.</span><br><span>@@ -814,9 +814,38 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb=
[], uint32_t id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_update_=
peer_stat(dco_context_t *dco, struct nlattr *tb[], uint32_t id)</span><br><=
span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct c=
ontext_2 *c2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;ifmode =
=3D=3D OVPN_MODE_P2P)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c2 =
=3D &amp;dco-&gt;c-&gt;c2;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (c2-&gt;tls_multi-&gt;dco_peer_id !=3D id)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
id &gt;=3D dco-&gt;c-&gt;multi-&gt;max_clients)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            msg(M_WARN, &quot;%s: received out of bound i=
d %u (max=3D%u)&quot;, __func__, id,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                dco-&gt;c-&gt;multi-&gt;max_clients);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct multi_instance *mi =3D dco-&gt;c=
-&gt;multi-&gt;instances[id];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (!mi)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(M_WARN | M_NOIPREFIX, &quot;%s: received data for a non-existi=
ng peer %u&quot;, __func__, id);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c2=
 =3D &amp;mi-&gt;context.c2;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>     if (tb[OVPN_A_PEER_LINK_RX_BYTES])</span><br><span>     {<=
/span><br><span>         c2-&gt;dco_read_bytes =3D ovpn_nla_get_uint(tb[OVP=
N_A_PEER_LINK_RX_BYTES]);</span><br><span>@@ -824,7 +853,8 @@</span><br><sp=
an>     }</span><br><span>     else</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: no link =
RX bytes provided in reply for peer %u&quot;, __func__, id);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;%s: no l=
ink RX bytes provided for peer %u&quot;, __func__, id);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span> =
    }</span><br><span> </span><br><span>     if (tb[OVPN_A_PEER_LINK_TX_BYT=
ES])</span><br><span>@@ -834,7 +864,8 @@</span><br><span>     }</span><br><=
span>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_WARN, &quot;%s: no link TX bytes provided in =
reply for peer %u&quot;, __func__, id);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_WARN, &quot;%s: no link TX bytes provided=
 for peer %u&quot;, __func__, id);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return false;</span><br><span>     }</span><br><span=
> </span><br><span>     if (tb[OVPN_A_PEER_VPN_RX_BYTES])</span><br><span>@=
@ -844,7 +875,8 @@</span><br><span>     }</span><br><span>     else</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  msg(M_WARN, &quot;%s: no VPN RX bytes provided in reply for peer %u&quot;=
, __func__, id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_WARN, &quot;%s: no VPN RX bytes provided for peer %u&quot;, __fu=
nc__, id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn false;</span><br><span>     }</span><br><span> </span><br><span>     =
if (tb[OVPN_A_PEER_VPN_TX_BYTES])</span><br><span>@@ -854,8 +886,11 @@</spa=
n><br><span>     }</span><br><span>     else</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s:=
 no VPN TX bytes provided in reply for peer %u&quot;, __func__, id);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;=
%s: no VPN TX bytes provided for peer %u&quot;, __func__, id);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br>=
<span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br=
><span> }</span><br><span> </span><br><span> static int</span><br><span>@@ =
-877,40 +912,10 @@</span><br><span>     }</span><br><span> </span><br><span=
>     uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct context_2 *c2;</span>=
<br><span> </span><br><span>     msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: p=
arsing message for peer %u...&quot;, __func__, peer_id);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco-&gt;ifmode=
 =3D=3D OVPN_MODE_P2P)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c2 =3D =
&amp;dco-&gt;c-&gt;c2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (c2-&gt;tls_multi-&gt;dco_peer_id !=3D peer_id)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            return NL_SKIP;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (peer_id &gt;=
=3D dco-&gt;c-&gt;multi-&gt;max_clients)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(M_WARN, &quot;%s: received out of bound peer_id %u (=
max=3D%u)&quot;, __func__, peer_id,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                dco-&gt;c-&gt;multi-&gt;max_clients);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            return NL_SKIP;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        struct multi_instance *mi =3D dco-&gt;c-&gt;mult=
i-&gt;instances[peer_id];</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (!mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
sg(M_WARN | M_NOIPREFIX, &quot;%s: received data for a non-existing peer %u=
&quot;, __func__, peer_id);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            return NL_SKIP;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c2 =3D &amp;m=
i-&gt;context.c2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    dco_update_peer_stat(c2, tb_peer, pee=
r_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return NL_OK;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return dco_update_peer_stat(dco, t=
b_peer, peer_id) ? NL_OK : NL_SKIP;</span><br><span> }</span><br><span> </s=
pan><br><span> static bool</span><br><span>@@ -976,6 +981,9 @@</span><br><s=
pan>     dco-&gt;dco_del_peer_reason =3D reason;</span><br><span>     dco-&=
gt;dco_message_type =3D OVPN_CMD_PEER_DEL_NTF;</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* parse stats if availabl=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;dco=
_del_peer_stats_updated =3D dco_update_peer_stat(dco, dp_attrs, peerid);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     =
return NL_OK;</span><br><span> }</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h</span><br><span>inde=
x efd5b27..e275061 100644</span><br><span>--- a/src/openvpn/dco_linux.h</sp=
an><br><span>+++ b/src/openvpn/dco_linux.h</span><br><span>@@ -80,6 +80,7 @=
@</span><br><span>     int dco_message_peer_id;</span><br><span>     int dc=
o_message_key_id;</span><br><span>     int dco_del_peer_reason;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bool dco_del_peer_stats_upd=
ated;</span><br><span>     struct sockaddr_storage dco_float_peer_ss;</span=
><br><span> } dco_context_t;</span><br><span> </span><br><span>diff --git a=
/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index 94f043=
f..030d353 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><sp=
an>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -681,6 +681,7 @@</span><b=
r><span>         dco-&gt;dco_message_peer_id =3D dco-&gt;notif_buf.PeerId;<=
/span><br><span>         dco-&gt;dco_message_type =3D dco-&gt;notif_buf.Cmd=
;</span><br><span>         dco-&gt;dco_del_peer_reason =3D dco-&gt;notif_bu=
f.DelPeerReason;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     dco-&gt;dco_del_peer_stats_updated =3D false;</span><br><span>        =
 dco-&gt;dco_float_peer_ss =3D dco-&gt;notif_buf.FloatAddress;</span><br><s=
pan>     }</span><br><span>     else</span><br><span>diff --git a/src/openv=
pn/dco_win.h b/src/openvpn/dco_win.h</span><br><span>index 02b8389..599f41d=
 100644</span><br><span>--- a/src/openvpn/dco_win.h</span><br><span>+++ b/s=
rc/openvpn/dco_win.h</span><br><span>@@ -53,6 +53,7 @@</span><br><span>    =
 int dco_message_peer_id;</span><br><span>     int dco_message_type;</span>=
<br><span>     int dco_del_peer_reason;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    bool dco_del_peer_stats_updated;</span><br><span>  =
   struct sockaddr_storage dco_float_peer_ss;</span><br><span> </span><br><=
span>     struct context *c;</span><br><span>diff --git a/src/openvpn/multi=
.c b/src/openvpn/multi.c</span><br><span>index 153695c..4c7d3e2 100644</spa=
n><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/mul=
ti.c</span><br><span>@@ -510,7 +510,7 @@</span><br><span> static void</span=
><br><span> setenv_stats(struct multi_context *m, struct context *c)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (d=
co_enabled(&amp;m-&gt;top.options))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (dco_enabled(&amp;m-&gt;top.options) &amp;&amp; !dco=
_del_peer_stats_updated(&amp;m-&gt;top.c1.tuntap-&gt;dco))</span><br><span>=
     {</span><br><span>         if (dco_get_peer_stats_multi(&amp;m-&gt;top=
.c1.tuntap-&gt;dco, false) &lt; 0)</span><br><span>         {</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1434?usp=3Demail">change 1434</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1434?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7f3b95cacdf359536e827f176f2=
b81da4b00f22f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1434 </div>
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

--AHsq87kx5sM=--

