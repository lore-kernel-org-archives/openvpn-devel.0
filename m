From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 3 Sep 2025 20:26:47 +0000
In-Reply-To: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
References: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <5ce1d44ea6d0a0617c25687706d5059471479f62-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lWZV37sOPqk="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE message
 sender: enabling the server to send PUSH_UPDATE c...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lWZV37sOPqk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#26) to the change originally created b=
y mrbff. ( http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: PUSH_UPDATE message sender: enabling the server to send PUS=
H_UPDATE control messages
......................................................................

PUSH_UPDATE message sender: enabling the server to send PUSH_UPDATE control=
 messages

Using the management interface you can now target one or more clients
(via broadcast or via cid) and send a PUSH_UPDATE control message
to update some options.  See doc/management-notes.txt for details.

Change-Id: Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250903164826.13284-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
807.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M doc/management-notes.txt
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/options.c
M src/openvpn/options_util.c
M src/openvpn/push.c
M src/openvpn/push.h
M src/openvpn/push_util.c
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_push_update_msg.c
13 files changed, 741 insertions(+), 18 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/869/26

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 35513e9..f027b01 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -874,9 +874,10 @@
     target_sources(test_push_update_msg PRIVATE
         tests/unit_tests/openvpn/mock_msg.c
         tests/unit_tests/openvpn/mock_get_random.c
-	    src/openvpn/push_util.c
-	    src/openvpn/options_util.c
-	    src/openvpn/otime.c
+        src/openvpn/push_util.c
+        src/openvpn/options_util.c
+        src/openvpn/otime.c
+        src/openvpn/list.c
         )

     if (TARGET test_argv)
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index f1d2930..1a5c311 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -1028,6 +1028,35 @@
 stored outside of the filesystem (e.g. in Mac OS X Keychain)
 with OpenVPN via the management interface.

+COMMAND -- push-update-broad (OpenVPN 2.7 or higher)
+----------------------------------------------------
+Send a message to every connected client to update options at runtime.
+The updatable options are: "block-ipv6", "block-outside-dns", "dhcp-option=
",
+"dns", "ifconfig", "ifconfig-ipv6", "redirect-gateway", "redirect-private",
+"route", "route-gateway", "route-ipv6", "route-metric", "topology",
+"tun-mtu", "keepalive". When a valid option is pushed, the receiving clien=
t will
+delete every previous value and set new value, so the update of the option=
 will
+not be incremental even when theoretically possible (ex. with "redirect-ga=
teway").
+The '-' symbol in front of an option means the option should be removed.
+When an option is used with '-', it cannot take any parameter.
+The '?' symbol in front of an option means the option's update is optional
+so if the client do not support it, that option will just be ignored witho=
ut
+making fail the entire command. The '-' and '?' symbols can be used togeth=
er.
+
+Option Format Ex.
+  `-?option`, `-option`, `?option parameters` are valid formats,
+  `?-option` is not a valid format.
+
+Example
+  push-update-broad "route 10.10.10.1 255.255.255.255, -dns, ?tun-mtu 1400"
+
+COMMAND -- push-update-cid (OpenVPN 2.7 or higher)
+----------------------------------------------------
+Same as push-update-broad but you must target a single client using client=
 id.
+
+Example
+  push-update-cid 42 "route 10.10.10.1 255.255.255.255, -dns, ?tun-mtu 140=
0"
+
 OUTPUT FORMAT
 -------------

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 5b2a7de..114e4c6 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -41,6 +41,7 @@
 #include "manage.h"
 #include "openvpn.h"
 #include "dco.h"
+#include "push.h"
 #include "multi.h"

 #include "memdbg.h"
@@ -132,8 +133,10 @@
     msg(M_CLIENT, "test n                 : Produce n lines of output for =
testing/debugging.");
     msg(M_CLIENT, "username type u        : Enter username u for a queried=
 OpenVPN username.");
     msg(M_CLIENT, "verb [n]               : Set log verbosity level to n, =
or show if n is absent.");
-    msg(M_CLIENT,
-        "version [n]            : Set client's version to n or show curren=
t version of daemon.");
+    msg(M_CLIENT, "version [n]            : Set client's version to n or s=
how current version of daemon.");
+    msg(M_CLIENT, "push-update-broad options : Broadcast a message to upda=
te the specified options.");
+    msg(M_CLIENT, "                            Ex. push-update-broad \"rou=
te something, -dns\"");
+    msg(M_CLIENT, "push-update-cid CID options : Send an update message to=
 the client identified by CID.");
     msg(M_CLIENT, "END");
 }

@@ -1333,6 +1336,48 @@
 }

 static void
+man_push_update(struct management *man, const char **p, const push_update_=
type type)
+{
+    bool status =3D false;
+
+    if (type =3D=3D UPT_BROADCAST)
+    {
+        if (!man->persist.callback.push_update_broadcast)
+        {
+            man_command_unsupported("push-update-broad");
+            return;
+        }
+
+        status =3D (*man->persist.callback.push_update_broadcast)(man->per=
sist.callback.arg, p[1]);
+    }
+    else if (type =3D=3D UPT_BY_CID)
+    {
+        if (!man->persist.callback.push_update_by_cid)
+        {
+            man_command_unsupported("push-update-cid");
+            return;
+        }
+
+        unsigned long cid =3D 0;
+
+        if (!parse_cid(p[1], &cid))
+        {
+            msg(M_CLIENT, "ERROR: push-update-cid fail during cid parsing"=
);
+            return;
+        }
+
+        status =3D (*man->persist.callback.push_update_by_cid)(man->persis=
t.callback.arg, cid, p[2]);
+    }
+
+    if (status)
+    {
+        msg(M_CLIENT, "SUCCESS: push-update command succeeded");
+        return;
+    }
+    msg(M_CLIENT, "ERROR: push-update command failed");
+}
+
+static void
 man_dispatch_command(struct management *man, struct status_output *so, con=
st char **p,
                      const int nparms)
 {
@@ -1655,6 +1700,20 @@
             man_remote(man, p);
         }
     }
+    else if (streq(p[0], "push-update-broad"))
+    {
+        if (man_need(man, p, 1, 0))
+        {
+            man_push_update(man, p, UPT_BROADCAST);
+        }
+    }
+    else if (streq(p[0], "push-update-cid"))
+    {
+        if (man_need(man, p, 2, 0))
+        {
+            man_push_update(man, p, UPT_BY_CID);
+        }
+    }
 #if 1
     else if (streq(p[0], "test"))
     {
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 0b064cf..0bce25e 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -43,7 +43,6 @@
 #define MF_EXTERNAL_KEY_PSSPAD    (1u << 16)
 #define MF_EXTERNAL_KEY_DIGEST    (1u << 17)

-
 #ifdef ENABLE_MANAGEMENT

 #include "misc.h"
@@ -197,6 +196,8 @@
 #endif
     unsigned int (*remote_entry_count)(void *arg);
     bool (*remote_entry_get)(void *arg, unsigned int index, char **remote);
+    bool (*push_update_broadcast)(void *arg, const char *options);
+    bool (*push_update_by_cid)(void *arg, unsigned long cid, const char *o=
ptions);
 };

 /*
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f1abdbe..85975ff 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3996,7 +3996,7 @@
     }
 }

-static struct multi_instance *
+struct multi_instance *
 lookup_by_cid(struct multi_context *m, const unsigned long cid)
 {
     if (m)
@@ -4137,6 +4137,8 @@
         cb.client_auth =3D management_client_auth;
         cb.client_pending_auth =3D management_client_pending_auth;
         cb.get_peer_info =3D management_get_peer_info;
+        cb.push_update_broadcast =3D management_callback_send_push_update_=
broadcast;
+        cb.push_update_by_cid =3D management_callback_send_push_update_by_=
cid;
         management_set_callback(management, &cb);
     }
 #endif /* ifdef ENABLE_MANAGEMENT */
@@ -4261,3 +4263,47 @@
     multi_top_free(&multi);
     close_instance(top);
 }
+
+/**
+ * Update the vhash with new IP/IPv6 addresses in the multi_context when a
+ * push-update message containing ifconfig/ifconfig-ipv6 options is sent
+ * from the server. This function should be called after a push-update
+ * and old_ip/old_ipv6 are the previous addresses of the client in
+ * ctx->options.ifconfig_local and ctx->options.ifconfig_ipv6_local.
+ */
+void
+update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *old_ip, const char *old_ipv6)
+{
+    struct in_addr addr;
+    struct in6_addr new_ipv6;
+
+    if ((mi->context.options.ifconfig_local && (!old_ip || strcmp(old_ip, =
mi->context.options.ifconfig_local)))
+        && inet_pton(AF_INET, mi->context.options.ifconfig_local, &addr) =
=3D=3D 1)
+    {
+        in_addr_t new_ip =3D ntohl(addr.s_addr);
+
+        /* Add new IP */
+        multi_learn_in_addr_t(m, mi, new_ip, -1, true);
+    }
+
+    /* TO DO:
+     *  else if (old_ip)
+     *  {
+     *      // remove old IP
+     *  }
+     */
+
+    if ((mi->context.options.ifconfig_ipv6_local && (!old_ipv6 || strcmp(o=
ld_ipv6, mi->context.options.ifconfig_ipv6_local)))
+        && inet_pton(AF_INET6, mi->context.options.ifconfig_ipv6_local, &n=
ew_ipv6) =3D=3D 1)
+    {
+        /* Add new IPv6 */
+        multi_learn_in6_addr(m, mi, new_ipv6, -1, true);
+    }
+
+    /* TO DO:
+     *  else if (old_ipv6)
+     *  {
+     *      // remove old IPv6
+     *  }
+     */
+}
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index e87e465..087c0e6 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -686,5 +686,12 @@
  */
 void multi_assign_peer_id(struct multi_context *m, struct multi_instance *=
mi);

+#ifdef ENABLE_MANAGEMENT
+struct multi_instance *
+lookup_by_cid(struct multi_context *m, const unsigned long cid);
+#endif
+
+void
+update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *old_ip, const char *old_ipv6);

 #endif /* MULTI_H */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a268b92..0616a17 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5488,7 +5488,6 @@
             {
                 continue; /* Ignoring this option */
             }
-            throw_signal_soft(SIGUSR1, "Offending option received from ser=
ver");
             return false; /* Cause push/pull error and stop push processin=
g */
         }

diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index be1eefc..28f1f9e 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -236,11 +236,11 @@
     {
         if (*flags & PUSH_OPT_OPTIONAL)
         {
-            msg(D_PUSH, "Pushed option is not updatable: '%s'. Ignoring.",=
 line);
+            msg(D_PUSH, "Pushed dispensable option is not updatable: '%s'.=
 Ignoring.", line);
         }
         else
         {
-            msg(M_WARN, "Pushed option is not updatable: '%s'. Restarting.=
", line);
+            msg(M_WARN, "Pushed option is not updatable: '%s'.", line);
             return false;
         }
     }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 4f6adfc..1ea7ed9 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1073,6 +1073,10 @@
                     break;
             }
         }
+        else
+        {
+            throw_signal_soft(SIGUSR1, "Offending option received from ser=
ver");
+        }
     }
     else if (ch =3D=3D '\0')
     {
@@ -1100,7 +1104,7 @@
     }
     else if (honor_received_options && buf_string_compare_advance(&buf, pu=
sh_update_cmd))
     {
-        return process_incoming_push_update(c, permission_mask, option_typ=
es_found, &buf);
+        return process_incoming_push_update(c, permission_mask, option_typ=
es_found, &buf, false);
     }
     else
     {
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 22b940f..8ffd0c2 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -41,6 +41,15 @@
 #define PUSH_OPT_TO_REMOVE (1 << 0)
 #define PUSH_OPT_OPTIONAL  (1 << 1)

+#ifdef ENABLE_MANAGEMENT
+/* Push-update message sender modes */
+typedef enum
+{
+    UPT_BROADCAST =3D 0,
+    UPT_BY_CID =3D 1
+} push_update_type;
+#endif
+
 int process_incoming_push_request(struct context *c);

 /**
@@ -56,6 +65,7 @@
  * @param option_types_found A pointer to a variable that will be filled w=
ith the types of options
  *                           found in the message.
  * @param buf A buffer containing the received message.
+ * @param msg_sender A boolean indicating if function is called by the mes=
sage sender (server).
  *
  * @return
  * - `PUSH_MSG_UPDATE`: The message was processed successfully, and the up=
dates were applied.
@@ -65,7 +75,8 @@
  */

 int process_incoming_push_update(struct context *c, unsigned int permissio=
n_mask,
-                                 unsigned int *option_types_found, struct =
buffer *buf);
+                                 unsigned int *option_types_found, struct =
buffer *buf,
+                                 bool msg_sender);

 int process_incoming_push_msg(struct context *c, const struct buffer *buff=
er,
                               bool honor_received_options, unsigned int pe=
rmission_mask,
@@ -127,4 +138,28 @@
  */
 void receive_auth_pending(struct context *c, const struct buffer *buffer);

+#ifdef ENABLE_MANAGEMENT
+/**
+ * @brief A function to send a PUSH_UPDATE control message from server to =
client(s).
+ *
+ * @param m the multi_context, contains all the clients connected to this =
server.
+ * @param target the target to which to send the message. It should be:
+ * `NULL` if `type =3D=3D UPT_BROADCAST`,
+ * a `mroute_addr *` if `type =3D=3D UPT_BY_ADDR`,
+ * a `char *` if `type =3D=3D UPT_BY_CN`,
+ * an `unsigned long *` if `type =3D=3D UPT_BY_CID`.
+ * @param msg a string containing the options to send.
+ * @param type the way to address the message (broadcast, by cid, by cn, b=
y address).
+ * @param push_bundle_size the maximum size of a bundle of pushed option. =
Just use PUSH_BUNDLE_SIZE macro.
+ * @return the number of clients to which the message was sent.
+ */
+int
+send_push_update(struct multi_context *m, const void *target, const char *=
msg, const push_update_type type, const int push_bundle_size);
+
+bool management_callback_send_push_update_broadcast(void *arg, const char =
*options);
+
+bool management_callback_send_push_update_by_cid(void *arg, unsigned long =
cid, const char *options);
+
+#endif /* ifdef ENABLE_MANAGEMENT*/
+
 #endif /* ifndef PUSH_H */
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 0862a74..bd3992b 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -3,10 +3,16 @@
 #endif

 #include "push.h"
+#include "buffer.h"
+
+#ifdef ENABLE_MANAGEMENT
+#include "multi.h"
+#endif

 int
 process_incoming_push_update(struct context *c, unsigned int permission_ma=
sk,
-                             unsigned int *option_types_found, struct buff=
er *buf)
+                             unsigned int *option_types_found, struct buff=
er *buf,
+                             bool msg_sender)
 {
     int ret =3D PUSH_MSG_ERROR;
     const uint8_t ch =3D buf_read_u8(buf);
@@ -27,6 +33,10 @@
                     break;
             }
         }
+        else if (!msg_sender)
+        {
+            throw_signal_soft(SIGUSR1, "Offending option received from ser=
ver");
+        }
     }
     else if (ch =3D=3D '\0')
     {
@@ -35,3 +45,260 @@

     return ret;
 }
+
+#ifdef ENABLE_MANAGEMENT
+/**
+ * Return index of last `,` or `0` if it didn't find any.
+ * If there is a comma at index `0` it's an error anyway
+ */
+static int
+find_first_comma_of_next_bundle(const char *str, int ix)
+{
+    while (ix > 0)
+    {
+        if (str[ix] =3D=3D ',')
+        {
+            return ix;
+        }
+        ix--;
+    }
+    return 0;
+}
+
+/* Allocate memory and assemble the final message */
+static struct buffer
+forge_msg(const char *src, const char *continuation, struct gc_arena *gc)
+{
+    int src_len =3D strlen(src);
+    int con_len =3D continuation ? strlen(continuation) : 0;
+    struct buffer buf =3D alloc_buf_gc(src_len + sizeof(push_update_cmd) +=
 con_len + 2, gc);
+
+    buf_printf(&buf, "%s,%s%s", push_update_cmd, src, continuation ? conti=
nuation : "");
+
+    return buf;
+}
+
+static char *
+gc_strdup(const char *src, struct gc_arena *gc)
+{
+    char *ret =3D gc_malloc((strlen(src) + 1) * sizeof(char), true, gc);
+
+    strcpy(ret, src);
+    return ret;
+}
+
+/* It split the messagge (if necessay) and fill msgs with the message chun=
ks.
+ * Return `false` on failure an `true` on success.
+ */
+static bool
+message_splitter(const char *s, struct buffer *msgs, struct gc_arena *gc, =
const int safe_cap)
+{
+    if (!s || !*s)
+    {
+        return false;
+    }
+
+    char *str =3D gc_strdup(s, gc);
+    int i =3D 0;
+    int im =3D 0;
+
+    while (*str)
+    {
+        /* + ',' - '/0' */
+        if (strlen(str) > safe_cap)
+        {
+            int ci =3D find_first_comma_of_next_bundle(str, safe_cap);
+            if (!ci)
+            {
+                /* if no commas were found go to fail, do not send any mes=
sage */
+                return false;
+            }
+            str[ci] =3D '\0';
+            /* copy from i to (ci -1) */
+            msgs[im] =3D forge_msg(str, ",push-continuation 2", gc);
+            i =3D ci + 1;
+        }
+        else
+        {
+            if (im)
+            {
+                msgs[im] =3D forge_msg(str, ",push-continuation 1", gc);
+            }
+            else
+            {
+                msgs[im] =3D forge_msg(str, NULL, gc);
+            }
+            i =3D strlen(str);
+        }
+        str =3D &str[i];
+        im++;
+    }
+    return true;
+}
+
+/* send the message(s) prepared to one single client */
+static bool
+send_single_push_update(struct context *c, struct buffer *msgs, unsigned i=
nt *option_types_found)
+{
+    if (!msgs[0].data || !*(msgs[0].data))
+    {
+        return false;
+    }
+    int i =3D -1;
+
+    while (msgs[++i].data && *(msgs[i].data))
+    {
+        if (!send_control_channel_string(c, BSTR(&msgs[i]), D_PUSH))
+        {
+            return false;
+        }
+
+        /* After sending the control message, we update the options
+         * server-side in the client's context so pushed options like
+         * ifconfig/ifconfig-ipv6 can actually work.
+         * If we don't do that, packets arriving from the client with the
+         * new address will be rejected and packets for the new address
+         * will not be routed towards the client.
+         * For the same reason we later update the vhash too in
+         * `send_push_update()` function.
+         */
+        buf_string_compare_advance(&msgs[i], push_update_cmd);
+        if (process_incoming_push_update(c, pull_permission_mask(c), optio=
n_types_found, &msgs[i], true) =3D=3D PUSH_MSG_ERROR)
+        {
+            msg(M_WARN, "Failed to process push update message sent to cli=
ent ID: %u",
+                c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);
+            continue;
+        }
+        c->options.push_option_types_found |=3D *option_types_found;
+        if (!options_postprocess_pull(&c->options, c->c2.es))
+        {
+            msg(M_WARN, "Failed to post-process push update message sent t=
o client ID: %u",
+                c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);
+        }
+    }
+    return true;
+}
+
+int
+send_push_update(struct multi_context *m, const void *target, const char *=
msg, const push_update_type type, const int push_bundle_size)
+{
+    if (!msg || !*msg || !m
+        || (!target && type !=3D UPT_BROADCAST))
+    {
+        return -EINVAL;
+    }
+
+    struct gc_arena gc =3D gc_new();
+    /* extra space for possible trailing ifconfig and push-continuation */
+    const int extra =3D 84 + sizeof(push_update_cmd);
+    /* push_bundle_size is the maximum size of a message, so if the message
+     * we want to send exceeds that size we have to split it into smaller =
messages */
+    const int safe_cap =3D push_bundle_size - extra;
+    int msgs_num =3D (strlen(msg) / safe_cap) + ((strlen(msg) % safe_cap) =
!=3D 0);
+    struct buffer *msgs =3D gc_malloc((msgs_num + 1) * sizeof(struct buffe=
r), true, &gc);
+
+    unsigned int option_types_found =3D 0;
+
+    msgs[msgs_num].data =3D NULL;
+    if (!message_splitter(msg, msgs, &gc, safe_cap))
+    {
+        gc_free(&gc);
+        return -EINVAL;
+    }
+
+    if (type =3D=3D UPT_BY_CID)
+    {
+        struct multi_instance *mi =3D lookup_by_cid(m, *((unsigned long *)=
target));
+
+        if (!mi)
+        {
+            return -ENOENT;
+        }
+
+        const char *old_ip =3D mi->context.options.ifconfig_local;
+        const char *old_ipv6 =3D mi->context.options.ifconfig_ipv6_local;
+        if (!mi->halt
+            && send_single_push_update(&mi->context, msgs, &option_types_f=
ound))
+        {
+            if (option_types_found & OPT_P_UP)
+            {
+                update_vhash(m, mi, old_ip, old_ipv6);
+            }
+            gc_free(&gc);
+            return 1;
+        }
+        else
+        {
+            gc_free(&gc);
+            return 0;
+        }
+    }
+
+    int count =3D 0;
+    struct hash_iterator hi;
+    const struct hash_element *he;
+
+    hash_iterator_init(m->iter, &hi);
+    while ((he =3D hash_iterator_next(&hi)))
+    {
+        struct multi_instance *curr_mi =3D he->value;
+
+        if (curr_mi->halt)
+        {
+            continue;
+        }
+
+        /* Type is UPT_BROADCAST so we update every client */
+        option_types_found =3D 0;
+        const char *old_ip =3D curr_mi->context.options.ifconfig_local;
+        const char *old_ipv6 =3D curr_mi->context.options.ifconfig_ipv6_lo=
cal;
+        if (!send_single_push_update(&curr_mi->context, msgs, &option_type=
s_found))
+        {
+            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated",
+                curr_mi->context.c2.tls_multi ? curr_mi->context.c2.tls_mu=
lti->peer_id : UINT32_MAX);
+            continue;
+        }
+        if (option_types_found & OPT_P_UP)
+        {
+            update_vhash(m, curr_mi, old_ip, old_ipv6);
+        }
+        count++;
+    }
+
+    hash_iterator_free(&hi);
+    gc_free(&gc);
+    return count;
+}
+
+#define RETURN_UPDATE_STATUS(n_sent)                                  \
+    do                                                                \
+    {                                                                 \
+        if ((n_sent) > 0)                                             \
+        {                                                             \
+            msg(M_CLIENT, "SUCCESS: %d client(s) updated", (n_sent)); \
+            return true;                                              \
+        }                                                             \
+        else                                                          \
+        {                                                             \
+            msg(M_CLIENT, "ERROR: no client updated");                \
+            return false;                                             \
+        }                                                             \
+    } while (0)
+
+
+bool
+management_callback_send_push_update_broadcast(void *arg, const char *opti=
ons)
+{
+    int n_sent =3D send_push_update(arg, NULL, options, UPT_BROADCAST, PUS=
H_BUNDLE_SIZE);
+
+    RETURN_UPDATE_STATUS(n_sent);
+}
+
+bool
+management_callback_send_push_update_by_cid(void *arg, unsigned long cid, =
const char *options)
+{
+    int n_sent =3D send_push_update(arg, &cid, options, UPT_BY_CID, PUSH_B=
UNDLE_SIZE);
+
+    RETURN_UPDATE_STATUS(n_sent);
+}
+#endif /* ifdef ENABLE_MANAGEMENT */
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 7a7fec7..ec8cc69 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -337,7 +337,8 @@
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/push_util.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
-	$(top_srcdir)/src/openvpn/otime.c
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/list.c

 socket_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
index 0f4ad41..87329b1 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -8,9 +8,16 @@
 #include <cmocka.h>
 #include "push.h"
 #include "options_util.h"
+#include "multi.h"

 /* mocks */

+void
+throw_signal_soft(const int signum, const char *signal_text)
+{
+    msg(M_WARN, "Offending option received from server");
+}
+
 unsigned int
 pull_permission_mask(const struct context *c)
 {
@@ -21,6 +28,18 @@
     return flags;
 }

+void
+update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *old_ip, const char *old_ipv6)
+{
+    return;
+}
+
+bool
+options_postprocess_pull(struct options *options, struct env_set *es)
+{
+    return true;
+}
+
 bool
 apply_push_options(struct context *c, struct options *options, struct buff=
er *buf,
                    unsigned int permission_mask, unsigned int *option_type=
s_found,
@@ -48,7 +67,6 @@
                 {
                     continue; /* Ignoring this option */
                 }
-                msg(M_WARN, "Offending option received from server");
                 return false; /* Cause push/pull error and stop push proce=
ssing */
             }
         }
