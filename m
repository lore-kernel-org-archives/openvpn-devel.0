From: "mrbff (Code Review)" <gerrit@...515...>
Date: Thu, 10 Jul 2025 13:28:26 +0000
In-Reply-To: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
References: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., gert@...1296...
Message-ID: <a64afdc00153a54e8e04487a2487ceafd67454c3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DVcGvDNSu0o="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DVcGvDNSu0o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, mrbff, plaisthos=
, stipa.

Hello cron2, flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail

to look at the new patch set (#11).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
M doc/management-notes.txt
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/push.h
M src/openvpn/push_util.c
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_push_update_msg.c
10 files changed, 893 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/869/11

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 54cf503..1381e03 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -861,6 +861,7 @@
 	    src/openvpn/push_util.c
 	    src/openvpn/options_util.c
 	    src/openvpn/otime.c
+        src/openvpn/list.c
         )

     if (TARGET test_argv)
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index f1d2930..58393da 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -1028,6 +1028,51 @@
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
+COMMAND -- push-update-cn (OpenVPN 2.7 or higher)
+----------------------------------------------------
+Same as push-update-broad but target the clients based on the provided com=
mon name
+(usually just one client per common name is permitted except if "duplicate=
-cn" option is used).
+
+Example
+  push-update-cid Client0 "route 10.10.10.1 255.255.255.255, -dns, ?tun-mt=
u 1400"
+
+COMMAND -- push-update-addr (OpenVPN 2.7 or higher)
+----------------------------------------------------
+Same as push-update-broad but target only the client(s) connecting from the
+provided address (real address). Support both IPv4 and IPv6.
+
+Example
+  push-update-addr 9.9.9.9 1234 "route 10.10.10.1 255.255.255.255, -dns, ?=
tun-mtu 1400"
+
 OUTPUT FORMAT
 -------------

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 8836e79..251b076 100644
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

@@ -1335,6 +1340,154 @@
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
@@ -1656,6 +1809,34 @@
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
index eb19a4e..fd7cb11 100644
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
index 7f0d890..985af17 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4072,7 +4072,7 @@
     }
 }

-static struct multi_instance *
+struct multi_instance *
 lookup_by_cid(struct multi_context *m, const unsigned long cid)
 {
     if (m)
@@ -4220,6 +4220,10 @@
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
@@ -4344,3 +4348,47 @@
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
+        /* Add new, remove old if exist */
+        multi_learn_in_addr_t(m, mi, new_ip, 0, true);
+    }
+
+    /* TO DO:
+     *  else if (old_ip && !mi->context.options.ifconfig_local)
+     *  {
+     *      // remove old ip
+     *  }
+     */
+
+    if ((mi->context.options.ifconfig_ipv6_local && (!old_ipv6 || strcmp(o=
ld_ipv6, mi->context.options.ifconfig_ipv6_local)))
+        && inet_pton(AF_INET6, mi->context.options.ifconfig_ipv6_local, &n=
ew_ipv6) =3D=3D 1)
+    {
+        /* Add new, remove old if exist */
+        multi_learn_in6_addr(m, mi, new_ipv6, 0, true);
+    }
+
+    /* TO DO:
+     *  else if (old_ipv6 && !mi->context.options.ifconfig_ipv6_local)
+     *  {
+     *      // remove old IPv6
+     *  }
+     */
+}
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 40f7519..4841075 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -710,5 +710,13 @@
  */
 void multi_assign_peer_id(struct multi_context *m, struct multi_instance *=
mi);

+#ifdef ENABLE_MANAGEMENT
+struct multi_instance *
+lookup_by_cid(struct multi_context *m, const unsigned long cid);
+
+#endif
+
+void
+update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *old_ip, const char *old_ipv6);

 #endif /* MULTI_H */
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 18dfcd8..e67c3ac 100644
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
@@ -134,4 +144,33 @@
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
index b4d1e8b..1739510 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -3,6 +3,8 @@
 #endif

 #include "push.h"
