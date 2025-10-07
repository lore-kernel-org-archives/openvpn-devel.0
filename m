From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 16:37:46 +0000
References: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9cff46dbfcda8370908e036f1cc4f86caf17f200-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8jUH+MIXb14="; charset=UTF-8
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

--8jUH+MIXb14=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail

to review the following change.


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
6 files changed, 187 insertions(+), 74 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/1253/1

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2863ff1..2dc50de 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4269,46 +4269,138 @@
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
+    dmsg(D_MULTI_DEBUG, "MULTI: DEL %s", mroute_addr_print(&r->addr, &gc));
+    msg(D_MULTI_LOW, "MULTI: Remove: %s -> %s", mroute_addr_print(&r->addr=
, &gc), multi_instance_string(mi, false, &gc));
+    learn_address_script(m, NULL, "delete", &r->addr);
+    hash_remove_by_value(m->vhash, r);
+    route_quota_dec(mi);
+    multi_instance_dec_refcount(mi);
+
+    gc_free(&gc);
+}
+
+/**
+ * @param m     The multi_context
+ * @param mi    The multi_instance of the client we are updating
+ * @param a     The new IPv4 address in host byte order
+ */
+static void
+multi_unlearn_in_addr_t(struct multi_context *m, struct multi_instance *mi=
, in_addr_t a)
+{
+    struct openvpn_sockaddr remote_si;
+    struct mroute_addr addr =3D { 0 };
+
+    CLEAR(remote_si);
+    remote_si.addr.in4.sin_family =3D AF_INET;
+    remote_si.addr.in4.sin_addr.s_addr =3D a;
+    addr.proto =3D 0;
+    ASSERT(mroute_extract_openvpn_sockaddr(&addr, &remote_si, false));
+
+    multi_unlearn_addr(m, mi, &addr);
+}
+
+/**
+ * @param m     The multi_context
+ * @param mi    The multi_instance of the client we are updating
+ * @param a6    The new IPv6 address in host byte order
+ */
+static void
+multi_unlearn_in6_addr(struct multi_context *m, struct multi_instance *mi,=
 struct in6_addr a6)
+{
+    struct mroute_addr addr =3D { 0 };
+
+    addr.len =3D 16;
+    addr.type =3D MR_ADDR_IPV6;
+    addr.netbits =3D 0;
+    addr.v6.addr =3D a6;
+
+    multi_unlearn_addr(m, mi, &addr);
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
+        struct in_addr new_addr;
+        struct in_addr old_addr;
+        CLEAR(new_addr);
+        CLEAR(old_addr);
+
+        /* Remove old IP */
+        if (mi->context.c2.push_ifconfig_defined)
+        {
+            old_addr.s_addr =3D ntohl(mi->context.c2.push_ifconfig_local);
+
+            multi_unlearn_in_addr_t(m, mi, old_addr.s_addr);
+            mi->context.c2.push_ifconfig_defined =3D false;
+            mi->context.c2.push_ifconfig_local =3D 0;
+        }

         /* Add new IP */
-        multi_learn_in_addr_t(m, mi, new_ip, -1, true);
+        if (inet_pton(AF_INET, new_ip, &new_addr) =3D=3D 1
+            && multi_learn_in_addr_t(m, mi, ntohl(new_addr.s_addr), -1, tr=
ue))
+        {
+            mi->context.c2.push_ifconfig_defined =3D true;
+            mi->context.c2.push_ifconfig_local =3D new_addr.s_addr;
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
+        struct in6_addr new_addr6;
+        struct in6_addr old_addr6;
+        CLEAR(new_addr6);
+        CLEAR(old_addr6);

-    /* TO DO:
-     *  else if (old_ipv6)
-     *  {
-     *      // remove old IPv6
-     *  }
-     */
+        /* Remove old IPv6 */
+        if (mi->context.c2.push_ifconfig_ipv6_defined)
+        {
+            old_addr6 =3D mi->context.c2.push_ifconfig_ipv6_local;
+            multi_unlearn_in6_addr(m, mi, old_addr6);
+            mi->context.c2.push_ifconfig_ipv6_defined =3D false;
+            CLEAR(mi->context.c2.push_ifconfig_ipv6_local);
+        }
+
+        /* Add new IPv6 */
+        if (inet_pton(AF_INET6, new_ipv6, &new_addr6) =3D=3D 1
+            && multi_learn_in6_addr(m, mi, new_addr6, -1, true))
+        {
+            mi->context.c2.push_ifconfig_ipv6_defined =3D true;
+            mi->context.c2.push_ifconfig_ipv6_local =3D new_addr6;
+        }
+    }
 }
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index b2b892b..a9d643f 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -692,6 +692,6 @@
 #endif

 void
