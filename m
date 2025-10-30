From: Gert Doering <gert@...1296...>
Date: Thu, 30 Oct 2025 20:38:20 +0100
Message-ID: <20251030193834.1186-1-gert@...1296...>
In-Reply-To: <gerrit.1761745430000.I648ee99b1152b1248d1b3e64af7679ab99f1388f@...2715...>
References: <gerrit.1761745430000.I648ee99b1152b1248d1b3e64af7679ab99f1388f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix warnings about conversion from int
 to unsigned char/uint8_t
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

From: Arne Schwabe <arne@...1227...>

When compiling with cmake -DCMAKE_BUILD_TYPE=ASAN under Ubuntu 25.10
(gcc 15.2.0).

Explicitly cast these instances to uint8_t/unssigned char to silence this
warning.

Change-Id: I648ee99b1152b1248d1b3e64af7679ab99f1388f
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1328
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1328
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index be20638..3e6520a 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -46,7 +46,7 @@
         }
         else
         {
-            Hex[i * 2] = (j + 'a' - 10);
+            Hex[i * 2] = (unsigned char)(j + 'a' - 10);
         }
         j = Bin[i] & 0xf;
         if (j <= 9)
@@ -55,7 +55,7 @@
         }
         else
         {
-            Hex[i * 2 + 1] = (j + 'a' - 10);
+            Hex[i * 2 + 1] = (unsigned char)(j + 'a' - 10);
         }
     }
     Hex[HASHHEXLEN] = '\0';
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index b50d48f..d17902f 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -337,7 +337,7 @@
             }
             else
             {
-                ma->v6.addr.s6_addr[byte--] &= (0xFF << bits_to_clear);
+                ma->v6.addr.s6_addr[byte--] &= (uint8_t)(0xFF << bits_to_clear);
                 bits_to_clear = 0;
             }
         }