@@ -77,7 +95,7 @@
     }
     else if (honor_received_options && buf_string_compare_advance(&buf, pu=
sh_update_cmd))
     {
-        return process_incoming_push_update(c, permission_mask, option_typ=
es_found, &buf);
+        return process_incoming_push_update(c, permission_mask, option_typ=
es_found, &buf, false);
     }
     else
     {
@@ -85,6 +103,49 @@
     }
 }

+const char *
+tls_common_name(const struct tls_multi *multi, const bool null)
+{
+    return NULL;
+}
+
+#ifndef ENABLE_MANAGEMENT
+bool
+send_control_channel_string(struct context *c, const char *str, int msglev=
el)
+{
+    return true;
+}
+#else  /* ifndef ENABLE_MANAGEMENT */
+char **res;
+int i;
+
+bool
+send_control_channel_string(struct context *c, const char *str, int msglev=
el)
+{
+    if (res && res[i] && strcmp(res[i], str))
+    {
+        printf("\n\nexpected: %s\n\n  actual: %s\n\n", res[i], str);
+        return false;
+    }
+    i++;
+    return true;
+}
+
+struct multi_instance *
+lookup_by_cid(struct multi_context *m, const unsigned long cid)
+{
+    return *(m->instances);
+}
+
+bool
+mroute_extract_openvpn_sockaddr(struct mroute_addr *addr,
+                                const struct openvpn_sockaddr *osaddr,
+                                bool use_port)
+{
+    return true;
+}
+#endif /* ifndef ENABLE_MANAGEMENT */
+
 /* tests */

 static void
