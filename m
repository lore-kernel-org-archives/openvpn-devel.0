From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 25 Nov 2025 11:23:28 +0000
In-Reply-To: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
References: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <85393e8163b4f82fd38819bc793f2f1e33ed846a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4c42sK06a3I="; charset=UTF-8
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

--4c42sK06a3I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail

to look at the new patch set (#4).


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
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/multi_io.c
9 files changed, 71 insertions(+), 35 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1403/4

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
index 0ae30b1..7c55f98 100644
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
@@ -1125,11 +1130,25 @@
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
index ccb8404..070018e 100644
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
@@ -2369,7 +2367,7 @@
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
index 2b944667..1459976 100644
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
@@ -3329,7 +3327,6 @@
     dco->dco_message_type =3D 0;
     dco->dco_message_peer_id =3D -1;
     dco->dco_del_peer_reason =3D -1;
-    return ret > 0;
 }
 #endif /* if defined(ENABLE_DCO) */

@@ -4462,4 +4459,4 @@

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
Gerrit-PatchSet: 4
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--4c42sK06a3I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ralf_lici <strong>uploaded patch set #4</strong> to this change.</p><p><=
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
s.<br><br>Reported-by: Stefan Baranoff<br>Change-Id: Iefc251cb4483c0b9fb9d6=
a5207db4445cd884d52<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>=
---<br>M src/openvpn/dco.h<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/=
dco_linux.c<br>M src/openvpn/dco_win.c<br>M src/openvpn/forward.c<br>M src/=
openvpn/forward.h<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M sr=
c/openvpn/multi_io.c<br>9 files changed, 71 insertions(+), 35 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/03/1403/4</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.h b/src/openvpn=
/dco.h</span><br><span>index e5e8709..cd6e32a 100644</span><br><span>--- a/=
src/openvpn/dco.h</span><br><span>+++ b/src/openvpn/dco.h</span><br><span>@=
@ -127,12 +127,13 @@</span><br><span> void close_tun_dco(struct tuntap *tt,=
 openvpn_net_ctx_t *ctx);</span><br><span> </span><br><span> /**</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * Read data from the DCO commun=
ication channel (i.e. a control packet)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Read and process data from the DCO communication cha=
nnel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (i.e. a cont=
rol packet)</span><br><span>  *</span><br><span>  * @param dco       the DC=
O context</span><br><span>  * @return          0 on success or a negative e=
rror code otherwise</span><br><span>  */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-int dco_do_read(dco_context_t *dco);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+int dco_read_and_process(dco_context_t =
*dco);</span><br><span> </span><br><span> /**</span><br><span>  * Install a=
 DCO in the main event loop</span><br><span>@@ -305,7 +306,7 @@</span><br><=
span> }</span><br><span> </span><br><span> static inline int</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-dco_do_read(dco_context_t *dco)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_read_and_process(dco=
_context_t *dco)</span><br><span> {</span><br><span>     ASSERT(false);</sp=
an><br><span>     return 0;</span><br><span>diff --git a/src/openvpn/dco_fr=
eebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index f2a89ac..25deafe =
100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</span><br><span>+++ =
b/src/openvpn/dco_freebsd.c</span><br><span>@@ -578,7 +578,7 @@</span><br><=
span> }</span><br><span> </span><br><span> int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-dco_do_read(dco_context_t *dco)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+dco_read_and_process(dco_context_t *dc=
o)</span><br><span> {</span><br><span>     struct ifdrv drv;</span><br><spa=
n>     uint8_t buf[4096];</span><br><span>@@ -689,6 +689,15 @@</span><br><s=
pan> </span><br><span>     nvlist_destroy(nvl);</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;c-&gt;mode =
=3D=3D CM_TOP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_proce=
ss_incoming_dco(dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        process_incoming_dco(dco);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return 0;</spa=
n><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/d=
co_linux.c b/src/openvpn/dco_linux.c</span><br><span>index 0ae30b1..7c55f98=
 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b=
/src/openvpn/dco_linux.c</span><br><span>@@ -1094,29 +1094,34 @@</span><br>=
<span>      * message, that stores the type-specific attributes.</span><br>=
<span>      *</span><br><span>      * the &quot;dco&quot; object is then fi=
lled accordingly with the information</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-     * retrieved from the message, so that the rest of the =
OpenVPN code can</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
* react as need be.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * retrieved from the message, so that *process_incoming_dco can react<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * as need be.</=
span><br><span>      */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int ret;</span><br><span>     switch (gnlh-&gt;cmd)</span><br><span=
>     {</span><br><span>         case OVPN_CMD_PEER_GET:</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            r=
eturn ovpn_handle_peer(dco, attrs);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            ret =3D ovpn_handle_peer(dco, attrs);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br>=
<span>         }</span><br><span> </span><br><span>         case OVPN_CMD_P=
EER_DEL_NTF:</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            return ovpn_handle_peer_del_ntf(dco, attrs);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret =3D =
ovpn_handle_peer_del_ntf(dco, attrs);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            break;</span><br><span>         }</span><br><=
span> </span><br><span>         case OVPN_CMD_PEER_FLOAT_NTF:</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    return ovpn_handle_peer_float_ntf(dco, attrs);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            ret =3D ovpn_handle_peer_float_n=
tf(dco, attrs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        break;</span><br><span>         }</span><br><span> </span><br><span=
>         case OVPN_CMD_KEY_SWAP_NTF:</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            return ovpn_handle_k=
ey_swap_ntf(dco, attrs);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            ret =3D ovpn_handle_key_swap_ntf(dco, attrs);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><sp=
an>         }</span><br><span> </span><br><span>         default:</span><br=
><span>@@ -1125,11 +1130,25 @@</span><br><span>             return NL_STOP;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (ret !=3D NL_OK)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return ret;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;c-&gt=
;mode =3D=3D CM_TOP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi=
_process_incoming_dco(dco);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        process_incoming_dco(dc=
o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return N=
L_OK;</span><br><span> }</span><br><span> </span><br><span> int</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-dco_do_read(dco_context_t *dco)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_read_and_process(=
dco_context_t *dco)</span><br><span> {</span><br><span>     msg(D_DCO_DEBUG=
, __func__);</span><br><span> </span><br><span>diff --git a/src/openvpn/dco=
_win.c b/src/openvpn/dco_win.c</span><br><span>index ca5eedf..94f043f 10064=
4</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/ope=
nvpn/dco_win.c</span><br><span>@@ -690,7 +690,7 @@</span><br><span> }</span=
><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-dco_do_read(dco_context_t *dco)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+dco_read_and_process(dco_context_t *dco)</span><br>=
<span> {</span><br><span>     if (dco-&gt;ifmode !=3D DCO_MODE_MP)</span><b=
r><span>     {</span><br><span>@@ -727,6 +727,15 @@</span><br><span>       =
      break;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        multi_process_incoming_dc=
o(dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        process_incoming_dco(dco);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     return 0;</span><br><span> }=
</span><br><span> </span><br><span>diff --git a/src/openvpn/forward.c b/src=
/openvpn/forward.c</span><br><span>index ccb8404..070018e 100644</span><br>=
<span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward=
.c</span><br><span>@@ -1243,13 +1243,11 @@</span><br><span>     }</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-proc=
ess_incoming_dco(struct context *c)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+process_incoming_dco(dco_context_t *dco)</span><br><span> {</span><br><spa=
n> #if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TAR=
GET_FREEBSD))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_=
context_t *dco =3D &amp;c-&gt;c1.tuntap-&gt;dco;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    dco_do_read(dco);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct context *c =3D dco-&gt;c;</span><br><span> </span><br><s=
pan>     /* no message for us to handle - platform specific code has logged=
 details */</span><br><span>     if (dco-&gt;dco_message_type =3D=3D 0)</sp=
