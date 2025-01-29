From: Gert Doering <gert@...1296...>
Date: Wed, 29 Jan 2025 12:16:05 +0100
Message-ID: <20250129111605.9538-1-gert@...1296...>
In-Reply-To: <gerrit.1738072669000.I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1@...2715...>
References: <gerrit.1738072669000.I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] mroute/management: fix uninitialized
 variable (UNINIT)
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

From: Gianmarco De Gregori <gianmarco@...2726...>

Fix issue reported by Coverity:
CID 1641564: Uninitialized variables (UNINIT)
Using unitialized value "maddr.proto" when
calling "mroute_addr_equal()".

Fix this by passing the proto along with
IP:port.

While at it, changed the
mroute_addr_print_ex() format to display
the protocol only in case of MR_WITH_PROTO
avoid doing it on virtual addresses when
MR_WITH_PORT is not specified.

Change-Id: I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/880
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/Changes.rst b/Changes.rst
index 16ae6fc..d01816b 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -317,6 +317,9 @@
   settings will contradict the setting of allow-compression as this almost
   always results in a non-working connection.
 
+- The "kill" by addr management command now requires also the protocol
+  as string e.g. "udp", "tcp".
+
 Common errors with OpenSSL 3.0 and OpenVPN 2.6
 ----------------------------------------------
 Both OpenVPN 2.6 and OpenSSL 3.0 tighten the security considerable, so some
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index b55135a..f1d2930 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -205,8 +205,12 @@
 
   kill Test-Client -- kill the client instance having a
                       common name of "Test-Client".
-  kill 1.2.3.4:4000 -- kill the client instance having a
-                       source address and port of 1.2.3.4:4000
+  kill tcp:1.2.3.4:4000 -- kill the client instance having a
+                           source address, port and proto of
+                           tcp:1.2.3.4:4000
+
+  Note that kill by address won't work for IPv6-connected
+  clients yet, so rely on kill by CN or CID instead.
 
 Use the "status" command to see which clients are connected.
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0c77f85..a796dbe 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -544,45 +544,52 @@
         struct buffer buf;
         char p1[128];
         char p2[128];
+        char p3[128];
         int n_killed;
 
         buf_set_read(&buf, (uint8_t *) victim, strlen(victim) + 1);
         buf_parse(&buf, ':', p1, sizeof(p1));
         buf_parse(&buf, ':', p2, sizeof(p2));
+        buf_parse(&buf, ':', p3, sizeof(p3));
 
