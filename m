From: "mrbff (Code Review)" <gerrit@...515...>
Date: Thu, 16 Jan 2025 12:11:37 +0000
References: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <bfdd12a2df62908e7beca2893d3803f8c94a29d1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OF1Ubm2hy2Y="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OF1Ubm2hy2Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail

to review the following change.


Change subject: PUSH_UPDATE message sender: enabling the server to send PUS=
H_UPDATE control messages
......................................................................

PUSH_UPDATE message sender: enabling the server to send PUSH_UPDATE control=
 messages

Using the management interface you can now target one or more clients (via =
broadcast,
via cid, via common name, via address) and send a PUSH_UPDATE control messa=
ge
to update some options.

Change-Id: Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc
Signed-off-by: Marco Baffo <marco@...2726...>
---
M CMakeLists.txt
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/push.h
M src/openvpn/push_util.c
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_push_update_msg.c
9 files changed, 729 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/869/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index dec3db4..a44134a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -818,6 +818,7 @@
 	    src/openvpn/push_util.c
 	    src/openvpn/options_util.c
 	    src/openvpn/otime.c
+        src/openvpn/list.c
         )

     if (TARGET test_argv)
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0c77f85..0bbf93c 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -24,7 +24,6 @@
 #ifdef HAVE_CONFIG_H
 #include "config.h"
 #endif
-
 #include "syshead.h"

 #ifdef ENABLE_MANAGEMENT
@@ -42,6 +41,7 @@
 #include "manage.h"
 #include "openvpn.h"
 #include "dco.h"
+#include "push.h"

 #include "memdbg.h"

