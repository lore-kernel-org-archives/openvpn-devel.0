From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 28 Nov 2025 12:32:47 +0000
In-Reply-To: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
References: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726...
Message-ID: <c21f1e640614169a44da1bb4031d2a3a1b4309f5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uHaKwjRm6IA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: process
 messages immediately after read
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uHaKwjRm6IA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#14) to the change originally created b=
y ralf_lici. ( http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dco: process messages immediately after read
......................................................................

dco: process messages immediately after read

Currently, reading and processing of incoming DCO messages are
decoupled: notifications are read, parsed, and the relevant information
is stored in fields of dco_context_t for later processing (with the only
exception being stats). This approach is problematic on Linux, since
libnl does not allow reading a single netlink message at a time, which
can result in loss of information when multiple notifications are
available.

This change adopts a read -> parse -> process paradigm. On Linux,
processing is now invoked directly from within the parsing callback,
which libnl calls for each received netlink packet. The other interfaces
are adapted accordingly to unify the processing model across all
platforms.

On Linux, however, a DEL_PEER notification from the kernel triggers a
GET_PEER request from userspace, which clutters the netlink
communication logic and can lead to errors or even process exit when
multiple simultaneous DEL_PEER notifications are received. To avoid
this, introduce a lock that prevents requesting stats while we are still
busy parsing other messages.

Reported-by: Stefan Baranoff <stefan.baranoff@...2970...>
Github: OpenVPN/openvpn#900
Github: OpenVPN/openvpn#918
Github: fixes OpenVPN/openvpn#919

Change-Id: Iefc251cb4483c0b9fb9d6a5207db4445cd884d52
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1403
Message-Id: <20251128112705.12613-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
785.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/multi_io.c
9 files changed, 88 insertions(+), 44 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1403/14

diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index e5e8709..cd6e32a 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -127,12 +127,13 @@
 void close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx);

 /**
- * Read data from the DCO communication channel (i.e. a control packet)
+ * Read and process data from the DCO communication channel
+ * (i.e. a control packet)
  *
  * @param dco       the DCO context
  * @return          0 on success or a negative error code otherwise
  */
-int dco_do_read(dco_context_t *dco);
+int dco_read_and_process(dco_context_t *dco);

 /**
  * Install a DCO in the main event loop
@@ -305,7 +306,7 @@
 }

 static inline int
-dco_do_read(dco_context_t *dco)
+dco_read_and_process(dco_context_t *dco)
 {
     ASSERT(false);
     return 0;
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index f2a89ac..d1ad092 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -578,7 +578,7 @@
 }

 int
-dco_do_read(dco_context_t *dco)
+dco_read_and_process(dco_context_t *dco)
 {
     struct ifdrv drv;
     uint8_t buf[4096];
@@ -684,11 +684,21 @@

         default:
             msg(M_WARN, "%s: unknown kernel notification %d", __func__, ty=
pe);
+            dco->dco_message_type =3D 0;
             break;
     }

     nvlist_destroy(nvl);

+    if (dco->c->mode =3D=3D CM_TOP)
+    {
+        multi_process_incoming_dco(dco);
+    }
+    else
+    {
+        process_incoming_dco(dco);
+    }
+
     return 0;
 }

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 0ae30b1..2664029 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -49,6 +49,15 @@
 #include <netlink/genl/family.h>
 #include <netlink/genl/ctrl.h>

+/* When parsing multiple DEL_PEER notifications, openvpn tries to request =
stats
+ * for each DEL_PEER message (see setenv_stats). This triggers a GET_PEER
+ * request-reply while we are still parsing the rest of the initial
+ * notifications, which can lead to NLE_BUSY or even NLE_NOMEM.
+ *
+ * This basic lock ensures we don't bite our own tail by issuing a dco_get=
_peer
+ * while still busy receiving and parsing other messages.
+ */
+static bool __is_locked =3D false;

 /* libnl < 3.5.0 does not set the NLA_F_NESTED on its own, therefore we
  * have to explicitly do it to prevent the kernel from failing upon
@@ -127,7 +136,9 @@
 static int
 ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
 {
+    __is_locked =3D true;
     int ret =3D nl_recvmsgs(dco->nl_sock, dco->nl_cb);
+    __is_locked =3D false;

     switch (ret)
     {
@@ -1094,29 +1105,34 @@
      * message, that stores the type-specific attributes.
      *
      * the "dco" object is then filled accordingly with the information
-     * retrieved from the message, so that the rest of the OpenVPN code can
-     * react as need be.
+     * retrieved from the message, so that *process_incoming_dco can react
+     * as need be.
      */
