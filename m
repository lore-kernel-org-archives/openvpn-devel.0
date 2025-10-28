From: Gert Doering <gert@...1296...>
Date: Tue, 28 Oct 2025 19:39:35 +0100
Message-ID: <20251028183945.31901-1-gert@...1296...>
In-Reply-To: <gerrit.1760967063000.I2554b9baec6af191b0adb137e64124586dc4331c@...2715...>
References: <gerrit.1760967063000.I2554b9baec6af191b0adb137e64124586dc4331c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] gremlin: Avoid some conversion warnings
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

We know these casts are safe, so make
them explicit.

Change-Id: I2554b9baec6af191b0adb137e64124586dc4331c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1286
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1286
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index 0e5e93f..a3dbff1 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -98,11 +98,6 @@
     return (get_random() % n) == 0;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Return uniformly distributed random number between
  * low and high.
@@ -112,7 +107,7 @@
 {
     int ret;
     ASSERT(low <= high);
-    ret = low + (get_random() % (high - low + 1));
+    ret = low + (int)(get_random() % (high - low + 1));
     ASSERT(ret >= low && ret <= high);
     return ret;
 }
@@ -195,7 +190,7 @@
             {
                 if (buf->len > 0)
                 {
-                    uint8_t r = roll(0, 255);
+                    uint8_t r = (uint8_t)roll(0, 255);
                     int method = roll(0, 5);
 
                     switch (method)
@@ -235,8 +230,4 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* ifdef ENABLE_DEBUG */

