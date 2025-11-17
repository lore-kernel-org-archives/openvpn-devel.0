From: Gert Doering <gert@...1296...>
Date: Mon, 17 Nov 2025 18:28:58 +0100
Message-ID: <20251117173843.10091-2-gert@...1296...>
In-Reply-To: <20251117173843.10091-1-gert@...1296...>
References: <20251117173843.10091-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] socket: reject mismatched address
 family in get_addr_generic
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

From: Mikhail Khachaiants <mkhachaiants@...277...>

Add a family check to prevent copying address data of the wrong type,
which could cause buffer over-read when parsing routes or endpoints.

CVE: 2025-12106

Github: OpenVPN/openvpn-private-issues#77

Signed-off-by: Mikhail Khachaiants <mkhachaiants@...277...>
Acked-By: Gert Doering <gert@...1296...>
Signed-Off-By: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index f7317d13..8b6e35e4 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -147,6 +147,13 @@ get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname, void
         struct in6_addr *ip6;
         in_addr_t *ip4;
 
+        if (af != ai->ai_family)
+        {
+            msg(msglevel, "Can't parse %s as IPv%d address", var_host, (af == AF_INET) ? 4 : 6);
+            ret = -1;
+            goto out;
+        }
+
         switch (af)
         {
             case AF_INET:
-- 
2.51.2


