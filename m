From: Gert Doering <gert@...1296...>
Date: Thu, 30 Oct 2025 19:29:12 +0100
Message-ID: <20251030182922.26448-1-gert@...1296...>
In-Reply-To: <gerrit.1761570487000.I750a0b8107baa77fb14558d0c8e4ef8020d62efd@...2715...>
References: <gerrit.1761570487000.I750a0b8107baa77fb14558d0c8e4ef8020d62efd@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] manage: Change kill_by_addr to use
 better types for port/proto
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

Change-Id: I750a0b8107baa77fb14558d0c8e4ef8020d62efd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1310
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1310
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 685b137..e46b5f2 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -608,14 +608,14 @@
             if (status)
             {
                 const int port = atoi(p3);
-                const int proto = (streq(p1, "tcp"))   ? PROTO_TCP_SERVER
-                                  : (streq(p1, "udp")) ? PROTO_UDP
-                                                       : PROTO_NONE;
+                const uint8_t proto = (streq(p1, "tcp"))   ? PROTO_TCP_SERVER
+                                      : (streq(p1, "udp")) ? PROTO_UDP
+                                                           : PROTO_NONE;
 
-                if ((port > 0 && port < 65536) && (proto != PROTO_NONE))
+                if ((port > 0 && port < UINT16_MAX) && (proto != PROTO_NONE))
                 {
                     n_killed = (*man->persist.callback.kill_by_addr)(man->persist.callback.arg,
-                                                                     addr, port, proto);
+                                                                     addr, (uint16_t)port, proto);
                     if (n_killed > 0)
                     {
                         msg(M_CLIENT, "SUCCESS: %d client(s) at address %s:%s:%d killed", n_killed,
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index fe460bf..dedcc15 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -178,7 +178,7 @@
     void (*status)(void *arg, const int version, struct status_output *so);
     void (*show_net)(void *arg, const msglvl_t msglevel);
     int (*kill_by_cn)(void *arg, const char *common_name);
-    int (*kill_by_addr)(void *arg, const in_addr_t addr, const int port, const int proto);
+    int (*kill_by_addr)(void *arg, const in_addr_t addr, const uint16_t port, const uint8_t proto);
     void (*delete_event)(void *arg, event_t event);
     int (*n_clients)(void *arg);
     bool (*send_cc_message)(void *arg, const char *message, const char *parameter);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 285671d..00637b1 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3951,7 +3951,7 @@
 }
 
 static int
-management_callback_kill_by_addr(void *arg, const in_addr_t addr, const int port, const int proto)
+management_callback_kill_by_addr(void *arg, const in_addr_t addr, const uint16_t port, const uint8_t proto)
 {
     struct multi_context *m = (struct multi_context *)arg;
     struct hash_iterator hi;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index e986c9c..832d62e 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -89,7 +89,7 @@
     const char *ipchange_command;
     const struct plugin_list *plugins;
     bool remote_float;
-    int proto;       /* Protocol (PROTO_x defined below) */
+    uint8_t proto;   /* Protocol (PROTO_x defined below) */
     sa_family_t af;  /* Address family like AF_INET, AF_INET6 or AF_UNSPEC*/
     bool bind_ipv6_only;
     int mtu_changed; /* Set to true when mtu value is changed */