-update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *old_ip, const char *old_ipv6);
+update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *new_ip, const char *new_ipv6);

 #endif /* MULTI_H */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e7fc50c..eea402c 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1112,7 +1112,7 @@
     }
     else if (honor_received_options && buf_string_compare_advance(&buf, pu=
sh_update_cmd))
     {
-        return process_incoming_push_update(c, permission_mask, option_typ=
es_found, &buf, false);
+        return process_incoming_push_update(c, permission_mask, option_typ=
es_found, &buf);
     }
     else
     {
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 6b3275e..bda731e 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -65,7 +65,6 @@
  * @param option_types_found A pointer to a variable that will be filled w=
ith the types of options
  *                           found in the message.
  * @param buf A buffer containing the received message.
- * @param msg_sender A boolean indicating if function is called by the mes=
sage sender (server).
  *
  * @return
  * - `PUSH_MSG_UPDATE`: The message was processed successfully, and the up=
dates were applied.
@@ -75,8 +74,7 @@
  */

 int process_incoming_push_update(struct context *c, unsigned int permissio=
n_mask,
-                                 unsigned int *option_types_found, struct =
buffer *buf,
-                                 bool msg_sender);
+                                 unsigned int *option_types_found, struct =
buffer *buf);

 int process_incoming_push_msg(struct context *c, const struct buffer *buff=
er,
                               bool honor_received_options, unsigned int pe=
rmission_mask,
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 9138bdb..0cd066c 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -16,8 +16,7 @@

 int
 process_incoming_push_update(struct context *c, unsigned int permission_ma=
sk,
-                             unsigned int *option_types_found, struct buff=
er *buf,
-                             bool msg_sender)
+                             unsigned int *option_types_found, struct buff=
er *buf)
 {
     int ret =3D PUSH_MSG_ERROR;
     const uint8_t ch =3D buf_read_u8(buf);
@@ -38,7 +37,7 @@
                     break;
             }
         }
-        else if (!msg_sender)
+        else
         {
             throw_signal_soft(SIGUSR1, "Offending option received from ser=
ver");
         }
@@ -51,6 +50,45 @@
     return ret;
 }

+static int
+process_sent_push_update(struct context *c, struct options *o, unsigned in=
t *option_types_found, struct buffer *buf)
+{
+    /* Using `buf_string_compare_advance()` we mimic the behavior
+     * inside `process_incoming_push_msg()`. However, we don't need
+     * to check the return value here because we just want to `advance`,
+     * meaning we skip the `push_update_cmd' we added earlier.
+     */
+    buf_string_compare_advance(buf, push_update_cmd);
+
+    int ret =3D PUSH_MSG_ERROR;
+    const uint8_t ch =3D buf_read_u8(buf);
+    unsigned int permission_mask =3D pull_permission_mask(c);
+
+    if (ch =3D=3D ',')
+    {
+        if (apply_push_options(c, o, buf, permission_mask, option_types_fo=
und, c->c2.es, true))
+        {
+            switch (o->push_continuation)
+            {
+                case 0:
+                case 1:
+                    ret =3D PUSH_MSG_UPDATE;
+                    break;
+
+                case 2:
+                    ret =3D PUSH_MSG_CONTINUATION;
+                    break;
+            }
+        }
+    }
+    else if (ch =3D=3D '\0')
+    {
+        ret =3D PUSH_MSG_UPDATE;
+    }
+
+    return ret;
+}
+
 #ifdef ENABLE_MANAGEMENT
 /**
  * Return index of last `,` or `0` if it didn't find any.
@@ -143,13 +181,19 @@

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
+
+    memset(&o, 0, sizeof(struct options));

     while (msgs[++i].data && *(msgs[i].data))
     {
@@ -158,33 +202,27 @@
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
-         * Using `buf_string_compare_advance()` we mimic the behavior
-         * inside `process_incoming_push_msg()`. However, we don't need
-         * to check the return value here because we just want to `advance=
`,
-         * meaning we skip the `push_update_cmd' we added earlier.
          */
