From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 16 Feb 2024 13:30:37 +0100
Message-Id: <20240216123037.3670448-1-frank@...2641...>
In-Reply-To: <gerrit.1708078156000.Id6b038c1c0095b2f22033e9dc7090e2507a373ab@...2715...>
References: <gerrit.1708078156000.Id6b038c1c0095b2f22033e9dc7090e2507a373ab@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] check_compression_settings_valid: Do not
 test for LZ4 in LZO check
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

Probably introduced by copy & paste since there is no
COMP_ALGV2_LZO.

Github: #500
Change-Id: Id6b038c1c0095b2f22033e9dc7090e2507a373ab
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master and release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/526
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 6e30369..311f3e9 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -195,7 +195,7 @@
     }
 #endif
 #ifndef ENABLE_LZO
-    if (info->alg == COMP_ALG_LZO || info->alg == COMP_ALG_LZ4)
+    if (info->alg == COMP_ALG_LZO)
     {
         msg(msglevel, "OpenVPN is compiled without LZO support. Requested "
             "compression cannot be enabled.");

