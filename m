From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 14 Oct 2025 20:18:21 +0000
In-Reply-To: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
References: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726..., gert@...1296...
Message-ID: <05d461df08ffb50a01b21a18fcfdc50104ca0a0f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1GLepBCh3ZU="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE server:
 remove old IP(s) from vhash after sending a messa...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1GLepBCh3ZU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail

to look at the new patch set (#7).


Change subject: PUSH_UPDATE server: remove old IP(s) from vhash after sendi=
ng a message containing ifconfig(-ipv6)
......................................................................

PUSH_UPDATE server: remove old IP(s) from vhash after sending a message con=
taining ifconfig(-ipv6)

When sending a PUSH_UPDATE containing an ifconfig(-ipv6) option, we must ad=
d the new IP to the
multi_context vhash (hash table of the clients indexed by virtual IPs). Now=
 in addition to
adding new client IPs, old IPs are also removed from vhash, allowing for a =
more complete update.

Change-Id: I07a8ddd9026eef64b6f5abde98702a9801616a5f
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/push.c
M src/openvpn/push.h
M src/openvpn/push_util.c
M tests/unit_tests/openvpn/test_push_update_msg.c
6 files changed, 205 insertions(+), 72 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/1253/7

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2863ff1..558314c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4269,46 +4269,144 @@
     close_instance(top);
 }

+/* Searches for the address and deletes it if it is owned by the multi_ins=
tance */
+static void
+multi_unlearn_addr(struct multi_context *m, struct multi_instance *mi, con=
st struct mroute_addr *addr)
+{
+    struct hash_element *he;
+    const uint32_t hv =3D hash_value(m->vhash, addr);
+    struct hash_bucket *bucket =3D hash_bucket(m->vhash, hv);
+    struct multi_route *r =3D NULL;
+
+    /* if route currently exists, get the instance which owns it */
+    he =3D hash_lookup_fast(m->vhash, bucket, addr, hv);
+    if (he)
+    {
+        r =3D (struct multi_route *)he->value;
+    }
+
+    /* if the route does not exist or exists but is not owned by the curre=
nt instance, return */
+    if (!r || r->instance !=3D mi)
+    {
+        return;
+    }
+
+    struct gc_arena gc =3D gc_new();
+    msg(D_MULTI_LOW, "MULTI: Unlearn: %s -> %s", mroute_addr_print(&r->add=
r, &gc), multi_instance_string(mi, false, &gc));
+    learn_address_script(m, NULL, "delete", &r->addr);
+    hash_remove_by_value(m->vhash, r);
+    multi_route_del(r);
+
+    gc_free(&gc);
+}
+
+/**
+ * @param m     The multi_context
+ * @param mi    The multi_instance of the client we are updating
+ * @param a     The new IPv4 address in network byte order
+ */
+static void
+multi_unlearn_in_addr_t(struct multi_context *m, struct multi_instance *mi=
, in_addr_t a)
+{
+    struct mroute_addr addr;
+    CLEAR(addr);
+
+    addr.type =3D MR_ADDR_IPV4;
+    addr.len =3D 4;
+    addr.v4.addr =3D a;
+
+    multi_unlearn_addr(m, mi, &addr);
+}
+
+/**
+ * @param m     The multi_context
+ * @param mi    The multi_instance of the client we are updating
+ * @param a6    The new IPv6 address
+ */
+static void
+multi_unlearn_in6_addr(struct multi_context *m, struct multi_instance *mi,=
 struct in6_addr a6)
+{
+    struct mroute_addr addr;
+    CLEAR(addr);
+
+    addr.type =3D MR_ADDR_IPV6;
+    addr.len =3D 16;
+    addr.v6.addr =3D a6;
+
+    multi_unlearn_addr(m, mi, &addr);
+}
+
+/* Function to unlearn previous ifconfig of a client in the server multi_c=
ontext after a PUSH_UPDATE */
+void
+unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi)
+{
+    in_addr_t old_addr =3D 0;
+    old_addr =3D htonl(mi->context.c2.push_ifconfig_local);
+    multi_unlearn_in_addr_t(m, mi, old_addr);
+    mi->context.c2.push_ifconfig_defined =3D false;
+    mi->context.c2.push_ifconfig_local =3D 0;
+}
+
+/* Function to unlearn previous ifconfig-ipv6 of a client in the server mu=
lti_context after a PUSH_UPDATE */
+void
+unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)
+{
+    struct in6_addr old_addr6;
+    CLEAR(old_addr6);
+    old_addr6 =3D mi->context.c2.push_ifconfig_ipv6_local;
+    multi_unlearn_in6_addr(m, mi, old_addr6);
+    mi->context.c2.push_ifconfig_ipv6_defined =3D false;
+    CLEAR(mi->context.c2.push_ifconfig_ipv6_local);
+}
+
 /**
  * Update the vhash with new IP/IPv6 addresses in the multi_context when a
  * push-update message containing ifconfig/ifconfig-ipv6 options is sent
- * from the server. This function should be called after a push-update
- * and old_ip/old_ipv6 are the previous addresses of the client in
- * ctx->options.ifconfig_local and ctx->options.ifconfig_ipv6_local.
+ * from the server.
+ *
+ * @param m         The multi_context
+ * @param mi        The multi_instance of the client we are updating
+ * @param new_ip    The new IPv4 address or NULL if no change
+ * @param new_ipv6  The new IPv6 address or NULL if no change
  */
 void
