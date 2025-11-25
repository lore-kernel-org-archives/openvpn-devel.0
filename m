From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 25 Nov 2025 09:14:57 +0000
References: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <aa6e668ebb2ffa25712c2ad8c8722b7acfde0a6c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="egqxiu5Fq5U="; charset=UTF-8
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

--egqxiu5Fq5U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail

to review the following change.


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

Reported-by: Stefan Baranoff
Change-Id: Iefc251cb4483c0b9fb9d6a5207db4445cd884d52
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/multi_io.c
10 files changed, 74 insertions(+), 41 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1403/1

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
index f2a89ac..ff29ee7 100644
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
@@ -689,6 +689,16 @@

     nvlist_destroy(nvl);

+    if (dco->c->mode =3D=3D CM_TOP)
+    {
+        ASSERT(dco->c->multi);
+        multi_process_incoming_dco(dco->c->multi);
+    }
+    else
+    {
+        process_incoming_dco(dco->c);
+    }
+
     return 0;
 }

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 0ae30b1..ebdfc34 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -1094,29 +1094,34 @@
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
@@ -1125,11 +1130,26 @@
             return NL_STOP;
     }

+    if (ret !=3D NL_OK)
+    {
+        return ret;
+    }
+
+    if (dco->c->mode =3D=3D CM_TOP)
+    {
+        ASSERT(dco->c->multi);
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

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index ca5eedf..54044c5 100644
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
@@ -727,6 +727,16 @@
             break;
     }

+    if (dco->c->mode =3D=3D CM_TOP)
+    {
+        ASSERT(dco->c->multi);
+        multi_process_incoming_dco(dco);
+    }
+    else
+    {
+        ASSERT(false);
+    }
+
     return 0;
 }

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f01fb4c..3ef8794 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1243,13 +1243,11 @@
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
+    struct context *c =3D dco->c;

     /* no message for us to handle - platform specific code has logged det=
ails */
     if (dco->dco_message_type =3D=3D 0)
@@ -2379,7 +2377,7 @@
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
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 31134be..08ec8ff 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -417,11 +417,7 @@
     {
         if (!IS_SIG(&m->top))
         {
-            bool ret =3D true;
-            while (ret)
-            {
-                ret =3D multi_process_incoming_dco(m);
-            }
+            dco_read_and_process(&m->top.c1.tuntap->dco);
         }
     }
 #endif
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2b944667..f3c770e 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3263,14 +3263,10 @@
     multi_signal_instance(m, mi, SIGTERM);
 }

-bool
-multi_process_incoming_dco(struct multi_context *m)
+void
+multi_process_incoming_dco(dco_context_t *dco)
 {
-    dco_context_t *dco =3D &m->top.c1.tuntap->dco;
-
-    struct multi_instance *mi =3D NULL;
-
-    int ret =3D dco_do_read(&m->top.c1.tuntap->dco);
+    struct multi_context *m =3D dco->c->multi;

     int peer_id =3D dco->dco_message_peer_id;

@@ -3279,12 +3275,12 @@
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
@@ -3329,7 +3325,6 @@
     dco->dco_message_type =3D 0;
     dco->dco_message_peer_id =3D -1;
     dco->dco_del_peer_reason =3D -1;
-    return ret > 0;
 }
 #endif /* if defined(ENABLE_DCO) */

@@ -4462,4 +4457,4 @@

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
index 6e31687..3ade59f 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -516,7 +516,7 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iefc251cb4483c0b9fb9d6a5207db4445cd884d52
Gerrit-Change-Number: 1403
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--egqxiu5Fq5U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ralf_lici would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dco: process messages immediately after rea=
d<br><br>Currently, reading and processing of incoming DCO messages are<br>=
decoupled: notifications are read, parsed, and the relevant information<br>=
is stored in fields of dco_context_t for later processing (with the only<br=
>exception being stats). This approach is problematic on Linux, since<br>li=
bnl does not allow reading a single netlink message at a time, which<br>can=
 result in loss of information when multiple notifications are<br>available=
