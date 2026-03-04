From: Gert Doering <gert@...1296...>
Date: Wed,  4 Mar 2026 17:48:58 +0100
Message-ID: <20260304164904.15743-1-gert@...1296...>
In-Reply-To: <gerrit.1769789455000.I7be033bc88e9a6ba474916c8be039c126e8bc574@...2715...>
References: <gerrit.1769789455000.I7be033bc88e9a6ba474916c8be039c126e8bc574@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] push: Improve check of vsnprintf return
 value
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

Avoid sign-compare warning and do not ignore error
return values.

Change-Id: I7be033bc88e9a6ba474916c8be039c126e8bc574
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1502
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1502
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d13b24a..a948973 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -800,11 +800,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 bool
 send_push_reply(struct context *c, struct push_list *per_client_push_list)
 {
@@ -936,7 +931,7 @@
     va_start(arglist, format);
     len = vsnprintf(tmp, sizeof(tmp), format, arglist);
     va_end(arglist);
-    if (len > sizeof(tmp) - 1)
+    if (len < 0 || len >= (int)sizeof(tmp))
     {
         return false;
     }
@@ -944,10 +939,6 @@
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 push_reset(struct options *o)
 {

