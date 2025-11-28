From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 28 Nov 2025 10:56:29 +0000
In-Reply-To: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
References: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <701f7c370741a67886806c507203195a521a7c49-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZI+T+ROktGU="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZI+T+ROktGU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail

to look at the new patch set (#12).


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
Change-Id: Iefc251cb4483c0b9fb9d6a5207db4445cd884d52
Signed-off-by: Ralf Lici <ralf@...2726...>
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
9 files changed, 91 insertions(+), 45 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1403/12

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
index 0ae30b1..a838311 100644
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
@@ -1094,29 +1103,34 @@
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
@@ -1125,15 +1139,33 @@
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

-    return ovpn_nl_recvmsgs(dco, __func__);
+    __is_locked =3D true;
+    int ret =3D ovpn_nl_recvmsgs(dco, __func__);
+    __is_locked =3D false;
+
+    return ret;
 }

 static int
@@ -1141,6 +1173,12 @@
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
index ccb8404..1a68af4 100644
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
index a575faf..9e9b02e 100644
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
Gerrit-PatchSet: 12
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ralf_lici <ralf@...2726...>

--ZI+T+ROktGU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici. </p>
<p>ralf_lici <strong>uploaded patch set #12</strong> to this change.</p><p>=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail">View Cha=
nge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">dco: process messages immediately after read<br><b=
r>Currently, reading and processing of incoming DCO messages are<br>decoupl=
ed: notifications are read, parsed, and the relevant information<br>is stor=
ed in fields of dco_context_t for later processing (with the only<br>except=
ion being stats). This approach is problematic on Linux, since<br>libnl doe=
s not allow reading a single netlink message at a time, which<br>can result=
 in loss of information when multiple notifications are<br>available.<br><b=
