From: Gert Doering <gert@...1296...>
Date: Tue,  4 Nov 2025 10:19:35 +0100
Message-ID: <20251104091940.10826-1-gert@...1296...>
In-Reply-To: <gerrit.1761324750000.I3309265edf8d6bea7bd73b21eef589a92ede6e0a@...2715...>
References: <gerrit.1761324750000.I3309265edf8d6bea7bd73b21eef589a92ede6e0a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] ssl: Clean up type handling in
 write_string()
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

Make better checks for the maxlen input value.

Change-Id: I3309265edf8d6bea7bd73b21eef589a92ede6e0a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1300
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1300
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d177730..e03b81e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1780,20 +1780,16 @@
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static bool
 write_string(struct buffer *buf, const char *str, const int maxlen)
 {
-    const int len = strlen(str) + 1;
-    if (len < 1 || (maxlen >= 0 && len > maxlen))
+    const size_t len = strlen(str) + 1;
+    const size_t real_maxlen = (maxlen >= 0 && maxlen <= UINT16_MAX) ? (size_t)maxlen : UINT16_MAX;
+    if (len > real_maxlen)
     {
         return false;
     }
-    if (!buf_write_u16(buf, len))
+    if (!buf_write_u16(buf, (uint16_t)len))
     {
         return false;
     }
@@ -1833,6 +1829,11 @@
     return len;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static char *
 read_string_alloc(struct buffer *buf)
 {

