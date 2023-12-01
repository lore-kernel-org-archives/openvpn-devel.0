From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  1 Dec 2023 12:17:17 +0100
Message-Id: <20231201111717.14940-1-frank@...2641...>
In-Reply-To: <gerrit.1701361470000.Ie7fd59cc84e2eb024086c28c2ec2a5606a2b2e7c@...2715...>
References: <gerrit.1701361470000.Ie7fd59cc84e2eb024086c28c2ec2a5606a2b2e7c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove TEST_GET_DEFAULT_GATEWAY as it
 duplicates --show-gateway
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

This debug code is not very useful as it is outdated and the same
functionality is provided by --show-gateway

Change-Id: Ie7fd59cc84e2eb024086c28c2ec2a5606a2b2e7c
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/463
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index abba748..fdab26b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -885,17 +885,6 @@
     return false;
 #endif
 
-#ifdef TEST_GET_DEFAULT_GATEWAY
-    {
-        struct route_gateway_info rgi;
-        struct route_ipv6_gateway_info rgi6;
-        get_default_gateway(&rgi);
-        get_default_gateway_ipv6(&rgi6, NULL);
-        print_default_gateway(M_INFO, &rgi, &rgi6);
-        return false;
-    }
-#endif
-
 #ifdef GEN_PATH_TEST
     {
         struct gc_arena gc = gc_new();