-update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *old_ip, const char *old_ipv6)
+update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *new_ip, const char *new_ipv6)
 {
-    struct in_addr addr;
-    struct in6_addr new_ipv6;
-
-    if ((mi->context.options.ifconfig_local && (!old_ip || strcmp(old_ip, =
mi->context.options.ifconfig_local)))
-        && inet_pton(AF_INET, mi->context.options.ifconfig_local, &addr) =
=3D=3D 1)
+    if (new_ip)
     {
-        in_addr_t new_ip =3D ntohl(addr.s_addr);
+        /* Remove old IP */
+        if (mi->context.c2.push_ifconfig_defined)
+        {
+            unlearn_ifconfig(m, mi);
+        }

         /* Add new IP */
-        multi_learn_in_addr_t(m, mi, new_ip, -1, true);
+        struct in_addr new_addr;
+        CLEAR(new_addr);
+        if (inet_pton(AF_INET, new_ip, &new_addr) =3D=3D 1
+            && multi_learn_in_addr_t(m, mi, ntohl(new_addr.s_addr), -1, tr=
ue))
+        {
+            mi->context.c2.push_ifconfig_defined =3D true;
+            mi->context.c2.push_ifconfig_local =3D ntohl(new_addr.s_addr);
+        }
     }

-    /* TO DO:
-     *  else if (old_ip)
-     *  {
-     *      // remove old IP
-     *  }
-     */
-
-    if ((mi->context.options.ifconfig_ipv6_local && (!old_ipv6 || strcmp(o=
ld_ipv6, mi->context.options.ifconfig_ipv6_local)))
-        && inet_pton(AF_INET6, mi->context.options.ifconfig_ipv6_local, &n=
ew_ipv6) =3D=3D 1)
+    if (new_ipv6)
     {
-        /* Add new IPv6 */
-        multi_learn_in6_addr(m, mi, new_ipv6, -1, true);
-    }
+        /* Remove old IPv6 */
+        if (mi->context.c2.push_ifconfig_ipv6_defined)
+        {
+            unlearn_ifconfig_ipv6(m, mi);
+        }

-    /* TO DO:
-     *  else if (old_ipv6)
-     *  {
-     *      // remove old IPv6
-     *  }
-     */
+        /* Add new IPv6 */
+        struct in6_addr new_addr6;
+        CLEAR(new_addr6);
+        if (inet_pton(AF_INET6, new_ipv6, &new_addr6) =3D=3D 1
+            && multi_learn_in6_addr(m, mi, new_addr6, -1, true))
+        {
+            mi->context.c2.push_ifconfig_ipv6_defined =3D true;
+            mi->context.c2.push_ifconfig_ipv6_local =3D new_addr6;
+        }
+    }
 }
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index b2b892b..97bbc4a 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -692,6 +692,8 @@
 #endif

 void
-update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *old_ip, const char *old_ipv6);
+update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *new_ip, const char *new_ipv6);
+void unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi);
+void unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance =
*mi);

 #endif /* MULTI_H */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 0c8eb84..2c717c7 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1118,7 +1118,7 @@
                         " To be able to process PUSH_UPDATE messages, be s=
ure to use the --disable-dco option.");
             return PUSH_MSG_ERROR;
         }