@@ -120,7 +181,6 @@
     free_buf(&buf);
 }

-
 static void
 test_incoming_push_message_error2(void **state)
 {
@@ -219,6 +279,207 @@
     free_buf(&buf);
 }

+#ifdef ENABLE_MANAGEMENT
+char *r0[] =3D {
+    "PUSH_UPDATE,redirect-gateway local,route 192.168.1.0 255.255.255.0"
+};
+char *r1[] =3D {
+    "PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalala=
lalalalalalalalaf,push-continuation 2",
+    "PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,redire=
ct-gateway local,push-continuation 2",
+    "PUSH_UPDATE,route 192.168.1.0 255.255.255.0,push-continuation 1"
+};
+char *r3[] =3D {
+    "PUSH_UPDATE,,,"
+};
+char *r4[] =3D {
+    "PUSH_UPDATE,-dhcp-option, blablalalalalalalalalalalalalf, lalalalalal=
alalalalalalalalaf,push-continuation 2",
+    "PUSH_UPDATE, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redire=
ct-gateway local,push-continuation 2",
+    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1"
+};
+char *r5[] =3D {
+    "PUSH_UPDATE,,-dhcp-option, blablalalalalalalalalalalalalf, lalalalala=
lalalalalalalalalaf,push-continuation 2",
+    "PUSH_UPDATE, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redire=
ct-gateway local,push-continuation 2",
+    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,push-continuation 1"
+};
+char *r6[] =3D {
+    "PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalala=
lalalalalalalalaf,push-continuation 2",
+    "PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8, redir=
ect-gateway 10.10.10.10,,push-continuation 2",
+    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1"
+};
+char *r7[] =3D {
+    "PUSH_UPDATE,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,=
,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,push-continuation 2",
+    "PUSH_UPDATE,,,,,,,,,,,,,,,,,,,push-continuation 1"
+};
+char *r8[] =3D {
+    "PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalala=
lalalalalalalalaf,push-continuation 2",
+    "PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,redire=
ct-gateway\n local,push-continuation 2",
+    "PUSH_UPDATE,route 192.168.1.0 255.255.255.0\n\n\n,push-continuation 1"
+};
+char *r9[] =3D {
+    "PUSH_UPDATE,,"
+};
+
+
+const char *msg0 =3D "redirect-gateway local,route 192.168.1.0 255.255.255=
.0";
+const char *msg1 =3D "-dhcp-option,blablalalalalalalalalalalalalf, lalalal=
alalalalalalalalalalaf,"
+                   " akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,red=
irect-gateway local,route 192.168.1.0 255.255.255.0";
+const char *msg2 =3D "";
+const char *msg3 =3D ",,";
+const char *msg4 =3D "-dhcp-option, blablalalalalalalalalalalalalf, lalala=
lalalalalalalalalalalaf,"
+                   " akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, red=
irect-gateway local, route 192.168.1.0 255.255.255.0,";
+const char *msg5 =3D ",-dhcp-option, blablalalalalalalalalalalalalf, lalal=
alalalalalalalalalalalaf,"
+                   " akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, red=
irect-gateway local, route 192.168.1.0 255.255.255.0";
+const char *msg6 =3D "-dhcp-option,blablalalalalalalalalalalalalf, lalalal=
alalalalalalalalalalaf, akakakakakakakakakakakaf,"
+                   " dhcp-option DNS 8.8.8.8, redirect-gateway 10.10.10.10=
,, route 192.168.1.0 255.255.255.0,";
+const char *msg7 =3D ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,=
,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,";
+const char *msg8 =3D "-dhcp-option,blablalalalalalalalalalalalalf, lalalal=
alalalalalalalalalalaf, akakakakakakakakakakakaf,"
+                   " dhcp-option DNS 8.8.8.8,redirect-gateway\n local,rout=
e 192.168.1.0 255.255.255.0\n\n\n";
+const char *msg9 =3D ",";
+
+const char *msg10 =3D "abandon ability able about above absent absorb abst=
ract absurd abuse access accident account accuse achieve"
+                    "acid acoustic acquire across act action actor actress=
 actual adapt add addict address adjust"
