From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 28 Feb 2025 18:02:32 +0100
Message-Id: <20250228170232.322186-1-frank@...2641...>
In-Reply-To: <gerrit.1736860439000.I925accd8267f94ecfd9ccea85bae965dc2a10208@...2715...>
References: <gerrit.1736860439000.I925accd8267f94ecfd9ccea85bae965dc2a10208@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Add more "intentional fallthrough"
 comments
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

To make it easier to exclude them from compiler
warnings.

Based on the existing comment in init.c

Change-Id: I925accd8267f94ecfd9ccea85bae965dc2a10208
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/864
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 69f1510..6987def 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -437,34 +437,44 @@
     {
         case 11:
             c += ((uint32_t) k[10] << 24);
+        /* Intentional [[fallthrough]]; */
 
         case 10:
             c += ((uint32_t) k[9] << 16);
+        /* Intentional [[fallthrough]]; */
 
         case 9:
             c += ((uint32_t) k[8] << 8);
+        /* Intentional [[fallthrough]]; */
 
         /* the first byte of c is reserved for the length */
         case 8:
             b += ((uint32_t) k[7] << 24);
+        /* Intentional [[fallthrough]]; */
 
         case 7:
             b += ((uint32_t) k[6] << 16);
+        /* Intentional [[fallthrough]]; */
 
         case 6:
             b += ((uint32_t) k[5] << 8);
+        /* Intentional [[fallthrough]]; */
 
         case 5:
             b += k[4];
+        /* Intentional [[fallthrough]]; */
 
         case 4:
             a += ((uint32_t) k[3] << 24);
+        /* Intentional [[fallthrough]]; */
 
         case 3:
             a += ((uint32_t) k[2] << 16);
+        /* Intentional [[fallthrough]]; */
 
         case 2:
             a += ((uint32_t) k[1] << 8);
+        /* Intentional [[fallthrough]]; */
 
         case 1:
             a += k[0];
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index ddad109..914f520 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -98,6 +98,7 @@
 
             case AR_INTERACT:
                 ssl_purge_auth(false);
+            /* Intentional [[fallthrough]]; */
 
             case AR_NOINTERACT:
                 /* SOFT-SIGTUSR1 -- Auth failure error */