-        if (strlen(p1) && strlen(p2))
+        if (strlen(p1) && strlen(p2) && strlen(p3))
         {
             /* IP:port specified */
             bool status;
-            const in_addr_t addr = getaddr(GETADDR_HOST_ORDER|GETADDR_MSG_VIRT_OUT, p1, 0, &status, NULL);
+            const in_addr_t addr = getaddr(GETADDR_HOST_ORDER|GETADDR_MSG_VIRT_OUT, p2, 0, &status, NULL);
             if (status)
             {
-                const int port = atoi(p2);
-                if (port > 0 && port < 65536)
+                const int port = atoi(p3);
+                const int proto = (streq(p1, "tcp")) ? PROTO_TCP_SERVER :
+                                  (streq(p1, "udp")) ? PROTO_UDP : PROTO_NONE;
+
+                if ((port > 0 && port < 65536) && (proto != PROTO_NONE))
                 {
-                    n_killed = (*man->persist.callback.kill_by_addr)(man->persist.callback.arg, addr, port);
+                    n_killed = (*man->persist.callback.kill_by_addr)(man->persist.callback.arg, addr, port, proto);
                     if (n_killed > 0)
                     {
-                        msg(M_CLIENT, "SUCCESS: %d client(s) at address %s:%d killed",
+                        msg(M_CLIENT, "SUCCESS: %d client(s) at address %s:%s:%d killed",
                             n_killed,
+                            proto2ascii(proto, AF_INET, true),
                             print_in_addr_t(addr, 0, &gc),
                             port);
                     }
                     else
                     {
-                        msg(M_CLIENT, "ERROR: client at address %s:%d not found",
+                        msg(M_CLIENT, "ERROR: client at address %s:%s:%d not found",
+                            proto2ascii(proto, AF_INET, true),
                             print_in_addr_t(addr, 0, &gc),
                             port);
                     }
                 }
                 else
                 {
-                    msg(M_CLIENT, "ERROR: port number is out of range: %s", p2);
+                    msg(M_CLIENT, "ERROR: port number or protocol out of range: %s %s", p3, p1);
                 }
             }
             else
             {
-                msg(M_CLIENT, "ERROR: error parsing IP address: %s", p1);
+                msg(M_CLIENT, "ERROR: error parsing IP address: %s", p2);
             }
         }
         else if (strlen(p1))
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index f501543..02ceb82 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -180,7 +180,7 @@
     void (*status) (void *arg, const int version, struct status_output *so);
     void (*show_net) (void *arg, const int msglevel);
     int (*kill_by_cn) (void *arg, const char *common_name);
-    int (*kill_by_addr) (void *arg, const in_addr_t addr, const int port);
+    int (*kill_by_addr) (void *arg, const in_addr_t addr, const int port, const int proto);
     void (*delete_event) (void *arg, event_t event);
     int (*n_clients) (void *arg);
     bool (*send_cc_message) (void *arg, const char *message, const char *parameter);
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 74923cf..24b9543 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -276,6 +276,10 @@
                 addr->len = 6;
                 addr->v4.addr = osaddr->addr.in4.sin_addr.s_addr;
                 addr->v4.port = osaddr->addr.in4.sin_port;
+                if (addr->proto != PROTO_NONE)
+                {
+                    addr->type |= MR_WITH_PROTO;
+                }
             }
             else
             {
@@ -295,6 +299,10 @@
                 addr->len = 18;
                 addr->v6.addr = osaddr->addr.in6.sin6_addr;
                 addr->v6.port = osaddr->addr.in6.sin6_port;
+                if (addr->proto != PROTO_NONE)
+                {
+                    addr->type |= MR_WITH_PROTO;
+                }
             }
             else
             {
@@ -403,6 +411,10 @@
                 {
                     buf_printf(&out, "ARP/");
                 }
+                if (maddr.type & MR_WITH_PROTO)
+                {
+                    buf_printf(&out, "%s:", proto2ascii(maddr.proto, AF_INET, false));
+                }
                 buf_printf(&out, "%s", print_in_addr_t(ntohl(maddr.v4.addr),
                                                        (flags & MAPF_IA_EMPTY_IF_UNDEF) ? IA_EMPTY_IF_UNDEF : 0, gc));
                 if (maddr.type & MR_WITH_NETBITS)
@@ -426,6 +438,10 @@
 
             case MR_ADDR_IPV6:
             {
+                if (maddr.type & MR_WITH_PROTO)
+                {
+                    buf_printf(&out, "%s:", proto2ascii(maddr.proto, AF_INET6, false));
+                }
                 if (IN6_IS_ADDR_V4MAPPED( &maddr.v6.addr ) )
                 {
                     buf_printf(&out, "%s", print_in_addr_t(maddr.v4mappedv6.addr,
@@ -454,7 +470,6 @@
                 buf_printf(&out, "UNKNOWN");
                 break;
         }
-        buf_printf(&out, "|%d", maddr.proto);
         return BSTR(&out);
     }
     else
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 2659695..fbe102a 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -72,6 +72,9 @@
 /* Indicates than IPv4 addr was extracted from ARP packet */
 #define MR_ARP                   16
 
+/* Address type mask indicating that proto # is part of address */
+#define MR_WITH_PROTO            32
+
 struct mroute_addr {
     uint8_t len;    /* length of address */
     uint8_t proto;
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 62ed044..9a8b1cb 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -111,6 +111,7 @@
     ASSERT(mi->context.c2.link_sockets[0]->info.lsa->actual.dest.addr.sa.sa_family == AF_INET
            || mi->context.c2.link_sockets[0]->info.lsa->actual.dest.addr.sa.sa_family == AF_INET6
            );
+    mi->real.proto = mi->context.c2.link_sockets[0]->info.proto;
     if (!mroute_extract_openvpn_sockaddr(&mi->real,
                                          &mi->context.c2.link_sockets[0]->info.lsa->actual.dest,
                                          true))
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9c8c014..b0e1941 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -794,7 +794,6 @@
         {
             goto err;
         }
-        mi->real.proto = ls->info.proto;
         generate_prefix(mi);
     }
 
@@ -3942,7 +3941,8 @@
 }
 
 static int
-management_callback_kill_by_addr(void *arg, const in_addr_t addr, const int port)
+management_callback_kill_by_addr(void *arg, const in_addr_t addr,
+                                 const int port, const int proto)
 {
     struct multi_context *m = (struct multi_context *) arg;
     struct hash_iterator hi;
@@ -3957,6 +3957,7 @@
     saddr.addr.in4.sin_port = htons(port);
     if (mroute_extract_openvpn_sockaddr(&maddr, &saddr, true))
     {
+        maddr.proto = proto;
         hash_iterator_init(m->iter, &hi);
         while ((he = hash_iterator_next(&hi)))
         {

