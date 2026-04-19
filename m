From: Gert Doering <gert@...1296...>
Date: Sun, 19 Apr 2026 15:39:41 +0200
Message-ID: <20260419133947.21215-1-gert@...1296...>
In-Reply-To: <gerrit.1775421558000.I87c40dc94035345add1162e5029e51288811cb09@...2715...>
References: <gerrit.1775421558000.I87c40dc94035345add1162e5029e51288811cb09@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] tapctl: Remove unused function dont_mute
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

Identified by cppcheck.

Change-Id: I87c40dc94035345add1162e5029e51288811cb09
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1615
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1615
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/tapctl/error.h b/src/tapctl/error.h
index 9632b2f..f9586dc 100644
--- a/src/tapctl/error.h
+++ b/src/tapctl/error.h
@@ -109,11 +109,11 @@
     return (level & M_DEBUG_LEVEL) <= x_debug_level;
 }
 
-/** Return true if flags represent and enabled, not muted log level */
+/** Return true if flags represent */
 static inline bool
 msg_test(unsigned int flags)
 {
-    return check_debug_level(flags) && dont_mute(flags);
+    return check_debug_level(flags);
 }
 
 #endif /* ifndef ERROR_H */
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 1d047dd..6a4a240 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -686,15 +686,6 @@
 }
 
 
-bool
-dont_mute(unsigned int flags)
-{
-    UNREFERENCED_PARAMETER(flags);
-
-    return true;
-}
-
-
 void
 x_msg_va(const unsigned int flags, const char *format, va_list arglist)
 {

