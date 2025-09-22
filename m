From: Gert Doering <gert@...1296...>
Date: Mon, 22 Sep 2025 10:02:59 +0200
Message-ID: <20250922080305.18477-1-gert@...1296...>
In-Reply-To: <gerrit.1758524470000.I5fea6ca1ccadb434b5c4f4b49881524a079a9d15@...2715...>
References: <gerrit.1758524470000.I5fea6ca1ccadb434b5c4f4b49881524a079a9d15@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix t_net.sh / networking_testdriver
 after 'broadcast' change
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

Commit 0df0edc49c re-introduced explicit setting of broadcast addresses
for Linux IPv4 interfaces.  t_net.sh verifies that the built-in netlink
code (sitnl) achieves the same result as "equivalent" iproute2 statements
- and we missed adjusting of these iproute2 statements (printed by
networking_testdriver).  Done.

Change-Id: I5fea6ca1ccadb434b5c4f4b49881524a079a9d15
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1203
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1203
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index f2da83e..6a2d09f 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -61,7 +61,7 @@
 
     addr = ntohl(addr);
 
-    printf("CMD: ip addr add %s/%d dev %s\n", addr_str, prefixlen, iface);
+    printf("CMD: ip addr add %s/%d dev %s broadcast +\n", addr_str, prefixlen, iface);
 
     return net_addr_v4_add(NULL, iface, &addr, prefixlen);
 }