-        return process_incoming_push_update(c, permission_mask, option_typ=
es_found, &buf, false);
+        return process_push_update(c, &c->options, permission_mask, option=
_types_found, &buf, false);
     }
     else
     {
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 6b3275e..19a029a 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -61,11 +61,13 @@
  * message has not yet been received.
  *
  * @param c The context for the operation.
+ * @param o The options structure to be updated with the received push opt=
ions.
  * @param permission_mask The permission mask specifying which options are=
 allowed to be pulled.
  * @param option_types_found A pointer to a variable that will be filled w=
ith the types of options
  *                           found in the message.
  * @param buf A buffer containing the received message.
- * @param msg_sender A boolean indicating if function is called by the mes=
sage sender (server).
+ * @param msg_sender A boolean indicating if the message is being processe=
d on the client (false)
+ *                   or on the server (true).
  *
  * @return
  * - `PUSH_MSG_UPDATE`: The message was processed successfully, and the up=
dates were applied.
@@ -74,9 +76,8 @@
  * - `PUSH_MSG_ERROR`: An error occurred during message processing, or the=
 message is invalid.
  */

-int process_incoming_push_update(struct context *c, unsigned int permissio=
n_mask,
-                                 unsigned int *option_types_found, struct =
buffer *buf,
-                                 bool msg_sender);
+int process_push_update(struct context *c, struct options *o, unsigned int=
 permission_mask,
+                        unsigned int *option_types_found, struct buffer *b=
uf, bool msg_sender);

 int process_incoming_push_msg(struct context *c, const struct buffer *buff=
er,
                               bool honor_received_options, unsigned int pe=
rmission_mask,
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 25c6ebe..0e86ad3 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -16,18 +16,17 @@
 #endif

 int
-process_incoming_push_update(struct context *c, unsigned int permission_ma=
sk,
-                             unsigned int *option_types_found, struct buff=
er *buf,
-                             bool msg_sender)
+process_push_update(struct context *c, struct options *o, unsigned int per=
mission_mask,
+                    unsigned int *option_types_found, struct buffer *buf, =
bool msg_sender)
 {
     int ret =3D PUSH_MSG_ERROR;
     const uint8_t ch =3D buf_read_u8(buf);
     if (ch =3D=3D ',')
     {
-        if (apply_push_options(c, &c->options, buf, permission_mask, optio=
n_types_found, c->c2.es,
+        if (apply_push_options(c, o, buf, permission_mask, option_types_fo=
und, c->c2.es,
                                true))
         {
-            switch (c->options.push_continuation)
+            switch (o->push_continuation)
             {
                 case 0:
                 case 1:
@@ -144,13 +143,27 @@

 /* send the message(s) prepared to one single client */
 static bool
-send_single_push_update(struct context *c, struct buffer *msgs, unsigned i=
nt *option_types_found)
+send_single_push_update(struct multi_context *m, struct multi_instance *mi=
, struct buffer *msgs)
 {
     if (!msgs[0].data || !*(msgs[0].data))
     {
         return false;
     }
+
     int i =3D -1;
+    unsigned int option_types_found =3D 0;
+    struct context *c =3D &mi->context;
+    struct options o;
+    CLEAR(o);
+
+    /* Set canary values to detect ifconfig options in push-update message=
s.
+     * These placeholder strings will be overwritten to NULL by the option
+     * parser if -ifconfig or -ifconfig-ipv6 options are present in the
+     * push-update.
+     */
+    const char *canary =3D "canary";
+    o.ifconfig_local =3D canary;
+    o.ifconfig_ipv6_local =3D canary;

     while (msgs[++i].data && *(msgs[i].data))
     {
@@ -159,14 +172,14 @@
             return false;
         }

-        /* After sending the control message, we update the options
-         * server-side in the client's context so pushed options like
-         * ifconfig/ifconfig-ipv6 can actually work.
+        /* After sending the control message, we parse it, miming the beha=
vior
+         * of `process_incoming_push_msg()` and we fill an empty `options`=
 struct
+         * with the new options. If an `ifconfig_local` or `ifconfig_ipv6_=
local`
+         * options is found we update the vhash accordingly, so that the p=
ushed
+         * ifconfig/ifconfig-ipv6 options can actually work.
          * If we don't do that, packets arriving from the client with the
          * new address will be rejected and packets for the new address
          * will not be routed towards the client.
-         * For the same reason we later update the vhash too in
-         * `send_push_update()` function.
          * Using `buf_string_compare_advance()` we mimic the behavior
          * inside `process_incoming_push_msg()`. However, we don't need
          * to check the return value here because we just want to `advance=
`,
@@ -176,17 +189,39 @@
          */
         struct buffer tmp_msg =3D msgs[i];
         buf_string_compare_advance(&tmp_msg, push_update_cmd);
-        if (process_incoming_push_update(c, pull_permission_mask(c), optio=
n_types_found, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR)
+        unsigned int permission_mask =3D pull_permission_mask(c);
+        if (process_push_update(c, &o, permission_mask, &option_types_foun=
d, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR)
         {
             msg(M_WARN, "Failed to process push update message sent to cli=
ent ID: %u", c->c2.tls_multi->peer_id);
-            continue;
-        }
-        c->options.push_option_types_found |=3D *option_types_found;
-        if (!options_postprocess_pull(&c->options, c->c2.es))
-        {
-            msg(M_WARN, "Failed to post-process push update message sent t=
o client ID: %u", c->c2.tls_multi->peer_id);
         }
     }
+
+    if (option_types_found & OPT_P_UP)
+    {
+        /* -ifconfig */
+        if (!o.ifconfig_local && mi->context.c2.push_ifconfig_defined)
+        {
+            unlearn_ifconfig(m, mi);
+        }
+        /* -ifconfig-ipv6 */
+        if (!o.ifconfig_ipv6_local && mi->context.c2.push_ifconfig_ipv6_de=
fined)
+        {
+            unlearn_ifconfig_ipv6(m, mi);
+        }
+
+        if (o.ifconfig_local && !strcmp(o.ifconfig_local, canary))
+        {
+            o.ifconfig_local =3D NULL;
+        }
+        if (o.ifconfig_ipv6_local && !strcmp(o.ifconfig_ipv6_local, canary=
))
+        {
+            o.ifconfig_ipv6_local =3D NULL;
+        }
+
+        /* new ifconfig or new ifconfig-ipv6 */
+        update_vhash(m, mi, o.ifconfig_local, o.ifconfig_ipv6_local);
+    }
+
     return true;
 }

@@ -229,8 +264,6 @@
     int msgs_num =3D (strlen(msg) / safe_cap) + ((strlen(msg) % safe_cap) =
!=3D 0);
     struct buffer *msgs =3D gc_malloc((msgs_num + 1) * sizeof(struct buffe=
r), true, &gc);

-    unsigned int option_types_found =3D 0;
-
     msgs[msgs_num].data =3D NULL;
     if (!message_splitter(msg, msgs, &gc, safe_cap))
     {
@@ -255,15 +288,9 @@
             return 0;
         }

-        const char *old_ip =3D mi->context.options.ifconfig_local;
-        const char *old_ipv6 =3D mi->context.options.ifconfig_ipv6_local;
         if (!mi->halt
-            && send_single_push_update(&mi->context, msgs, &option_types_f=
ound))
+            && send_single_push_update(m, mi, msgs))
         {
-            if (option_types_found & OPT_P_UP)
-            {
-                update_vhash(m, mi, old_ip, old_ipv6);
-            }
             gc_free(&gc);
             return 1;
         }
@@ -289,18 +316,11 @@
         }

         /* Type is UPT_BROADCAST so we update every client */
-        option_types_found =3D 0;
-        const char *old_ip =3D curr_mi->context.options.ifconfig_local;
-        const char *old_ipv6 =3D curr_mi->context.options.ifconfig_ipv6_lo=
cal;
-        if (!send_single_push_update(&curr_mi->context, msgs, &option_type=
s_found))
+        if (!send_single_push_update(m, curr_mi, msgs))
         {
             msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_=
mi->context.c2.tls_multi->peer_id);
             continue;
         }
-        if (option_types_found & OPT_P_UP)
-        {
-            update_vhash(m, curr_mi, old_ip, old_ipv6);
-        }
         count++;
     }

diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
index 60596ed..7fadb69 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -29,7 +29,19 @@
 }

 void
-update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *old_ip, const char *old_ipv6)
+unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi)
+{
+    return;
+}
+
+void
+unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)
+{
+    return;
+}
+
+void
+update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *new_ip, const char *new_ipv6)
 {
     return;
 }
@@ -95,7 +107,7 @@
     }
     else if (honor_received_options && buf_string_compare_advance(&buf, pu=
sh_update_cmd))
     {
-        return process_incoming_push_update(c, permission_mask, option_typ=
es_found, &buf, false);
+        return process_push_update(c, &c->options, permission_mask, option=
_types_found, &buf, false);
     }
     else
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde98702a9801616a5f
Gerrit-Change-Number: 1253
Gerrit-PatchSet: 7
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>

--1GLepBCh3ZU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, ordex, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #7</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">PUSH_UPDATE server: remove old IP(s) from vhash after s=
ending a message containing ifconfig(-ipv6)<br><br>When sending a PUSH_UPDA=
TE containing an ifconfig(-ipv6) option, we must add the new IP to the<br>m=
ulti_context vhash (hash table of the clients indexed by virtual IPs). Now =
in addition to<br>adding new client IPs, old IPs are also removed from vhas=
h, allowing for a more complete update.<br><br>Change-Id: I07a8ddd9026eef64=
b6f5abde98702a9801616a5f<br>Signed-off-by: Marco Baffo &lt;marco@...2726...=
&gt;<br>---<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M src/open=
vpn/push.c<br>M src/openvpn/push.h<br>M src/openvpn/push_util.c<br>M tests/=
unit_tests/openvpn/test_push_update_msg.c<br>6 files changed, 205 insertion=
s(+), 72 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/53/1253/7</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/multi.c b/src/openvpn/multi.c</span><br><span>index 2863ff1..558314c 100=
644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/ope=
nvpn/multi.c</span><br><span>@@ -4269,46 +4269,144 @@</span><br><span>     =
close_instance(top);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Searches for the address and delet=
es it if it is owned by the multi_instance */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+multi_unlearn_addr(struct multi_context *m, struct multi_=
instance *mi, const struct mroute_addr *addr)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct hash_element *he;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const uint32_t hv =3D hash_value(m-&gt;vhash, addr);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucke=
t *bucket =3D hash_bucket(m-&gt;vhash, hv);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct multi_route *r =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* if route currently exists, get the instance whi=
ch owns it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    he=
 =3D hash_lookup_fast(m-&gt;vhash, bucket, addr, hv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (he)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        r =3D (struct multi_route *)he-&gt;value;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* if the route does not exist or exists but is not owned by t=
he current instance, return */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!r || r-&gt;instance !=3D mi)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
sg(D_MULTI_LOW, &quot;MULTI: Unlearn: %s -&gt; %s&quot;, mroute_addr_print(=
&amp;r-&gt;addr, &amp;gc), multi_instance_string(mi, false, &amp;gc));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    learn_address_script=
(m, NULL, &quot;delete&quot;, &amp;r-&gt;addr);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    hash_remove_by_value(m-&gt;vhash, r);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_route_del(r);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m     =
The multi_context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param mi    The multi_instance of the client we are updating</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param a     The new IPv4 add=
ress in network byte order</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_unlearn_in_=
addr_t(struct multi_context *m, struct multi_instance *mi, in_addr_t a)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct mroute_addr addr;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(addr);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    addr.type =3D MR_ADDR_IPV4;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    addr.len =3D 4;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    addr.v4.addr =3D a;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    multi_unlearn_addr(m, mi, &amp;addr);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m =
    The multi_context</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param mi    The multi_instance of the client we are updating</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param a6    The new IPv6=
 address</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+multi_unlearn_in6_addr(struct multi=
_context *m, struct multi_instance *mi, struct in6_addr a6)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct mroute_addr addr;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    CLEAR(addr);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    addr.type =3D MR_ADDR_IPV6;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    addr.len =3D 16;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    addr.v6.addr =3D a6;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    multi_unlearn_addr(m, mi, &amp;addr);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Func=
tion to unlearn previous ifconfig of a client in the server multi_context a=
fter a PUSH_UPDATE */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unlearn_ifcon=
fig(struct multi_context *m, struct multi_instance *mi)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    in_addr_t old_addr =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    old_addr =3D htonl(mi-&gt;context.c2.push_i=
fconfig_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
multi_unlearn_in_addr_t(m, mi, old_addr);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    mi-&gt;context.c2.push_ifconfig_defined =3D false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;context=
.c2.push_ifconfig_local =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* Function to unlearn pre=
vious ifconfig-ipv6 of a client in the server multi_context after a PUSH_UP=
DATE */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+unlearn_ifconfig_ipv6(struc=
t multi_context *m, struct multi_instance *mi)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct in6_addr old_addr6;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    CLEAR(old_addr6);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    old_addr6 =3D mi-&gt;context.c2.push_ifconfig_ipv=
6_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_u=
nlearn_in6_addr(m, mi, old_addr6);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    mi-&gt;context.c2.push_ifconfig_ipv6_defined =3D false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mi-&gt;con=
text.c2.push_ifconfig_ipv6_local);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> /**</span><br><span>  * Update the vhash with new IP/IPv6 ad=
dresses in the multi_context when a</span><br><span>  * push-update message=
 containing ifconfig/ifconfig-ipv6 options is sent</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * from the server. This function should be ca=
lled after a push-update</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * and old_ip/old_ipv6 are the previous addresses of the client in</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * ctx-&gt;options.ifconfig=
_local and ctx-&gt;options.ifconfig_ipv6_local.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * from the server.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param m         The multi_context</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param mi        The multi_instance of the =
client we are updating</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param new_ip    The new IPv4 address or NULL if no change</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param new_ipv6  The new IP=
v6 address or NULL if no change</span><br><span>  */</span><br><span> void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-update_vhash(struct mu=
lti_context *m, struct multi_instance *mi, const char *old_ip, const char *=
old_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+update_vha=
sh(struct multi_context *m, struct multi_instance *mi, const char *new_ip, =
const char *new_ipv6)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct in_addr addr;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct in6_addr new_ipv6;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if ((mi-&gt;context.options.ifconfig_local &amp;&amp; (!old_=
ip || strcmp(old_ip, mi-&gt;context.options.ifconfig_local)))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; inet_pton(AF_INE=
T, mi-&gt;context.options.ifconfig_local, &amp;addr) =3D=3D 1)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (new_ip)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in_addr=
_t new_ip =3D ntohl(addr.s_addr);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* Remove old IP */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (mi-&gt;context.c2.push_ifconfig_defined)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            unlearn_ifconfig(m=
, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span> </span><br><span>         /* Add new IP */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        multi_learn_in_addr_t(m, mi, new=
_ip, -1, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    struct in_addr new_addr;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        CLEAR(new_addr);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (inet_pton(AF_INET, new_ip, &amp;new_addr) =3D=3D =
1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&=
amp; multi_learn_in_addr_t(m, mi, ntohl(new_addr.s_addr), -1, true))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context.c2.push_i=
fconfig_defined =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            mi-&gt;context.c2.push_ifconfig_local =3D ntohl(new_addr.=
s_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* TO DO:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-     *  else if (old_ip)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-     *  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     *      // remove old IP</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-     *  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if ((mi-&gt;context.options.ifconfi=
g_ipv6_local &amp;&amp; (!old_ipv6 || strcmp(old_ipv6, mi-&gt;context.optio=
ns.ifconfig_ipv6_local)))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        &amp;&amp; inet_pton(AF_INET6, mi-&gt;context.options.ifconfig_=
ipv6_local, &amp;new_ipv6) =3D=3D 1)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (new_ipv6)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        /* Add new IPv6 */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        multi_learn_in6_addr(m, mi=
, new_ipv6, -1, true);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Re=
move old IPv6 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (mi-&gt;context.c2.push_ifconfig_ipv6_defined)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            unlearn_ifconfig_ipv6(m, mi);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* TO DO:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     *  else if (old_ipv6)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-     *  {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-     *      // remove old IPv6</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-     *  }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* Add new IPv6 */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct in6_addr new_addr6;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(new_addr6);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (inet_pton(AF=
_INET6, new_ipv6, &amp;new_addr6) =3D=3D 1</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &amp;&amp; multi_learn_in6_addr(m, mi, n=
ew_addr6, -1, true))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   mi-&gt;context.c2.push_ifconfig_ipv6_defined =3D true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context.c2.push_if=
config_ipv6_local =3D new_addr6;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span> }</span><br><span>diff --git a/src/openvpn/multi.=
h b/src/openvpn/multi.h</span><br><span>index b2b892b..97bbc4a 100644</span=
><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/mult=
i.h</span><br><span>@@ -692,6 +692,8 @@</span><br><span> #endif</span><br><=
span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-update_vhash(struct multi_context *m, struct multi_instance *mi, con=
st char *old_ip, const char *old_ipv6);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+update_vhash(struct multi_context *m, struct multi_inst=
ance *mi, const char *new_ip, const char *new_ipv6);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void unlearn_ifconfig(struct multi_contex=
t *m, struct multi_instance *mi);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+void unlearn_ifconfig_ipv6(struct multi_context *m, struct mu=
lti_instance *mi);</span><br><span> </span><br><span> #endif /* MULTI_H */<=
/span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span>=
<br><span>index 0c8eb84..2c717c7 100644</span><br><span>--- a/src/openvpn/p=
ush.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -1118,7 +=
1118,7 @@</span><br><span>                         &quot; To be able to pro=
cess PUSH_UPDATE messages, be sure to use the --disable-dco option.&quot;);=
</span><br><span>             return PUSH_MSG_ERROR;</span><br><span>      =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return pr=
ocess_incoming_push_update(c, permission_mask, option_types_found, &amp;buf=
, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn process_push_update(c, &amp;c-&gt;options, permission_mask, option_typ=
es_found, &amp;buf, false);</span><br><span>     }</span><br><span>     els=
e</span><br><span>     {</span><br><span>diff --git a/src/openvpn/push.h b/=
src/openvpn/push.h</span><br><span>index 6b3275e..19a029a 100644</span><br>=
<span>--- a/src/openvpn/push.h</span><br><span>+++ b/src/openvpn/push.h</sp=
an><br><span>@@ -61,11 +61,13 @@</span><br><span>  * message has not yet be=
en received.</span><br><span>  *</span><br><span>  * @param c The context f=
or the operation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param o The options structure to be updated with the received push option=
s.</span><br><span>  * @param permission_mask The permission mask specifyin=
g which options are allowed to be pulled.</span><br><span>  * @param option=
_types_found A pointer to a variable that will be filled with the types of =
options</span><br><span>  *                           found in the message.=
</span><br><span>  * @param buf A buffer containing the received message.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param msg_sender A =
boolean indicating if function is called by the message sender (server).</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param msg_sender A=
 boolean indicating if the message is being processed on the client (false)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                 =
  or on the server (true).</span><br><span>  *</span><br><span>  * @return<=
/span><br><span>  * - `PUSH_MSG_UPDATE`: The message was processed successf=
ully, and the updates were applied.</span><br><span>@@ -74,9 +76,8 @@</span=
><br><span>  * - `PUSH_MSG_ERROR`: An error occurred during message process=
ing, or the message is invalid.</span><br><span>  */</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-int process_incoming_push_=
update(struct context *c, unsigned int permission_mask,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                                 unsigned=
 int *option_types_found, struct buffer *buf,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                 bool msg_sender);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+int process_push_upd=
ate(struct context *c, struct options *o, unsigned int permission_mask,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 unsigned int *option_types_found, struct buffer *buf, bool msg_sender);</s=
pan><br><span> </span><br><span> int process_incoming_push_msg(struct conte=
xt *c, const struct buffer *buffer,</span><br><span>                       =
        bool honor_received_options, unsigned int permission_mask,</span><b=
r><span>diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c</spa=
n><br><span>index 25c6ebe..0e86ad3 100644</span><br><span>--- a/src/openvpn=
/push_util.c</span><br><span>+++ b/src/openvpn/push_util.c</span><br><span>=
@@ -16,18 +16,17 @@</span><br><span> #endif</span><br><span> </span><br><sp=
an> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-process_incomi=
ng_push_update(struct context *c, unsigned int permission_mask,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                             unsi=
gned int *option_types_found, struct buffer *buf,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                             bool msg_sender)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+process_push_update(s=
truct context *c, struct options *o, unsigned int permission_mask,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    unsigned=
 int *option_types_found, struct buffer *buf, bool msg_sender)</span><br><s=
pan> {</span><br><span>     int ret =3D PUSH_MSG_ERROR;</span><br><span>   =
  const uint8_t ch =3D buf_read_u8(buf);</span><br><span>     if (ch =3D=3D=
 &#39;,&#39;)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (apply_push_options(c, &amp;c-&gt;options, buf, p=
ermission_mask, option_types_found, c-&gt;c2.es,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (apply_push_options(c, o, buf, perm=
ission_mask, option_types_found, c-&gt;c2.es,</span><br><span>             =
                   true))</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            switch (c-&gt;options.push_cont=
inuation)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  switch (o-&gt;push_continuation)</span><br><span>             {</span><br=
><span>                 case 0:</span><br><span>                 case 1:</s=
pan><br><span>@@ -144,13 +143,27 @@</span><br><span> </span><br><span> /* s=
end the message(s) prepared to one single client */</span><br><span> static=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-send_single_push=
_update(struct context *c, struct buffer *msgs, unsigned int *option_types_=
found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_single_p=
ush_update(struct multi_context *m, struct multi_instance *mi, struct buffe=
r *msgs)</span><br><span> {</span><br><span>     if (!msgs[0].data || !*(ms=
gs[0].data))</span><br><span>     {</span><br><span>         return false;<=
/span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     int i =3D -1;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    unsigned int option_types_found =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi=
-&gt;context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct options o;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
CLEAR(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Set canary values to d=
etect ifconfig options in push-update messages.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * These placeholder strings will be overwr=
itten to NULL by the option</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * parser if -ifconfig or -ifconfig-ipv6 options are present in=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * push-upd=
ate.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *canary =3D =
&quot;canary&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    o.ifconfig_local =3D canary;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    o.ifconfig_ipv6_local =3D canary;</span><br><span> </span>=
<br><span>     while (msgs[++i].data &amp;&amp; *(msgs[i].data))</span><br>=
<span>     {</span><br><span>@@ -159,14 +172,14 @@</span><br><span>        =
     return false;</span><br><span>         }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /* After sending the cont=
rol message, we update the options</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-         * server-side in the client&#39;s context so pushed o=
ptions like</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         *=
 ifconfig/ifconfig-ipv6 can actually work.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* After sending the control message, we par=
se it, miming the behavior</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+         * of `process_incoming_push_msg()` and we fill an empty `op=
tions` struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * with the new options. If an `ifconfig_local` or `ifconfig_ipv6_local`<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * options i=
s found we update the vhash accordingly, so that the pushed</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * ifconfig/ifconfig-ipv6 o=
ptions can actually work.</span><br><span>          * If we don&#39;t do th=
at, packets arriving from the client with the</span><br><span>          * n=
ew address will be rejected and packets for the new address</span><br><span=
>          * will not be routed towards the client.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * For the same reason we later upd=
ate the vhash too in</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
        * `send_push_update()` function.</span><br><span>          * Using =
`buf_string_compare_advance()` we mimic the behavior</span><br><span>      =
    * inside `process_incoming_push_msg()`. However, we don&#39;t need</spa=
n><br><span>          * to check the return value here because we just want=
 to `advance`,</span><br><span>@@ -176,17 +189,39 @@</span><br><span>      =
    */</span><br><span>         struct buffer tmp_msg =3D msgs[i];</span><b=
r><span>         buf_string_compare_advance(&amp;tmp_msg, push_update_cmd);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (process_i=
ncoming_push_update(c, pull_permission_mask(c), option_types_found, &amp;tm=
p_msg, true) =3D=3D PUSH_MSG_ERROR)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        unsigned int permission_mask =3D pull_permission_ma=
sk(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p=
rocess_push_update(c, &amp;o, permission_mask, &amp;option_types_found, &am=
p;tmp_msg, true) =3D=3D PUSH_MSG_ERROR)</span><br><span>         {</span><b=
r><span>             msg(M_WARN, &quot;Failed to process push update messag=
e sent to client ID: %u&quot;, c-&gt;c2.tls_multi-&gt;peer_id);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            continue;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        c-&gt;options.push_option_types_fou=
nd |=3D *option_types_found;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (!options_postprocess_pull(&amp;c-&gt;options, c-&gt;c2.e=
s))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;=
Failed to post-process push update message sent to client ID: %u&quot;, c-&=
gt;c2.tls_multi-&gt;peer_id);</span><br><span>         }</span><br><span>  =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (option_types_found &amp; O=
PT_P_UP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* -ifconfig */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!o.ifconf=
ig_local &amp;&amp; mi-&gt;context.c2.push_ifconfig_defined)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            unlearn_ifconfig(m, mi);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        /* -ifconfig-ipv6 */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!o.ifconfig_ipv6=
_local &amp;&amp; mi-&gt;context.c2.push_ifconfig_ipv6_defined)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            unlearn_ifconfig_ipv6(m, mi);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (o.ifconfig_local &amp;&amp; !strcmp(=
o.ifconfig_local, canary))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         o.ifconfig_local =3D NULL;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (o.ifconfig_ipv6_local &amp;&amp; !strcmp(o.ifconfig_ipv6_=
local, canary))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            o.=
ifconfig_ipv6_local =3D NULL;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* new ifco=
nfig or new ifconfig-ipv6 */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        update_vhash(m, mi, o.ifconfig_local, o.ifconfig_ipv6_loca=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return t=
rue;</span><br><span> }</span><br><span> </span><br><span>@@ -229,8 +264,6 =
@@</span><br><span>     int msgs_num =3D (strlen(msg) / safe_cap) + ((strle=
n(msg) % safe_cap) !=3D 0);</span><br><span>     struct buffer *msgs =3D gc=
_malloc((msgs_num + 1) * sizeof(struct buffer), true, &amp;gc);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned in=
t option_types_found =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span>     msgs[msgs_num].data =3D NULL;</span><br><span> =
    if (!message_splitter(msg, msgs, &amp;gc, safe_cap))</span><br><span>  =
   {</span><br><span>@@ -255,15 +288,9 @@</span><br><span>             retu=
rn 0;</span><br><span>         }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        const char *old_ip =3D mi-&gt;context.=
options.ifconfig_local;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        const char *old_ipv6 =3D mi-&gt;context.options.ifconfig_ipv6_loc=
al;</span><br><span>         if (!mi-&gt;halt</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            &amp;&amp; send_single_push_update(&amp=
;mi-&gt;context, msgs, &amp;option_types_found))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &amp;&amp; send_single_push_update=
(m, mi, msgs))</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (option_types_found &amp; OPT_P_UP)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                update_vhash(m, mi=
, old_ip, old_ipv6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           }</span><br><span>             gc_free(&amp;gc);</span><br><span=
>             return 1;</span><br><span>         }</span><br><span>@@ -289,=
18 +316,11 @@</span><br><span>         }</span><br><span> </span><br><span>=
         /* Type is UPT_BROADCAST so we update every client */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        option_types_found =3D 0;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *ol=
d_ip =3D curr_mi-&gt;context.options.ifconfig_local;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const char *old_ipv6 =3D curr_mi-&g=
t;context.options.ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (!send_single_push_update(&amp;curr_mi-&gt;cont=
ext, msgs, &amp;option_types_found))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (!send_single_push_update(m, curr_mi, msgs))</s=
pan><br><span>         {</span><br><span>             msg(M_CLIENT, &quot;E=
RROR: Peer ID: %u has not been updated&quot;, curr_mi-&gt;context.c2.tls_mu=
lti-&gt;peer_id);</span><br><span>             continue;</span><br><span>  =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (o=
ption_types_found &amp; OPT_P_UP)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            update_vhash(m, curr_mi, old_ip, old_ipv6);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>         count+=
+;</span><br><span>     }</span><br><span> </span><br><span>diff --git a/te=
sts/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/te=
st_push_update_msg.c</span><br><span>index 60596ed..7fadb69 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>@@=
 -29,7 +29,19 @@</span><br><span> }</span><br><span> </span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-update_vhash(struct m=
ulti_context *m, struct multi_instance *mi, const char *old_ip, const char =
*old_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unlearn_i=
fconfig(struct multi_context *m, struct multi_instance *mi)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+unlearn_ifconfig_ipv6(struct multi_con=
text *m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+update_vhash(struct multi_context *m, struct multi_instance *m=
i, const char *new_ip, const char *new_ipv6)</span><br><span> {</span><br><=
span>     return;</span><br><span> }</span><br><span>@@ -95,7 +107,7 @@</sp=
an><br><span>     }</span><br><span>     else if (honor_received_options &a=
mp;&amp; buf_string_compare_advance(&amp;buf, push_update_cmd))</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn process_incoming_push_update(c, permission_mask, option_types_found, &=
amp;buf, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return process_push_update(c, &amp;c-&gt;options, permission_mask, opt=
ion_types_found, &amp;buf, false);</span><br><span>     }</span><br><span> =
    else</span><br><span>     {</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail">=
change 1253</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde987=
02a9801616a5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1253 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>

</body></html>=

--1GLepBCh3ZU=--

