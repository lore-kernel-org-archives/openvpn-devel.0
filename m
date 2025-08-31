From: Gert Doering <gert@...1296...>
Date: Sun, 31 Aug 2025 17:12:52 +0200
Message-ID: <20250831151259.25788-1-gert@...1296...>
In-Reply-To: <gerrit.1756402061000.Id3b8719ee6b457ce2d85156b39e0cea771a97e74@...2715...>
References: <gerrit.1756402061000.Id3b8719ee6b457ce2d85156b39e0cea771a97e74@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] socket_util: Clean up conversion
 warnings in add_in6_addr
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

Change-Id: Id3b8719ee6b457ce2d85156b39e0cea771a97e74
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1161
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c
index 13f8c32..9b7312d 100644
--- a/src/openvpn/socket_util.c
+++ b/src/openvpn/socket_util.c
@@ -241,14 +241,12 @@
 struct in6_addr
 add_in6_addr(struct in6_addr base, uint32_t add)
 {
-    int i;
-
-    for (i = 15; i >= 0 && add > 0; i--)
+    for (int i = 15; i >= 0 && add > 0; i--)
     {
-        register int carry;
+        register uint32_t carry;
         register uint32_t h;
 
-        h = (unsigned char)base.s6_addr[i];
+        h = base.s6_addr[i];
         base.s6_addr[i] = (h + add) & UINT8_MAX;
 
         /* using explicit carry for the 8-bit additions will catch