-        buf_string_compare_advance(&msgs[i], push_update_cmd);
-        if (process_incoming_push_update(c, pull_permission_mask(c), optio=
n_types_found, &msgs[i], true) =3D=3D PUSH_MSG_ERROR)
+        if (process_sent_push_update(c, &o, &option_types_found, &msgs[i])=
 =3D=3D PUSH_MSG_ERROR)
         {
             msg(M_WARN, "Failed to process push update message sent to cli=
ent ID: %u",
                 c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);
-            continue;
-        }
-        c->options.push_option_types_found |=3D *option_types_found;
-        if (!options_postprocess_pull(&c->options, c->c2.es))
-        {
-            msg(M_WARN, "Failed to post-process push update message sent t=
o client ID: %u",
-                c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);
         }
     }
+
+    if (option_types_found & OPT_P_UP)
+    {
+        update_vhash(m, mi, o.ifconfig_local, o.ifconfig_ipv6_local);
+    }
+
     return true;
 }

@@ -206,8 +244,6 @@
     int msgs_num =3D (strlen(msg) / safe_cap) + ((strlen(msg) % safe_cap) =
!=3D 0);
     struct buffer *msgs =3D gc_malloc((msgs_num + 1) * sizeof(struct buffe=
r), true, &gc);

-    unsigned int option_types_found =3D 0;
-
     msgs[msgs_num].data =3D NULL;
     if (!message_splitter(msg, msgs, &gc, safe_cap))
     {
@@ -224,15 +260,9 @@
             return -ENOENT;
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
@@ -258,19 +288,12 @@
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
             msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated",
                 curr_mi->context.c2.tls_multi ? curr_mi->context.c2.tls_mu=
lti->peer_id : UINT32_MAX);
             continue;
         }
-        if (option_types_found & OPT_P_UP)
-        {
-            update_vhash(m, curr_mi, old_ip, old_ipv6);
-        }
         count++;
     }
