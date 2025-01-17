From: Gert Doering <gert@...1296...>
Date: Fri, 17 Jan 2025 12:04:22 +0100
Message-ID: <20250117110422.921-1-gert@...1296...>
In-Reply-To: <gerrit.1737047498000.Ia58cff107d14e29e51df0a988e8337cbb70ebfbb@...2715...>
References: <gerrit.1737047498000.Ia58cff107d14e29e51df0a988e8337cbb70ebfbb@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] IPv6 MADDR LOG: Wrap IPv6 addresses in
 square brackets and print port when the port is specified
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

From: Marco Baffo <marco@...2726...>

  Updated the mroute_addr_print_ex() function to wrap IPv6 addresses in square
  brackets and printing the port when the port is specified, e.g., [2001:db8::1]:8080 .
  When the port is not specified the IPv6 address formatting remain the same, e.g., 2001:db8::1 .

Change-Id: Ia58cff107d14e29e51df0a988e8337cbb70ebfbb
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/870
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index f4539dc..80e18b7 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -430,18 +430,19 @@
                 {
                     buf_printf(&out, "%s", print_in_addr_t(maddr.v4mappedv6.addr,
                                                            IA_NET_ORDER, gc));
-                    /* we only print port numbers for v4mapped v6 as of
-                     * today, because "v6addr:port" is too ambiguous
-                     */
-                    if (maddr.type & MR_WITH_PORT)
-                    {
-                        buf_printf(&out, ":%d", ntohs(maddr.v6.port));
-                    }
+                }
+                else if (maddr.type & MR_WITH_PORT)
+                {
+                    buf_printf(&out, "[%s]", print_in6_addr(maddr.v6.addr, 0, gc));
                 }
                 else
                 {
                     buf_printf(&out, "%s", print_in6_addr(maddr.v6.addr, 0, gc));
                 }
+                if (maddr.type & MR_WITH_PORT)
+                {
+                    buf_printf(&out, ":%d", ntohs(maddr.v6.port));
+                }
                 if (maddr.type & MR_WITH_NETBITS)
                 {
                     buf_printf(&out, "/%d", maddr.netbits);

