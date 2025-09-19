From: Gert Doering <gert@...1296...>
Date: Fri, 19 Sep 2025 17:40:34 +0200
Message-ID: <20250919154040.17684-1-gert@...1296...>
In-Reply-To: <gerrit.1754490554000.I5ef21e425786a49c90d4b7305c3fb174ab6ddf92@...2715...>
References: <gerrit.1754490554000.I5ef21e425786a49c90d4b7305c3fb174ab6ddf92@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] socket: Change resolve flags to unsigned
 int
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

And use them consistently so to avoid conversion
warnings.

Change-Id: I5ef21e425786a49c90d4b7305c3fb174ab6ddf92
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1131
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1131
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 306170c..e362e5e 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -245,10 +245,10 @@
  */
 static int
 get_cached_dns_entry(struct cached_dns_entry *dns_cache, const char *hostname, const char *servname,
-                     int ai_family, int resolve_flags, struct addrinfo **ai)
+                     int ai_family, unsigned int resolve_flags, struct addrinfo **ai)
 {
     struct cached_dns_entry *ph;
-    int flags;
+    unsigned int flags;
 
     /* Only use flags that are relevant for the structure */
     flags = resolve_flags & GETADDR_CACHE_MASK;
@@ -268,7 +268,7 @@
 
 static int
 do_preresolve_host(struct context *c, const char *hostname, const char *servname, const int af,
-                   const int flags)
+                   const unsigned int flags)
 {
     struct addrinfo *ai;
     int status;
@@ -322,7 +322,7 @@
     {
         int status;
         const char *remote;
-        int flags = preresolve_flags;
+        unsigned int flags = preresolve_flags;
 
         struct connection_entry *ce = l->array[i];
 
@@ -1185,7 +1185,7 @@
     /* resolve local address if undefined */
     if (!sock->info.lsa->bind_local)
     {
-        int flags = GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL | GETADDR_PASSIVE;
+        unsigned int flags = GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL | GETADDR_PASSIVE;
         int status;
 
         if (proto_is_dgram(sock->info.proto))
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index cce9183..e45981f 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -67,7 +67,7 @@
     const char *hostname;
     const char *servname;
     int ai_family;
-    int flags;
+    unsigned int flags;
     struct addrinfo *ai;
     struct cached_dns_entry *next;
 };
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index 5ea37dd..801fbfa 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -114,18 +114,18 @@
  * DNS resolution
  */
 
-#define GETADDR_RESOLVE                 (1 << 0)
-#define GETADDR_FATAL                   (1 << 1)
-#define GETADDR_HOST_ORDER              (1 << 2)
-#define GETADDR_MENTION_RESOLVE_RETRY   (1 << 3)
-#define GETADDR_FATAL_ON_SIGNAL         (1 << 4)
-#define GETADDR_WARN_ON_SIGNAL          (1 << 5)
-#define GETADDR_MSG_VIRT_OUT            (1 << 6)
-#define GETADDR_TRY_ONCE                (1 << 7)
-#define GETADDR_UPDATE_MANAGEMENT_STATE (1 << 8)
-#define GETADDR_RANDOMIZE               (1 << 9)
-#define GETADDR_PASSIVE                 (1 << 10)
-#define GETADDR_DATAGRAM                (1 << 11)
+#define GETADDR_RESOLVE                 (1u << 0)
+#define GETADDR_FATAL                   (1u << 1)
+#define GETADDR_HOST_ORDER              (1u << 2)
+#define GETADDR_MENTION_RESOLVE_RETRY   (1u << 3)
+#define GETADDR_FATAL_ON_SIGNAL         (1u << 4)
+#define GETADDR_WARN_ON_SIGNAL          (1u << 5)
+#define GETADDR_MSG_VIRT_OUT            (1u << 6)
+#define GETADDR_TRY_ONCE                (1u << 7)
+#define GETADDR_UPDATE_MANAGEMENT_STATE (1u << 8)
+#define GETADDR_RANDOMIZE               (1u << 9)
+#define GETADDR_PASSIVE                 (1u << 10)
+#define GETADDR_DATAGRAM                (1u << 11)
 
 #define GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)
 

