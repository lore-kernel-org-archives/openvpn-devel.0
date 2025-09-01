From: Gert Doering <gert@...1296...>
Date: Mon,  1 Sep 2025 21:45:25 +0200
Message-ID: <20250901194531.13683-1-gert@...1296...>
In-Reply-To: <gerrit.1753360288000.I6d42c67b8dc5512933bed482bd9c2be80c63e993@...2715...>
References: <gerrit.1753360288000.I6d42c67b8dc5512933bed482bd9c2be80c63e993@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v10] forward: Make sure pip flags are
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

process_ip_header already expects them to be unsigned,
make sure the flags are to avoid spurious conversion warnings.

Change-Id: I6d42c67b8dc5512933bed482bd9c2be80c63e993
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1108
This mail reflects revision 10 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index d564149..79d0f8b 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -314,13 +314,13 @@
  */
 void reschedule_multi_process(struct context *c);
 
-#define PIPV4_PASSTOS             (1 << 0)
-#define PIP_MSSFIX                (1 << 1) /* v4 and v6 */
-#define PIP_OUTGOING              (1 << 2)
-#define PIPV4_EXTRACT_DHCP_ROUTER (1 << 3)
-#define PIPV4_CLIENT_NAT          (1 << 4)
-#define PIPV6_ICMP_NOHOST_CLIENT  (1 << 5)
-#define PIPV6_ICMP_NOHOST_SERVER  (1 << 6)
+#define PIPV4_PASSTOS             (1u << 0)
+#define PIP_MSSFIX                (1u << 1) /* v4 and v6 */
+#define PIP_OUTGOING              (1u << 2)
+#define PIPV4_EXTRACT_DHCP_ROUTER (1u << 3)
+#define PIPV4_CLIENT_NAT          (1u << 4)
+#define PIPV6_ICMP_NOHOST_CLIENT  (1u << 5)
+#define PIPV6_ICMP_NOHOST_SERVER  (1u << 6)
 
 
 void process_ip_header(struct context *c, unsigned int flags, struct buffer *buf,

