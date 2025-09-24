From: Gert Doering <gert@...1296...>
Date: Wed, 24 Sep 2025 16:57:09 +0200
Message-ID: <20250924145715.28701-1-gert@...1296...>
In-Reply-To: <gerrit.1757601342000.Ie8a242838b6f8b42f36327c33fc62bb5f94ec43f@...2715...>
References: <gerrit.1757601342000.Ie8a242838b6f8b42f36327c33fc62bb5f94ec43f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] event: Silence conversion warning in
 tv_to_ms_timeout
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

The APIs want int (at least on unixy systems), so we
use int. max_int() protects us against negative values.

Change-Id: Ie8a242838b6f8b42f36327c33fc62bb5f94ec43f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1178
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1178
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 2f60b78..ca84d19 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -65,11 +65,15 @@
 #define SELECT_MAX_FDS 256
 #endif
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
+/** Convert \c timeval value (which is in seconds and microseconds)
+    to a value of milliseconds which is required by multiple polling
+    APIs.
 
+    @param tv \c timeval to convert
+
+    @return Milliseconds to wait. Zero if \p tv is zero.
+     Otherwise the return value is always greater than zero.
+*/
 static inline int
 tv_to_ms_timeout(const struct timeval *tv)
 {
@@ -79,14 +83,11 @@
     }
     else
     {
-        return max_int(tv->tv_sec * 1000 + (tv->tv_usec + 500) / 1000, 1);
+        /* might overflow but not for practically useful numbers */
+        return max_int((int)(tv->tv_sec * 1000 + (tv->tv_usec + 500) / 1000), 1);
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #ifdef _WIN32
 
 struct we_set

