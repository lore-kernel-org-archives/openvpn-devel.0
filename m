From: Gert Doering <gert@...1296...>
Date: Mon,  6 Oct 2025 23:01:21 +0200
Message-ID: <20251006210127.28679-1-gert@...1296...>
In-Reply-To: <gerrit.1759230199000.Ie0c0fbf4f7f8b379d46b6755c4eff209acc20fef@...2715...>
References: <gerrit.1759230199000.Ie0c0fbf4f7f8b379d46b6755c4eff209acc20fef@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] dhcp: Fix conversion warnings
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

- Use correct type for pointer difference
- Make sure that small sizeof sum is treated as int

Change-Id: Ie0c0fbf4f7f8b379d46b6755c4eff209acc20fef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1241
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1241
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 38e8d40..850a4b6 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -72,11 +72,6 @@
     return -1;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static in_addr_t
 do_extract(struct dhcp *dhcp, int optlen)
 {
@@ -115,7 +110,7 @@
                         const int owlen = len + 2; /* len of data to overwrite */
                         uint8_t *src = dest + owlen;
                         uint8_t *end = p + optlen;
-                        const int movlen = end - src;
+                        const intptr_t movlen = end - src;
                         if (movlen > 0)
                         {
                             memmove(dest, src, movlen);       /* overwrite router option */
@@ -155,7 +150,7 @@
     struct dhcp_full *df = (struct dhcp_full *)BPTR(ipbuf);
     const int optlen =
         BLEN(ipbuf)
-        - (sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr) + sizeof(struct dhcp));
+        - (int)(sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr) + sizeof(struct dhcp));
 
     if (optlen >= 0 && df->ip.protocol == OPENVPN_IPPROTO_UDP
         && df->udp.source == htons(BOOTPS_PORT) && df->udp.dest == htons(BOOTPC_PORT)
@@ -190,7 +185,3 @@
     }
     return 0;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