+    int ret;
     switch (gnlh->cmd)
     {
         case OVPN_CMD_PEER_GET:
         {
+            /* return directly, there are no messages to pass to *process_=
incoming_dco() */
             return ovpn_handle_peer(dco, attrs);
         }

         case OVPN_CMD_PEER_DEL_NTF:
         {
-            return ovpn_handle_peer_del_ntf(dco, attrs);
+            ret =3D ovpn_handle_peer_del_ntf(dco, attrs);
+            break;
         }

         case OVPN_CMD_PEER_FLOAT_NTF:
         {
-            return ovpn_handle_peer_float_ntf(dco, attrs);
+            ret =3D ovpn_handle_peer_float_ntf(dco, attrs);
+            break;
         }

         case OVPN_CMD_KEY_SWAP_NTF:
         {
-            return ovpn_handle_key_swap_ntf(dco, attrs);
+            ret =3D ovpn_handle_key_swap_ntf(dco, attrs);
+            break;
         }

         default:
@@ -1125,11 +1141,25 @@
             return NL_STOP;
     }

+    if (ret !=3D NL_OK)
+    {
+        return ret;
+    }
+
+    if (dco->c->mode =3D=3D CM_TOP)
+    {
+        multi_process_incoming_dco(dco);
+    }
+    else
+    {
+        process_incoming_dco(dco);
+    }
+
     return NL_OK;
 }

 int
-dco_do_read(dco_context_t *dco)
+dco_read_and_process(dco_context_t *dco)
 {
     msg(D_DCO_DEBUG, __func__);

@@ -1141,6 +1171,12 @@
 {
     ASSERT(dco);

+    if (__is_locked)
+    {
+        msg(D_DCO_DEBUG, "%s: cannot request peer stats while parsing othe=
r messages", __func__);
+        return 0;
+    }
+
     /* peer_id =3D=3D -1 means "dump all peers", but this is allowed in MP=
 mode only.
      * If it happens in P2P mode it means that the DCO peer was deleted an=
d we
      * can simply bail out
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index ca5eedf..94f043f 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -690,7 +690,7 @@
 }

 int
-dco_do_read(dco_context_t *dco)
+dco_read_and_process(dco_context_t *dco)
 {
     if (dco->ifmode !=3D DCO_MODE_MP)
     {
@@ -727,6 +727,15 @@
             break;
     }

+    if (dco->c->mode =3D=3D CM_TOP)
+    {
+        multi_process_incoming_dco(dco);
+    }
+    else
+    {
+        process_incoming_dco(dco);
+    }
+
     return 0;
 }

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index bc600d6..6f1bc0c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1243,19 +1243,11 @@
     }
 }

-static void
-process_incoming_dco(struct context *c)
+void
+process_incoming_dco(dco_context_t *dco)
 {
 #if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D))
-    dco_context_t *dco =3D &c->c1.tuntap->dco;
-
-    dco_do_read(dco);
-
-    /* no message for us to handle - platform specific code has logged det=
ails */
-    if (dco->dco_message_type =3D=3D 0)
-    {
-        return;
-    }
+    struct context *c =3D dco->c;

     /* FreeBSD currently sends us removal notifcation with the old peer-id=
 in
      * p2p mode with the ping timeout reason, so ignore that one to not sh=
oot
@@ -2369,7 +2361,7 @@
     {
         if (!IS_SIG(c))
         {
-            process_incoming_dco(c);
+            dco_read_and_process(&c->c1.tuntap->dco);
         }
     }
 }
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 3cd710e..06808b9 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -210,6 +210,13 @@
                                  const struct sockaddr *float_sa);

 /**
+ * Process an incoming DCO message (from kernel space).
+ *
+ * @param dco - Pointer to the structure representing the DCO context.
+ */
+void process_incoming_dco(dco_context_t *dco);
+
+/**
  * Write a packet to the external network interface.
  * @ingroup external_multiplexer
  *
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2b944667..153695c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3263,14 +3263,12 @@
     multi_signal_instance(m, mi, SIGTERM);
 }

-bool
-multi_process_incoming_dco(struct multi_context *m)
+void
+multi_process_incoming_dco(dco_context_t *dco)
 {
-    dco_context_t *dco =3D &m->top.c1.tuntap->dco;
+    ASSERT(dco->c->multi);

-    struct multi_instance *mi =3D NULL;
-
-    int ret =3D dco_do_read(&m->top.c1.tuntap->dco);
+    struct multi_context *m =3D dco->c->multi;

     int peer_id =3D dco->dco_message_peer_id;

@@ -3279,12 +3277,12 @@
      */
     if (peer_id < 0)
     {
-        return ret > 0;
+        return;
     }

     if ((peer_id < m->max_clients) && (m->instances[peer_id]))
     {
-        mi =3D m->instances[peer_id];
+        struct multi_instance *mi =3D m->instances[peer_id];
         set_prefix(mi);
         if (dco->dco_message_type =3D=3D OVPN_CMD_DEL_PEER)
         {
@@ -3325,11 +3323,6 @@
             "type %d, del_peer_reason %d",
             peer_id, dco->dco_message_type, dco->dco_del_peer_reason);
     }
-
-    dco->dco_message_type =3D 0;
-    dco->dco_message_peer_id =3D -1;
-    dco->dco_del_peer_reason =3D -1;
-    return ret > 0;
 }
 #endif /* if defined(ENABLE_DCO) */

@@ -4462,4 +4455,4 @@

     return (!ipv6_net_contains_host(&ifconfig_local, o->ifconfig_ipv6_netb=
its,
                                     dest));
-}
\ No newline at end of file
+}
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index a62b07a..a44f9f2 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -305,13 +305,9 @@
 /**
  * Process an incoming DCO message (from kernel space).
  *
- * @param m            - The single \c multi_context structure.
- *
- * @return
- *  - True, if the message was received correctly.
- *  - False, if there was an error while reading the message.
+ * @param dco - Pointer to the structure representing the DCO context.
  */
