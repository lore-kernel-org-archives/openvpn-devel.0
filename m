From: Gert Doering <gert@...1296...>
Date: Fri, 17 Oct 2025 22:38:24 +0200
Message-ID: <20251017203830.23807-1-gert@...1296...>
In-Reply-To: <gerrit.1760698129000.I348abec1e2f32301a0368d5f541e67bddf358bbc@...2715...>
References: <gerrit.1760698129000.I348abec1e2f32301a0368d5f541e67bddf358bbc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] push_util: Make send_push_update static
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

Not necessary to make it non-static just for UTs.

Change-Id: I348abec1e2f32301a0368d5f541e67bddf358bbc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1282
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1282
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index b773dcb..23fb4a5 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -889,7 +889,6 @@
     target_sources(test_push_update_msg PRIVATE
         tests/unit_tests/openvpn/mock_msg.c
         tests/unit_tests/openvpn/mock_get_random.c
-        src/openvpn/push_util.c
         src/openvpn/options_util.c
         src/openvpn/otime.c
         src/openvpn/list.c
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 6b3275e..fa72732 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -139,23 +139,6 @@
 void receive_auth_pending(struct context *c, const struct buffer *buffer);
 
 #ifdef ENABLE_MANAGEMENT
-/**
- * @brief A function to send a PUSH_UPDATE control message from server to client(s).
- *
- * @param m the multi_context, contains all the clients connected to this server.
- * @param target the target to which to send the message. It should be:
- * `NULL` if `type == UPT_BROADCAST`,
- * a `mroute_addr *` if `type == UPT_BY_ADDR`,
- * a `char *` if `type == UPT_BY_CN`,
- * an `unsigned long *` if `type == UPT_BY_CID`.
- * @param msg a string containing the options to send.
- * @param type the way to address the message (broadcast, by cid, by cn, by address).
- * @param push_bundle_size the maximum size of a bundle of pushed option. Just use PUSH_BUNDLE_SIZE macro.
- * @return the number of clients to which the message was sent.
- */
-int
-send_push_update(struct multi_context *m, const void *target, const char *msg, const push_update_type type, const int push_bundle_size);
-
 bool management_callback_send_push_update_broadcast(void *arg, const char *options);
 
 bool management_callback_send_push_update_by_cid(void *arg, unsigned long cid, const char *options);
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 25c6ebe..06b4c8b 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -204,7 +204,21 @@
     return true;
 }
 
-int
+/**
+ * @brief A function to send a PUSH_UPDATE control message from server to client(s).
+ *
+ * @param m the multi_context, contains all the clients connected to this server.
+ * @param target the target to which to send the message. It should be:
+ * `NULL` if `type == UPT_BROADCAST`,
+ * a `mroute_addr *` if `type == UPT_BY_ADDR`,
+ * a `char *` if `type == UPT_BY_CN`,
+ * an `unsigned long *` if `type == UPT_BY_CID`.
+ * @param msg a string containing the options to send.
+ * @param type the way to address the message (broadcast, by cid, by cn, by address).
+ * @param push_bundle_size the maximum size of a bundle of pushed option. Just use PUSH_BUNDLE_SIZE macro.
+ * @return The number of clients to which the message was sent. Might return < 0 in case of error.
+ */
+static int
 send_push_update(struct multi_context *m, const void *target, const char *msg, const push_update_type type, const int push_bundle_size)
 {
     if (dco_enabled(&m->top.options))
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 17aa0ce..997703a 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -356,7 +356,6 @@
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/platform.c \
-	$(top_srcdir)/src/openvpn/push_util.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
 	$(top_srcdir)/src/openvpn/otime.c \
 	$(top_srcdir)/src/openvpn/list.c
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
index 60596ed..91b60ba 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -10,6 +10,8 @@
 #include "options_util.h"
 #include "multi.h"
 
+#include "push_util.c"
+
 /* mocks */
 
 void

