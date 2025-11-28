From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 28 Nov 2025 09:01:31 +0000
In-Reply-To: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
References: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <c58f8263dcfb5a94ad19c7e69d56e31c67f8cf2c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TlJcIdpDw5k="; charset=UTF-8
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

--TlJcIdpDw5k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail

to look at the new patch set (#9).


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
9 files changed, 91 insertions(+), 46 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1403/9

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
index f2a89ac..25deafe 100644
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
@@ -689,6 +689,15 @@

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
index 0ae30b1..d320018 100644
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
-            return ovpn_handle_peer(dco, attrs);
+            ret =3D ovpn_handle_peer(dco, attrs);
+            break;
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
@@ -1195,6 +1227,12 @@
 int
 dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_e=
rr)
 {
+    if (__is_locked)
+    {
+        msg(D_DCO_DEBUG, "cannot request peer stats while parsing other me=
ssages");
+        return 0;
+    }
+
     return dco_get_peer(dco, -1, raise_sigusr1_on_err);
 }

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
Gerrit-PatchSet: 9
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>

--TlJcIdpDw5k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos. </p>
<p>ralf_lici <strong>uploaded patch set #9</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">dco: process messages immediately after read<br><br=
>Currently, reading and processing of incoming DCO messages are<br>decouple=
d: notifications are read, parsed, and the relevant information<br>is store=
d in fields of dco_context_t for later processing (with the only<br>excepti=
on being stats). This approach is problematic on Linux, since<br>libnl does=
 not allow reading a single netlink message at a time, which<br>can result =
in loss of information when multiple notifications are<br>available.<br><br=
>This change adopts a read -&gt; parse -&gt; process paradigm. On Linux,<br=
>processing is now invoked directly from within the parsing callback,<br>wh=
ich libnl calls for each received netlink packet. The other interfaces<br>a=
re adapted accordingly to unify the processing model across all<br>platform=
s.<br><br>On Linux, however, a DEL_PEER notification from the kernel trigge=
rs a<br>GET_PEER request from userspace, which clutters the netlink<br>comm=
unication logic and can lead to errors or even process exit when<br>multipl=
e simultaneous DEL_PEER notifications are received. To avoid<br>this, intro=
duce a lock that prevents requesting stats while we are still<br>busy parsi=
ng other messages.<br><br>Reported-by: Stefan Baranoff &lt;stefan.baranoff@=
...2970...&gt;<br>Change-Id: Iefc251cb4483c0b9fb9d6a5207db4445cd884d52<br>S=
igned-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M src/openvpn/dco=
.h<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/ope=
nvpn/dco_win.c<br>M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>M s=
rc/openvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/multi_io.c<br>=
9 files changed, 91 insertions(+), 46 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1403/9<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h</span><br><span>=
index e5e8709..cd6e32a 100644</span><br><span>--- a/src/openvpn/dco.h</span=
><br><span>+++ b/src/openvpn/dco.h</span><br><span>@@ -127,12 +127,13 @@</s=
pan><br><span> void close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx=
);</span><br><span> </span><br><span> /**</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * Read data from the DCO communication channel (i.e. a=
 control packet)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Read and process data from the DCO communication channel</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * (i.e. a control packet)</span><br><=
span>  *</span><br><span>  * @param dco       the DCO context</span><br><sp=
an>  * @return          0 on success or a negative error code otherwise</sp=
an><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int =
dco_do_read(dco_context_t *dco);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+int dco_read_and_process(dco_context_t *dco);</span><br><span>=
 </span><br><span> /**</span><br><span>  * Install a DCO in the main event =
loop</span><br><span>@@ -305,7 +306,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static inline int</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-dco_do_read(dco_context_t *dco)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+dco_read_and_process(dco_context_t *dco)</span>=
<br><span> {</span><br><span>     ASSERT(false);</span><br><span>     retur=
n 0;</span><br><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/d=
co_freebsd.c</span><br><span>index f2a89ac..25deafe 100644</span><br><span>=
--- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freeb=
sd.c</span><br><span>@@ -578,7 +578,7 @@</span><br><span> }</span><br><span=
> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-dco_do_read(dco_context_t *dco)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+dco_read_and_process(dco_context_t *dco)</span><br><span> {</=
span><br><span>     struct ifdrv drv;</span><br><span>     uint8_t buf[4096=
];</span><br><span>@@ -689,6 +689,15 @@</span><br><span> </span><br><span> =
    nvlist_destroy(nvl);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        multi_process_incoming_dco(dco);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        process_incoming_dco(dco);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     return 0;</span><br><span> }</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/=
dco_linux.c</span><br><span>index 0ae30b1..d320018 100644</span><br><span>-=
-- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c<=
/span><br><span>@@ -49,6 +49,15 @@</span><br><span> #include &lt;netlink/ge=
nl/family.h&gt;</span><br><span> #include &lt;netlink/genl/ctrl.h&gt;</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* When=
 parsing multiple DEL_PEER notifications, openvpn tries to request stats</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * for each DEL_PEER m=
essage (see setenv_stats). This triggers a GET_PEER</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * request-reply while we are still parsi=
ng the rest of the initial</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * notifications, which can lead to NLE_BUSY or even NLE_NOMEM.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * This basic lock ensures we don&#39;t b=
ite our own tail by issuing a dco_get_peer</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * while still busy receiving and parsing other mess=
ages.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static bool __is_locked =3D fa=
lse;</span><br><span> </span><br><span> /* libnl &lt; 3.5.0 does not set th=
e NLA_F_NESTED on its own, therefore we</span><br><span>  * have to explici=
tly do it to prevent the kernel from failing upon</span><br><span>@@ -1094,=
29 +1103,34 @@</span><br><span>      * message, that stores the type-specif=
ic attributes.</span><br><span>      *</span><br><span>      * the &quot;dc=
o&quot; object is then filled accordingly with the information</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     * retrieved from the message,=
 so that the rest of the OpenVPN code can</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     * react as need be.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * retrieved from the message, so that *proces=
s_incoming_dco can react</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * as need be.</span><br><span>      */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int ret;</span><br><span>     switch (gnlh=
-&gt;cmd)</span><br><span>     {</span><br><span>         case OVPN_CMD_PEE=
R_GET:</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            return ovpn_handle_peer(dco, attrs);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            ret =3D ovpn_handle_pe=
er(dco, attrs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        break;</span><br><span>         }</span><br><span> </span><br><span=
>         case OVPN_CMD_PEER_DEL_NTF:</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            return ovpn_handle_p=
eer_del_ntf(dco, attrs);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            ret =3D ovpn_handle_peer_del_ntf(dco, attrs);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><sp=
an>         }</span><br><span> </span><br><span>         case OVPN_CMD_PEER=
_FLOAT_NTF:</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            return ovpn_handle_peer_float_ntf(dco, attrs);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret =3D=
 ovpn_handle_peer_float_ntf(dco, attrs);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            break;</span><br><span>         }</span><b=
