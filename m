From: Gert Doering <gert@...1296...>
Date: Fri, 17 Oct 2025 22:49:09 +0200
Message-ID: <20251017204914.7548-1-gert@...1296...>
In-Reply-To: <gerrit.1760698129000.I2d1fbe7ec080beb931253d09c1b5227e9bf4e756@...2715...>
References: <gerrit.1760698129000.I2d1fbe7ec080beb931253d09c1b5227e9bf4e756@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] ssl_util: Fix conversion warning in
 get_num_elements
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

Just use correct type.

Change-Id: I2d1fbe7ec080beb931253d09c1b5227e9bf4e756
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1281
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1281
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index 50e8c03..fb7cf3e 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -290,21 +290,16 @@
     return NULL;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 get_num_elements(const char *string, char delimiter)
 {
-    int string_len = strlen(string);
+    const size_t string_len = strlen(string);
 
     ASSERT(0 != string_len);
 
     int element_count = 1;
     /* Get number of ciphers */
-    for (int i = 0; i < string_len; i++)
+    for (size_t i = 0; i < string_len; i++)
     {
         if (string[i] == delimiter)
         {
@@ -314,7 +309,3 @@
 
     return element_count;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