+#include "multi.h"
+#include "ssl_verify.h"

 int
 process_incoming_push_update(struct context *c,
@@ -42,3 +44,293 @@

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
+/* Allocate memory and asseble the final message */
+static char *
+forge_msg(const char *src, const char *continuation, struct gc_arena *gc)
+{
+    int src_len =3D strlen(src);
+    int con_len =3D continuation ? strlen(continuation) : 0;
+    char *ret =3D gc_malloc((src_len + sizeof(push_update_cmd) + con_len +=
 2) * sizeof(char), true, gc);
+    int i =3D sizeof(push_update_cmd) -1;
+
+    strcpy(ret, push_update_cmd);
+    ret[i++] =3D ',';
+    strcpy(&ret[i], src);
+    if (continuation)
+    {
+        i +=3D src_len;
+        strcpy(&ret[i], continuation);
+    }
+    return ret;
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
+message_splitter(char *str, char **msgs, struct gc_arena *gc, const int sa=
fe_cap)
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
+/* It actually send the already divided messagge to one single client */
+static bool
+send_single_push_update(struct context *c, char **msgs, unsigned int *opti=
on_types_found)
+{
+    if (!msgs[0] || !*msgs[0])
+    {
+        return false;
+    }
+    int i =3D 0;
+    struct gc_arena gc =3D gc_new();
+
+    while (msgs[i] && *msgs[i])
+    {
+        struct buffer buf =3D alloc_buf_gc(strlen(msgs[i]), &gc);
+
+        buf_write(&buf, msgs[i], strlen(msgs[i]));
+        if (!send_control_channel_string(c, msgs[i], D_PUSH))
+        {
+            return false;
+        }
+        i++;
+
+        /* After sending the control message, we update the options server=
-side in the client's context */
+        buf_string_compare_advance(&buf, push_update_cmd);
+        if (process_incoming_push_update(c, pull_permission_mask(c), optio=
n_types_found, &buf) =3D=3D PUSH_MSG_ERROR)
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
+    gc_free(&gc);
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
+    char **msgs =3D gc_malloc(sizeof(char *) * (msgs_num + 1), true, &gc);
+    unsigned int option_types_found =3D 0;
+
+    msgs[msgs_num] =3D NULL;
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
+#endif /* ifdef ENABLE_MANAGEMENT */
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
index b24e03c..9a40512 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -343,4 +343,5 @@
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
index d0876bc..38ea9a6 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -8,6 +8,7 @@
 #include <cmocka.h>
 #include "push.h"
 #include "options_util.h"
+#include "multi.h"

 /* mocks */

@@ -36,6 +37,18 @@
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
 apply_push_options(struct context *c,
                    struct options *options,
@@ -94,6 +107,49 @@
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
@@ -124,7 +180,6 @@
     free_buf(&buf);
 }

-
 static void
 test_incoming_push_message_error2(void **state)
 {
@@ -209,6 +264,207 @@
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
@@ -238,7 +494,20 @@
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
Gerrit-PatchSet: 11
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-MessageType: newpatchset

--DVcGvDNSu0o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, mrbff, plais=
thos, stipa. </p>
<p>mrbff <strong>uploaded patch set #11</strong> to this change.</p><p><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">PUSH_UPDATE message sender: enabling the serv=
er to send PUSH_UPDATE control messages<br><br>Using the management interfa=
ce you can now target one or more clients (via broadcast,<br>via cid, via c=
ommon name, via address) and send a PUSH_UPDATE control message<br>to updat=
e some options.<br><br>Change-Id: Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc=
<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M CMakeLi=
sts.txt<br>M doc/management-notes.txt<br>M src/openvpn/manage.c<br>M src/op=
envpn/manage.h<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M src/o=
penvpn/push.h<br>M src/openvpn/push_util.c<br>M tests/unit_tests/openvpn/Ma=
kefile.am<br>M tests/unit_tests/openvpn/test_push_update_msg.c<br>10 files =
changed, 893 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/69/869/11</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMake=
Lists.txt b/CMakeLists.txt</span><br><span>index 54cf503..1381e03 100644</s=
pan><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</sp=
an><br><span>@@ -861,6 +861,7 @@</span><br><span> 	    src/openvpn/push_uti=
l.c</span><br><span> 	    src/openvpn/options_util.c</span><br><span> 	    =
src/openvpn/otime.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        src/openvpn/list.c</span><br><span>         )</span><br><span> </sp=
an><br><span>     if (TARGET test_argv)</span><br><span>diff --git a/doc/ma=
nagement-notes.txt b/doc/management-notes.txt</span><br><span>index f1d2930=
..58393da 100644</span><br><span>--- a/doc/management-notes.txt</span><br><=
span>+++ b/doc/management-notes.txt</span><br><span>@@ -1028,6 +1028,51 @@<=
/span><br><span> stored outside of the filesystem (e.g. in Mac OS X Keychai=
n)</span><br><span> with OpenVPN via the management interface.</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+COMMAND -- pus=
h-update-broad (OpenVPN 2.7 or higher)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+----------------------------------------------------</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+Send a message to every=
 connected client to update options at runtime.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+The updatable options are: &quot;block-ipv6&quo=
t;, &quot;block-outside-dns&quot;, &quot;dhcp-option&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+&quot;dns&quot;, &quot;ifconfig&quo=
t;, &quot;ifconfig-ipv6&quot;, &quot;redirect-gateway&quot;, &quot;redirect=
-private&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&quo=
t;route&quot;, &quot;route-gateway&quot;, &quot;route-ipv6&quot;, &quot;rou=
te-metric&quot;, &quot;topology&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+&quot;tun-mtu&quot;, &quot;keepalive&quot;. When a valid=
 option is pushed, the receiving client will</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+delete every previous value and set new value, so =
the update of the option will </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+not be incremental even when theoretically possible (ex. with &q=
uot;redirect-gateway&quot;).</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+The &#39;-&#39; symbol in front of an option means the option shou=
ld be removed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+When =
an option is used with &#39;-&#39;, it cannot take any parameter.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+The &#39;?&#39; symbol in fro=
nt of an option means the option&#39;s update is optional</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+so if the client do not support it, t=
hat option will just be ignored without</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+making fail the entire command. The &#39;-&#39; and &#3=
9;?&#39; symbols can be used together.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
Option Format Ex.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
`-?option`, `-option`, `?option parameters` are valid formats,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  `?-option` is not a valid form=
at.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+Example</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  push-update-broad &quot;route 10.10.10.1 255.=
255.255.255, -dns, ?tun-mtu 1400&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
COMMAND -- push-update-cid (OpenVPN 2.7 or higher)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+--------------------------------------------=
--------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Same as pus=
h-update-broad but you must target a single client using client id.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+Example</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  push-update-cid 42 &quot;route 10.10.10.1 255.255.255.25=
5, -dns, ?tun-mtu 1400&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+COMMAND --=
 push-update-cn (OpenVPN 2.7 or higher)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+----------------------------------------------------</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+Same as push-update-br=
oad but target the clients based on the provided common name</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+(usually just one client per commo=
n name is permitted except if &quot;duplicate-cn&quot; option is used).</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Example</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  push-update-cid Client0 &quot;route 10.10.10.1 255.=
255.255.255, -dns, ?tun-mtu 1400&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
COMMAND -- push-update-addr (OpenVPN 2.7 or higher)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+-----------------------------------------=
-----------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Same as =
push-update-broad but target only the client(s) connecting from the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+provided address (real addr=
ess). Support both IPv4 and IPv6.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Examp=
le</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  push-update-add=
r 9.9.9.9 1234 &quot;route 10.10.10.1 255.255.255.255, -dns, ?tun-mtu 1400&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> OUTPUT FORMAT</span><br><span> -------------</span><br><span> </span><b=
r><span>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br>=
<span>index 8836e79..251b076 100644</span><br><span>--- a/src/openvpn/manag=
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
><span> </span><br><span>@@ -1335,6 +1340,154 @@</span><br><span> }</span><=
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
br><span>@@ -1656,6 +1809,34 @@</span><br><span>             man_remote(man=
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
><br><span>index eb19a4e..fd7cb11 100644</span><br><span>--- a/src/openvpn/=
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
src/openvpn/multi.c</span><br><span>index 7f0d890..985af17 100644</span><br=
><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c<=
/span><br><span>@@ -4072,7 +4072,7 @@</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static struct multi_instance *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+struct multi_instance *</span><br><span> lookup_by_cid(struct m=
ulti_context *m, const unsigned long cid)</span><br><span> {</span><br><spa=
n>     if (m)</span><br><span>@@ -4220,6 +4220,10 @@</span><br><span>      =
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
<br><span>@@ -4344,3 +4348,47 @@</span><br><span>     close_instance(top);<=
/span><br><span> </span><br><span> }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Update the vhas=
h with new IP/IPv6 addresses in the multi_context when a</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * push-update message containing ifco=
nfig/ifconfig-ipv6 options is sent</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * from the server. This function should be called after a p=
ush-update</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and ol=
d_ip/old_ipv6 are the previous addresses of the client in</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * ctx-&gt;options.ifconfig_local and=
 ctx-&gt;options.ifconfig_ipv6_local.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+update_vhash(=
struct multi_context *m, struct multi_instance *mi, const char *old_ip, con=
st char *old_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in_addr =
addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6=
_addr new_ipv6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((mi-&gt;context=
.options.ifconfig_local &amp;&amp; (!old_ip || strcmp(old_ip, mi-&gt;contex=
t.options.ifconfig_local)))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        &amp;&amp; inet_pton(AF_INET, mi-&gt;context.options.ifconf=
ig_local, &amp;addr) =3D=3D 1)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     in_addr_t new_ip =3D ntohl(addr.s_addr);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* Add new, remove old if exist */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        multi_learn_in_addr_t(m, mi, new_ip, =
0, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* TO DO:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     *  else if (old_ip &amp;&amp; !mi-&gt;cont=
ext.options.ifconfig_local)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     *  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   *      // remove old ip</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     *  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if ((mi-&gt;context.options.if=
config_ipv6_local &amp;&amp; (!old_ipv6 || strcmp(old_ipv6, mi-&gt;context.=
options.ifconfig_ipv6_local)))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        &amp;&amp; inet_pton(AF_INET6, mi-&gt;context.options.if=
config_ipv6_local, &amp;new_ipv6) =3D=3D 1)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /* Add new, remove old if exist */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        multi_learn_in6_addr(m, mi, new_i=
pv6, 0, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* TO DO:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     *  else if (old_ipv6 &amp;&amp; !mi-&gt=
;context.options.ifconfig_ipv6_local)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     *  {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     *      // remove old IPv6</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     *  }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span=
><br><span>index 40f7519..4841075 100644</span><br><span>--- a/src/openvpn/=
multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -710,5=
 +710,13 @@</span><br><span>  */</span><br><span> void multi_assign_peer_id=
(struct multi_context *m, struct multi_instance *mi);</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMEN=
T</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_insta=
nce *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+lookup_by_cid(=
struct multi_context *m, const unsigned long cid);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+update_vhash(struct multi_context *=
m, struct multi_instance *mi, const char *old_ip, const char *old_ipv6);</s=
pan><br><span> </span><br><span> #endif /* MULTI_H */</span><br><span>diff =
--git a/src/openvpn/push.h b/src/openvpn/push.h</span><br><span>index 18dfc=
d8..e67c3ac 100644</span><br><span>--- a/src/openvpn/push.h</span><br><span=
>+++ b/src/openvpn/push.h</span><br><span>@@ -42,6 +42,16 @@</span><br><spa=
n> #define PUSH_OPT_TO_REMOVE (1&lt;&lt;0)</span><br><span> #define PUSH_OP=
T_OPTIONAL (1&lt;&lt;1)</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Push-update message sender modes */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+typedef enum {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    UPT_BROADCAST =3D 0,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    UPT_BY_ADDR =3D 1,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    UPT_BY_CN =3D 2,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    UPT_BY_CID =3D 3</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+} push_update_type;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int process_incomin=
g_push_request(struct context *c);</span><br><span> </span><br><span> /**</=
span><br><span>@@ -134,4 +144,33 @@</span><br><span> void</span><br><span> =
receive_auth_pending(struct context *c, const struct buffer *buffer);</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief A function to=
 send a PUSH_UPDATE control message from server to client(s).</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param m the multi_context, contains all the cl=
ients connected to this server.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param target the target to which to send the message. It sh=
ould be:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * `NULL` i=
f `type =3D=3D UPT_BROADCAST`,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * a `mroute_addr *` if `type =3D=3D UPT_BY_ADDR`,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * a `char *` if `type =3D=3D UPT=
_BY_CN`,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * an `unsi=
gned long *` if `type =3D=3D UPT_BY_CID`.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param msg a string containing the options to send=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param type the=
 way to address the message (broadcast, by cid, by cn, by address).</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param push_bundle_size =
the maximum size of a bundle of pushed option. Just use PUSH_BUNDLE_SIZE ma=
cro.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return the =
number of clients to which the message was sent.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sen=
d_push_update(struct multi_context *m, const void *target, const char *msg,=
 const push_update_type type, const int push_bundle_size);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+bool management_callback_send_push_update_broadcast(void *arg, const =
char *options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool management_callbac=
k_send_push_update_by_cid(void *arg, unsigned long cid, const char *options=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool management_callback_send_push_u=
pdate_by_cn(void *arg, const char *cn, const char *options);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool management_callback_send_push_update_by_addr(voi=
d *arg, const struct mroute_addr *maddr, const char *options);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT*/</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef =
PUSH_H */</span><br><span>diff --git a/src/openvpn/push_util.c b/src/openvp=
n/push_util.c</span><br><span>index b4d1e8b..1739510 100644</span><br><span=
>--- a/src/openvpn/push_util.c</span><br><span>+++ b/src/openvpn/push_util.=
c</span><br><span>@@ -3,6 +3,8 @@</span><br><span> #endif</span><br><span> =
</span><br><span> #include &quot;push.h&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;multi.h&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_verify.h&quot;</span>=
<br><span> </span><br><span> int</span><br><span> process_incoming_push_upd=
ate(struct context *c,</span><br><span>@@ -42,3 +44,293 @@</span><br><span>=
 </span><br><span>     return ret;</span><br><span> }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Return index of last `,` or `0` if it didn&#39;t find any.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * If there is a comma at index `0=
` it&#39;s an error anyway</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static in=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+find_first_comma_o=
f_next_bundle(const char *str, int ix)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    while (ix &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(str[ix] =3D=3D &#39;,&#39;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return ix;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
ix--;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* Allocate memory and asseble the final message */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static char *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+forge_msg(const char *src, const char *contin=
uation, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int s=
rc_len =3D strlen(src);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int con_len =3D continuation ? strlen(continuation) : 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D gc_malloc((s=
rc_len + sizeof(push_update_cmd) + con_len + 2) * sizeof(char), true, gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i =3D sizeof=
(push_update_cmd) -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(ret, p=
ush_update_cmd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ret[i++] =3D &#39;,&#39;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    strcpy(&amp;ret[i], src);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (continuation)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        i +=3D src_len;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        strcpy(&amp;ret[i], continuation);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static char *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+gc_strdup(const char *src, =
struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D=
 gc_malloc((strlen(src) + 1) * sizeof(char), true, gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    strcpy(ret, src);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* It split the messag=
ge (if necessay) and fill msgs with the message chunks.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Return `false` on failure an `true` =
on success.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+message_splitter(char *str, char=
 **msgs, struct gc_arena *gc, const int safe_cap)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!str || !*str)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int i =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int im =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    while (*str)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* + &#39;,&#39; - &#39;/0&#39; */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (strlen(str) &gt; safe_cap)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            int ci =3D find_first_comma=
_of_next_bundle(str, safe_cap);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (!ci)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                /* if no commas were found go to fail, do not send a=
ny message */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          str[ci] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            /* copy from i to (ci -1) */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            msgs[im] =3D forge_msg(str=
, &quot;,push-continuation 2&quot;, gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            i =3D ci + 1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if (im)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          msgs[im] =3D forge_msg(str, &quot;,push-continuation 1&quot;, gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                msgs[im] =3D forg=
e_msg(str, NULL, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        i =3D strlen(str);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     str =3D &amp;str[i];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        im++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* It actually send the already divided messagge to on=
e single client */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_sing=
le_push_update(struct context *c, char **msgs, unsigned int *option_types_f=
ound)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!msgs[0] || !*msgs[0])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int i =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    while (msgs[i] &amp;&amp; *msgs[i])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        struct buffer buf =3D alloc_buf_gc(str=
len(msgs[i]), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_wri=
te(&amp;buf, msgs[i], strlen(msgs[i]));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!send_control_channel_string(c, msgs[i], D_=
PUSH))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        i++;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        /* After sending the control message, we upda=
te the options server-side in the client&#39;s context */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        buf_string_compare_advance(&a=
mp;buf, push_update_cmd);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (process_incoming_push_update(c, pull_permission_mask(c), =
option_types_found, &amp;buf) =3D=3D PUSH_MSG_ERROR)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;Failed to process pus=
h update message sent to client ID: %u&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                c-&gt;c2.tls_multi ? c-&gt;c2.tls=
_multi-&gt;peer_id : UINT32_MAX);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            continue;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        c-&gt;options.push_option_types_found |=3D *option_types_foun=
d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!opti=
ons_postprocess_pull(&amp;c-&gt;options, c-&gt;c2.es))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;Failed to post-proce=
ss push update message sent to client ID: %u&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2.tls_multi ? c-&g=
t;c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+send_push_update(struct multi_context *m, const void *ta=
rget, const char *msg, const push_update_type type, const int push_bundle_s=
ize)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!msg || !*msg || !m</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        || (!target &amp;=
&amp; type !=3D UPT_BROADCAST))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return -EINVAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* extra s=
pace for possible trailing ifconfig and push-continuation */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const int extra =3D 84 + sizeo=
f(push_update_cmd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* push_bundle_size is the maximum size of a message, so if the message=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * we want to s=
end exceeds that size we have to split it into smaller messages */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const int safe_cap =3D p=
ush_bundle_size - extra;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int msgs_num =3D (strlen(msg) / safe_cap) + ((strlen(msg) % safe_c=
ap) !=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cha=
r **msgs =3D gc_malloc(sizeof(char *) * (msgs_num + 1), true, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int option=
_types_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msgs[msgs_num] =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!m=
essage_splitter(gc_strdup(msg, &amp;gc), msgs, &amp;gc, safe_cap))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (type =3D=3D UPT_BY_CID)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        struct multi_instance *mi =3D lookup_by_cid(m, *((uns=
igned long *)target));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!mi)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            return -ENOENT;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const char *old_ip =3D mi-&gt;context.opti=
ons.ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        const char *old_ipv6 =3D mi-&gt;context.options.ifconfig_ipv6_local=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!mi-&g=
t;halt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &=
amp;&amp; send_single_push_update(&amp;mi-&gt;context, msgs, &amp;option_ty=
pes_found))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (op=
tion_types_found &amp; OPT_P_UP)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                update_vhash(m, mi, old_ip, old_ipv6);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            return 1;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int count =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct hash_iterator hi;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const struct hash_element *he;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    hash_iterator_init(m-&gt;iter, &amp;hi);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    while ((he =3D hash_iterator_ne=
xt(&amp;hi)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct multi=
_instance *curr_mi =3D he-&gt;value;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (curr_mi-&gt;halt)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (type =3D=3D UPT_BY_ADDR &amp;&amp; !mroute_addr_equal(target, &amp;curr_m=
i-&gt;real))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            conti=
nue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (type =3D=
=3D UPT_BY_CN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            con=
st char *curr_cn =3D tls_common_name(curr_mi-&gt;context.c2.tls_multi, fals=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (=
strcmp(curr_cn, target))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               continue;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
Either we found a matching client or type is UPT_BROADCAST so we update eve=
ry client */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 option_types_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        const char *old_ip =3D curr_mi-&gt;context.options.ifconfig_=
local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const=
 char *old_ipv6 =3D curr_mi-&gt;context.options.ifconfig_ipv6_local;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!send_single_p=
ush_update(&amp;curr_mi-&gt;context, msgs, &amp;option_types_found))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;ERRO=
R: Peer ID: %u has not been updated&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                curr_mi-&gt;context.c2.tls_multi ? c=
urr_mi-&gt;context.c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (option_types_found &amp; OPT_P_U=
P)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            update_vhash(m,=
 curr_mi, old_ip, old_ipv6);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       count++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    hash_iterator_free(&amp;hi);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return count;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define RETURN_UPDATE_STATUS(n_sent) \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    do { \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if ((n_sent) &gt; 0) { \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;=
SUCCESS: %d client(s) updated&quot;, (n_sent)); \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return true; \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        } else { \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;ERROR: =
no client updated&quot;); \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            return false; \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        } \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    } while (0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+management_callback_send_push_update_broadcast(vo=
id *arg, const char *options)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
n_sent =3D send_push_update(arg, NULL, options, UPT_BROADCAST, PUSH_BUNDLE_=
SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    RETURN_UPDATE_STATUS(n_sent)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+management_callback_send_push_update_by_cid(void *arg, unsigned long c=
id, const char *options)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
=3D send_push_update(arg, &amp;cid, options, UPT_BY_CID, PUSH_BUNDLE_SIZE);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (ret =3D=3D -ENOENT)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ERROR: no client=
 found with CID: %lu&quot;, cid);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (ret &gt=
; 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+management_callback_send_push_update_by_cn(void *arg, const char *=
cn, const char *options)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n_sen=
t =3D send_push_update(arg, cn, options, UPT_BY_CN, PUSH_BUNDLE_SIZE);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    RETURN_UPDATE_STATUS(n_sent);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mana=
gement_callback_send_push_update_by_addr(void *arg, const struct mroute_add=
r *maddr, const char *options)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 n_sent =3D send_push_update(arg, maddr, options, UPT_BY_ADDR, PUSH_BUNDLE_=
SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    RETURN_UPDATE_STATUS(n_sent)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */=
</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/=
unit_tests/openvpn/Makefile.am</span><br><span>index b24e03c..9a40512 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><spa=
n>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br><span>@@ -343,4 +343=
,5 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platform.c \</span><br><s=
pan> 	$(top_srcdir)/src/openvpn/push_util.c \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/options_util.c \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	$(top_srcdir)/src/openvpn/otime.c</span><br><span>\ No newline a=
t end of file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top=
_srcdir)/src/openvpn/otime.c \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	$(top_srcdir)/src/openvpn/list.c</span><br><span>\ No newline a=
t end of file</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pu=
sh_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c</span><br=
><span>index d0876bc..38ea9a6 100644</span><br><span>--- a/tests/unit_tests=
/openvpn/test_push_update_msg.c</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_push_update_msg.c</span><br><span>@@ -8,6 +8,7 @@</span><br><span>=
 #include &lt;cmocka.h&gt;</span><br><span> #include &quot;push.h&quot;</sp=
an><br><span> #include &quot;options_util.h&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;multi.h&quot;</span><br><span>=
 </span><br><span> /* mocks */</span><br><span> </span><br><span>@@ -36,6 +=
37,18 @@</span><br><span>     return flags;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+update_vhash(struct multi_con=
text *m, struct multi_instance *mi, const char *old_ip, const char *old_ipv=
6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_postproces=
s_pull(struct options *options, struct env_set *es)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> bool</span><br><span> apply_push_options(struct context *c,</s=
pan><br><span>                    struct options *options,</span><br><span>=
@@ -94,6 +107,49 @@</span><br><span>     }</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_common_name(const =
struct tls_multi *multi, const bool null)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_MANAGEMENT</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+send_control_channel_string(struct context *c=
, const char *str, int msglevel)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* ifndef ENABLE_MA=
NAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char **r=
es;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int i;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+send_control_channel_string(struct context *c, const char *str,=
 int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (res &amp;&amp; =
res[i] &amp;&amp; strcmp(res[i], str))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        printf(&quot;\n\nexpected: %s\n\n  actual: %s\n\n&quot;, res[i=
], str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    i++;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct multi_instance *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+lookup_by_cid(struct multi_context *m, const unsigned long cid)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return *(m-&gt;instances);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mroute_ext=
ract_openvpn_sockaddr(struct mroute_addr *addr,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                const struct op=
envpn_sockaddr *osaddr,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                bool use_port)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /=
* ifndef ENABLE_MANAGEMENT */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> /* tests */</span><br><span> </span><br><span> =
static void</span><br><span>@@ -124,7 +180,6 @@</span><br><span>     free_b=
uf(&amp;buf);</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span>=
 test_incoming_push_message_error2(void **state)</span><br><span> {</span><=
br><span>@@ -209,6 +264,207 @@</span><br><span>     free_buf(&amp;buf);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+char *r0[] =3D {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;PUSH_UPDATE,redirect-gateway local,route 192.168.=
1.0 255.255.255.0&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *r1[] =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH=
_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalala=
lalalaf,push-continuation 2&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option=
 DNS 8.8.8.8,redirect-gateway local,push-continuation 2&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,route 192.=
168.1.0 255.255.255.0,push-continuation 1&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+char *r3[] =3D {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &quot;PUSH_UPDATE,,,&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+char *r4[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;PUSH_UPDATE,-dhcp-option, blablalalalalalalalalalalalalf, lalalala=
lalalalalalalalalalaf,push-continuation 2&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, akakakakakakakakakakaka=
f,dhcp-option DNS 8.8.8.8, redirect-gateway local,push-continuation 2&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPD=
ATE, route 192.168.1.0 255.255.255.0,,push-continuation 1&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+char *r5[] =3D {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,,-dhcp-option, blablalalalala=
lalalalalalalalf, lalalalalalalalalalalalalalaf,push-continuation 2&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDAT=
E, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redirect-gateway local=
,push-continuation 2&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &quot;PUSH_UPDATE, route 192.168.1.0 255.255.255.0,push-continu=
ation 1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+char *r6[] =3D {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,-dhc=
p-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push=
-continuation 2&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &quot;PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8=
, redirect-gateway 10.10.10.10,,push-continuation 2&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, route 192.168=
.1.0 255.255.255.0,,push-continuation 1&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+char *r7[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    &quot;PUSH_UPDATE,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,=
,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,push-continuation 2&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,,,,,=
,,,,,,,,,,,,,,push-continuation 1&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+char *r8[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &quot;PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalala=
lalalalalalalalalalaf,push-continuation 2&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, akakakakakakakakakakaka=
f, dhcp-option DNS 8.8.8.8,redirect-gateway\n local,push-continuation 2&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_U=
PDATE,route 192.168.1.0 255.255.255.0\n\n\n,push-continuation 1&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+char *r9[] =3D {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,,&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *ms=
g0 =3D &quot;redirect-gateway local,route 192.168.1.0 255.255.255.0&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *msg1 =3D=
 &quot;-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalal=
alalaf,&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
             &quot; akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,redir=
ect-gateway local,route 192.168.1.0 255.255.255.0&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+const char *msg2 =3D &quot;&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *msg3 =3D &q=
uot;,,&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const =
char *msg4 =3D &quot;-dhcp-option, blablalalalalalalalalalalalalf, lalalala=
lalalalalalalalalalaf,&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                   &quot; akakakakakakakakakakakaf,dhcp-option DNS=
 8.8.8.8, redirect-gateway local, route 192.168.1.0 255.255.255.0,&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *msg5 =3D =
&quot;,-dhcp-option, blablalalalalalalalalalalalalf, lalalalalalalalalalala=
lalalaf,&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
              &quot; akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redi=
rect-gateway local, route 192.168.1.0 255.255.255.0&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+const char *msg6 =3D &quot;-dhcp-opt=
ion,blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf, akakakak=
akakakakakakakaf,&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                   &quot; dhcp-option DNS 8.8.8.8, redirect-gateway 10.=
10.10.10,, route 192.168.1.0 255.255.255.0,&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+const char *msg7 =3D &quot;,,,,,,,,,,,,,,,,,=
,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,=
,,,,,,,,,,,,,,&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+const char *msg8 =3D &quot;-dhcp-option,blablalalalalalalalalalalalalf, l=
alalalalalalalalalalalalalaf, akakakakakakakakakakakaf,&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                   &quot; dhcp-op=
tion DNS 8.8.8.8,redirect-gateway\n local,route 192.168.1.0 255.255.255.0\n=
\n\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const ch=
ar *msg9 =3D &quot;,&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char =
*msg10 =3D &quot;abandon ability able about above absent absorb abstract ab=
surd abuse access accident account accuse achieve&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    &quot;acid acoustic=
 acquire across act action actor actress actual adapt add addict address ad=
just&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           &quot;baby bachelor bacon badge bag balance balcony ball bamboo =
banana banner bar barely bargain barrel base basic&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    &quot;basket battl=
e beach bean beauty because become beef before begin behave behind&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &q=
uot;cabbage cabin cable cactus cage cake call calm camera camp can canal ca=
ncel candy cannon canoe canvas canyon&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    &quot;capable capital captain c=
ar carbon card cargo carpet carry cart case&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    &quot;daisy damage damp d=
ance danger daring dash daughter dawn day deal debate debris decade decembe=
r decide decline&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    &quot;decorate decrease deer defense define defy deg=
ree delay deliver demand demise denial&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define PUSH_BUNDLE_SIZE_TEST 184</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_s=
end_push_msg0(void **state)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i =3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res =3D r0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_cont=
ext *m =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const unsigned long cid =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(send_push_update(m, &amp;cid, msg0, UPT_=
BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_send_=
push_msg1(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res =3D r1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context =
*m =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst unsigned long cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(send_push_update(m, &amp;cid, msg1, UPT_BY_C=
ID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_send_push_msg2(void **state)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    res =3D NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct multi_context *m =3D *state;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned long ci=
d =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(send_push_update(m, &amp;cid, msg2, UPT_BY_CID, PUSH_BUNDLE_SIZE_=
TEST), -EINVAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_send_push_msg3(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    i =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    res =3D r3;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct multi_context *m =3D *state;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const unsigned long cid =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(send_=
push_update(m, &amp;cid, msg3, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_send_push_msg4(void **state)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
res =3D r4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct multi_context *m =3D *state;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const unsigned long cid =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(send_push_update(m, &amp;ci=
d, msg4, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_send_push_m=
sg5(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    res =3D r5;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D=
 *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const u=
nsigned long cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(send_push_update(m, &amp;cid, msg5, UPT_BY_CID, PU=
SH_BUNDLE_SIZE_TEST), 1);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_send_push_msg6(void **state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    res =3D r6;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct multi_context *m =3D *state;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const unsigned long cid =3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(send_push_update(m, &amp;cid, msg6, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST),=
 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_send_push_msg7(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    res =3D r7;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct multi_context *m =3D *state;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const unsigned long cid =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(send_push_update(m,=
 &amp;cid, msg7, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_sen=
d_push_msg8(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res =3D r8;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_contex=
t *m =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const unsigned long cid =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(send_push_update(m, &amp;cid, msg8, UPT_BY=
_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+test_send_push_msg9(void **stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    res =3D r9;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D *state;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned long c=
id =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(send_push_update(m, &amp;cid, msg9, UPT_BY_CID, PUSH_BUNDLE_SIZE=
_TEST), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_send_push_msg10(void **state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    i =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    res =3D NULL;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct multi_context *m =3D *state;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const unsigned long cid =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(send_push=
_update(m, &amp;cid, msg10, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), -EINVAL);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#undef PUSH_BUNDLE_SIZE_TEST</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+se=
tup2(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_co=
ntext *m =3D calloc(1, sizeof(struct multi_context));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    m-&gt;instances =3D calloc(1, sizeof(=
struct multi_instance *));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct multi_instance *mi =3D calloc(1, sizeof(struct multi_inst=
ance));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *(m-&gt;=
instances) =3D mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   *state =3D m;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+teardown2(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct multi_context *m =3D *state;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    free(*(m-&gt;instances));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    free(m-&gt;instances);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    free(m);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> static int</span><br><span> =
setup(void **state)</span><br><span> {</span><br><span>@@ -238,7 +494,20 @@=
</span><br><span>         cmocka_unit_test_setup_teardown(test_incoming_pus=
h_message_1, setup, teardown),</span><br><span>         cmocka_unit_test_se=
tup_teardown(test_incoming_push_message_bad_format, setup, teardown),</span=
><br><span>         cmocka_unit_test_setup_teardown(test_incoming_push_mess=
age_mix, setup, teardown),</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        cmocka_unit_test_setup_teardown(test_incoming_push_message_mix=
2, setup, teardown)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        cmocka_unit_test_setup_teardown(test_incoming_push_message_mix2, se=
tup, teardown),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifd=
ef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test_setup_teardown(test_send_push_msg0, setup2, teard=
own2),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmock=
a_unit_test_setup_teardown(test_send_push_msg1, setup2, teardown2),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_se=
tup_teardown(test_send_push_msg2, setup2, teardown2),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(t=
est_send_push_msg3, setup2, teardown2),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_send_push_=
msg4, setup2, teardown2),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cmocka_unit_test_setup_teardown(test_send_push_msg5, setup2, =
teardown2),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test_setup_teardown(test_send_push_msg6, setup2, teardown2),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st_setup_teardown(test_send_push_msg7, setup2, teardown2),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teard=
own(test_send_push_msg8, setup2, teardown2),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_send_=
push_msg9, setup2, teardown2),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test_setup_teardown(test_send_push_msg10, se=
tup2, teardown2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span>     };</span><br><span> </span><br><span>     return c=
mocka_run_group_tests(tests, NULL, NULL);</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869?usp=
=3Demail">change 869</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie82bcc7a8e583de9156b185d71d=
1a323ed8df3fc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 869 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--DVcGvDNSu0o=--