=20
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
index 8a5beeb..650fd2e 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -95,7 +95,7 @@
     }
     else if (honor_received_options && buf_string_compare_advance(&buf, pu=
sh_update_cmd))
     {
-        return process_incoming_push_update(c, permission_mask, option_typ=
es_found, &buf, false);
+        return process_incoming_push_update(c, permission_mask, option_typ=
es_found, &buf);
     }
     else
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde98702a9801616a5f
Gerrit-Change-Number: 1253
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--8jUH+MIXb14=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">PUSH_UPDATE server: remove old IP(s) from v=
hash after sending a message containing ifconfig(-ipv6)<br><br>When sending=
 a PUSH_UPDATE containing an ifconfig(-ipv6) option, we must add the new IP=
 to the<br>multi_context vhash (hash table of the clients indexed by virtua=
l IPs). Now in addition to<br>adding new client IPs, old IPs are also remov=
ed from vhash, allowing for a more complete update.<br><br>Change-Id: I07a8=
ddd9026eef64b6f5abde98702a9801616a5f<br>Signed-off-by: Marco Baffo &lt;marc=
o@...2726...&gt;<br>---<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<b=
r>M src/openvpn/push.c<br>M src/openvpn/push.h<br>M src/openvpn/push_util.c=
<br>M tests/unit_tests/openvpn/test_push_update_msg.c<br>6 files changed, 1=
87 insertions(+), 74 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/53/1253/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 2863f=
f1..2dc50de 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><spa=
n>+++ b/src/openvpn/multi.c</span><br><span>@@ -4269,46 +4269,138 @@</span>=
<br><span>     close_instance(top);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Searches for the ad=
dress and deletes it if it is owned by the multi_instance */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_unlearn_addr(struct multi_context *=
m, struct multi_instance *mi, const struct mroute_addr *addr)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct hash_element *he;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint32_t hv =3D hash_value(m-&g=
t;vhash, addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct hash_bucket *bucket =3D hash_bucket(m-&gt;vhash, hv);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct multi_route *r =3D NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* if route currently exists, get=
 the instance which owns it */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    he =3D hash_lookup_fast(m-&gt;vhash, bucket, addr, hv);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (he)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        r =3D (struct multi_route *)he-&gt;val=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* if the route does not exist or exists but =
is not owned by the current instance, return */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!r || r-&gt;instance !=3D mi)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    dmsg(D_MULTI_DEBUG, &quot;MULTI: DEL %s&quot;, mroute_add=
r_print(&amp;r-&gt;addr, &amp;gc));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    msg(D_MULTI_LOW, &quot;MULTI: Remove: %s -&gt; %s&quot;=
, mroute_addr_print(&amp;r-&gt;addr, &amp;gc), multi_instance_string(mi, fa=
lse, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
learn_address_script(m, NULL, &quot;delete&quot;, &amp;r-&gt;addr);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    hash_remove_by_value(m-=
&gt;vhash, r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
oute_quota_dec(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    multi_instance_dec_refcount(mi);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param m     The multi_context</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param mi    The multi_instance of t=
he client we are updating</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param a     The new IPv4 address in host byte order</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+multi_unlearn_in_addr_t(struct multi_context *m, struct m=
ulti_instance *mi, in_addr_t a)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct openvpn_sockaddr remote_si;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct mroute_addr addr =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    CLEAR(remote_si);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    remote_si.addr.in4.sin_family =3D AF_INET;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    remote_si.addr.in4.sin_addr=
.s_addr =3D a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ddr.proto =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ASSERT(mroute_extract_openvpn_sockaddr(&amp;addr, &amp;remote_si, false));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    multi_unlearn_addr(m, mi, &amp;add=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param m     The multi_context</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param mi    The multi_instance of the client we are=
 updating</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
a6    The new IPv6 address in host byte order</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+multi_unlearn_in6_addr(struct multi_context *m, struct multi_instance *mi=
, struct in6_addr a6)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mrout=
e_addr addr =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    addr.len =3D=
 16;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    addr.type =
=3D MR_ADDR_IPV6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  addr.netbits =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    addr.v6.addr =3D a6;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_un=
learn_addr(m, mi, &amp;addr);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> /**</span><br><span>  * Update the vhash with new IP/IPv6 address=
es in the multi_context when a</span><br><span>  * push-update message cont=
aining ifconfig/ifconfig-ipv6 options is sent</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * from the server. This function should be called =
after a push-update</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 and old_ip/old_ipv6 are the previous addresses of the client in</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * ctx-&gt;options.ifconfig_loca=
l and ctx-&gt;options.ifconfig_ipv6_local.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * from the server.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param m         The multi_context</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param mi        The multi_instance of the clien=
t we are updating</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param new_ip    The new IPv4 address or NULL if no change</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param new_ipv6  The new IPv6 ad=
dress or NULL if no change</span><br><span>  */</span><br><span> void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-update_vhash(struct multi_c=
ontext *m, struct multi_instance *mi, const char *old_ip, const char *old_i=
pv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+update_vhash(st=
ruct multi_context *m, struct multi_instance *mi, const char *new_ip, const=
 char *new_ipv6)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct in_addr addr;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct in6_addr new_ipv6;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if ((mi-&gt;context.options.ifconfig_local &amp;&amp; (!old_ip || s=
trcmp(old_ip, mi-&gt;context.options.ifconfig_local)))</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; inet_pton(AF_INET, mi-&=
gt;context.options.ifconfig_local, &amp;addr) =3D=3D 1)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (new_ip)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in_addr_t new_=
ip =3D ntohl(addr.s_addr);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct in_addr new_addr;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct in_addr old_addr;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        CLEAR(new_addr);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(old_addr);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* Remove old IP */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (mi-&gt;context.c2.push_ifconf=
ig_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            old_ad=
dr.s_addr =3D ntohl(mi-&gt;context.c2.push_ifconfig_local);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            multi_unlearn_in_addr_t(m, mi, old_addr.s_=
addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
i-&gt;context.c2.push_ifconfig_defined =3D false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            mi-&gt;context.c2.push_ifconfig_l=
ocal =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span> </span><br><span>         /* Add new IP */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        multi_learn_in_addr_t(m, mi=
, new_ip, -1, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (inet_pton(AF_INET, new_ip, &amp;new_addr) =3D=3D 1</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; multi_le=
arn_in_addr_t(m, mi, ntohl(new_addr.s_addr), -1, true))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            mi-&gt;context.c2.push_ifconfig_defin=
ed =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     mi-&gt;context.c2.push_ifconfig_local =3D new_addr.s_addr;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  /* TO DO:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *  el=
se if (old_ip)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *      // remo=
ve old IP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *  }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if ((mi-&gt;context.options.ifconfig_ipv6_local &amp;&a=
mp; (!old_ipv6 || strcmp(old_ipv6, mi-&gt;context.options.ifconfig_ipv6_loc=
al)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&am=
p; inet_pton(AF_INET6, mi-&gt;context.options.ifconfig_ipv6_local, &amp;new=
_ipv6) =3D=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (new_ipv6)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        /* Add new IPv6 */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        multi_learn_in6_addr(m, mi, new_ipv6, -1, true=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        struct in6_addr new_addr6=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct in6=
_addr old_addr6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     CLEAR(new_addr6);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        CLEAR(old_addr6);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* TO DO:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     *  else if (old_ipv6)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-     *  {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-     *      // remove old IPv6</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     *  }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /* Remove old IPv6 */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (mi-&gt;context.c2.push_ifconfig_ipv6_defined)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            old_addr6 =3D mi-&gt;context.=
c2.push_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            multi_unlearn_in6_addr(m, mi, old_addr6);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context.c2.pu=
sh_ifconfig_ipv6_defined =3D false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            CLEAR(mi-&gt;context.c2.push_ifconfig_ipv6_loca=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* Add new IPv6 */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (inet_pton(AF_INET6, new_ip=
v6, &amp;new_addr6) =3D=3D 1</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            &amp;&amp; multi_learn_in6_addr(m, mi, new_addr6, -1, =
true))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;cont=
ext.c2.push_ifconfig_ipv6_defined =3D true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            mi-&gt;context.c2.push_ifconfig_ipv6_lo=
cal =3D new_addr6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span> }</span><br><span>diff --git a/src/openvpn/multi.h b/src/openvp=
n/multi.h</span><br><span>index b2b892b..a9d643f 100644</span><br><span>---=
 a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br>=
<span>@@ -692,6 +692,6 @@</span><br><span> #endif</span><br><span> </span><=
br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-update_=
vhash(struct multi_context *m, struct multi_instance *mi, const char *old_i=
p, const char *old_ipv6);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+update_vhash(struct multi_context *m, struct multi_instance *mi, cons=
t char *new_ip, const char *new_ipv6);</span><br><span> </span><br><span> #=
endif /* MULTI_H */</span><br><span>diff --git a/src/openvpn/push.c b/src/o=
penvpn/push.c</span><br><span>index e7fc50c..eea402c 100644</span><br><span=
>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><b=
r><span>@@ -1112,7 +1112,7 @@</span><br><span>     }</span><br><span>     e=
lse if (honor_received_options &amp;&amp; buf_string_compare_advance(&amp;b=
uf, push_update_cmd))</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        return process_incoming_push_update(c, permi=
ssion_mask, option_types_found, &amp;buf, false);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return process_incoming_push_update(c=
, permission_mask, option_types_found, &amp;buf);</span><br><span>     }</s=
pan><br><span>     else</span><br><span>     {</span><br><span>diff --git a=
/src/openvpn/push.h b/src/openvpn/push.h</span><br><span>index 6b3275e..bda=
731e 100644</span><br><span>--- a/src/openvpn/push.h</span><br><span>+++ b/=
src/openvpn/push.h</span><br><span>@@ -65,7 +65,6 @@</span><br><span>  * @p=
aram option_types_found A pointer to a variable that will be filled with th=
e types of options</span><br><span>  *                           found in t=
he message.</span><br><span>  * @param buf A buffer containing the received=
 message.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param ms=
g_sender A boolean indicating if function is called by the message sender (=
server).</span><br><span>  *</span><br><span>  * @return</span><br><span>  =
* - `PUSH_MSG_UPDATE`: The message was processed successfully, and the upda=
tes were applied.</span><br><span>@@ -75,8 +74,7 @@</span><br><span>  */</s=
pan><br><span> </span><br><span> int process_incoming_push_update(struct co=
ntext *c, unsigned int permission_mask,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                 unsigned int *option_typ=
es_found, struct buffer *buf,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                 bool msg_sender);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                 uns=
igned int *option_types_found, struct buffer *buf);</span><br><span> </span=
><br><span> int process_incoming_push_msg(struct context *c, const struct b=
uffer *buffer,</span><br><span>                               bool honor_re=
ceived_options, unsigned int permission_mask,</span><br><span>diff --git a/=
src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br><span>index 913=
8bdb..0cd066c 100644</span><br><span>--- a/src/openvpn/push_util.c</span><b=
r><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -16,8 +16,7 @@</sp=
an><br><span> </span><br><span> int</span><br><span> process_incoming_push_=
update(struct context *c, unsigned int permission_mask,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                             unsigned int=
 *option_types_found, struct buffer *buf,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                             bool msg_sender)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
unsigned int *option_types_found, struct buffer *buf)</span><br><span> {</s=
pan><br><span>     int ret =3D PUSH_MSG_ERROR;</span><br><span>     const u=
int8_t ch =3D buf_read_u8(buf);</span><br><span>@@ -38,7 +37,7 @@</span><br=
><span>                     break;</span><br><span>             }</span><br=
><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    else if (!msg_sender)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        else</span><br><span>         {</span><br><span>             =
throw_signal_soft(SIGUSR1, &quot;Offending option received from server&quot=
;);</span><br><span>         }</span><br><span>@@ -51,6 +50,45 @@</span><br=
><span>     return ret;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+process_sent_push_update(struct context *=
c, struct options *o, unsigned int *option_types_found, struct buffer *buf)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Using `buf_string_compare_adva=
nce()` we mimic the behavior</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * inside `process_incoming_push_msg()`. However, we don&#39;t=
 need</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * to chec=
k the return value here because we just want to `advance`,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * meaning we skip the `push_upd=
ate_cmd&#39; we added earlier.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   buf_string_compare_advance(buf, push_update_cmd);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int ret =3D PUSH_MSG_ERROR;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const uint8_t ch =3D buf_read_u8(buf);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int permissi=
on_mask =3D pull_permission_mask(c);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (ch =3D=3D &#39;,&#39;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (apply_push_options(c, o, buf, permission_mask, option_types_found, c=
-&gt;c2.es, true))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 switch (o-&gt;push_continuation)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                case 0:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                case 1:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    ret =3D PUSH_MSG_UPDATE;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    break;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                case 2:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    ret =3D PUSH_MSG_CONT=
INUATION;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else if (ch =3D=3D &#39;\0&#3=
9;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D PUSH_MSG_UPDAT=
E;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> /**</span><b=
r><span>  * Return index of last `,` or `0` if it didn&#39;t find any.</spa=
n><br><span>@@ -143,13 +181,19 @@</span><br><span> </span><br><span> /* sen=
d the message(s) prepared to one single client */</span><br><span> static b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-send_single_push_u=
pdate(struct context *c, struct buffer *msgs, unsigned int *option_types_fo=
und)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_single_pus=
h_update(struct multi_context *m, struct multi_instance *mi, struct buffer =
*msgs)</span><br><span> {</span><br><span>     if (!msgs[0].data || !*(msgs=
[0].data))</span><br><span>     {</span><br><span>         return false;</s=
pan><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     int i =3D -1;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    unsigned int option_types_found =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi-&=
gt;context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct options o;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset(&amp;o, 0, siz=
eof(struct options));</span><br><span> </span><br><span>     while (msgs[++=
i].data &amp;&amp; *(msgs[i].data))</span><br><span>     {</span><br><span>=
@@ -158,33 +202,27 @@</span><br><span>             return false;</span><br>=
<span>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        /* After sending the control message, we update the op=
tions</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * serve=
r-side in the client&#39;s context so pushed options like</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-         * ifconfig/ifconfig-ipv6 can a=
ctually work.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* After sending the control message, we parse it, miming the behavior</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * of `process=
_incoming_push_msg()` and we fill an empty `options` struct</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * with the new options. If=
 an `ifconfig_local` or `ifconfig_ipv6_local`</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * options is found we update the vhash a=
ccordingly, so that the pushed</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * ifconfig/ifconfig-ipv6 options can actually work.</sp=
an><br><span>          * If we don&#39;t do that, packets arriving from the=
 client with the</span><br><span>          * new address will be rejected a=
nd packets for the new address</span><br><span>          * will not be rout=
ed towards the client.</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-         * For the same reason we later update the vhash too in</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-         * `send_push_update()` =
function.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * U=
sing `buf_string_compare_advance()` we mimic the behavior</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-         * inside `process_incoming_pus=
h_msg()`. However, we don&#39;t need</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         * to check the return value here because we just wa=
nt to `advance`,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
    * meaning we skip the `push_update_cmd&#39; we added earlier.</span><br=
><span>          */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      buf_string_compare_advance(&amp;msgs[i], push_update_cmd);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (process_incoming_pus=
h_update(c, pull_permission_mask(c), option_types_found, &amp;msgs[i], true=
) =3D=3D PUSH_MSG_ERROR)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (process_sent_push_update(c, &amp;o, &amp;option_types_foun=
d, &amp;msgs[i]) =3D=3D PUSH_MSG_ERROR)</span><br><span>         {</span><b=
r><span>             msg(M_WARN, &quot;Failed to process push update messag=
e sent to client ID: %u&quot;,</span><br><span>                 c-&gt;c2.tl=
s_multi ? c-&gt;c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            continue;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        c-&gt;options.push_option_types_found |=3D *o=
ption_types_found;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (!options_postprocess_pull(&amp;c-&gt;options, c-&gt;c2.es))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;Failed to =
post-process push update message sent to client ID: %u&quot;,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                c-&gt;c2.tls_multi =
? c-&gt;c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br><span>         }<=
/span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (option_t=
ypes_found &amp; OPT_P_UP)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 update_vhash(m, mi, o.ifconfig_local, o.ifconfig_ipv6_local);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     return true;</span><br><=
span> }</span><br><span> </span><br><span>@@ -206,8 +244,6 @@</span><br><sp=
an>     int msgs_num =3D (strlen(msg) / safe_cap) + ((strlen(msg) % safe_ca=
p) !=3D 0);</span><br><span>     struct buffer *msgs =3D gc_malloc((msgs_nu=
m + 1) * sizeof(struct buffer), true, &amp;gc);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int option_types_f=
ound =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span>     msgs[msgs_num].data =3D NULL;</span><br><span>     if (!message=
_splitter(msg, msgs, &amp;gc, safe_cap))</span><br><span>     {</span><br><=
span>@@ -224,15 +260,9 @@</span><br><span>             return -ENOENT;</spa=
n><br><span>         }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        const char *old_ip =3D mi-&gt;context.options.if=
config_local;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
const char *old_ipv6 =3D mi-&gt;context.options.ifconfig_ipv6_local;</span>=
<br><span>         if (!mi-&gt;halt</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            &amp;&amp; send_single_push_update(&amp;mi-&gt;co=
ntext, msgs, &amp;option_types_found))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            &amp;&amp; send_single_push_update(m, mi, ms=
gs))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            if (option_types_found &amp; OPT_P_UP)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                update_vhash(m, mi, old_ip,=
 old_ipv6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span>             gc_free(&amp;gc);</span><br><span>        =
     return 1;</span><br><span>         }</span><br><span>@@ -258,19 +288,1=
2 @@</span><br><span>         }</span><br><span> </span><br><span>         =
/* Type is UPT_BROADCAST so we update every client */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        option_types_found =3D 0;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        const char *old_ip =3D =
curr_mi-&gt;context.options.ifconfig_local;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        const char *old_ipv6 =3D curr_mi-&gt;context.=
options.ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (!send_single_push_update(&amp;curr_mi-&gt;context, msgs,=
 &amp;option_types_found))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (!send_single_push_update(m, curr_mi, msgs))</span><br><s=
pan>         {</span><br><span>             msg(M_CLIENT, &quot;ERROR: Peer=
 ID: %u has not been updated&quot;,</span><br><span>                 curr_m=
i-&gt;context.c2.tls_multi ? curr_mi-&gt;context.c2.tls_multi-&gt;peer_id :=
 UINT32_MAX);</span><br><span>             continue;</span><br><span>      =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (optio=
n_types_found &amp; OPT_P_UP)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        update_vhash(m, curr_mi, old_ip, old_ipv6);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>         count++;=
</span><br><span>     }</span><br><span> </span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test=
_push_update_msg.c</span><br><span>index 8a5beeb..650fd2e 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span=
>+++ b/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>@@ -=
95,7 +95,7 @@</span><br><span>     }</span><br><span>     else if (honor_re=
ceived_options &amp;&amp; buf_string_compare_advance(&amp;buf, push_update_=
cmd))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return process_incoming_push_update(c, permission_mask, opti=
on_types_found, &amp;buf, false);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return process_incoming_push_update(c, permission_mas=
k, option_types_found, &amp;buf);</span><br><span>     }</span><br><span>  =
   else</span><br><span>     {</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail">c=
hange 1253</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde987=
02a9801616a5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1253 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--8jUH+MIXb14=--

