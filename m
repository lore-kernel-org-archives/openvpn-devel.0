From: Gert Doering <gert@...1296...>
Date: Mon, 24 Mar 2025 09:33:44 +0100
Message-ID: <20250324083350.4019-1-gert@...1296...>
In-Reply-To: <gerrit.1741926089000.I23710b1f5b2122ec1f14465911836c0f0afa9c64@...2715...>
References: <gerrit.1741926089000.I23710b1f5b2122ec1f14465911836c0f0afa9c64@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] win: calculate address string buffer size
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

From: Heiko Hund <heiko@...2662...>

Instead of making the string buffer statically sized for a max. of
four addresses, calculate it to hold up to the max number of addresses
a dns_cfg_message_t can hold (currently four as well). Improves the code
so that it doesn't rely on the addresses never being more than four in
the future.

Change-Id: I23710b1f5b2122ec1f14465911836c0f0afa9c64
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/908
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index abbc916..100c69a 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1857,9 +1857,10 @@
     int addr_len = msg->addr_len;
 
     /* sanity check */
-    if (addr_len > _countof(msg->addr))
+    const size_t max_addrs = _countof(msg->addr);
+    if (addr_len > max_addrs)
     {
-        addr_len = _countof(msg->addr);
+        addr_len = max_addrs;
     }
 
     if (!msg->iface.name[0]) /* interface name is required */
@@ -1909,7 +1910,7 @@
     if (msg->addr_len > 0)
     {
         /* prepare the comma separated address list */
-        CHAR addrs[256]; /* large enough to hold four IPv4 / IPv6 address strings */
+        CHAR addrs[max_addrs * 64]; /* 64 is enough for one IPv4/6 address */
         size_t offset = 0;
         for (int i = 0; i < addr_len; ++i)
         {