.<br><br>This change adopts a read -&gt; parse -&gt; process paradigm. On L=
inux,<br>processing is now invoked directly from within the parsing callbac=
k,<br>which libnl calls for each received netlink packet. The other interfa=
ces<br>are adapted accordingly to unify the processing model across all<br>=
platforms.<br><br>Reported-by: Stefan Baranoff<br>Change-Id: Iefc251cb4483c=
0b9fb9d6a5207db4445cd884d52<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...=
&gt;<br>---<br>M src/openvpn/dco.h<br>M src/openvpn/dco_freebsd.c<br>M src/=
openvpn/dco_linux.c<br>M src/openvpn/dco_win.c<br>M src/openvpn/forward.c<b=
r>M src/openvpn/forward.h<br>M src/openvpn/mudp.c<br>M src/openvpn/multi.c<=
br>M src/openvpn/multi.h<br>M src/openvpn/multi_io.c<br>10 files changed, 7=
4 insertions(+), 41 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/03/1403/1</pre><pre style=
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
pan><br><span>index f2a89ac..ff29ee7 100644</span><br><span>--- a/src/openv=
pn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br>=
<span>@@ -578,7 +578,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_do_read(d=
co_context_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
co_read_and_process(dco_context_t *dco)</span><br><span> {</span><br><span>=
     struct ifdrv drv;</span><br><span>     uint8_t buf[4096];</span><br><s=
pan>@@ -689,6 +689,16 @@</span><br><span> </span><br><span>     nvlist_dest=
roy(nvl);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        ASSERT(dco-&gt;c-&gt;multi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        multi_process_incoming_dco(dco-&g=
t;c-&gt;multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        process_incoming_dco(dco-&gt;c);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return 0;</s=
pan><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn=
/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index 0ae30b1..ebdfc=
34 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++=
 b/src/openvpn/dco_linux.c</span><br><span>@@ -1094,29 +1094,34 @@</span><b=
r><span>      * message, that stores the type-specific attributes.</span><b=
r><span>      *</span><br><span>      * the &quot;dco&quot; object is then =
filled accordingly with the information</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     * retrieved from the message, so that the rest of th=
e OpenVPN code can</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  * react as need be.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * retrieved from the message, so that *process_incoming_dco can reac=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * as need be.=
</span><br><span>      */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int ret;</span><br><span>     switch (gnlh-&gt;cmd)</span><br><sp=
an>     {</span><br><span>         case OVPN_CMD_PEER_GET:</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 return ovpn_handle_peer(dco, attrs);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            ret =3D ovpn_handle_peer(dco, attrs);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><b=
r><span>         }</span><br><span> </span><br><span>         case OVPN_CMD=
_PEER_DEL_NTF:</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            return ovpn_handle_peer_del_ntf(dco, attrs)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret =
=3D ovpn_handle_peer_del_ntf(dco, attrs);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            break;</span><br><span>         }</span><=
br><span> </span><br><span>         case OVPN_CMD_PEER_FLOAT_NTF:</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        return ovpn_handle_peer_float_ntf(dco, attrs);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            ret =3D ovpn_handle_peer_flo=
at_ntf(dco, attrs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            break;</span><br><span>         }</span><br><span> </span><br><=
span>         case OVPN_CMD_KEY_SWAP_NTF:</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            return ovpn_hand=
le_key_swap_ntf(dco, attrs);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            ret =3D ovpn_handle_key_swap_ntf(dco, attrs);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br=
><span>         }</span><br><span> </span><br><span>         default:</span=
><br><span>@@ -1125,11 +1130,26 @@</span><br><span>             return NL_S=
TOP;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (ret !=3D NL_OK)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return ret;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;c=
-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        A=
SSERT(dco-&gt;c-&gt;multi);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        multi_process_incoming_dco(dco);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pr=
ocess_incoming_dco(dco);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     return NL_OK;</span><br><span> }</span><br><span> </span><br><=
span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_do_read(=
dco_context_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
dco_read_and_process(dco_context_t *dco)</span><br><span> {</span><br><span=
>     msg(D_DCO_DEBUG, __func__);</span><br><span> </span><br><span>diff --=
git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index c=
a5eedf..54044c5 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><b=
r><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -690,7 +690,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-dco_do_read(dco_context_t *dco)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dco_read_and_process(dco_conte=
xt_t *dco)</span><br><span> {</span><br><span>     if (dco-&gt;ifmode !=3D =
DCO_MODE_MP)</span><br><span>     {</span><br><span>@@ -727,6 +727,16 @@</s=
pan><br><span>             break;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;c-&g=
t;mode =3D=3D CM_TOP)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSE=
RT(dco-&gt;c-&gt;multi);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        multi_process_incoming_dco(dco);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSER=
T(false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     re=
turn 0;</span><br><span> }</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>index f01fb4c.=
.3ef8794 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><span=
>+++ b/src/openvpn/forward.c</span><br><span>@@ -1243,13 +1243,11 @@</span>=
<br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-process_incoming_dco(struct context *c)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+process_incoming_dco(dco_context_t *dco)</span><=
br><span> {</span><br><span> #if defined(ENABLE_DCO) &amp;&amp; (defined(TA=
RGET_LINUX) || defined(TARGET_FREEBSD))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    dco_context_t *dco =3D &amp;c-&gt;c1.tuntap-&gt;dco;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    dco_do_read(dco);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D dco-&gt;c;</spa=
n><br><span> </span><br><span>     /* no message for us to handle - platfor=
m specific code has logged details */</span><br><span>     if (dco-&gt;dco_=
message_type =3D=3D 0)</span><br><span>@@ -2379,7 +2377,7 @@</span><br><spa=
n>     {</span><br><span>         if (!IS_SIG(c))</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            process_=
incoming_dco(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         dco_read_and_process(&amp;c-&gt;c1.tuntap-&gt;dco);</span><br><spa=
n>         }</span><br><span>     }</span><br><span> }</span><br><span>diff=
 --git a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>inde=
x a575faf..9e9b02e 100644</span><br><span>--- a/src/openvpn/forward.h</span=
><br><span>+++ b/src/openvpn/forward.h</span><br><span>@@ -210,6 +210,13 @@=
</span><br><span>                                  const struct sockaddr *f=
loat_sa);</span><br><span> </span><br><span> /**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Process an incoming DCO message (from kerne=
l space).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dco - Pointer to =
the structure representing the DCO context.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void process_incoming_dco(dco_context_t *dco);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span>  * Write a packet to the external netw=
ork interface.</span><br><span>  * @ingroup external_multiplexer</span><br>=
<span>  *</span><br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mud=
p.c</span><br><span>index 31134be..08ec8ff 100644</span><br><span>--- a/src=
/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@=
 -417,11 +417,7 @@</span><br><span>     {</span><br><span>         if (!IS_=
SIG(&amp;m-&gt;top))</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            bool ret =3D true;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            while (ret)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                ret =3D multi_process_incoming=
_dco(m);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dco_rea=
d_and_process(&amp;m-&gt;top.c1.tuntap-&gt;dco);</span><br><span>         }=
</span><br><span>     }</span><br><span> #endif</span><br><span>diff --git =
a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 2b944667.=
.f3c770e 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+=
++ b/src/openvpn/multi.c</span><br><span>@@ -3263,14 +3263,10 @@</span><br>=
<span>     multi_signal_instance(m, mi, SIGTERM);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_process_incoming_dco(=
struct multi_context *m)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_proc=
ess_incoming_dco(dco_context_t *dco)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    dco_context_t *dco =3D &amp;m-&gt;top=
.c1.tuntap-&gt;dco;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instan=
ce *mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco_do_rea=
d(&amp;m-&gt;top.c1.tuntap-&gt;dco);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct multi_context *m =3D dco-&gt;c-&gt;multi;</span=
><br><span> </span><br><span>     int peer_id =3D dco-&gt;dco_message_peer_=
id;</span><br><span> </span><br><span>@@ -3279,12 +3275,12 @@</span><br><sp=
an>      */</span><br><span>     if (peer_id &lt; 0)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return ret &g=
t; 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
;</span><br><span>     }</span><br><span> </span><br><span>     if ((peer_i=
d &lt; m-&gt;max_clients) &amp;&amp; (m-&gt;instances[peer_id]))</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
i =3D m-&gt;instances[peer_id];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct multi_instance *mi =3D m-&gt;instances[peer_id];=
</span><br><span>         set_prefix(mi);</span><br><span>         if (dco-=
&gt;dco_message_type =3D=3D OVPN_CMD_DEL_PEER)</span><br><span>         {</=
span><br><span>@@ -3329,7 +3325,6 @@</span><br><span>     dco-&gt;dco_messa=
ge_type =3D 0;</span><br><span>     dco-&gt;dco_message_peer_id =3D -1;</sp=
an><br><span>     dco-&gt;dco_del_peer_reason =3D -1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return ret &gt; 0;</span><br><span> }</=
span><br><span> #endif /* if defined(ENABLE_DCO) */</span><br><span> </span=
><br><span>@@ -4462,4 +4457,4 @@</span><br><span> </span><br><span>     ret=
urn (!ipv6_net_contains_host(&amp;ifconfig_local, o-&gt;ifconfig_ipv6_netbi=
ts,</span><br><span>                                     dest));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>\ No newline a=
t end of file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><b=
r><span>index a62b07a..a44f9f2 100644</span><br><span>--- a/src/openvpn/mul=
ti.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -305,13 +=
305,9 @@</span><br><span> /**</span><br><span>  * Process an incoming DCO m=
essage (from kernel space).</span><br><span>  *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * @param m            - The single \c multi_cont=
ext structure.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *  - True, if the message was receiv=
ed correctly.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - Fa=
lse, if there was an error while reading the message.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param dco - Pointer to the structure =
representing the DCO context.</span><br><span>  */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-bool multi_process_incoming_dco(struct multi_c=
ontext *m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void mul=
ti_process_incoming_dco(dco_context_t *dco);</span><br><span> </span><br><s=
pan> /*********************************************************************=
*****/</span><br><span> /**</span><br><span>diff --git a/src/openvpn/multi_=
io.c b/src/openvpn/multi_io.c</span><br><span>index 6e31687..3ade59f 100644=
</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>+++ b/src/ope=
nvpn/multi_io.c</span><br><span>@@ -516,7 +516,7 @@</span><br><span>       =
          /* incoming data on DCO? */</span><br><span>                 else=
 if (e-&gt;arg =3D=3D MULTI_IO_DCO)</span><br><span>                 {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    multi_=
process_incoming_dco(m);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    dco_read_and_process(&amp;m-&gt;top.c1.tuntap-&gt;=
dco);</span><br><span>                 }</span><br><span> #endif</span><br>=
<span>                 /* signal received? */</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1403=
?usp=3Demail">change 1403</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1403?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefc251cb4483c0b9fb9d6a5207d=
b4445cd884d52 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1403 </div>
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

--egqxiu5Fq5U=--

