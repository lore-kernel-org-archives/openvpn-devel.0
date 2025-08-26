From: Gert Doering <gert@...1296...>
Date: Tue, 26 Aug 2025 20:38:41 +0200
Message-ID: <20250826183902.21252-1-gert@...1296...>
In-Reply-To: <gerrit.1753360288000.Ib7f78abbcd52c00a32afdea36ef635681ac8e127@...2715...>
References: <gerrit.1753360288000.Ib7f78abbcd52c00a32afdea36ef635681ac8e127@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] route: Make sure various route flags are
 treated as unsigned
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

The variables that hold them are already unsigned, make sure
the flags are as well to avoid spurious conversion warnings.

Change-Id: Ib7f78abbcd52c00a32afdea36ef635681ac8e127
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1109
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index ea8b767..9b6a47e 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -83,14 +83,14 @@
 };
 
 /* redirect-gateway flags */
-#define RG_ENABLE      (1 << 0)
-#define RG_LOCAL       (1 << 1)
-#define RG_DEF1        (1 << 2)
-#define RG_BYPASS_DHCP (1 << 3)
-#define RG_BYPASS_DNS  (1 << 4)
-#define RG_REROUTE_GW  (1 << 5)
-#define RG_AUTO_LOCAL  (1 << 6)
-#define RG_BLOCK_LOCAL (1 << 7)
+#define RG_ENABLE      (1u << 0)
+#define RG_LOCAL       (1u << 1)
+#define RG_DEF1        (1u << 2)
+#define RG_BYPASS_DHCP (1u << 3)
+#define RG_BYPASS_DNS  (1u << 4)
+#define RG_REROUTE_GW  (1u << 5)
+#define RG_AUTO_LOCAL  (1u << 6)
+#define RG_BLOCK_LOCAL (1u << 7)
 
 struct route_option_list
 {
@@ -117,9 +117,9 @@
 
 struct route_ipv4
 {
-#define RT_DEFINED        (1 << 0)
-#define RT_ADDED          (1 << 1)
-#define RT_METRIC_DEFINED (1 << 2)
+#define RT_DEFINED        (1u << 0)
+#define RT_ADDED          (1u << 1)
+#define RT_METRIC_DEFINED (1u << 2)
     struct route_ipv4 *next;
     unsigned int flags;
     const struct route_option *option;
@@ -227,9 +227,9 @@
 
 struct route_list
 {
-#define RL_DID_REDIRECT_DEFAULT_GATEWAY (1 << 0)
-#define RL_DID_LOCAL                    (1 << 1)
-#define RL_ROUTES_ADDED                 (1 << 2)
+#define RL_DID_REDIRECT_DEFAULT_GATEWAY (1u << 0)
+#define RL_DID_LOCAL                    (1u << 1)
+#define RL_ROUTES_ADDED                 (1u << 2)
     unsigned int iflags;
 
     struct route_special_addr spec;