-bool multi_process_incoming_dco(struct multi_context *m);
+void multi_process_incoming_dco(dco_context_t *dco);

 /*************************************************************************=
*/
 /**
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index fe72456..997951e 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -505,7 +505,7 @@
                 /* incoming data on DCO? */
                 else if (e->arg =3D=3D MULTI_IO_DCO)
                 {
-                    multi_process_incoming_dco(m);
+                    dco_read_and_process(&m->top.c1.tuntap->dco);
                 }
 #endif
                 /* signal received? */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iefc251cb4483c0b9fb9d6a5207db4445cd884d52
Gerrit-Change-Number: 1403
Gerrit-PatchSet: 14
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uHaKwjRm6IA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #14</strong> to the change originally created by ralf_lici.=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail">V=
iew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">dco: process messages immediately a=
fter read<br><br>Currently, reading and processing of incoming DCO messages=
 are<br>decoupled: notifications are read, parsed, and the relevant informa=
tion<br>is stored in fields of dco_context_t for later processing (with the=
 only<br>exception being stats). This approach is problematic on Linux, sin=
ce<br>libnl does not allow reading a single netlink message at a time, whic=
h<br>can result in loss of information when multiple notifications are<br>a=
vailable.<br><br>This change adopts a read -&gt; parse -&gt; process paradi=
gm. On Linux,<br>processing is now invoked directly from within the parsing=
 callback,<br>which libnl calls for each received netlink packet. The other=
 interfaces<br>are adapted accordingly to unify the processing model across=
 all<br>platforms.<br><br>On Linux, however, a DEL_PEER notification from t=
he kernel triggers a<br>GET_PEER request from userspace, which clutters the=
 netlink<br>communication logic and can lead to errors or even process exit=
 when<br>multiple simultaneous DEL_PEER notifications are received. To avoi=