an><br><span>@@ -2369,7 +2367,7 @@</span><br><span>     {</span><br><span> =
        if (!IS_SIG(c))</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            process_incoming_dco(c);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            dco_read_and_proc=
ess(&amp;c-&gt;c1.tuntap-&gt;dco);</span><br><span>         }</span><br><sp=
an>     }</span><br><span> }</span><br><span>diff --git a/src/openvpn/forwa=
rd.h b/src/openvpn/forward.h</span><br><span>index a575faf..9e9b02e 100644<=
/span><br><span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/openv=
pn/forward.h</span><br><span>@@ -210,6 +210,13 @@</span><br><span>         =
                         const struct sockaddr *float_sa);</span><br><span>=
 </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Process an incoming DCO message (from kernel space).</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param dco - Pointer to the structure representing=
 the DCO context.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void process_incom=
ing_dco(dco_context_t *dco);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span>  * Write a packet to the external network interface.</span><br><=
span>  * @ingroup external_multiplexer</span><br><span>  *</span><br><span>=
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>inde=
x 2b944667..1459976 100644</span><br><span>--- a/src/openvpn/multi.c</span>=
<br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3263,14 +3263,12 @@=
</span><br><span>     multi_signal_instance(m, mi, SIGTERM);</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_process_in=
coming_dco(struct multi_context *m)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+multi_process_incoming_dco(dco_context_t *dco)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    dco_context_t *dco =3D &am=
p;m-&gt;top.c1.tuntap-&gt;dco;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ASSERT(dco-&gt;c-&gt;multi);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D N=
ULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco_do_read(&amp;m-&gt=
;top.c1.tuntap-&gt;dco);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct multi_context *m =3D dco-&gt;c-&gt;multi;</span><br><span> =
</span><br><span>     int peer_id =3D dco-&gt;dco_message_peer_id;</span><b=
r><span> </span><br><span>@@ -3279,12 +3277,12 @@</span><br><span>      */<=
/span><br><span>     if (peer_id &lt; 0)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        return ret &gt; 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br>=
<span>     }</span><br><span> </span><br><span>     if ((peer_id &lt; m-&gt=
;max_clients) &amp;&amp; (m-&gt;instances[peer_id]))</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi =3D m-&gt;=
instances[peer_id];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        struct multi_instance *mi =3D m-&gt;instances[peer_id];</span><br><=
span>         set_prefix(mi);</span><br><span>         if (dco-&gt;dco_mess=
age_type =3D=3D OVPN_CMD_DEL_PEER)</span><br><span>         {</span><br><sp=
an>@@ -3329,7 +3327,6 @@</span><br><span>     dco-&gt;dco_message_type =3D =
0;</span><br><span>     dco-&gt;dco_message_peer_id =3D -1;</span><br><span=
>     dco-&gt;dco_del_peer_reason =3D -1;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return ret &gt; 0;</span><br><span> }</span><br><sp=
an> #endif /* if defined(ENABLE_DCO) */</span><br><span> </span><br><span>@=
@ -4462,4 +4459,4 @@</span><br><span> </span><br><span>     return (!ipv6_n=
et_contains_host(&amp;ifconfig_local, o-&gt;ifconfig_ipv6_netbits,</span><b=
r><span>                                     dest));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>\ No newline at end of fi=
le</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>ind=
ex a62b07a..a44f9f2 100644</span><br><span>--- a/src/openvpn/multi.h</span>=
<br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -305,13 +305,9 @@</s=
pan><br><span> /**</span><br><span>  * Process an incoming DCO message (fro=
m kernel space).</span><br><span>  *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * @param m            - The single \c multi_context structu=
re.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * @return</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *  - True, if the message was received correctl=
y.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - False, if the=
re was an error while reading the message.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param dco - Pointer to the structure representin=
g the DCO context.</span><br><span>  */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-bool multi_process_incoming_dco(struct multi_context *m);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_process_=
incoming_dco(dco_context_t *dco);</span><br><span> </span><br><span> /*****=
*********************************************************************/</spa=
n><br><span> /**</span><br><span>diff --git a/src/openvpn/multi_io.c b/src/=
openvpn/multi_io.c</span><br><span>index fe72456..997951e 100644</span><br>=
<span>--- a/src/openvpn/multi_io.c</span><br><span>+++ b/src/openvpn/multi_=
io.c</span><br><span>@@ -505,7 +505,7 @@</span><br><span>                 /=
* incoming data on DCO? */</span><br><span>                 else if (e-&gt;=
arg =3D=3D MULTI_IO_DCO)</span><br><span>                 {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    multi_process_inc=
oming_dco(m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              dco_read_and_process(&amp;m-&gt;top.c1.tuntap-&gt;dco);</span=
><br><span>                 }</span><br><span> #endif</span><br><span>     =
            /* signal received? */</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demai=
l">change 1403</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefc251cb4483c0b9fb9d6a5207d=
b4445cd884d52 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1403 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--4c42sK06a3I=--

