From: gert@...1296...
Date: Mon, 11 Mar 2013 21:10:25 +0100
Message-Id: <1363032625-23311-1-git-send-email-gert@...1296...>
In-Reply-To: <C673F57BE2DD3148AC2DD4AF464686F901BBDB56@...1815...>
References: <C673F57BE2DD3148AC2DD4AF464686F901BBDB56@...1815...>
Subject: [Openvpn-devel] [PATCH] Repair "tcp server queue overflow"
	brokenness, more <stdbool.h> fallout.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Gert Doering <gert@...1296...>

Return value of mbuf_len() wrong - it's returning a length value, not
a yes/no value - so when the queue length approached 65 (full!), it
still only returned "1", leading to MBUF overflow later on.  Change
from "bool" to "int", misbehaviour gone...

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/mbuf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index a0de679..6d5292d 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -83,7 +83,7 @@ mbuf_defined (const struct mbuf_set *ms)
   return ms && ms->len;
 }
 
-static inline bool
+static inline int
 mbuf_len (const struct mbuf_set *ms)
 {
   return ms->len;
-- 
1.7.8.6