d<br>this, introduce a lock that prevents requesting stats while we are sti=
ll<br>busy parsing other messages.<br><br>Reported-by: Stefan Baranoff &lt;=
stefan.baranoff@...2970...&gt;<br>Github: OpenVPN/openvpn#900<br>Github: Op=
enVPN/openvpn#918<br>Github: fixes OpenVPN/openvpn#919<br><br>Change-Id: Ie=
fc251cb4483c0b9fb9d6a5207db4445cd884d52<br>Signed-off-by: Ralf Lici &lt;ral=
f@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerri=
t URL: https://gerrit.openvpn.net/c/openvpn/+/1403<br>Message-Id: &lt;20251=
128112705.12613-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/=
openvpn-devel@lists.sourceforge.net/msg34785.html<br>Signed-off-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco.h<br>M src/openvp=
n/dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_win.c<br>=
M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>M src/openvpn/multi.c=
<br>M src/openvpn/multi.h<br>M src/openvpn/multi_io.c<br>9 files changed, 8=
8 insertions(+), 44 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/03/1403/14</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/dco.h b/src/openvpn/dco.h</span><br><span>index e5e8709..=
cd6e32a 100644</span><br><span>--- a/src/openvpn/dco.h</span><br><span>+++ =
b/src/openvpn/dco.h</span><br><span>@@ -127,12 +127,13 @@</span><br><span> =
void close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx);</span><br><s=
pan> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Read data from the DCO communication channel (i.e. a control packet=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read and proces=
s data from the DCO communication channel</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * (i.e. a control packet)</span><br><span>  *</span>=
<br><span>  * @param dco       the DCO context</span><br><span>  * @return =
         0 on success or a negative error code otherwise</span><br><span>  =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int dco_do_read(dco=
_context_t *dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
t dco_read_and_process(dco_context_t *dco);</span><br><span> </span><br><sp=
an> /**</span><br><span>  * Install a DCO in the main event loop</span><br>=
<span>@@ -305,7 +306,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-dco_do_read(dco_context_t *dco)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+dco_read_and_process(dco_context_t *dco)</span><br><span> {</s=
pan><br><span>     ASSERT(false);</span><br><span>     return 0;</span><br>=
<span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</s=
pan><br><span>index f2a89ac..d1ad092 100644</span><br><span>--- a/src/openv=
pn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br>=
<span>@@ -578,7 +578,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_do_read(d=
co_context_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
co_read_and_process(dco_context_t *dco)</span><br><span> {</span><br><span>=
     struct ifdrv drv;</span><br><span>     uint8_t buf[4096];</span><br><s=
pan>@@ -684,11 +684,21 @@</span><br><span> </span><br><span>         defaul=
t:</span><br><span>             msg(M_WARN, &quot;%s: unknown kernel notifi=
cation %d&quot;, __func__, type);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            dco-&gt;dco_message_type =3D 0;</span><br><span> =
            break;</span><br><span>     }</span><br><span> </span><br><span=
>     nvlist_destroy(nvl);</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        multi_process_incoming_dco(dco);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        process_incoming_dco(dco);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span>     return 0;</span><br><span> }</span><=
br><span> </span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openv=
pn/dco_linux.c</span><br><span>index 0ae30b1..2664029 100644</span><br><spa=
n>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux=
.c</span><br><span>@@ -49,6 +49,15 @@</span><br><span> #include &lt;netlink=
/genl/family.h&gt;</span><br><span> #include &lt;netlink/genl/ctrl.h&gt;</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* W=
hen parsing multiple DEL_PEER notifications, openvpn tries to request stats=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * for each DEL_PEE=
R message (see setenv_stats). This triggers a GET_PEER</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * request-reply while we are still pars=
ing the rest of the initial</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * notifications, which can lead to NLE_BUSY or even NLE_NOMEM.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * This basic lock ensures we don&#39;t =
bite our own tail by issuing a dco_get_peer</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * while still busy receiving and parsing other mes=
sages.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static bool __is_locked =3D f=
alse;</span><br><span> </span><br><span> /* libnl &lt; 3.5.0 does not set t=
he NLA_F_NESTED on its own, therefore we</span><br><span>  * have to explic=
itly do it to prevent the kernel from failing upon</span><br><span>@@ -127,=
7 +136,9 @@</span><br><span> static int</span><br><span> ovpn_nl_recvmsgs(d=
co_context_t *dco, const char *prefix)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    __is_locked =3D true;</span><br><=
span>     int ret =3D nl_recvmsgs(dco-&gt;nl_sock, dco-&gt;nl_cb);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    __is_locked =3D false;</=
span><br><span> </span><br><span>     switch (ret)</span><br><span>     {</=
span><br><span>@@ -1094,29 +1105,34 @@</span><br><span>      * message, tha=
t stores the type-specific attributes.</span><br><span>      *</span><br><s=
pan>      * the &quot;dco&quot; object is then filled accordingly with the =
information</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * ret=
rieved from the message, so that the rest of the OpenVPN code can</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-     * react as need be.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * retrieved from the =
message, so that *process_incoming_dco can react</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * as need be.</span><br><span>      */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret;</span><br=
><span>     switch (gnlh-&gt;cmd)</span><br><span>     {</span><br><span>  =
       case OVPN_CMD_PEER_GET:</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* return directly, there=
 are no messages to pass to *process_incoming_dco() */</span><br><span>    =
         return ovpn_handle_peer(dco, attrs);</span><br><span>         }</s=
pan><br><span> </span><br><span>         case OVPN_CMD_PEER_DEL_NTF:</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           return ovpn_handle_peer_del_ntf(dco, attrs);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            ret =3D ovpn_handle_peer_de=
l_ntf(dco, attrs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           break;</span><br><span>         }</span><br><span> </span><br><s=
pan>         case OVPN_CMD_PEER_FLOAT_NTF:</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            return ovpn_han=
dle_peer_float_ntf(dco, attrs);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            ret =3D ovpn_handle_peer_float_ntf(dco, attrs);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</spa=
n><br><span>         }</span><br><span> </span><br><span>         case OVPN=
_CMD_KEY_SWAP_NTF:</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            return ovpn_handle_key_swap_ntf(dco, at=
trs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
t =3D ovpn_handle_key_swap_ntf(dco, attrs);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            break;</span><br><span>         }</span=
><br><span> </span><br><span>         default:</span><br><span>@@ -1125,11 =
+1141,25 @@</span><br><span>             return NL_STOP;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (ret !=3D NL_OK)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;c-&gt;mode =3D=3D CM_TOP=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        multi_process_incoming_d=
co(dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        process_incoming_dco(dco);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     return NL_OK;</span><br><sp=
an> }</span><br><span> </span><br><span> int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-dco_do_read(dco_context_t *dco)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+dco_read_and_process(dco_context_t *dco)=
</span><br><span> {</span><br><span>     msg(D_DCO_DEBUG, __func__);</span>=
<br><span> </span><br><span>@@ -1141,6 +1171,12 @@</span><br><span> {</span=
><br><span>     ASSERT(dco);</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (__is_locked)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(D_DCO_DEBUG, &quot;%s: cannot request peer stats =
while parsing other messages&quot;, __func__);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     /* peer_id =3D=3D -1 means &quot;dump all =
peers&quot;, but this is allowed in MP mode only.</span><br><span>      * I=
f it happens in P2P mode it means that the DCO peer was deleted and we</spa=
n><br><span>      * can simply bail out</span><br><span>diff --git a/src/op=
envpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index ca5eedf..94f0=
43f 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ =
b/src/openvpn/dco_win.c</span><br><span>@@ -690,7 +690,7 @@</span><br><span=
> }</span><br><span> </span><br><span> int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-dco_do_read(dco_context_t *dco)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_read_and_process(dco_context_t *dco)<=
/span><br><span> {</span><br><span>     if (dco-&gt;ifmode !=3D DCO_MODE_MP=
)</span><br><span>     {</span><br><span>@@ -727,6 +727,15 @@</span><br><sp=
an>             break;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;c-&gt;mode =3D=
=3D CM_TOP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_process_=
incoming_dco(dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        process_incoming_dco(dco);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return 0;</span><=
br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/forw=
ard.c b/src/openvpn/forward.c</span><br><span>index bc600d6..6f1bc0c 100644=
</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/open=
vpn/forward.c</span><br><span>@@ -1243,19 +1243,11 @@</span><br><span>     =
}</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-process_incoming_dco(struct context *c)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+process_incoming_dco(dco_context_t *dco)</span><br><span> {</sp=
an><br><span> #if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || =
defined(TARGET_FREEBSD))</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    dco_context_t *dco =3D &amp;c-&gt;c1.tuntap-&gt;dco;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    dco_do_read(dco);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* no message for us to handle - platform specific code has logged details =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco-&gt;dco=
_message_type =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D dco-&gt;=
c;</span><br><span> </span><br><span>     /* FreeBSD currently sends us rem=
oval notifcation with the old peer-id in</span><br><span>      * p2p mode w=
ith the ping timeout reason, so ignore that one to not shoot</span><br><spa=
n>@@ -2369,7 +2361,7 @@</span><br><span>     {</span><br><span>         if =
(!IS_SIG(c))</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            process_incoming_dco(c);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            dco_read_and_process(&amp;c-=
&gt;c1.tuntap-&gt;dco);</span><br><span>         }</span><br><span>     }</=
span><br><span> }</span><br><span>diff --git a/src/openvpn/forward.h b/src/=
openvpn/forward.h</span><br><span>index 3cd710e..06808b9 100644</span><br><=
span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/openvpn/forward.=
h</span><br><span>@@ -210,6 +210,13 @@</span><br><span>                    =
              const struct sockaddr *float_sa);</span><br><span> </span><br=
><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Proce=
ss an incoming DCO message (from kernel space).</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param dco - Pointer to the structure representing the DCO co=
ntext.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void process_incoming_dco(dco=
_context_t *dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span> =
 * Write a packet to the external network interface.</span><br><span>  * @i=
ngroup external_multiplexer</span><br><span>  *</span><br><span>diff --git =
a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 2b944667.=
.153695c 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+=
++ b/src/openvpn/multi.c</span><br><span>@@ -3263,14 +3263,12 @@</span><br>=
<span>     multi_signal_instance(m, mi, SIGTERM);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_process_incoming_dco(=
struct multi_context *m)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_proc=
ess_incoming_dco(dco_context_t *dco)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    dco_context_t *dco =3D &amp;m-&gt;top=
.c1.tuntap-&gt;dco;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(dco-&gt;c-&gt;multi);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D NULL;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    int ret =3D dco_do_read(&amp;m-&gt;top.c1.tun=
tap-&gt;dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct multi_context *m =3D dco-&gt;c-&gt;multi;</span><br><span> </span><br>=
<span>     int peer_id =3D dco-&gt;dco_message_peer_id;</span><br><span> </=
span><br><span>@@ -3279,12 +3277,12 @@</span><br><span>      */</span><br><=
span>     if (peer_id &lt; 0)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return ret &gt; 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span>    =
 }</span><br><span> </span><br><span>     if ((peer_id &lt; m-&gt;max_clien=
ts) &amp;&amp; (m-&gt;instances[peer_id]))</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        mi =3D m-&gt;instances[=
peer_id];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct multi_instance *mi =3D m-&gt;instances[peer_id];</span><br><span>     =
    set_prefix(mi);</span><br><span>         if (dco-&gt;dco_message_type =
=3D=3D OVPN_CMD_DEL_PEER)</span><br><span>         {</span><br><span>@@ -33=
25,11 +3323,6 @@</span><br><span>             &quot;type %d, del_peer_reaso=
n %d&quot;,</span><br><span>             peer_id, dco-&gt;dco_message_type,=
 dco-&gt;dco_del_peer_reason);</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    dco-&gt;dco_message_type =3D 0;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    dco-&gt;dco_message_peer_id =3D -1;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;dco_del_peer_reason =
=3D -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret=
 &gt; 0;</span><br><span> }</span><br><span> #endif /* if defined(ENABLE_DC=
O) */</span><br><span> </span><br><span>@@ -4462,4 +4455,4 @@</span><br><sp=
an> </span><br><span>     return (!ipv6_net_contains_host(&amp;ifconfig_loc=
al, o-&gt;ifconfig_ipv6_netbits,</span><br><span>                          =
           dest));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span>\ No newline at end of file</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/multi.h b=
