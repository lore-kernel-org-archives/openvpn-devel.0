From: Antonio Quartulli <a@...2181...>
Date: Sat, 19 Aug 2017 15:52:09 +0800
Message-Id: <20170819075209.28520-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] fix a couple of typ0s in comments and
 strings
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 configure.ac            | 2 +-
 src/openvpn/block_dns.h | 2 +-
 src/openvpn/buffer.h    | 2 +-
 src/openvpn/options.h   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 70660621..6f1044e8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -230,7 +230,7 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[werror],
-	[AS_HELP_STRING([--enable-werror], [promote compiler warnings to errors, will cause builds to fail is the compiler issues warnings (debugging option) @<:@default=no@:>@])],
+	[AS_HELP_STRING([--enable-werror], [promote compiler warnings to errors, will cause builds to fail if the compiler issues warnings (debugging option) @<:@default=no@:>@])],
 	,
 	[enable_werror="no"]
 )
diff --git a/src/openvpn/block_dns.h b/src/openvpn/block_dns.h
index c4b6693b..c9a9d708 100644
--- a/src/openvpn/block_dns.h
+++ b/src/openvpn/block_dns.h
@@ -26,7 +26,7 @@
 #ifndef OPENVPN_BLOCK_DNS_H
 #define OPENVPN_BLOCK_DNS_H
 
-/* Any value less than 5 should work fine. 3 is choosen without any real reason. */
+/* Any value less than 5 should work fine. 3 is chosen without any real reason. */
 #define BLOCK_DNS_IFACE_METRIC 3
 
 typedef void (*block_dns_msg_handler_t) (DWORD err, const char *msg);
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 8bc44287..1ed56316 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -91,7 +91,7 @@ struct gc_entry
 };
 
 /**
- * Gargabe collection entry for a specially allocated structure that needs
+ * Garbage collection entry for a specially allocated structure that needs
  * a custom free function to be freed like struct addrinfo
  *
  */
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 95ff4cda..41fc5b9e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -181,7 +181,7 @@ struct options
 
     /* enable forward compatibility for post-2.1 features */
     bool forward_compatible;
-    /* list of options that should be ignored even if unkown */
+    /* list of options that should be ignored even if unknown */
     const char **ignore_unknown_option;
 
     /* persist parms */
-- 
2.14.1