@@ -124,6 +124,11 @@
     msg(M_CLIENT, "username type u        : Enter username u for a queried=
 OpenVPN username.");
     msg(M_CLIENT, "verb [n]               : Set log verbosity level to n, =
or show if n is absent.");
     msg(M_CLIENT, "version [n]            : Set client's version to n or s=
how current version of daemon.");
+    msg(M_CLIENT, "push-update-broad options : Broadcast a message to upda=
te the specified options.");
+    msg(M_CLIENT, "                            Ex. push-update-broad \"rou=
te something, -dns\"");
+    msg(M_CLIENT, "push-update-cid CID options : Send an update message to=
 the client identified by CID.");
+    msg(M_CLIENT, "push-update-cn CN options : Send an update message to t=
he client(s) with the specified Common Name.");
+    msg(M_CLIENT, "push-update-addr ip port options : Send an update messa=
ge to the client(s) connecting from the provided address.");
     msg(M_CLIENT, "END");
 }

@@ -1327,6 +1332,154 @@
 }

 static void
+man_push_update(struct management *man, const char **p, const push_update_=
type type)
+{
+    if (type =3D=3D UPT_BROADCAST)
+    {
+        if (!man->persist.callback.push_update_broadcast)
+        {
+            man_command_unsupported("push-update-broad");
+            return;
+        }
+
+        const bool status =3D (*man->persist.callback.push_update_broadcas=
t)(man->persist.callback.arg, p[1]);
+
+        if (status)
+        {
+            msg(M_CLIENT, "SUCCESS: push-update-broad command succeeded");
+        }
+        else
+        {
+            msg(M_CLIENT, "ERROR: push-update-broad command failed");
+        }
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
+        const bool status =3D (*man->persist.callback.push_update_by_cid)(=
man->persist.callback.arg, cid, p[2]);
+
+        if (status)
+        {
+            msg(M_CLIENT, "SUCCESS: push-update-cid command succeeded");
+        }
+        else
+        {
+            msg(M_CLIENT, "ERROR: push-update-cid command failed");
+        }
+    }
+    else if (type =3D=3D UPT_BY_CN)
+    {
+        if (!man->persist.callback.push_update_by_cn)
+        {
+            man_command_unsupported("push-update-cn");
+            return;
+        }
+
+        const bool status =3D (*man->persist.callback.push_update_by_cn)(m=
an->persist.callback.arg, p[1], p[2]);
+
+        if (status)
+        {
+            msg(M_CLIENT, "SUCCESS: push-update-cn command succeeded");
+        }
+        else
+        {
+            msg(M_CLIENT, "ERROR: push-update-cn command failed");
+        }
+    }
+    else if (type =3D=3D UPT_BY_ADDR)
+    {
+        if (!man->persist.callback.push_update_by_addr)
+        {
+            man_command_unsupported("push-update-addr");
+            return;
+        }
+
+        const char *ip_str =3D p[1];
+        const char *port_str =3D p[2];
+        const char *options =3D p[3];
+
+        if (!strlen(ip_str) || !strlen(port_str))
+        {
+            msg(M_CLIENT, "ERROR: push-update-addr parse");
+            return;
+        }
+
+        struct addrinfo *res =3D NULL;
+        int port =3D atoi(port_str);
+
+        if (port < 1 || port > 65535)
+        {
+            msg(M_CLIENT, "ERROR: port number is out of range: %s", port_s=
tr);
+            return;
+        }
+
+        int status =3D openvpn_getaddrinfo(GETADDR_MSG_VIRT_OUT, ip_str, p=
ort_str, 0, NULL, AF_UNSPEC, &res);
+
+        if (status !=3D 0 || !res)
+        {
+            msg(M_CLIENT, "ERROR: error resolving address: %s (%s)", ip_st=
r, gai_strerror(status));
+            return;
+        }
+
+        struct addrinfo *rp;
+        bool found_client =3D false;
+
+        /* Iterate through resolved addresses */
+        for (rp =3D res; rp !=3D NULL; rp =3D rp->ai_next)
+        {
+            struct openvpn_sockaddr saddr;
+            struct mroute_addr maddr;
+
+            CLEAR(saddr);
+            switch (rp->ai_family)
+            {
+                case AF_INET:
+                    saddr.addr.in4 =3D *((struct sockaddr_in *)rp->ai_addr=
);
+                    break;
+
+                case AF_INET6:
+                    saddr.addr.in6 =3D *((struct sockaddr_in6 *)rp->ai_add=
r);
+                    break;
+
+                default:
+                    continue;
+            }
+
+            if (!mroute_extract_openvpn_sockaddr(&maddr, &saddr, true))
+            {
+                continue;
+            }
+
+            if ((*man->persist.callback.push_update_by_addr)(man->persist.=
callback.arg, &maddr, options))
+            {
+                msg(M_CLIENT, "SUCCESS: push-update sent to %s:%d", ip_str=
, port);
+                found_client =3D true;
+                break;
+            }
+        }
+
+        if (!found_client)
+        {
+            msg(M_CLIENT, "ERROR: no client found at address %s:%d", ip_st=
r, port);
+        }
+        freeaddrinfo(res);
+    }
+}
+
+static void
 man_dispatch_command(struct management *man, struct status_output *so, con=
st char **p, const int nparms)
 {
     struct gc_arena gc =3D gc_new();
@@ -1648,6 +1801,34 @@
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
+    else if (streq(p[0], "push-update-cn"))
+    {
+        if (man_need(man, p, 2, 0))
+        {
+            man_push_update(man, p, UPT_BY_CN);
+        }
+    }
+    else if (streq(p[0], "push-update-addr"))
+    {
+        if (man_need(man, p, 3, 0))
+        {
+            man_push_update(man, p, UPT_BY_ADDR);
+        }
+    }
 #if 1
     else if (streq(p[0], "test"))
     {
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index f501543..8f463c6 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -44,7 +44,6 @@
 #define MF_EXTERNAL_KEY_PSSPAD      (1<<16)
 #define MF_EXTERNAL_KEY_DIGEST      (1<<17)

-
 #ifdef ENABLE_MANAGEMENT

 #include "misc.h"
@@ -205,6 +204,10 @@
 #endif
     unsigned int (*remote_entry_count)(void *arg);
     bool (*remote_entry_get)(void *arg, unsigned int index, char **remote);
+    bool (*push_update_broadcast)(void *arg, const char *options);
+    bool (*push_update_by_cid)(void *arg, unsigned long cid, const char *o=
ptions);
+    bool (*push_update_by_cn)(void *arg, const char *cn, const char *optio=
ns);
+    bool (*push_update_by_addr)(void *arg, const struct mroute_addr *maddr=
, const char *options);
 };

 /*
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 5b693f9..6a9ce83 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3981,7 +3981,7 @@
     }
 }

-static struct multi_instance *
+struct multi_instance *
 lookup_by_cid(struct multi_context *m, const unsigned long cid)
 {
     if (m)
@@ -4129,6 +4129,10 @@
         cb.client_auth =3D management_client_auth;
         cb.client_pending_auth =3D management_client_pending_auth;
         cb.get_peer_info =3D management_get_peer_info;
+        cb.push_update_broadcast =3D management_callback_send_push_update_=
broadcast;
+        cb.push_update_by_cid =3D management_callback_send_push_update_by_=
cid;
+        cb.push_update_by_cn =3D management_callback_send_push_update_by_c=
n;
+        cb.push_update_by_addr =3D management_callback_send_push_update_by=
_addr;
         management_set_callback(management, &cb);
     }
 #endif /* ifdef ENABLE_MANAGEMENT */
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 9b6834a..4bb6e21 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -714,5 +714,10 @@
  */
 void multi_assign_peer_id(struct multi_context *m, struct multi_instance *=
mi);

+#ifdef ENABLE_MANAGEMENT
+struct multi_instance *
+lookup_by_cid(struct multi_context *m, const unsigned long cid);
+
+#endif

 #endif /* MULTI_H */
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index b930c6c..112a2a5 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -42,6 +42,16 @@
 #define PUSH_OPT_TO_REMOVE (1<<0)
 #define PUSH_OPT_OPTIONAL (1<<1)

+/* Push-update message sender modes */
+typedef enum {
+    UPT_BROADCAST =3D 0,
+    UPT_BY_ADDR =3D 1,
+    UPT_BY_CN =3D 2,
+#ifdef ENABLE_MANAGEMENT
+    UPT_BY_CID =3D 3
+#endif
+} push_update_type;
+
 int process_incoming_push_request(struct context *c);

 /**
@@ -135,4 +145,33 @@
 void
 receive_auth_pending(struct context *c, const struct buffer *buffer);

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
+#ifdef ENABLE_MANAGEMENT
+
+bool management_callback_send_push_update_broadcast(void *arg, const char =
*options);
+
+bool management_callback_send_push_update_by_cid(void *arg, unsigned long =
cid, const char *options);
+
+bool management_callback_send_push_update_by_cn(void *arg, const char *cn,=
 const char *options);
+
+bool management_callback_send_push_update_by_addr(void *arg, const struct =
mroute_addr *maddr, const char *options);
+
+#endif /* ifdef ENABLE_MANAGEMENT*/
+
 #endif /* ifndef PUSH_H */
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index b4d1e8b..69d7a9c 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -3,6 +3,8 @@
 #endif

 #include "push.h"
+#include "multi.h"
+#include "ssl_verify.h"

 int
 process_incoming_push_update(struct context *c,
@@ -42,3 +44,247 @@

     return ret;
 }
+
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
+message_splitter(char *str, char **mesgs, struct gc_arena *gc, const int s=
afe_cap)
+{
+    if (!str || !*str)
+    {
+        return false;
+    }
+
+    int i =3D 0;
+    int im =3D 0;
+
+    while (*str)
+    {
+        /* sizeof(push_update_cmd) + ',' - '/0' */
+        if (strlen(str) + sizeof(push_update_cmd) > safe_cap)
+        {
+            int ci =3D find_first_comma_of_next_bundle(str, safe_cap - siz=
eof(push_update_cmd));
+            if (!ci)
+            {
+                /* if no commas were found go to fail, do not send any mes=
sage */
+                return false;
+            }
+            str[ci] =3D '\0';
+            /* copy from i to (ci -1) */
+            mesgs[im] =3D gc_strdup(str, gc);
+            i =3D ci + 1;
+        }
+        else
+        {
+            mesgs[im] =3D gc_strdup(str, gc);
+            i =3D strlen(str);
+        }
+        str =3D &str[i];
+        im++;
+    }
+    return true;
+}
+
+/* It actually send the already divided messagge to one single client */
+static bool
+send_single_push_update(struct context *c, char **msgs, struct buffer *buf=
, struct gc_arena *gc, const int push_bundle_size)
+{
+    if (!msgs[0] || !*msgs[0])
+    {
+        return false;
+    }
+    else if (!msgs[1] || !*msgs[1])
+    {
+        buf_printf(buf, "%s%c%s", push_update_cmd, ',', msgs[0]);
+        if (!send_control_channel_string(c, BSTR(buf), D_PUSH))
+        {
+            return false;
+        }
+    }
+    else
+    {
+        int i =3D 0;
+        while (msgs[i] && *msgs[i])
+        {
+            if (msgs[i+1])
+            {
+                buf_printf(buf, "%s%c%s%s", push_update_cmd, ',', msgs[i],=
 ",push-continuation 2");
+            }
+            else
+            {
+                buf_printf(buf, "%s%c%s%s", push_update_cmd, ',', msgs[i],=
 ",push-continuation 1");
+            }
+
+            if (!send_control_channel_string(c, BSTR(buf), D_PUSH))
+            {
+                return false;
+            }
+            *buf =3D alloc_buf_gc(push_bundle_size, gc);
+            i++;
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
+    struct buffer buf =3D alloc_buf_gc(push_bundle_size, &gc);
+    /* extra space for possible trailing ifconfig and push-continuation */
+    const int extra =3D 84;
+    /* push_bundle_size is the maximum size of a message, so if the message
+     * we want to send exceeds that size we have to split it into smaller =
messages */
+    const int safe_cap =3D BCAP(&buf) - extra;
+    int mexnum =3D (strlen(msg) / (safe_cap  - sizeof(push_update_cmd))) +=
 1;
+    char **msgs =3D gc_malloc(sizeof(char *) * (mexnum + 1), true, &gc);
+
+    msgs[mexnum] =3D NULL;
+    if (!message_splitter(gc_strdup(msg, &gc), msgs, &gc, safe_cap))
+    {
+        gc_free(&gc);
+        return -EINVAL;
+    }
+
+#ifdef ENABLE_MANAGEMENT
+    if (type =3D=3D UPT_BY_CID)
+    {
+        struct multi_instance *mi =3D lookup_by_cid(m, *((unsigned long *)=
target));
+
+        if (!mi)
+        {
+            return -ENOENT;
+        }
+        if (!mi->halt
+            && send_single_push_update(&mi->context, msgs, &buf, &gc, push=
_bundle_size))
+        {
+            gc_free(&gc);
+            return 1;
+        }
+    }
+#endif
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
+        if (type =3D=3D UPT_BY_ADDR && !mroute_addr_equal(target, &curr_mi=
->real))
+        {
+            continue;
+        }
+        else if (type =3D=3D UPT_BY_CN)
+        {
+            const char *curr_cn =3D tls_common_name(curr_mi->context.c2.tl=
s_multi, false);
+            if (strcmp(curr_cn, target))
+            {
+                continue;
+            }
+        }
+        /* Either we found a matching client or type is UPT_BROADCAST so w=
e update every client */
+        if (!send_single_push_update(&curr_mi->context, msgs, &buf, &gc, p=
ush_bundle_size))
+        {
+            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated",
+                curr_mi->context.c2.tls_multi ? curr_mi->context.c2.tls_mu=
lti->peer_id : UINT32_MAX);
+            continue;
+        }
+        count++;
+    }
+
+    hash_iterator_free(&hi);
+    gc_free(&gc);
+    return count;
+}
+
+#ifdef ENABLE_MANAGEMENT
+#define RETURN_UPDATE_STATUS(n_sent) \
+    do { \
+        if ((n_sent) > 0) { \
+            msg(M_CLIENT, "SUCCESS: %d client(s) updated", (n_sent)); \
+            return true; \
+        } else { \
+            msg(M_CLIENT, "ERROR: no client updated"); \
+            return false; \
+        } \
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
+    int ret =3D send_push_update(arg, &cid, options, UPT_BY_CID, PUSH_BUND=
LE_SIZE);
+
+    if (ret =3D=3D -ENOENT)
+    {
+        msg(M_CLIENT, "ERROR: no client found with CID: %lu", cid);
+    }
+
+    return (ret > 0);
+}
+
+bool
+management_callback_send_push_update_by_cn(void *arg, const char *cn, cons=
t char *options)
+{
+    int n_sent =3D send_push_update(arg, cn, options, UPT_BY_CN, PUSH_BUND=
LE_SIZE);
+
+    RETURN_UPDATE_STATUS(n_sent);
+}
+
+bool
+management_callback_send_push_update_by_addr(void *arg, const struct mrout=
e_addr *maddr, const char *options)
+{
+    int n_sent =3D send_push_update(arg, maddr, options, UPT_BY_ADDR, PUSH=
_BUNDLE_SIZE);
+
+    RETURN_UPDATE_STATUS(n_sent);
+}
+#endif /* ifdef ENABLE_MANAGEMENT */
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 651c5f6..529b77b 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -325,4 +325,5 @@
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/push_util.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
-	$(top_srcdir)/src/openvpn/otime.c
\ No newline at end of file
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/list.c
\ No newline at end of file
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
index d0876bc..1a9e093 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -8,6 +8,7 @@
 #include <cmocka.h>
 #include "push.h"
 #include "options_util.h"
+#include "multi.h"
=20
 /* mocks */

@@ -94,6 +95,48 @@
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
@@ -124,7 +167,6 @@
     free_buf(&buf);
 }

-
 static void
 test_incoming_push_message_error2(void **state)
 {
@@ -209,6 +251,194 @@
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
alalalalalalalalalalaf, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,r=
edirect-gateway local,route 192.168.1.0 255.255.255.0";
+const char *msg2 =3D "";
+const char *msg3 =3D ",,";
+const char *msg4 =3D "-dhcp-option, blablalalalalalalalalalalalalf, lalala=
lalalalalalalalalalalaf, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, =
redirect-gateway local, route 192.168.1.0 255.255.255.0,";
+const char *msg5 =3D ",-dhcp-option, blablalalalalalalalalalalalalf, lalal=
alalalalalalalalalalalaf, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8,=
 redirect-gateway local, route 192.168.1.0 255.255.255.0";
+const char *msg6 =3D "-dhcp-option,blablalalalalalalalalalalalalf, lalalal=
alalalalalalalalalalaf, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8, =
redirect-gateway 10.10.10.10,, route 192.168.1.0 255.255.255.0,";
+const char *msg7 =3D ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,=
,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,";
+const char *msg8 =3D "-dhcp-option,blablalalalalalalalalalalalalf, lalalal=
alalalalalalalalalalaf, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,r=
edirect-gateway\n local,route 192.168.1.0 255.255.255.0\n\n\n";
+const char *msg9 =3D ",";
+const char *msg10 =3D "Voil=C3=A0! In view, a humble vaudevillian veteran =
cast vicariously as both victim and villain by the vicissitudes of Fate. Th=
is visage no mere veneer of vanity is a vestige of the vox populi now vacan=
t vanished. However this valorous visitation of a by-gone vexation stands v=
ivified and has vowed to vanquish these venal and virulent vermin vanguardi=
ng vice and vouchsafing the violently vicious and voracious violation of vo=
lition. The only verdict is vengeance; a vendetta held as a votive not in v=
ain for the value and veracity of such shall one day vindicate the vigilant=
 and the virtuous. Verily this vichyssoise of verbiage veers most verbose s=
o let me simply add that it is my very good honor to meet you and you may c=
all me V.";
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
@@ -238,7 +468,20 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--OF1Ubm2hy2Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">PUSH_UPDATE message sender: enabling the server to send PUSH_=
UPDATE control messages<br><br>Using the management interface you can now t=
arget one or more clients (via broadcast,<br>via cid, via common name, via =
address) and send a PUSH_UPDATE control message<br>to update some options.<=
br><br>Change-Id: Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc<br>Signed-off-b=
y: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M CMakeLists.txt<br>M src=
/openvpn/manage.c<br>M src/openvpn/manage.h<br>M src/openvpn/multi.c<br>M s=
rc/openvpn/multi.h<br>M src/openvpn/push.h<br>M src/openvpn/push_util.c<br>=
M tests/unit_tests/openvpn/Makefile.am<br>M tests/unit_tests/openvpn/test_p=
ush_update_msg.c<br>9 files changed, 729 insertions(+), 6 deletions(-)<br><=
br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/869/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index=
 dec3db4..a44134a 100644</span><br><span>--- a/CMakeLists.txt</span><br><sp=
an>+++ b/CMakeLists.txt</span><br><span>@@ -818,6 +818,7 @@</span><br><span=
> 	    src/openvpn/push_util.c</span><br><span> 	    src/openvpn/options_ut=
il.c</span><br><span> 	    src/openvpn/otime.c</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        src/openvpn/list.c</span><br><span>     =
    )</span><br><span> </span><br><span>     if (TARGET test_argv)</span><b=
r><span>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br>=
<span>index 0c77f85..0bbf93c 100644</span><br><span>--- a/src/openvpn/manag=
e.c</span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -24,7 +24=
,6 @@</span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot=
;config.h&quot;</span><br><span> #endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> #include &quot;syshead.h&quot;</span><b=
r><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>@@ -42,=
6 +41,7 @@</span><br><span> #include &quot;manage.h&quot;</span><br><span> =
#include &quot;openvpn.h&quot;</span><br><span> #include &quot;dco.h&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;push.=
h&quot;</span><br><span> </span><br><span> #include &quot;memdbg.h&quot;</s=
pan><br><span> </span><br><span>@@ -124,6 +124,11 @@</span><br><span>     m=
sg(M_CLIENT, &quot;username type u        : Enter username u for a queried =
OpenVPN username.&quot;);</span><br><span>     msg(M_CLIENT, &quot;verb [n]=
               : Set log verbosity level to n, or show if n is absent.&quot=
;);</span><br><span>     msg(M_CLIENT, &quot;version [n]            : Set c=
lient&#39;s version to n or show current version of daemon.&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_CLIENT, &quot;pus=
h-update-broad options : Broadcast a message to update the specified option=
s.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M=
_CLIENT, &quot;                            Ex. push-update-broad \&quot;rou=
te something, -dns\&quot;&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    msg(M_CLIENT, &quot;push-update-cid CID options : Send an=
 update message to the client identified by CID.&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    msg(M_CLIENT, &quot;push-update-cn=
 CN options : Send an update message to the client(s) with the specified Co=
mmon Name.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   msg(M_CLIENT, &quot;push-update-addr ip port options : Send an update me=
ssage to the client(s) connecting from the provided address.&quot;);</span>=
<br><span>     msg(M_CLIENT, &quot;END&quot;);</span><br><span> }</span><br=
><span> </span><br><span>@@ -1327,6 +1332,154 @@</span><br><span> }</span><=
br><span> </span><br><span> static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+man_push_update(struct management *man, const char **p,=
 const push_update_type type)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
type =3D=3D UPT_BROADCAST)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!man-&gt;persist.callback.push_update_broadcast)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            man_command_unsupported(&quot;push-upda=
te-broad&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        const bool status =3D (*=
man-&gt;persist.callback.push_update_broadcast)(man-&gt;persist.callback.ar=
g, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (status)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;SUCCESS=
: push-update-broad command succeeded&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(M_CLIENT, &quot;ERROR: push-update-broad command failed&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else if (type =3D=3D UPT_BY_CID)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (!man-&gt;persist.callback=
.push_update_by_cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   man_command_unsupported(&quot;push-update-cid&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        unsigned long cid =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (!parse_cid(p[1], &amp;cid))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(M_CLIENT, &quot;ERROR: push-update-cid fail dur=
ing cid parsing&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            return;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        const bool status=
 =3D (*man-&gt;persist.callback.push_update_by_cid)(man-&gt;persist.callbac=
k.arg, cid, p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (status)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quo=
t;SUCCESS: push-update-cid command succeeded&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(M_CLIENT, &quot;ERROR: push-update-cid command faile=
d&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else if (type =3D=3D UPT_BY_CN=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (!man-&gt;persist.cal=
lback.push_update_by_cn)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       man_command_unsupported(&quot;push-update-cn&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        const bool status =3D (*man-&gt;persist.callback.push_up=
date_by_cn)(man-&gt;persist.callback.arg, p[1], p[2]);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (status)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(M_CLIENT, &quot;SUCCESS: push-update-cn command succe=
eded&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;ER=
ROR: push-update-cn command failed&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else if (type =3D=3D UPT_BY_ADDR)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (!man-&gt;persist.callback.push_update_by_addr)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            man_command_unsupported(&quot=
;push-update-addr&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *ip_=
str =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  const char *port_str =3D p[2];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        const char *options =3D p[3];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!strlen(ip_str) || !strlen(port_str))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;ERROR: pu=
sh-update-addr parse&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct addri=
nfo *res =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       int port =3D atoi(port_str);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (port &lt; 1 || port &gt; 65535)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(M_CLIENT, &quot;ERROR: port number is out of ran=
ge: %s&quot;, port_str);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        int status =3D o=
penvpn_getaddrinfo(GETADDR_MSG_VIRT_OUT, ip_str, port_str, 0, NULL, AF_UNSP=
EC, &amp;res);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (status !=3D =
0 || !res)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_C=
LIENT, &quot;ERROR: error resolving address: %s (%s)&quot;, ip_str, gai_str=
error(status));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        struct addrinfo *rp;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        bool found_clien=
t =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Iterate through=
 resolved addresses */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        for (rp =3D res; rp !=3D NULL; rp =3D rp-&gt;ai_next)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            struct openvpn_sockaddr sadd=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struc=
t mroute_addr maddr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            CLEAR(=
saddr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
switch (rp-&gt;ai_family)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                case AF_INET:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    saddr.addr.in4 =3D *((struct sockaddr_in *)rp=
-&gt;ai_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               break;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                c=
ase AF_INET6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              saddr.addr.in6 =3D *((struct sockaddr_in6 *)rp-&gt;ai_addr);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                default:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    continu=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!mroute_extract_openvpn_s=
ockaddr(&amp;maddr, &amp;saddr, true))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                continue;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if ((*man-&gt;persist.callback.push_update_by_addr)(man-&gt;persist.c=
allback.arg, &amp;maddr, options))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                msg(M_CLIENT, &quot;SUCCESS: push-update sent to %=
s:%d&quot;, ip_str, port);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                found_client =3D true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                break;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (!found_client)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_CLIENT, &quot;ERROR: no client found at address %s:%d&quot;, ip_st=
r, port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        freeaddrinfo=
(res);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span> man_dispatch_command(struct managem=
ent *man, struct status_output *so, const char **p, const int nparms)</span=
><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><=
br><span>@@ -1648,6 +1801,34 @@</span><br><span>             man_remote(man=
, p);</span><br><span>         }</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;push-upd=
ate-broad&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man_=
need(man, p, 1, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  man_push_update(man, p, UPT_BROADCAST);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else if (streq(p[0], &quot;push-update-cid&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (man_need(man, p, 2, 0))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            man_push_update(man, p, UPT_BY_CID);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;push-update-c=
n&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(man=
, p, 2, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            man_pu=
sh_update(man, p, UPT_BY_CN);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (s=
treq(p[0], &quot;push-update-addr&quot;))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (man_need(man, p, 3, 0))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            man_push_update(man, p, UPT_BY_ADDR);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #if 1</span><br><s=
pan>     else if (streq(p[0], &quot;test&quot;))</span><br><span>     {</sp=
an><br><span>diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h</span=
><br><span>index f501543..8f463c6 100644</span><br><span>--- a/src/openvpn/=
manage.h</span><br><span>+++ b/src/openvpn/manage.h</span><br><span>@@ -44,=
7 +44,6 @@</span><br><span> #define MF_EXTERNAL_KEY_PSSPAD      (1&lt;&lt;1=
6)</span><br><span> #define MF_EXTERNAL_KEY_DIGEST      (1&lt;&lt;17)</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> #ifdef ENABLE_MANAGEMENT</span><br><span> </span><br><span> #inclu=
de &quot;misc.h&quot;</span><br><span>@@ -205,6 +204,10 @@</span><br><span>=
 #endif</span><br><span>     unsigned int (*remote_entry_count)(void *arg);=
</span><br><span>     bool (*remote_entry_get)(void *arg, unsigned int inde=
x, char **remote);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool (*push_update_broadcast)(void *arg, const char *options);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    bool (*push_update_by_cid=
)(void *arg, unsigned long cid, const char *options);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool (*push_update_by_cn)(void *arg, =
const char *cn, const char *options);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool (*push_update_by_addr)(void *arg, const struct m=
route_addr *maddr, const char *options);</span><br><span> };</span><br><spa=
n> </span><br><span> /*</span><br><span>diff --git a/src/openvpn/multi.c b/=
src/openvpn/multi.c</span><br><span>index 5b693f9..6a9ce83 100644</span><br=
><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c<=
/span><br><span>@@ -3981,7 +3981,7 @@</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static struct multi_instance *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+struct multi_instance *</span><br><span> lookup_by_cid(struct m=
ulti_context *m, const unsigned long cid)</span><br><span> {</span><br><spa=
n>     if (m)</span><br><span>@@ -4129,6 +4129,10 @@</span><br><span>      =
   cb.client_auth =3D management_client_auth;</span><br><span>         cb.c=
lient_pending_auth =3D management_client_pending_auth;</span><br><span>    =
     cb.get_peer_info =3D management_get_peer_info;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cb.push_update_broadcast =3D mana=
gement_callback_send_push_update_broadcast;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cb.push_update_by_cid =3D management_callba=
ck_send_push_update_by_cid;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cb.push_update_by_cn =3D management_callback_send_push_upda=
te_by_cn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cb=
.push_update_by_addr =3D management_callback_send_push_update_by_addr;</spa=
n><br><span>         management_set_callback(management, &amp;cb);</span><b=
r><span>     }</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span>=
<br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br>=
<span>index 9b6834a..4bb6e21 100644</span><br><span>--- a/src/openvpn/multi=
.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -714,5 +714=
,10 @@</span><br><span>  */</span><br><span> void multi_assign_peer_id(stru=
ct multi_context *m, struct multi_instance *mi);</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_instance *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+lookup_by_cid(struc=
t multi_context *m, const unsigned long cid);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span> </span><br><span> #endif /* MULTI_H */</span=
><br><span>diff --git a/src/openvpn/push.h b/src/openvpn/push.h</span><br><=
span>index b930c6c..112a2a5 100644</span><br><span>--- a/src/openvpn/push.h=
</span><br><span>+++ b/src/openvpn/push.h</span><br><span>@@ -42,6 +42,16 @=
@</span><br><span> #define PUSH_OPT_TO_REMOVE (1&lt;&lt;0)</span><br><span>=
 #define PUSH_OPT_OPTIONAL (1&lt;&lt;1)</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Push-update message sender modes *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef enum {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    UPT_BROADCAST =3D 0=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    UPT_BY_ADDR =
=3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    UPT_BY_CN=
 =3D 2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABL=
E_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    UPT=
_BY_CID =3D 3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} push_update_type;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> i=
nt process_incoming_push_request(struct context *c);</span><br><span> </spa=
n><br><span> /**</span><br><span>@@ -135,4 +145,33 @@</span><br><span> void=
</span><br><span> receive_auth_pending(struct context *c, const struct buff=
er *buffer);</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @b=
rief A function to send a PUSH_UPDATE control message from server to client=
(s).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param m the multi_context, c=
ontains all the clients connected to this server.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param target the target to which to send =
the message. It should be:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * `NULL` if `type =3D=3D UPT_BROADCAST`,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * a `mroute_addr *` if `type =3D=3D UPT_BY_AD=
DR`,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a `char *` i=
f `type =3D=3D UPT_BY_CN`,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * an `unsigned long *` if `type =3D=3D UPT_BY_CID`.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param msg a string containing t=
he options to send.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param type the way to address the message (broadcast, by cid, by cn, by=
 address).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 push_bundle_size the maximum size of a bundle of pushed option. Just use P=
USH_BUNDLE_SIZE macro.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @return the number of clients to which the message was sent.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+send_push_update(struct multi_context *m, const void *target=
, const char *msg, const push_update_type type, const int push_bundle_size)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool management_callback_send_push_update_broadcast=
(void *arg, const char *options);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool =
management_callback_send_push_update_by_cid(void *arg, unsigned long cid, c=
onst char *options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool management_ca=
llback_send_push_update_by_cn(void *arg, const char *cn, const char *option=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool management_callback_send_push_=
update_by_addr(void *arg, const struct mroute_addr *maddr, const char *opti=
ons);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT=
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 #endif /* ifndef PUSH_H */</span><br><span>diff --git a/src/openvpn/push_u=
til.c b/src/openvpn/push_util.c</span><br><span>index b4d1e8b..69d7a9c 1006=
44</span><br><span>--- a/src/openvpn/push_util.c</span><br><span>+++ b/src/=
openvpn/push_util.c</span><br><span>@@ -3,6 +3,8 @@</span><br><span> #endif=
</span><br><span> </span><br><span> #include &quot;push.h&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi.h&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_ver=
ify.h&quot;</span><br><span> </span><br><span> int</span><br><span> process=
_incoming_push_update(struct context *c,</span><br><span>@@ -42,3 +44,247 @=
@</span><br><span> </span><br><span>     return ret;</span><br><span> }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Return index of last `,` or `0` if it didn&#39;t find =
any.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If there is =
a comma at index `0` it&#39;s an error anyway</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+find_first_comma_of_next_bundle(const char *str, int ix)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    while (ix &gt; 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (str[ix] =3D=3D &#39;,&#39;)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return ix;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        ix--;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static char *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+gc_strdup(const char *src, struct gc_arena *gc)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    char *ret =3D gc_malloc((strlen(src) + 1) * =
sizeof(char), true, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(ret=
, src);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return r=
et;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* It split the messagge (if necessay) and fill msgs =
with the message chunks.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Return `false` on failure an `true` on success.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+message_splitter(char *str, char **mesgs, struct gc_arena *gc, =
const int safe_cap)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!str || !*=
str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int i =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int im =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while=
 (*str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* sizeof(push_upd=
ate_cmd) + &#39;,&#39; - &#39;/0&#39; */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (strlen(str) + sizeof(push_update_cmd) &gt;=
 safe_cap)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            int ci =
=3D find_first_comma_of_next_bundle(str, safe_cap - sizeof(push_update_cmd)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!=
ci)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* if =
no commas were found go to fail, do not send any message */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            str[ci] =3D &#39;\0=
&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /=
* copy from i to (ci -1) */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            mesgs[im] =3D gc_strdup(str, gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            i =3D ci + 1;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            mesgs[im] =3D gc_strdup(str, gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            i =3D strlen(str);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        str =3D &amp;str[i];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        im++;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* It actua=
lly send the already divided messagge to one single client */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+send_single_push_update(struct context *c=
, char **msgs, struct buffer *buf, struct gc_arena *gc, const int push_bund=
le_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!msgs[0] || !*msgs[0]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else if (!msgs[1] || !*msgs[1])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        buf_printf(buf, &quot;%s%c%s&quot=
;, push_update_cmd, &#39;,&#39;, msgs[0]);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!send_control_channel_string(c, BSTR(buf=
), D_PUSH))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        int i =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        while (msgs[i] &amp;&amp; *msgs[i])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (msgs[i+1])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                buf_printf(buf, &quot;%s%c%s%=
s&quot;, push_update_cmd, &#39;,&#39;, msgs[i], &quot;,push-continuation 2&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_printf(=
buf, &quot;%s%c%s%s&quot;, push_update_cmd, &#39;,&#39;, msgs[i], &quot;,pu=
sh-continuation 1&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!se=
nd_control_channel_string(c, BSTR(buf), D_PUSH))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            *buf =3D alloc_buf_gc(push_bundle_s=
ize, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  i++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_push_update(s=
truct multi_context *m, const void *target, const char *msg, const push_upd=
ate_type type, const int push_bundle_size)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!msg || !*msg || !m</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        || (!target &amp;&amp; type !=3D UPT_BROADCAST))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(push_bundle_=
size, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* extra space for possible trailing ifconfig and push-continuation */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int extra =3D =
84;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* push_bund=
le_size is the maximum size of a message, so if the message</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * we want to send exceeds that=
 size we have to split it into smaller messages */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const int safe_cap =3D BCAP(&amp;buf) - =
extra;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int mexnu=
m =3D (strlen(msg) / (safe_cap  - sizeof(push_update_cmd))) + 1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    char **msgs =3D gc_malloc(=
sizeof(char *) * (mexnum + 1), true, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msgs[mexnum] =3D NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!message_splitter(gc_strdup(msg, &amp;gc), msgs, &am=
p;gc, safe_cap))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn -EINVAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (type =3D=3D UPT_BY_CID)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct multi_instance *mi =3D=
 lookup_by_cid(m, *((unsigned long *)target));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!mi)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       return -ENOENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!mi-&gt;halt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          &amp;&amp; send_single_push_update(&amp;mi-&gt;context, msgs, &am=
p;buf, &amp;gc, push_bundle_size))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            return 1;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int count =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct hash_iterator hi;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const struct hash_element=
 *he;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    hash_iterator_init(m-&gt;iter=
, &amp;hi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    whil=
e ((he =3D hash_iterator_next(&amp;hi)))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct multi_instance *curr_mi =3D he-&gt;value;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (curr_mi-&gt;halt)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (type =3D=3D UPT_BY_ADDR &amp;&amp; !mroute_add=
r_equal(target, &amp;curr_mi-&gt;real))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            continue;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        else if (type =3D=3D UPT_BY_CN)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            const char *curr_cn =3D tls_common_name(curr_mi-&gt=
;context.c2.tls_multi, false);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (strcmp(curr_cn, target))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                continue;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /* Either we found a matching client or type is U=
PT_BROADCAST so we update every client */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (!send_single_push_update(&amp;curr_mi-&gt=
;context, msgs, &amp;buf, &amp;gc, push_bundle_size))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;ERROR: Peer ID: %u =
has not been updated&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                curr_mi-&gt;context.c2.tls_multi ? curr_mi-&gt;cont=
ext.c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        count++;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hash_iterator_fr=
ee(&amp;hi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn count;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define RETURN_UPDATE_STATUS(n_sent) \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do { \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if ((n_sent) &gt; 0) =
{ \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(=
M_CLIENT, &quot;SUCCESS: %d client(s) updated&quot;, (n_sent)); \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            return true; \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        } else { \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIEN=
T, &quot;ERROR: no client updated&quot;); \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return false; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        } \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    } while (0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+management_callback_send_push_u=
pdate_broadcast(void *arg, const char *options)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int n_sent =3D send_push_update(arg, NULL, options, UPT_BROAD=
CAST, PUSH_BUNDLE_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    RETURN_UPD=
ATE_STATUS(n_sent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+management_callback_send_push_update_by_cid(void *ar=
g, unsigned long cid, const char *options)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int ret =3D send_push_update(arg, &amp;cid, options, UPT_BY_CID, P=
USH_BUNDLE_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret =3D=3D -E=
NOENT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot=
;ERROR: no client found with CID: %lu&quot;, cid);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return (ret &gt; 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+management_callback_send_push_update_by_cn(void *=
arg, const char *cn, const char *options)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int n_sent =3D send_push_update(arg, cn, options, UPT_BY_CN, PUSH_B=
UNDLE_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    RETURN_UPDATE_STATUS(n=
_sent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+management_callback_send_push_update_by_addr(void *arg, const st=
ruct mroute_addr *maddr, const char *options)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int n_sent =3D send_push_update(arg, maddr, options, UPT_BY_ADD=
R, PUSH_BUNDLE_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    RETURN_UPDATE=
_STATUS(n_sent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABL=
E_MANAGEMENT */</span><br><span>diff --git a/tests/unit_tests/openvpn/Makef=
ile.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span>index 651c5f6=
..529b77b 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile.am=
</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br><span=
>@@ -325,4 +325,5 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platform.c=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/push_util.c \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/options_util.c \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/otime.c</span><br><span=
>\ No newline at end of file</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/openvpn/otime.c \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/list.c</span><br><span=
>\ No newline at end of file</span><br><span>diff --git a/tests/unit_tests/=
openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_=
msg.c</span><br><span>index d0876bc..1a9e093 100644</span><br><span>--- a/t=
ests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_push_update_msg.c</span><br><span>@@ -8,6 +8,7 @@</=
span><br><span> #include &lt;cmocka.h&gt;</span><br><span> #include &quot;p=
ush.h&quot;</span><br><span> #include &quot;options_util.h&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi.h&quot;</=
span><br><span> </span><br><span> /* mocks */</span><br><span> </span><br><=
span>@@ -94,6 +95,48 @@</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_common_name(co=
nst struct tls_multi *multi, const bool null)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_MANAGEMENT</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string(struct contex=
t *c, const char *str, int msglevel)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* ifndef ENABL=
E_MANAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char=
 **res;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int i;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+send_control_channel_string(struct context *c, const char *=
str, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (res &amp;&a=
mp; res[i] &amp;&amp; strcmp(res[i], str))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 i++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+struct multi_instance *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+lookup_by_cid(struct multi_context *m, const unsig=
ned long cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return *(m-&gt;insta=
nces);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+mroute_extract_openvpn_sockaddr(struct mroute_addr *addr,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
     const struct openvpn_sockaddr *osaddr,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                bool use_port)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif /* ifndef ENABLE_MANAGEMENT */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> /* tests */</span><br><spa=
n> </span><br><span> static void</span><br><span>@@ -124,7 +167,6 @@</span>=
<br><span>     free_buf(&amp;buf);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static =
void</span><br><span> test_incoming_push_message_error2(void **state)</span=
><br><span> {</span><br><span>@@ -209,6 +251,194 @@</span><br><span>     fr=
ee_buf(&amp;buf);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+char *r0[] =3D {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,redirect-gateway=
 local,route 192.168.1.0 255.255.255.0&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+char *r1[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lal=
alalalalalalalalalalalalaf,push-continuation 2&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, akakakakakakakakak=
akakaf, dhcp-option DNS 8.8.8.8,redirect-gateway local,push-continuation 2&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUS=
H_UPDATE,route 192.168.1.0 255.255.255.0,push-continuation 1&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+char *r3[] =3D {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,,,&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+char *r4[] =3D {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &quot;PUSH_UPDATE,-dhcp-option, blablalalalalalalalal=
alalalalf, lalalalalalalalalalalalalalaf,push-continuation 2&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, akak=
akakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redirect-gateway local,push-c=
ontinuation 2&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation =
1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+char *r5[] =3D {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,,-dhcp-opt=
ion, blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-con=
tinuation 2&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;PUSH_UPDATE, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, red=
irect-gateway local,push-continuation 2&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, route 192.168.1.0 255.255=
.255.0,push-continuation 1&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char=
 *r6[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &qu=
ot;PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalal=
alalalalalalaf,push-continuation 2&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, akakakakakakakakakakakaf, dhcp=
-option DNS 8.8.8.8, redirect-gateway 10.10.10.10,,push-continuation 2&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UP=
DATE, route 192.168.1.0 255.255.255.0,,push-continuation 1&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+char *r7[] =3D {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,,,,,,,,,,,,,,,,,,,,,,,,,,,,,=
,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,push-continuat=
ion 2&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &qu=
ot;PUSH_UPDATE,,,,,,,,,,,,,,,,,,,push-continuation 1&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+char *r8[] =3D {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;PUSH_UPDATE,-dhcp-option,blablalalalalalalalal=
alalalalf, lalalalalalalalalalalalalalaf,push-continuation 2&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, akak=
akakakakakakakakakaf, dhcp-option DNS 8.8.8.8,redirect-gateway\n local,push=
-continuation 2&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &quot;PUSH_UPDATE,route 192.168.1.0 255.255.255.0\n\n\n,push-continu=
ation 1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+char *r9[] =3D {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,,&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+const char *msg0 =3D &quot;redirect-gateway local,route 192.168.1.0 255=
.255.255.0&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
nst char *msg1 =3D &quot;-dhcp-option,blablalalalalalalalalalalalalf, lalal=
alalalalalalalalalalalaf, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8=
,redirect-gateway local,route 192.168.1.0 255.255.255.0&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+const char *msg2 =3D &quot;&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *msg3 =
=3D &quot;,,&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
const char *msg4 =3D &quot;-dhcp-option, blablalalalalalalalalalalalalf, la=
lalalalalalalalalalalalalaf, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8=
.8, redirect-gateway local, route 192.168.1.0 255.255.255.0,&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+const char *msg5 =3D &quot;=
,-dhcp-option, blablalalalalalalalalalalalalf, lalalalalalalalalalalalalala=
f, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redirect-gateway local=
, route 192.168.1.0 255.255.255.0&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+const char *msg6 =3D &quot;-dhcp-option,blablalalalala=
lalalalalalalalf, lalalalalalalalalalalalalalaf, akakakakakakakakakakakaf, =
dhcp-option DNS 8.8.8.8, redirect-gateway 10.10.10.10,, route 192.168.1.0 2=
55.255.255.0,&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+const char *msg7 =3D &quot;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,=
,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+const char *msg8 =3D &quot;-=
dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf, =
akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,redirect-gateway\n local,=
route 192.168.1.0 255.255.255.0\n\n\n&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+const char *msg9 =3D &quot;,&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+const char *msg10 =3D &quot;Voil=
=C3=A0! In view, a humble vaudevillian veteran cast vicariously as both vic=
tim and villain by the vicissitudes of Fate. This visage no mere veneer of =
vanity is a vestige of the vox populi now vacant vanished. However this val=
orous visitation of a by-gone vexation stands vivified and has vowed to van=
quish these venal and virulent vermin vanguarding vice and vouchsafing the =
violently vicious and voracious violation of volition. The only verdict is =
vengeance; a vendetta held as a votive not in vain for the value and veraci=
ty of such shall one day vindicate the vigilant and the virtuous. Verily th=
is vichyssoise of verbiage veers most verbose so let me simply add that it =
is my very good honor to meet you and you may call me V.&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define PUSH_BUNDLE_SIZE_TEST 184</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+test_send_push_msg0(void **state)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    res =3D r0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct multi_context *m =3D *state;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const unsigned long cid =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(send_push_update(m, =
&amp;cid, msg0, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_send_push_msg1(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   res =3D r1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct multi_context *m =3D *state;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const unsigned long cid =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(send_push_update(m, &amp=
;cid, msg1, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_send_p=
ush_msg2(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    res =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context=
 *m =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const unsigned long cid =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(send_push_update(m, &amp;cid, msg2, UPT_BY_=
CID, PUSH_BUNDLE_SIZE_TEST), -EINVAL);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_send_push_msg3(void *=
*state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    res =3D r3;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D *state;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned lo=
ng cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(send_push_update(m, &amp;cid, msg3, UPT_BY_CID, PUSH_BUNDLE_=
SIZE_TEST), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_send_push_msg4(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    i =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    res =3D r4;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct multi_context *m =3D *state;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const unsigned long cid =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(send_pus=
h_update(m, &amp;cid, msg4, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+test_send_push_msg5(void **state)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res =
=3D r5;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct m=
ulti_context *m =3D *state;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const unsigned long cid =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(send_push_update(m, &amp;cid, m=
sg5, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_send_push_msg6(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    res =3D r6;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D *st=
ate;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsig=
ned long cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(send_push_update(m, &amp;cid, msg6, UPT_BY_CID, PUSH_B=
UNDLE_SIZE_TEST), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_send_push_msg7(void **state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    i =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    res =3D r7;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct multi_context *m =3D *state;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const unsigned long cid =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
send_push_update(m, &amp;cid, msg7, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_send_push_msg8(void **state)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    res =3D r8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct multi_context *m =3D *state;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const unsigned long cid =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(send_push_update(m, &am=
p;cid, msg8, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_send_p=
ush_msg9(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    res =3D r9;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *=
m =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst unsigned long cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(send_push_update(m, &amp;cid, msg9, UPT_BY_CI=
D, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_send_push_msg10(void **state)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    res =3D NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct multi_context *m =3D *state;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned long ci=
d =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(send_push_update(m, &amp;cid, msg10, UPT_BY_CID, PUSH_BUNDLE_SIZE=
_TEST), -EINVAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#undef PUSH_BUNDLE_SIZE_TEST</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+setup2(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct multi_context *m =3D calloc(1, sizeof(struct multi_context));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;instances =
=3D calloc(1, sizeof(struct multi_instance *));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct multi_instance *mi =3D calloc(1, siz=
eof(struct multi_instance));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    *(m-&gt;instances) =3D mi;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    *state =3D m;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+teardown2(void **state)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct multi_context *m =3D *state;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    free(*(m-&gt;instances))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(m-&gt;ins=
tances);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(m)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static=
 int</span><br><span> setup(void **state)</span><br><span> {</span><br><spa=
n>@@ -238,7 +468,20 @@</span><br><span>         cmocka_unit_test_setup_tear=
down(test_incoming_push_message_1, setup, teardown),</span><br><span>      =
   cmocka_unit_test_setup_teardown(test_incoming_push_message_bad_format, s=
etup, teardown),</span><br><span>         cmocka_unit_test_setup_teardown(t=
est_incoming_push_message_mix, setup, teardown),</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        cmocka_unit_test_setup_teardown(test_inc=
oming_push_message_mix2, setup, teardown)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_incoming=
_push_message_mix2, setup, teardown),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_send_pu=
sh_msg0, setup2, teardown2),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test_setup_teardown(test_send_push_msg1, setup=
2, teardown2),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   cmocka_unit_test_setup_teardown(test_send_push_msg2, setup2, teardown2),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit=
_test_setup_teardown(test_send_push_msg3, setup2, teardown2),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_te=
ardown(test_send_push_msg4, setup2, teardown2),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_se=
nd_push_msg5, setup2, teardown2),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test_setup_teardown(test_send_push_msg6, =
setup2, teardown2),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        cmocka_unit_test_setup_teardown(test_send_push_msg7, setup2, teardo=
wn2),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka=
_unit_test_setup_teardown(test_send_push_msg8, setup2, teardown2),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_set=
up_teardown(test_send_push_msg9, setup2, teardown2),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(t=
est_send_push_msg10, setup2, teardown2)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span>     };</span><br><span> </span>=
<br><span>     return cmocka_run_group_tests(tests, NULL, NULL);</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/869?usp=3Demail">change 869</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/86=
9?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie82bcc7a8e583de9156b185d71d=
1a323ed8df3fc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 869 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--OF1Ubm2hy2Y=--