+                    "baby bachelor bacon badge bag balance balcony ball ba=
mboo banana banner bar barely bargain barrel base basic"
+                    "basket battle beach bean beauty because become beef b=
efore begin behave behind"
+                    "cabbage cabin cable cactus cage cake call calm camera=
 camp can canal cancel candy cannon canoe canvas canyon"
+                    "capable capital captain car carbon card cargo carpet =
carry cart case"
+                    "daisy damage damp dance danger daring dash daughter d=
awn day deal debate debris decade december decide decline"
+                    "decorate decrease deer defense define defy degree del=
ay deliver demand demise denial";
+
+#define PUSH_BUNDLE_SIZE_TEST 184
+
+static void
+test_send_push_msg0(void **state)
+{
+    i =3D 0;
+    res =3D r0;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    assert_int_equal(send_push_update(m, &cid, msg0, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
+}
+static void
+test_send_push_msg1(void **state)
+{
+    i =3D 0;
+    res =3D r1;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    assert_int_equal(send_push_update(m, &cid, msg1, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg2(void **state)
+{
+    i =3D 0;
+    res =3D NULL;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    assert_int_equal(send_push_update(m, &cid, msg2, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), -EINVAL);
+}
+
+static void
+test_send_push_msg3(void **state)
+{
+    i =3D 0;
+    res =3D r3;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    assert_int_equal(send_push_update(m, &cid, msg3, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg4(void **state)
+{
+    i =3D 0;
+    res =3D r4;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    assert_int_equal(send_push_update(m, &cid, msg4, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg5(void **state)
+{
+    i =3D 0;
+    res =3D r5;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    assert_int_equal(send_push_update(m, &cid, msg5, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg6(void **state)
+{
+    i =3D 0;
+    res =3D r6;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    assert_int_equal(send_push_update(m, &cid, msg6, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg7(void **state)
+{
+    i =3D 0;
+    res =3D r7;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    assert_int_equal(send_push_update(m, &cid, msg7, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg8(void **state)
+{
+    i =3D 0;
+    res =3D r8;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    assert_int_equal(send_push_update(m, &cid, msg8, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg9(void **state)
+{
+    i =3D 0;
+    res =3D r9;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    assert_int_equal(send_push_update(m, &cid, msg9, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg10(void **state)
+{
+    i =3D 0;
+    res =3D NULL;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    assert_int_equal(send_push_update(m, &cid, msg10, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), -EINVAL);
+}
+
+#undef PUSH_BUNDLE_SIZE_TEST
+
+static int
+setup2(void **state)
+{
+    struct multi_context *m =3D calloc(1, sizeof(struct multi_context));
+    m->instances =3D calloc(1, sizeof(struct multi_instance *));
+    struct multi_instance *mi =3D calloc(1, sizeof(struct multi_instance));
+    *(m->instances) =3D mi;
+    *state =3D m;
+    return 0;
+}
+
+static int
+teardown2(void **state)
+{
+    struct multi_context *m =3D *state;
+    free(*(m->instances));
+    free(m->instances);
+    free(m);
+    return 0;
+}
+#endif /* ifdef ENABLE_MANAGEMENT */
+
 static int
 setup(void **state)
 {
@@ -249,7 +510,20 @@
         cmocka_unit_test_setup_teardown(test_incoming_push_message_1, setu=
p, teardown),
         cmocka_unit_test_setup_teardown(test_incoming_push_message_bad_for=
mat, setup, teardown),
         cmocka_unit_test_setup_teardown(test_incoming_push_message_mix, se=
tup, teardown),
-        cmocka_unit_test_setup_teardown(test_incoming_push_message_mix2, s=
etup, teardown)
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_mix2, s=
etup, teardown),
+#ifdef ENABLE_MANAGEMENT
+        cmocka_unit_test_setup_teardown(test_send_push_msg0, setup2, teard=
own2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg1, setup2, teard=
own2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg2, setup2, teard=
own2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg3, setup2, teard=
own2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg4, setup2, teard=
own2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg5, setup2, teard=
own2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg6, setup2, teard=
own2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg7, setup2, teard=
own2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg8, setup2, teard=
own2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg9, setup2, teard=
own2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg10, setup2, tear=
down2)
+#endif
     };

     return cmocka_run_group_tests(tests, NULL, NULL);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc
Gerrit-Change-Number: 869
Gerrit-PatchSet: 26
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--lWZV37sOPqk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #26</strong> to the change originally c=
reated by mrbff.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">PUSH_UPDATE message sender: enabling the server to s=
end PUSH_UPDATE control messages<br><br>Using the management interface you =
can now target one or more clients<br>(via broadcast or via cid) and send a=
 PUSH_UPDATE control message<br>to update some options.  See doc/management=
-notes.txt for details.<br><br>Change-Id: Ie82bcc7a8e583de9156b185d71d1a323=
ed8df3fc<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>Acked-by=
: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250903164826.13=
284-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-deve=
l@lists.sourceforge.net/msg32807.html<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M doc/management-notes.txt<=
br>M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>M src/openvpn/multi.=
c<br>M src/openvpn/multi.h<br>M src/openvpn/options.c<br>M src/openvpn/opti=
ons_util.c<br>M src/openvpn/push.c<br>M src/openvpn/push.h<br>M src/openvpn=
/push_util.c<br>M tests/unit_tests/openvpn/Makefile.am<br>M tests/unit_test=
s/openvpn/test_push_update_msg.c<br>13 files changed, 741 insertions(+), 18=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/69/869/26</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</s=
pan><br><span>index 35513e9..f027b01 100644</span><br><span>--- a/CMakeList=
s.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -874,9 +874,1=
0 @@</span><br><span>     target_sources(test_push_update_msg PRIVATE</span=
><br><span>         tests/unit_tests/openvpn/mock_msg.c</span><br><span>   =
      tests/unit_tests/openvpn/mock_get_random.c</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	    src/openvpn/push_util.c</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	    src/openvpn/options_util.c</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	    src/openvpn/otime.c</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/push_u=
til.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/op=
envpn/options_util.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        src/openvpn/otime.c</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        src/openvpn/list.c</span><br><span>         )</span><br><s=
pan> </span><br><span>     if (TARGET test_argv)</span><br><span>diff --git=
 a/doc/management-notes.txt b/doc/management-notes.txt</span><br><span>inde=
x f1d2930..1a5c311 100644</span><br><span>--- a/doc/management-notes.txt</s=
pan><br><span>+++ b/doc/management-notes.txt</span><br><span>@@ -1028,6 +10=
28,35 @@</span><br><span> stored outside of the filesystem (e.g. in Mac OS =
X Keychain)</span><br><span> with OpenVPN via the management interface.</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+COMMA=
ND -- push-update-broad (OpenVPN 2.7 or higher)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+-----------------------------------------------=
-----</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Send a message=
 to every connected client to update options at runtime.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+The updatable options are: &quot;block=
-ipv6&quot;, &quot;block-outside-dns&quot;, &quot;dhcp-option&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+&quot;dns&quot;, &quot;ifc=
onfig&quot;, &quot;ifconfig-ipv6&quot;, &quot;redirect-gateway&quot;, &quot=
;redirect-private&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+&quot;route&quot;, &quot;route-gateway&quot;, &quot;route-ipv6&quot;, =
&quot;route-metric&quot;, &quot;topology&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+&quot;tun-mtu&quot;, &quot;keepalive&quot;. Whe=
n a valid option is pushed, the receiving client will</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+delete every previous value and set new v=
alue, so the update of the option will</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+not be incremental even when theoretically possible (ex.=
 with &quot;redirect-gateway&quot;).</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+The &#39;-&#39; symbol in front of an option means the opt=
ion should be removed.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+When an option is used with &#39;-&#39;, it cannot take any parameter.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+The &#39;?&#39; symbo=
l in front of an option means the option&#39;s update is optional</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+so if the client do not suppo=
rt it, that option will just be ignored without</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+making fail the entire command. The &#39;-&#39;=
 and &#39;?&#39; symbols can be used together.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+Option Format Ex.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  `-?option`, `-option`, `?option parameters` are valid formats,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  `?-option` is not a va=
lid format.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+Example</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  push-update-broad &quot;route 10.10.1=
0.1 255.255.255.255, -dns, ?tun-mtu 1400&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+COMMAND -- push-update-cid (OpenVPN 2.7 or higher)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+------------------------------------=
----------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Sam=
e as push-update-broad but you must target a single client using client id.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+Example</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  push-update-cid 42 &quot;route 10.10.10.1 255.25=
5.255.255, -dns, ?tun-mtu 1400&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> OUTPUT FORMAT</span><br><span> ---------=
----</span><br><span> </span><br><span>diff --git a/src/openvpn/manage.c b/=
src/openvpn/manage.c</span><br><span>index 5b2a7de..114e4c6 100644</span><b=
r><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage=
.c</span><br><span>@@ -41,6 +41,7 @@</span><br><span> #include &quot;manage=
.h&quot;</span><br><span> #include &quot;openvpn.h&quot;</span><br><span> #=
include &quot;dco.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;push.h&quot;</span><br><span> #include &quot;multi.h&q=
uot;</span><br><span> </span><br><span> #include &quot;memdbg.h&quot;</span=
><br><span>@@ -132,8 +133,10 @@</span><br><span>     msg(M_CLIENT, &quot;te=
st n                 : Produce n lines of output for testing/debugging.&quo=
t;);</span><br><span>     msg(M_CLIENT, &quot;username type u        : Ente=
r username u for a queried OpenVPN username.&quot;);</span><br><span>     m=
sg(M_CLIENT, &quot;verb [n]               : Set log verbosity level to n, o=
r show if n is absent.&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    msg(M_CLIENT,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        &quot;version [n]            : Set client&#39;s version to n o=
r show current version of daemon.&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(M_CLIENT, &quot;version [n]            : Set =
client&#39;s version to n or show current version of daemon.&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_CLIENT, &quot;pu=
sh-update-broad options : Broadcast a message to update the specified optio=
ns.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
M_CLIENT, &quot;                            Ex. push-update-broad \&quot;ro=
ute something, -dns\&quot;&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(M_CLIENT, &quot;push-update-cid CID options : Send a=
n update message to the client identified by CID.&quot;);</span><br><span> =
    msg(M_CLIENT, &quot;END&quot;);</span><br><span> }</span><br><span> </s=
pan><br><span>@@ -1333,6 +1336,48 @@</span><br><span> }</span><br><span> </=
span><br><span> static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+man_push_update(struct management *man, const char **p, const push_=
update_type type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool status =3D =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (type =3D=3D UPT_BROADCAS=
T)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!man-&gt;persist.ca=
llback.push_update_broadcast)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            man_command_unsupported(&quot;push-update-broad&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        status =3D (*man-&gt;persist.callback.push_updat=
e_broadcast)(man-&gt;persist.callback.arg, p[1]);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else if (type =3D=3D UPT_BY_CID)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!man-&gt;persist.callback.push_update_by_ci=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            man_command_uns=
upported(&quot;push-update-cid&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        un=
signed long cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!par=
se_cid(p[1], &amp;cid))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(M_CLIENT, &quot;ERROR: push-update-cid fail during cid parsing&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        status =3D (*man-&gt;persist.call=
back.push_update_by_cid)(man-&gt;persist.callback.arg, cid, p[2]);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (status)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_CLIENT, &quot;SUCCESS: push-update command succeeded&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(M_CLIENT, &quot;ERROR: push-updat=
e command failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> man=
_dispatch_command(struct management *man, struct status_output *so, const c=
har **p,</span><br><span>                      const int nparms)</span><br>=
<span> {</span><br><span>@@ -1655,6 +1700,20 @@</span><br><span>           =
  man_remote(man, p);</span><br><span>         }</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0]=
, &quot;push-update-broad&quot;))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (man_need(man, p, 1, 0))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            man_push_update(man, p, UPT_BROADCAST);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else if (streq(p[0], &quot;push-update-cid&quot;))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (man_need(man, p, 2, 0))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            man_push_update(man, p=
, UPT_BY_CID);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span> #if 1</span><br><span>     else if (streq(p[0], &quot;test&quot;))<=
/span><br><span>     {</span><br><span>diff --git a/src/openvpn/manage.h b/=
src/openvpn/manage.h</span><br><span>index 0b064cf..0bce25e 100644</span><b=
r><span>--- a/src/openvpn/manage.h</span><br><span>+++ b/src/openvpn/manage=
.h</span><br><span>@@ -43,7 +43,6 @@</span><br><span> #define MF_EXTERNAL_K=
EY_PSSPAD    (1u &lt;&lt; 16)</span><br><span> #define MF_EXTERNAL_KEY_DIGE=
ST    (1u &lt;&lt; 17)</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><sp=
an> </span><br><span> #include &quot;misc.h&quot;</span><br><span>@@ -197,6=
 +196,8 @@</span><br><span> #endif</span><br><span>     unsigned int (*remo=
te_entry_count)(void *arg);</span><br><span>     bool (*remote_entry_get)(v=
oid *arg, unsigned int index, char **remote);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    bool (*push_update_broadcast)(void *arg, cons=
t char *options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  bool (*push_update_by_cid)(void *arg, unsigned long cid, const char *opti=
ons);</span><br><span> };</span><br><span> </span><br><span> /*</span><br><=
span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span=
>index f1abdbe..85975ff 100644</span><br><span>--- a/src/openvpn/multi.c</s=
pan><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3996,7 +3996,7 =
@@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static struct multi_instance *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_instance *=
</span><br><span> lookup_by_cid(struct multi_context *m, const unsigned lon=
g cid)</span><br><span> {</span><br><span>     if (m)</span><br><span>@@ -4=
137,6 +4137,8 @@</span><br><span>         cb.client_auth =3D management_cli=
ent_auth;</span><br><span>         cb.client_pending_auth =3D management_cl=
ient_pending_auth;</span><br><span>         cb.get_peer_info =3D management=
_get_peer_info;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cb.push_update_broadcast =3D management_callback_send_push_update_broad=
cast;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cb.pus=
h_update_by_cid =3D management_callback_send_push_update_by_cid;</span><br>=
<span>         management_set_callback(management, &amp;cb);</span><br><spa=
n>     }</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><s=
pan>@@ -4261,3 +4263,47 @@</span><br><span>     multi_top_free(&amp;multi);=
</span><br><span>     close_instance(top);</span><br><span> }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Update the vhash with new IP/IPv6 addresses in the multi_context =
when a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * push-updat=
e message containing ifconfig/ifconfig-ipv6 options is sent</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * from the server. This function s=
hould be called after a push-update</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * and old_ip/old_ipv6 are the previous addresses of the cl=
ient in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ctx-&gt;o=
ptions.ifconfig_local and ctx-&gt;options.ifconfig_ipv6_local.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+update_vhash(struct multi_context *m, struct multi_instance *mi=
, const char *old_ip, const char *old_ipv6)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct in_addr addr;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct in6_addr new_ipv6;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if ((mi-&gt;context.options.ifconfig_local &amp;&amp; (!old_ip || str=
cmp(old_ip, mi-&gt;context.options.ifconfig_local)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; inet_pton(AF_INET, mi-=
&gt;context.options.ifconfig_local, &amp;addr) =3D=3D 1)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        in_addr_t new_ip =3D ntohl(addr.s_addr);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Add new IP */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        multi_learn_in_addr_t(m, mi,=
 new_ip, -1, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* TO DO:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     *  else if (old_ip)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     *  {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     *      // remove old IP</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     *  }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if ((mi-&gt;context.options.ifconfig_ipv6_local &amp;&amp; (!old_ipv6 ||=
 strcmp(old_ipv6, mi-&gt;context.options.ifconfig_ipv6_local)))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; inet_pton(AF=
_INET6, mi-&gt;context.options.ifconfig_ipv6_local, &amp;new_ipv6) =3D=3D 1=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* Add new IPv6 */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_learn_in6_a=
ddr(m, mi, new_ipv6, -1, true);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TO DO:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     *  else if (old_ipv6)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *  {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     *      // remove old IPv6=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *  }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvp=
n/multi.h b/src/openvpn/multi.h</span><br><span>index e87e465..087c0e6 1006=
44</span><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/open=
vpn/multi.h</span><br><span>@@ -686,5 +686,12 @@</span><br><span>  */</span=
><br><span> void multi_assign_peer_id(struct multi_context *m, struct multi=
_instance *mi);</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+struct multi_instance *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+lookup_by_cid(struct multi_context *m, const unsigne=
d long cid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+update_vhash(struct multi_context *m, struct multi_ins=
tance *mi, const char *old_ip, const char *old_ipv6);</span><br><span> </sp=
an><br><span> #endif /* MULTI_H */</span><br><span>diff --git a/src/openvpn=
/options.c b/src/openvpn/options.c</span><br><span>index a268b92..0616a17 1=
00644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src=
/openvpn/options.c</span><br><span>@@ -5488,7 +5488,6 @@</span><br><span>  =
           {</span><br><span>                 continue; /* Ignoring this op=
tion */</span><br><span>             }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            throw_signal_soft(SIGUSR1, &quot;Offending opt=
ion received from server&quot;);</span><br><span>             return false;=
 /* Cause push/pull error and stop push processing */</span><br><span>     =
    }</span><br><span> </span><br><span>diff --git a/src/openvpn/options_ut=
il.c b/src/openvpn/options_util.c</span><br><span>index be1eefc..28f1f9e 10=
0644</span><br><span>--- a/src/openvpn/options_util.c</span><br><span>+++ b=
/src/openvpn/options_util.c</span><br><span>@@ -236,11 +236,11 @@</span><br=
><span>     {</span><br><span>         if (*flags &amp; PUSH_OPT_OPTIONAL)<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            msg(D_PUSH, &quot;Pushed option is not updatable: &#39;%s&=
#39;. Ignoring.&quot;, line);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(D_PUSH, &quot;Pushed dispensable option is not up=
datable: &#39;%s&#39;. Ignoring.&quot;, line);</span><br><span>         }</=
span><br><span>         else</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;Pushed opti=
on is not updatable: &#39;%s&#39;. Restarting.&quot;, line);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;Push=
ed option is not updatable: &#39;%s&#39;.&quot;, line);</span><br><span>   =
          return false;</span><br><span>         }</span><br><span>     }</=
span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><=
br><span>index 4f6adfc..1ea7ed9 100644</span><br><span>--- a/src/openvpn/pu=
sh.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -1073,6 +1=
073,10 @@</span><br><span>                     break;</span><br><span>     =
        }</span><br><span>         }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            throw_signal_soft(SIGUSR1, &quot;Offending option received from=
 server&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span>     }</span><br><span>     else if (ch =3D=3D &#39;\=
0&#39;)</span><br><span>     {</span><br><span>@@ -1100,7 +1104,7 @@</span>=
<br><span>     }</span><br><span>     else if (honor_received_options &amp;=
&amp; buf_string_compare_advance(&amp;buf, push_update_cmd))</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retur=
n process_incoming_push_update(c, permission_mask, option_types_found, &amp=
;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n process_incoming_push_update(c, permission_mask, option_types_found, &amp=
;buf, false);</span><br><span>     }</span><br><span>     else</span><br><s=
pan>     {</span><br><span>diff --git a/src/openvpn/push.h b/src/openvpn/pu=
sh.h</span><br><span>index 22b940f..8ffd0c2 100644</span><br><span>--- a/sr=
c/openvpn/push.h</span><br><span>+++ b/src/openvpn/push.h</span><br><span>@=
@ -41,6 +41,15 @@</span><br><span> #define PUSH_OPT_TO_REMOVE (1 &lt;&lt; 0=
)</span><br><span> #define PUSH_OPT_OPTIONAL  (1 &lt;&lt; 1)</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MA=
NAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Push-upd=
ate message sender modes */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+typedef enum</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    UPT_BROADCAST=
 =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    UPT_BY_C=
ID =3D 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} push_upda=
te_type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int pr=
ocess_incoming_push_request(struct context *c);</span><br><span> </span><br=
><span> /**</span><br><span>@@ -56,6 +65,7 @@</span><br><span>  * @param op=
tion_types_found A pointer to a variable that will be filled with the types=
 of options</span><br><span>  *                           found in the mess=
age.</span><br><span>  * @param buf A buffer containing the received messag=
e.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param msg_sen=
der A boolean indicating if function is called by the message sender (serve=
r).</span><br><span>  *</span><br><span>  * @return</span><br><span>  * - `=
PUSH_MSG_UPDATE`: The message was processed successfully, and the updates w=
ere applied.</span><br><span>@@ -65,7 +75,8 @@</span><br><span>  */</span><=
br><span> </span><br><span> int process_incoming_push_update(struct context=
 *c, unsigned int permission_mask,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                 unsigned int *option_types_fo=
und, struct buffer *buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                 unsigned int *option_types_found, st=
ruct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                               bool msg_sender);</span><br><span> </span><b=
r><span> int process_incoming_push_msg(struct context *c, const struct buff=
er *buffer,</span><br><span>                               bool honor_recei=
ved_options, unsigned int permission_mask,</span><br><span>@@ -127,4 +138,2=
8 @@</span><br><span>  */</span><br><span> void receive_auth_pending(struct=
 context *c, const struct buffer *buffer);</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @brief A function to send a PUSH_UPDATE co=
ntrol message from server to client(s).</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param m the multi_context, contains all the clients connected to thi=
s server.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
target the target to which to send the message. It should be:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * `NULL` if `type =3D=3D UPT_BRO=
ADCAST`,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a `mrout=
e_addr *` if `type =3D=3D UPT_BY_ADDR`,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * a `char *` if `type =3D=3D UPT_BY_CN`,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * an `unsigned long *` if `type =
=3D=3D UPT_BY_CID`.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param msg a string containing the options to send.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param type the way to address the me=
ssage (broadcast, by cid, by cn, by address).</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param push_bundle_size the maximum size of a =
bundle of pushed option. Just use PUSH_BUNDLE_SIZE macro.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return the number of clients to w=
hich the message was sent.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+send_push_update(struct m=
ulti_context *m, const void *target, const char *msg, const push_update_typ=
e type, const int push_bundle_size);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol management_callback_send_push_update_broadcast(void *arg, const char *op=
tions);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool management_callback_send_p=
ush_update_by_cid(void *arg, unsigned long cid, const char *options);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT*/</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* =
ifndef PUSH_H */</span><br><span>diff --git a/src/openvpn/push_util.c b/src=
/openvpn/push_util.c</span><br><span>index 0862a74..bd3992b 100644</span><b=
r><span>--- a/src/openvpn/push_util.c</span><br><span>+++ b/src/openvpn/pus=
h_util.c</span><br><span>@@ -3,10 +3,16 @@</span><br><span> #endif</span><b=
r><span> </span><br><span> #include &quot;push.h&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer.h&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;multi.h&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br>=
<span> int</span><br><span> process_incoming_push_update(struct context *c,=
 unsigned int permission_mask,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                             unsigned int *option_types_found, str=
uct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                          unsigned int *option_types_found, struct buffer *=
buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
              bool msg_sender)</span><br><span> {</span><br><span>     int =
ret =3D PUSH_MSG_ERROR;</span><br><span>     const uint8_t ch =3D buf_read_=
u8(buf);</span><br><span>@@ -27,6 +33,10 @@</span><br><span>               =
      break;</span><br><span>             }</span><br><span>         }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (!msg_se=
nder)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            throw_signal=
_soft(SIGUSR1, &quot;Offending option received from server&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>  =
   }</span><br><span>     else if (ch =3D=3D &#39;\0&#39;)</span><br><span>=
     {</span><br><span>@@ -35,3 +45,260 @@</span><br><span> </span><br><spa=
n>     return ret;</span><br><span> }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return in=
dex of last `,` or `0` if it didn&#39;t find any.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * If there is a comma at index `0` it&#39;s =
an error anyway</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+find_first_comma_of_next_bund=
le(const char *str, int ix)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while =
(ix &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (str[ix] =
=3D=3D &#39;,&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  return ix;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ix--;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Allocate memory and assemble the final message */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static struct buffer</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+forge_msg(const char *src, const char *conti=
nuation, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
src_len =3D strlen(src);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int con_len =3D continuation ? strlen(continuation) : 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D all=
oc_buf_gc(src_len + sizeof(push_update_cmd) + con_len + 2, gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;%s,%s%s&quot;, push=
_update_cmd, src, continuation ? continuation : &quot;&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return buf;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static char *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+gc_strdup(const char *s=
rc, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ret=
 =3D gc_malloc((strlen(src) + 1) * sizeof(char), true, gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    strcpy(ret, src);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* It split the me=
ssagge (if necessay) and fill msgs with the message chunks.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Return `false` on failure an `tr=
ue` on success.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+message_splitter(const char =
*s, struct buffer *msgs, struct gc_arena *gc, const int safe_cap)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!s || !*s)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *str =3D =
gc_strdup(s, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt im =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    while (*str)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* + &#39;,&#39; - &#39;/0&#39; *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strlen=
(str) &gt; safe_cap)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   int ci =3D find_first_comma_of_next_bundle(str, safe_cap);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (!ci)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                /* if no commas were f=
ound go to fail, do not send any message */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            str[ci] =3D &#39;\0&#39;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            /* copy from i to=
 (ci -1) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msgs[im] =3D forge_msg(str, &quot;,push-continuation 2&quot;, gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            i =3D ci + 1=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (im)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                msgs[im] =3D forge_msg(str, &quot;,=
push-continuation 1&quot;, gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             msgs[im] =3D forge_msg(str, NULL, gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            i =3D strlen(str);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        str =3D &amp;str[i];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        im++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* send the message(=
s) prepared to one single client */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+send_single_push_update(struct context *c, struct buffer *msgs, uns=
igned int *option_types_found)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!msgs[0].data || !*(msgs[0].data))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i =
=3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    while (msgs[++i].data &amp;=
&amp; *(msgs[i].data))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!send_control_channel_string(c, BSTR(&amp;msgs[i]), D_PUSH))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* After sending the control message, we update the opti=
ons</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * serve=
r-side in the client&#39;s context so pushed options like</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         * ifconfig/ifconfig-ipv6 can=
 actually work.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * If we don&#39;t do that, packets arriving from the client with the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * new addres=
s will be rejected and packets for the new address</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * will not be routed towards the cl=
ient.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * For=
 the same reason we later update the vhash too in</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         * `send_push_update()` function.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        buf_string_compare_adva=
nce(&amp;msgs[i], push_update_cmd);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (process_incoming_push_update(c, pull_permission=
_mask(c), option_types_found, &amp;msgs[i], true) =3D=3D PUSH_MSG_ERROR)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;Fa=
iled to process push update message sent to client ID: %u&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2.tls_m=
ulti ? c-&gt;c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        c-&gt;options.push_option_types_found |=
=3D *option_types_found;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (!options_postprocess_pull(&amp;c-&gt;options, c-&gt;c2.es)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quo=
t;Failed to post-process push update message sent to client ID: %u&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                c-&gt=
;c2.tls_multi ? c-&gt;c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+send_push_update(struct multi_contex=
t *m, const void *target, const char *msg, const push_update_type type, con=
st int push_bundle_size)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!msg =
|| !*msg || !m</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   || (!target &amp;&amp; type !=3D UPT_BROADCAST))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return -EINVAL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* extra space for possible trailing ifconfig and push-continua=
tion */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const in=
t extra =3D 84 + sizeof(push_update_cmd);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* push_bundle_size is the maximum size of a mess=
age, so if the message</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * we want to send exceeds that size we have to split it into smalle=
r messages */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst int safe_cap =3D push_bundle_size - extra;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    int msgs_num =3D (strlen(msg) / safe_cap) + =
((strlen(msg) % safe_cap) !=3D 0);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer *msgs =3D gc_malloc((msgs_num + 1) * sizeo=
f(struct buffer), true, &amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
nsigned int option_types_found =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   msgs[msgs_num].data =3D NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!message_splitter(msg, msgs, &amp;gc, safe_cap))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (type =3D=3D UPT_BY_CID)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        struct multi_instance *mi =3D lookup_by_cid(m, *((unsi=
gned long *)target));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!mi)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return -ENOENT;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const char *old_ip =3D mi-&gt;context.optio=
ns.ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       const char *old_ipv6 =3D mi-&gt;context.options.ifconfig_ipv6_local;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!mi-&gt=
;halt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &a=
mp;&amp; send_single_push_update(&amp;mi-&gt;context, msgs, &amp;option_typ=
es_found))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (opt=
ion_types_found &amp; OPT_P_UP)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                update_vhash(m, mi, old_ip, old_ipv6);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return 1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int c=
ount =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct hash_iterator hi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct hash_element *he;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 hash_iterator_init(m-&gt;iter, &amp;hi);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    while ((he =3D hash_iterator_next(&amp;hi)))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct multi_instance *curr_mi=
 =3D he-&gt;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (curr_mi-=
&gt;halt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* Type is UPT_BROADCAST so we update e=
very client */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   option_types_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        const char *old_ip =3D curr_mi-&gt;context.options.ifconfi=
g_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st char *old_ipv6 =3D curr_mi-&gt;context.options.ifconfig_ipv6_local;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!send_single=
_push_update(&amp;curr_mi-&gt;context, msgs, &amp;option_types_found))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;ER=
ROR: Peer ID: %u has not been updated&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                curr_mi-&gt;context.c2.tls_multi ?=
 curr_mi-&gt;context.c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (option_types_found &amp; OPT_=
P_UP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            update_vhash=
(m, curr_mi, old_ip, old_ipv6);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        count++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    hash_iterator_free(&amp;hi);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return count;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define RETURN_UPDATE_STATUS(n_sent)                      =
            \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do=
                                                                \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {                        =
                                         \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if ((n_sent) &gt; 0)                        =
                     \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {                                                             \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CL=
IENT, &quot;SUCCESS: %d client(s) updated&quot;, (n_sent)); \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            return true;         =
                                     \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }                                               =
              \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    else                                                          \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {                  =
                                           \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;ERROR: no client u=
pdated&quot;);                \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return false;                                      =
       \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }  =
                                                           \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    } while (0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_callb=
ack_send_push_update_broadcast(void *arg, const char *options)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int n_sent =3D send_push_update(arg, NULL, opt=
ions, UPT_BROADCAST, PUSH_BUNDLE_SIZE);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    RETURN_UPDATE_STATUS(n_sent);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+management_callback_send_push_update_=
by_cid(void *arg, unsigned long cid, const char *options)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int n_sent =3D send_push_update(arg, &amp;cid, opti=
ons, UPT_BY_CID, PUSH_BUNDLE_SIZE);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 RETURN_UPDATE_STATUS(n_sent);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif =
/* ifdef ENABLE_MANAGEMENT */</span><br><span>diff --git a/tests/unit_tests=
/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span=
>index 7a7fec7..ec8cc69 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/Makefile.am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</=
span><br><span>@@ -337,7 +337,8 @@</span><br><span> 	$(top_srcdir)/src/open=
vpn/platform.c \</span><br><span> 	$(top_srcdir)/src/openvpn/push_util.c \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/options_util.c \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/otime.c</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/op=
envpn/otime.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(t=
op_srcdir)/src/openvpn/list.c</span><br><span> </span><br><span> socket_tes=
tdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/include -I$(top_src=
dir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span>diff --git a/=
tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/=
test_push_update_msg.c</span><br><span>index 0f4ad41..87329b1 100644</span>=
<br><span>--- a/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>=
@@ -8,9 +8,16 @@</span><br><span> #include &lt;cmocka.h&gt;</span><br><span=
> #include &quot;push.h&quot;</span><br><span> #include &quot;options_util.=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;multi.h&quot;</span><br><span> </span><br><span> /* mocks */</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+throw_signal_soft(const int =
signum, const char *signal_text)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
sg(M_WARN, &quot;Offending option received from server&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> unsigned int</span><br><span> pu=
ll_permission_mask(const struct context *c)</span><br><span> {</span><br><s=
pan>@@ -21,6 +28,18 @@</span><br><span>     return flags;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+update_vhash(st=
ruct multi_context *m, struct multi_instance *mi, const char *old_ip, const=
 char *old_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+option=
s_postprocess_pull(struct options *options, struct env_set *es)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> bool</span><br><span> apply_push_options(struct cont=
ext *c, struct options *options, struct buffer *buf,</span><br><span>      =
              unsigned int permission_mask, unsigned int *option_types_foun=
d,</span><br><span>@@ -48,7 +67,6 @@</span><br><span>                 {</sp=
an><br><span>                     continue; /* Ignoring this option */</spa=
n><br><span>                 }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                msg(M_WARN, &quot;Offending option received from s=
erver&quot;);</span><br><span>                 return false; /* Cause push/=
pull error and stop push processing */</span><br><span>             }</span=
><br><span>         }</span><br><span>@@ -77,7 +95,7 @@</span><br><span>   =
  }</span><br><span>     else if (honor_received_options &amp;&amp; buf_str=
ing_compare_advance(&amp;buf, push_update_cmd))</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return process_inc=
oming_push_update(c, permission_mask, option_types_found, &amp;buf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return process_inc=
oming_push_update(c, permission_mask, option_types_found, &amp;buf, false);=
</span><br><span>     }</span><br><span>     else</span><br><span>     {</s=
pan><br><span>@@ -85,6 +103,49 @@</span><br><span>     }</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
onst char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_comm=
on_name(const struct tls_multi *multi, const bool null)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_MANAGEM=
ENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string(str=
uct context *c, const char *str, int msglevel)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if=
ndef ENABLE_MANAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+char **res;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
t i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+send_control_channel_string(struct context *c, co=
nst char *str, int msglevel)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (r=
es &amp;&amp; res[i] &amp;&amp; strcmp(res[i], str))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        printf(&quot;\n\nexpected: %s\n\n  actual: %s\n=
\n&quot;, res[i], str);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i++;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+struct multi_instance *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+lookup_by_cid(struct multi_context *m, const unsigned l=
ong cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return *(m-&gt;instances)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+mroute_extract_openvpn_sockaddr(struct mroute_addr *addr,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
const struct openvpn_sockaddr *osaddr,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                bool use_port)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif /* ifndef ENABLE_MANAGEMENT */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> /* tests */</span><br><span> </s=
pan><br><span> static void</span><br><span>@@ -120,7 +181,6 @@</span><br><s=
pan>     free_buf(&amp;buf);</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</=
span><br><span> test_incoming_push_message_error2(void **state)</span><br><=
span> {</span><br><span>@@ -219,6 +279,207 @@</span><br><span>     free_buf=
(&amp;buf);</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+char *r0[] =3D {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,redirect-gateway local=
,route 192.168.1.0 255.255.255.0&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+char *r1[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalal=
alalalalalalalalalaf,push-continuation 2&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, akakakakakakakakakakakaf=
, dhcp-option DNS 8.8.8.8,redirect-gateway local,push-continuation 2&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDA=
TE,route 192.168.1.0 255.255.255.0,push-continuation 1&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+char *r3[] =3D {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &quot;PUSH_UPDATE,,,&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+char *r4[] =3D {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &quot;PUSH_UPDATE,-dhcp-option, blablalalalalalalalalalal=
alalf, lalalalalalalalalalalalalalaf,push-continuation 2&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, akakakak=
akakakakakakakaf,dhcp-option DNS 8.8.8.8, redirect-gateway local,push-conti=
nuation 2&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &quot;PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+char *r5[] =3D {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,,-dhcp-option,=
 blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-continu=
ation 2&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
quot;PUSH_UPDATE, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redirec=
t-gateway local,push-continuation 2&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, route 192.168.1.0 255.255.255=
.0,push-continuation 1&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *r6=
[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;P=
USH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalal=
alalalalaf,push-continuation 2&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &quot;PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-opt=
ion DNS 8.8.8.8, redirect-gateway 10.10.10.10,,push-continuation 2&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE=
, route 192.168.1.0 255.255.255.0,,push-continuation 1&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+char *r7[] =3D {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &quot;PUSH_UPDATE,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,=
,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,push-continuation =
2&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;P=
USH_UPDATE,,,,,,,,,,,,,,,,,,,push-continuation 1&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+char *r8[] =3D {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalal=
alalf, lalalalalalalalalalalalalalaf,push-continuation 2&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, akakakak=
akakakakakakakaf, dhcp-option DNS 8.8.8.8,redirect-gateway\n local,push-con=
tinuation 2&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;PUSH_UPDATE,route 192.168.1.0 255.255.255.0\n\n\n,push-continuatio=
n 1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+char *r9[] =3D {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,,&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
const char *msg0 =3D &quot;redirect-gateway local,route 192.168.1.0 255.255=
.255.0&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const =
char *msg1 =3D &quot;-dhcp-option,blablalalalalalalalalalalalalf, lalalalal=
alalalalalalalalalaf,&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                   &quot; akakakakakakakakakakakaf, dhcp-option DNS=
 8.8.8.8,redirect-gateway local,route 192.168.1.0 255.255.255.0&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *msg2 =3D &qu=
ot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const cha=
r *msg3 =3D &quot;,,&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+const char *msg4 =3D &quot;-dhcp-option, blablalalalalalalalalalala=
lalf, lalalalalalalalalalalalalalaf,&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                   &quot; akakakakakakakakakakakaf,d=
hcp-option DNS 8.8.8.8, redirect-gateway local, route 192.168.1.0 255.255.2=
55.0,&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const c=
har *msg5 =3D &quot;,-dhcp-option, blablalalalalalalalalalalalalf, lalalala=
lalalalalalalalalalaf,&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                   &quot; akakakakakakakakakakakaf,dhcp-option DNS=
 8.8.8.8, redirect-gateway local, route 192.168.1.0 255.255.255.0&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *msg6 =3D &=
quot;-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalalal=
alaf, akakakakakakakakakakakaf,&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                   &quot; dhcp-option DNS 8.8.8.8, redire=
ct-gateway 10.10.10.10,, route 192.168.1.0 255.255.255.0,&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+const char *msg7 =3D &quot;,,,=
,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,=
,,,,,,,,,,,,,,,,,,,,,,,,,,,,&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+const char *msg8 =3D &quot;-dhcp-option,blablalalalalalalal=
alalalalalf, lalalalalalalalalalalalalalaf, akakakakakakakakakakakaf,&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
&quot; dhcp-option DNS 8.8.8.8,redirect-gateway\n local,route 192.168.1.0 2=
55.255.255.0\n\n\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+const char *msg9 =3D &quot;,&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+const char *msg10 =3D &quot;abandon ability able about above absent abso=
rb abstract absurd abuse access accident account accuse achieve&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot=
;acid acoustic acquire across act action actor actress actual adapt add add=
ict address adjust&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    &quot;baby bachelor bacon badge bag balance balcon=
y ball bamboo banana banner bar barely bargain barrel base basic&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quo=
t;basket battle beach bean beauty because become beef before begin behave b=
ehind&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            &quot;cabbage cabin cable cactus cage cake call calm camera cam=
p can canal cancel candy cannon canoe canvas canyon&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    &quot;capable cap=
ital captain car carbon card cargo carpet carry cart case&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;daisy=
 damage damp dance danger daring dash daughter dawn day deal debate debris =
decade december decide decline&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    &quot;decorate decrease deer defense d=
efine defy degree delay deliver demand demise denial&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define PUSH_BUNDLE_SIZE_TEST 184</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_send_push_msg0(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 res =3D r0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct multi_context *m =3D *state;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const unsigned long cid =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(send_push_update(m, &amp;c=
id, msg0, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+test_send_push_msg1(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res=
 =3D r1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
multi_context *m =3D *state;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const unsigned long cid =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(send_push_update(m, &amp;cid, =
msg1, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_send_push_msg2=
(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    res =3D NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D =
*state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const un=
signed long cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(send_push_update(m, &amp;cid, msg2, UPT_BY_CID, PUS=
H_BUNDLE_SIZE_TEST), -EINVAL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_send_push_msg3(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    res =3D r3;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct multi_context *m =3D *state;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned long cid =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(send_push_update(m, &amp;cid, msg3, UPT_BY_CID, PUSH_BUNDLE_SIZE_TE=
ST), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_send_push_msg4(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    i =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    res =3D r4;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct multi_context *m =3D *state;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const unsigned long cid =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(send_push_upda=
te(m, &amp;cid, msg4, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tes=
t_send_push_msg5(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res =3D r=
5;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_=
context *m =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const unsigned long cid =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(send_push_update(m, &amp;cid, msg5, =
UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_send_push_msg6(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    res =3D r6;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D *state;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned l=
ong cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(send_push_update(m, &amp;cid, msg6, UPT_BY_CID, PUSH_BUNDLE=
_SIZE_TEST), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_send_push_msg7(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    i =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    res =3D r7;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct multi_context *m =3D *state;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const unsigned long cid =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(send_=
push_update(m, &amp;cid, msg7, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_send_push_msg8(void **state)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
res =3D r8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct multi_context *m =3D *state;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const unsigned long cid =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(send_push_update(m, &amp;ci=
d, msg8, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_send_push_m=
sg9(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    res =3D r9;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D=
 *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const u=
nsigned long cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(send_push_update(m, &amp;cid, msg9, UPT_BY_CID, PU=
SH_BUNDLE_SIZE_TEST), 1);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_send_push_msg10(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    res =3D NULL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct multi_context *m =3D *state;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned long cid =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(send_push_update(m, &amp;cid, msg10, UPT_BY_CID, PUSH_BUNDLE_SIZE_T=
EST), -EINVAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#undef PUSH_BUNDLE_SIZE_TEST</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+setup2(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct multi_context *m =3D calloc(1, sizeof(struct multi_context));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;instances =3D =
calloc(1, sizeof(struct multi_instance *));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct multi_instance *mi =3D calloc(1, sizeof(=
struct multi_instance));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    *(m-&gt;instances) =3D mi;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    *state =3D m;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+teardown2(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct multi_context *m =3D *state;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    free(*(m-&gt;instances));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(m-&gt;instanc=
es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(m);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static int<=
/span><br><span> setup(void **state)</span><br><span> {</span><br><span>@@ =
-249,7 +510,20 @@</span><br><span>         cmocka_unit_test_setup_teardown(=
test_incoming_push_message_1, setup, teardown),</span><br><span>         cm=
ocka_unit_test_setup_teardown(test_incoming_push_message_bad_format, setup,=
 teardown),</span><br><span>         cmocka_unit_test_setup_teardown(test_i=
ncoming_push_message_mix, setup, teardown),</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        cmocka_unit_test_setup_teardown(test_incoming=
_push_message_mix2, setup, teardown)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_incoming_push=
_message_mix2, setup, teardown),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_send_push_ms=
g0, setup2, teardown2),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test_setup_teardown(test_send_push_msg1, setup2, te=
ardown2),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test_setup_teardown(test_send_push_msg2, setup2, teardown2),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
_setup_teardown(test_send_push_msg3, setup2, teardown2),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardow=
n(test_send_push_msg4, setup2, teardown2),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_send_pu=
sh_msg5, setup2, teardown2),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test_setup_teardown(test_send_push_msg6, setup=
2, teardown2),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   cmocka_unit_test_setup_teardown(test_send_push_msg7, setup2, teardown2),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit=
_test_setup_teardown(test_send_push_msg8, setup2, teardown2),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_te=
ardown(test_send_push_msg9, setup2, teardown2),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_se=
nd_push_msg10, setup2, teardown2)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span>     };</span><br><span> </span><br><s=
pan>     return cmocka_run_group_tests(tests, NULL, NULL);</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/869?usp=3Demail">change 869</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/869?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie82bcc7a8e583de9156b185d71d=
1a323ed8df3fc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 869 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 26 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--lWZV37sOPqk=--