r>This change adopts a read -&gt; parse -&gt; process paradigm. On Linux,<b=
r>processing is now invoked directly from within the parsing callback,<br>w=
hich libnl calls for each received netlink packet. The other interfaces<br>=
are adapted accordingly to unify the processing model across all<br>platfor=
ms.<br><br>On Linux, however, a DEL_PEER notification from the kernel trigg=
ers a<br>GET_PEER request from userspace, which clutters the netlink<br>com=
munication logic and can lead to errors or even process exit when<br>multip=
le simultaneous DEL_PEER notifications are received. To avoid<br>this, intr=
oduce a lock that prevents requesting stats while we are still<br>busy pars=
ing other messages.<br><br>Reported-by: Stefan Baranoff &lt;stefan.baranoff=
@...2970...&gt;<br>Change-Id: Iefc251cb4483c0b9fb9d6a5207db4445cd884d52<br>=
Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M src/openvpn/dc=
o.h<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/op=
envpn/dco_win.c<br>M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>M =
src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/multi_io.c<br=
>9 files changed, 91 insertions(+), 45 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1403/12=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h</span><br><span=
>index e5e8709..cd6e32a 100644</span><br><span>--- a/src/openvpn/dco.h</spa=
n><br><span>+++ b/src/openvpn/dco.h</span><br><span>@@ -127,12 +127,13 @@</=
span><br><span> void close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ct=
x);</span><br><span> </span><br><span> /**</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * Read data from the DCO communication channel (i.e. =
a control packet)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Read and process data from the DCO communication channel</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * (i.e. a control packet)</span><br>=
<span>  *</span><br><span>  * @param dco       the DCO context</span><br><s=
pan>  * @return          0 on success or a negative error code otherwise</s=
pan><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int=
 dco_do_read(dco_context_t *dco);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+int dco_read_and_process(dco_context_t *dco);</span><br><span=
> </span><br><span> /**</span><br><span>  * Install a DCO in the main event=
 loop</span><br><span>@@ -305,7 +306,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> static inline int</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-dco_do_read(dco_context_t *dco)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+dco_read_and_process(dco_context_t *dco)</span=
><br><span> {</span><br><span>     ASSERT(false);</span><br><span>     retu=
rn 0;</span><br><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/=
dco_freebsd.c</span><br><span>index f2a89ac..d1ad092 100644</span><br><span=
>--- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_free=
bsd.c</span><br><span>@@ -578,7 +578,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-dco_do_read(dco_context_t *dco)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+dco_read_and_process(dco_context_t *dco)</span><br><span> {<=
/span><br><span>     struct ifdrv drv;</span><br><span>     uint8_t buf[409=
6];</span><br><span>@@ -684,11 +684,21 @@</span><br><span> </span><br><span=
>         default:</span><br><span>             msg(M_WARN, &quot;%s: unkno=
wn kernel notification %d&quot;, __func__, type);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            dco-&gt;dco_message_type =3D 0;</=
span><br><span>             break;</span><br><span>     }</span><br><span> =
</span><br><span>     nvlist_destroy(nvl);</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;c-&gt;mode =3D=3D =
CM_TOP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_process_inco=
ming_dco(dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        process_incoming_dco(dco);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return 0;</span><br=
><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/dco_li=
nux.c b/src/openvpn/dco_linux.c</span><br><span>index 0ae30b1..a838311 1006=
44</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/=
openvpn/dco_linux.c</span><br><span>@@ -49,6 +49,15 @@</span><br><span> #in=
clude &lt;netlink/genl/family.h&gt;</span><br><span> #include &lt;netlink/g=
enl/ctrl.h&gt;</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/* When parsing multiple DEL_PEER notifications, openvpn tries=
 to request stats</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 for each DEL_PEER message (see setenv_stats). This triggers a GET_PEER</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * request-reply while =
we are still parsing the rest of the initial</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * notifications, which can lead to NLE_BUSY or ev=
en NLE_NOMEM.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This basic lock ensu=
res we don&#39;t bite our own tail by issuing a dco_get_peer</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * while still busy receiving and =
parsing other messages.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool =
__is_locked =3D false;</span><br><span> </span><br><span> /* libnl &lt; 3.5=
.0 does not set the NLA_F_NESTED on its own, therefore we</span><br><span> =
 * have to explicitly do it to prevent the kernel from failing upon</span><=
br><span>@@ -1094,29 +1103,34 @@</span><br><span>      * message, that stor=
es the type-specific attributes.</span><br><span>      *</span><br><span>  =
    * the &quot;dco&quot; object is then filled accordingly with the inform=
ation</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * retrieved=
 from the message, so that the rest of the OpenVPN code can</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-     * react as need be.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * retrieved from the messag=
e, so that *process_incoming_dco can react</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * as need be.</span><br><span>      */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int ret;</span><br><span=
>     switch (gnlh-&gt;cmd)</span><br><span>     {</span><br><span>        =
 case OVPN_CMD_PEER_GET:</span><br><span>         {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* return directly, there are=
 no messages to pass to *process_incoming_dco() */</span><br><span>        =
     return ovpn_handle_peer(dco, attrs);</span><br><span>         }</span>=
<br><span> </span><br><span>         case OVPN_CMD_PEER_DEL_NTF:</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       return ovpn_handle_peer_del_ntf(dco, attrs);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ret =3D ovpn_handle_peer_del_=
ntf(dco, attrs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         break;</span><br><span>         }</span><br><span> </span><br><spa=
n>         case OVPN_CMD_PEER_FLOAT_NTF:</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            return ovpn_handl=
e_peer_float_ntf(dco, attrs);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            ret =3D ovpn_handle_peer_float_ntf(dco, attrs);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span>=
<br><span>         }</span><br><span> </span><br><span>         case OVPN_C=
MD_KEY_SWAP_NTF:</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            return ovpn_handle_key_swap_ntf(dco, attr=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret =
=3D ovpn_handle_key_swap_ntf(dco, attrs);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            break;</span><br><span>         }</span><=
br><span> </span><br><span>         default:</span><br><span>@@ -1125,15 +1=
139,33 @@</span><br><span>             return NL_STOP;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (ret !=3D NL_OK)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        multi_process_incoming_dc=
o(dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        process_incoming_dco(dco);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     return NL_OK;</span><br><spa=
n> }</span><br><span> </span><br><span> int</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-dco_do_read(dco_context_t *dco)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_read_and_process(dco_context_t *dco)<=
/span><br><span> {</span><br><span>     msg(D_DCO_DEBUG, __func__);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
ovpn_nl_recvmsgs(dco, __func__);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    __is_locked =3D true;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int ret =3D ovpn_nl_recvmsgs(dco, __func__);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    __is_locked =3D false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span> }</spa=
n><br><span> </span><br><span> static int</span><br><span>@@ -1141,6 +1173,=
12 @@</span><br><span> {</span><br><span>     ASSERT(dco);</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (__is_locke=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;=
%s: cannot request peer stats while parsing other messages&quot;, __func__)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* peer_id =
=3D=3D -1 means &quot;dump all peers&quot;, but this is allowed in MP mode =
only.</span><br><span>      * If it happens in P2P mode it means that the D=
CO peer was deleted and we</span><br><span>      * can simply bail out</spa=
n><br><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</spa=
n><br><span>index ca5eedf..94f043f 100644</span><br><span>--- a/src/openvpn=
/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -=
690,7 +690,7 @@</span><br><span> }</span><br><span> </span><br><span> int</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_do_read(dco_context=
_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_read_an=
d_process(dco_context_t *dco)</span><br><span> {</span><br><span>     if (d=
co-&gt;ifmode !=3D DCO_MODE_MP)</span><br><span>     {</span><br><span>@@ -=
727,6 +727,15 @@</span><br><span>             break;</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        multi_process_incoming_dco(dco);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pro=
cess_incoming_dco(dco);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     return 0;</span><br><span> }</span><br><span> </span><br><span>=
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>=
index ccb8404..1a68af4 100644</span><br><span>--- a/src/openvpn/forward.c</=
span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1243,19 +124=
3,11 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-process_incoming_dco(struct context *c)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+process_incoming_dco(dco_context_t=
 *dco)</span><br><span> {</span><br><span> #if defined(ENABLE_DCO) &amp;&am=
p; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    dco_context_t *dco =3D &amp;c-&gt;c1.tu=
ntap-&gt;dco;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_do_read(dco);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* no message for us to handle - platform spec=
ific code has logged details */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (dco-&gt;dco_message_type =3D=3D 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct context *c =3D dco-&gt;c;</span><br><span> </span><br><span>     /* =
FreeBSD currently sends us removal notifcation with the old peer-id in</spa=
n><br><span>      * p2p mode with the ping timeout reason, so ignore that o=
ne to not shoot</span><br><span>@@ -2369,7 +2361,7 @@</span><br><span>     =
{</span><br><span>         if (!IS_SIG(c))</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            process_incomin=
g_dco(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  dco_read_and_process(&amp;c-&gt;c1.tuntap-&gt;dco);</span><br><span>     =
    }</span><br><span>     }</span><br><span> }</span><br><span>diff --git =
a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>index a575f=
af..9e9b02e 100644</span><br><span>--- a/src/openvpn/forward.h</span><br><s=
pan>+++ b/src/openvpn/forward.h</span><br><span>@@ -210,6 +210,13 @@</span>=
<br><span>                                  const struct sockaddr *float_sa=
);</span><br><span> </span><br><span> /**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Process an incoming DCO message (from kernel space=
).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param dco - Pointer to the str=
ucture representing the DCO context.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void process_incoming_dco(dco_context_t *dco);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span>  * Write a packet to the external network int=
erface.</span><br><span>  * @ingroup external_multiplexer</span><br><span> =
 *</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</=
span><br><span>index 2b944667..153695c 100644</span><br><span>--- a/src/ope=
nvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -=
3263,14 +3263,12 @@</span><br><span>     multi_signal_instance(m, mi, SIGTE=
RM);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-multi_process_incoming_dco(struct multi_context *m)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+multi_process_incoming_dco(dco_context_t *dco)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_con=
text_t *dco =3D &amp;m-&gt;top.c1.tuntap-&gt;dco;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ASSERT(dco-&gt;c-&gt;multi);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi=
_instance *mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco=
_do_read(&amp;m-&gt;top.c1.tuntap-&gt;dco);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct multi_context *m =3D dco-&gt;c-&gt;multi=
;</span><br><span> </span><br><span>     int peer_id =3D dco-&gt;dco_messag=
e_peer_id;</span><br><span> </span><br><span>@@ -3279,12 +3277,12 @@</span>=
<br><span>      */</span><br><span>     if (peer_id &lt; 0)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return=
 ret &gt; 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return;</span><br><span>     }</span><br><span> </span><br><span>     if (=
(peer_id &lt; m-&gt;max_clients) &amp;&amp; (m-&gt;instances[peer_id]))</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      mi =3D m-&gt;instances[peer_id];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        struct multi_instance *mi =3D m-&gt;instances[pe=
er_id];</span><br><span>         set_prefix(mi);</span><br><span>         i=
f (dco-&gt;dco_message_type =3D=3D OVPN_CMD_DEL_PEER)</span><br><span>     =
    {</span><br><span>@@ -3325,11 +3323,6 @@</span><br><span>             &=
quot;type %d, del_peer_reason %d&quot;,</span><br><span>             peer_i=
d, dco-&gt;dco_message_type, dco-&gt;dco_del_peer_reason);</span><br><span>=
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;dco_message_type =3D 0;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;dco_messag=
e_peer_id =3D -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
dco-&gt;dco_del_peer_reason =3D -1;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return ret &gt; 0;</span><br><span> }</span><br><span> #e=
ndif /* if defined(ENABLE_DCO) */</span><br><span> </span><br><span>@@ -446=
2,4 +4455,4 @@</span><br><span> </span><br><span>     return (!ipv6_net_con=
tains_host(&amp;ifconfig_local, o-&gt;ifconfig_ipv6_netbits,</span><br><spa=
n>                                     dest));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span>\ No newline at end of file</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff -=
-git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>index a62b=
07a..a44f9f2 100644</span><br><span>--- a/src/openvpn/multi.h</span><br><sp=
an>+++ b/src/openvpn/multi.h</span><br><span>@@ -305,13 +305,9 @@</span><br=
><span> /**</span><br><span>  * Process an incoming DCO message (from kerne=
l space).</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @param m            - The single \c multi_context structure.</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @return</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  - True, if the message was received correctly.</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - False, if there was=
 an error while reading the message.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param dco - Pointer to the structure representing the =
DCO context.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-bool multi_process_incoming_dco(struct multi_context *m);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_process_incomi=
ng_dco(dco_context_t *dco);</span><br><span> </span><br><span> /***********=
***************************************************************/</span><br>=
<span> /**</span><br><span>diff --git a/src/openvpn/multi_io.c b/src/openvp=
n/multi_io.c</span><br><span>index fe72456..997951e 100644</span><br><span>=
--- a/src/openvpn/multi_io.c</span><br><span>+++ b/src/openvpn/multi_io.c</=
span><br><span>@@ -505,7 +505,7 @@</span><br><span>                 /* inco=
ming data on DCO? */</span><br><span>                 else if (e-&gt;arg =
=3D=3D MULTI_IO_DCO)</span><br><span>                 {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    multi_process_incomin=
g_dco(m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          dco_read_and_process(&amp;m-&gt;top.c1.tuntap-&gt;dco);</span><br=
><span>                 }</span><br><span> #endif</span><br><span>         =
        /* signal received? */</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail">c=
hange 1403</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefc251cb4483c0b9fb9d6a5207d=
b4445cd884d52 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1403 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>

</body></html>=

--ZI+T+ROktGU=--

