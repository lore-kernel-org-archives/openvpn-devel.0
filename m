From: Gert Doering <gert@...1296...>
Date: Thu, 12 Mar 2026 08:41:18 +0100
Message-ID: <20260312074123.30838-1-gert@...1296...>
In-Reply-To: <gerrit.1769789455000.I96b6acffd7e5149d4c9488a06e43c62711b31cfc@...2715...>
References: <gerrit.1769789455000.I96b6acffd7e5149d4c9488a06e43c62711b31cfc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] error: Use SOCKET_UNDEFINED instead of
 -1 to avoid sign error on Windows
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

While here also mark a comparison we know is safe
with an explicit cast.

Change-Id: I96b6acffd7e5149d4c9488a06e43c62711b31cfc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1501
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1501
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 6fb4f32..2900352 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -97,15 +97,10 @@
     forked = true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 bool
 set_debug_level(const int level, const unsigned int flags)
 {
-    if (level >= 0 && level <= M_DEBUG_LEVEL)
+    if (level >= 0 && (unsigned int)level <= M_DEBUG_LEVEL)
     {
         x_debug_level = (msglvl_t)level;
         return true;
@@ -118,10 +113,6 @@
     return false;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 set_mute_cutoff(const int cutoff)
 {
@@ -621,11 +612,6 @@
     x_cs_verbose_level = verbose_level;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * Called after most socket or tun/tap operations, via the inline
  * function check_status().
@@ -674,15 +660,22 @@
         {
             if (extended_msg)
             {
-                msg(x_cs_info_level, "%s %s [%s]: %s (fd=" SOCKET_PRINTF ",code=%d)", description,
-                    sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "", extended_msg,
-                    openvpn_strerror(my_errno, crt_error, &gc), sock ? sock->sd : -1, my_errno);
+                msg(x_cs_info_level, "%s %s [%s]: %s (fd=" SOCKET_PRINTF ",code=%d)",
+                    description,
+                    sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "",
+                    extended_msg,
+                    openvpn_strerror(my_errno, crt_error, &gc),
+                    sock ? sock->sd : SOCKET_UNDEFINED,
+                    my_errno);
             }
             else
             {
-                msg(x_cs_info_level, "%s %s: %s (fd=" SOCKET_PRINTF ",code=%d)", description,
+                msg(x_cs_info_level, "%s %s: %s (fd=" SOCKET_PRINTF ",code=%d)",
+                    description,
                     sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "",
-                    openvpn_strerror(my_errno, crt_error, &gc), sock ? sock->sd : -1, my_errno);
+                    openvpn_strerror(my_errno, crt_error, &gc),
+                    sock ? sock->sd : SOCKET_UNDEFINED,
+                    my_errno);
             }
 
             if (x_cs_err_delay_ms)
@@ -694,10 +687,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * In multiclient mode, put a client-specific prefix
  * before each message.