/src/openvpn/multi.h</span><br><span>index a62b07a..a44f9f2 100644</span><b=
r><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h=
</span><br><span>@@ -305,13 +305,9 @@</span><br><span> /**</span><br><span>=
  * Process an incoming DCO message (from kernel space).</span><br><span>  =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param m         =
   - The single \c multi_context structure.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @return</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - Tr=
ue, if the message was received correctly.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  - False, if there was an error while reading the m=
essage.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dc=
o - Pointer to the structure representing the DCO context.</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool multi_proces=
s_incoming_dco(struct multi_context *m);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void multi_process_incoming_dco(dco_context_t *dco);</=
span><br><span> </span><br><span> /****************************************=
**********************************/</span><br><span> /**</span><br><span>di=
ff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c</span><br><span>=
index fe72456..997951e 100644</span><br><span>--- a/src/openvpn/multi_io.c<=
/span><br><span>+++ b/src/openvpn/multi_io.c</span><br><span>@@ -505,7 +505=
,7 @@</span><br><span>                 /* incoming data on DCO? */</span><b=
r><span>                 else if (e-&gt;arg =3D=3D MULTI_IO_DCO)</span><br>=
<span>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    multi_process_incoming_dco(m);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    dco_read_and_process(=
&amp;m-&gt;top.c1.tuntap-&gt;dco);</span><br><span>                 }</span=
><br><span> #endif</span><br><span>                 /* signal received? */<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1403?usp=3Demail">change 1403</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1403?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefc251cb4483c0b9fb9d6a5207d=
b4445cd884d52 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1403 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--uHaKwjRm6IA=--