r><span> </span><br><span>         case OVPN_CMD_KEY_SWAP_NTF:</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     return ovpn_handle_key_swap_ntf(dco, attrs);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            ret =3D ovpn_handle_key_swap_ntf(=
dco, attrs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     break;</span><br><span>         }</span><br><span> </span><br><span>  =
       default:</span><br><span>@@ -1125,15 +1139,33 @@</span><br><span>   =
          return NL_STOP;</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret !=3D NL_OK)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return ret;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        multi_process_incoming_dco(dco);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   process_incoming_dco(dco);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     return NL_OK;</span><br><span> }</span><br><span> </span>=
<br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_do_=
read(dco_context_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+dco_read_and_process(dco_context_t *dco)</span><br><span> {</span><br>=
<span>     msg(D_DCO_DEBUG, __func__);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return ovpn_nl_recvmsgs(dco, __func_=
_);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __is_locked =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int re=
t =3D ovpn_nl_recvmsgs(dco, __func__);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    __is_locked =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return ret;</span><br><span> }</span><br><span> </span><br><span=
> static int</span><br><span>@@ -1195,6 +1227,12 @@</span><br><span> int</s=
pan><br><span> dco_get_peer_stats_multi(dco_context_t *dco, const bool rais=
e_sigusr1_on_err)</span><br><span> {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (__is_locked)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(D_DCO_DEBUG, &quot;cannot request peer stats while parsing =
other messages&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     return dco_get_peer(dco, -1, raise_sigusr1_on_err);</span><br><spa=
n> }</span><br><span> </span><br><span>diff --git a/src/openvpn/dco_win.c b=
/src/openvpn/dco_win.c</span><br><span>index ca5eedf..94f043f 100644</span>=
<br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco=
_win.c</span><br><span>@@ -690,7 +690,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-dco_do_read(dco_context_t *dco)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+dco_read_and_process(dco_context_t *dco)</span><br><span> {=
</span><br><span>     if (dco-&gt;ifmode !=3D DCO_MODE_MP)</span><br><span>=
     {</span><br><span>@@ -727,6 +727,15 @@</span><br><span>             br=
eak;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        multi_process_incoming_dco(dco);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        process_incoming_dco(dco);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span>     return 0;</span><br><span> }</span><=
br><span> </span><br><span>diff --git a/src/openvpn/forward.c b/src/openvpn=
/forward.c</span><br><span>index ccb8404..1a68af4 100644</span><br><span>--=
- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span=
><br><span>@@ -1243,19 +1243,11 @@</span><br><span>     }</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-process_inco=
ming_dco(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+process=
_incoming_dco(dco_context_t *dco)</span><br><span> {</span><br><span> #if d=
efined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREE=
BSD))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_context_=
t *dco =3D &amp;c-&gt;c1.tuntap-&gt;dco;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  dco_do_read(dco);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* no message for u=
s to handle - platform specific code has logged details */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (dco-&gt;dco_message_type =3D=
=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct context *c =3D dco-&gt;c;</span><br><spa=
n> </span><br><span>     /* FreeBSD currently sends us removal notifcation =
with the old peer-id in</span><br><span>      * p2p mode with the ping time=
out reason, so ignore that one to not shoot</span><br><span>@@ -2369,7 +236=
1,7 @@</span><br><span>     {</span><br><span>         if (!IS_SIG(c))</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            process_incoming_dco(c);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            dco_read_and_process(&amp;c-&gt;c1.tuntap-&gt=
;dco);</span><br><span>         }</span><br><span>     }</span><br><span> }=
</span><br><span>diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h=
</span><br><span>index a575faf..9e9b02e 100644</span><br><span>--- a/src/op=
envpn/forward.h</span><br><span>+++ b/src/openvpn/forward.h</span><br><span=
>@@ -210,6 +210,13 @@</span><br><span>                                  con=
st struct sockaddr *float_sa);</span><br><span> </span><br><span> /**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Process an incoming DC=
O message (from kernel space).</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram dco - Pointer to the structure representing the DCO context.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void process_incoming_dco(dco_context_t *dco);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Write a packet=
 to the external network interface.</span><br><span>  * @ingroup external_m=
ultiplexer</span><br><span>  *</span><br><span>diff --git a/src/openvpn/mul=
ti.c b/src/openvpn/multi.c</span><br><span>index 2b944667..153695c 100644</=
span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/=
multi.c</span><br><span>@@ -3263,14 +3263,12 @@</span><br><span>     multi_=
signal_instance(m, mi, SIGTERM);</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-multi_process_incoming_dco(struct multi_con=
text *m)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+multi_process_incoming_dco=
(dco_context_t *dco)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    dco_context_t *dco =3D &amp;m-&gt;top.c1.tuntap-&gt;d=
co;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(dco-&=
gt;c-&gt;multi);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct multi_instance *mi =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int ret =3D dco_do_read(&amp;m-&gt;top.c1.tuntap-&gt;dco);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_cont=
ext *m =3D dco-&gt;c-&gt;multi;</span><br><span> </span><br><span>     int =
peer_id =3D dco-&gt;dco_message_peer_id;</span><br><span> </span><br><span>=
@@ -3279,12 +3277,12 @@</span><br><span>      */</span><br><span>     if (p=
eer_id &lt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return ret &gt; 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return;</span><br><span>     }</span><br><sp=
an> </span><br><span>     if ((peer_id &lt; m-&gt;max_clients) &amp;&amp; (=
m-&gt;instances[peer_id]))</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        mi =3D m-&gt;instances[peer_id];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct multi_insta=
nce *mi =3D m-&gt;instances[peer_id];</span><br><span>         set_prefix(m=
i);</span><br><span>         if (dco-&gt;dco_message_type =3D=3D OVPN_CMD_D=
EL_PEER)</span><br><span>         {</span><br><span>@@ -3325,11 +3323,6 @@<=
/span><br><span>             &quot;type %d, del_peer_reason %d&quot;,</span=
><br><span>             peer_id, dco-&gt;dco_message_type, dco-&gt;dco_del_=
peer_reason);</span><br><span>     }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dc=
o-&gt;dco_message_type =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    dco-&gt;dco_message_peer_id =3D -1;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    dco-&gt;dco_del_peer_reason =3D -1;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    return ret &gt; 0;</span><b=
r><span> }</span><br><span> #endif /* if defined(ENABLE_DCO) */</span><br><=
span> </span><br><span>@@ -4462,4 +4455,4 @@</span><br><span> </span><br><s=
pan>     return (!ipv6_net_contains_host(&amp;ifconfig_local, o-&gt;ifconfi=
g_ipv6_netbits,</span><br><span>                                     dest))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>\ =
No newline at end of file</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/mult=
i.h</span><br><span>index a62b07a..a44f9f2 100644</span><br><span>--- a/src=
/openvpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>=
@@ -305,13 +305,9 @@</span><br><span> /**</span><br><span>  * Process an in=
coming DCO message (from kernel space).</span><br><span>  *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * @param m            - The single \=
c multi_context structure.</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - True, if the messag=
e was received correctly.</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *  - False, if there was an error while reading the message.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dco - Pointer to th=
e structure representing the DCO context.</span><br><span>  */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-bool multi_process_incoming_dco(st=
ruct multi_context *m);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void multi_process_incoming_dco(dco_context_t *dco);</span><br><span> <=
/span><br><span> /*********************************************************=
*****************/</span><br><span> /**</span><br><span>diff --git a/src/op=
envpn/multi_io.c b/src/openvpn/multi_io.c</span><br><span>index fe72456..99=
7951e 100644</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>+=
++ b/src/openvpn/multi_io.c</span><br><span>@@ -505,7 +505,7 @@</span><br><=
span>                 /* incoming data on DCO? */</span><br><span>         =
        else if (e-&gt;arg =3D=3D MULTI_IO_DCO)</span><br><span>           =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      multi_process_incoming_dco(m);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    dco_read_and_process(&amp;m-&gt;top.c1=
.tuntap-&gt;dco);</span><br><span>                 }</span><br><span> #endi=
f</span><br><span>                 /* signal received? */</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1403?usp=3Demail">change 1403</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1403?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefc251cb4483c0b9fb9d6a5207d=
b4445cd884d52 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1403 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>

</body></html>=

--TlJcIdpDw5k=--

