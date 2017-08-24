From: Antonio Quartulli <a@...2181...>
Date: Thu, 24 Aug 2017 15:55:47 +0800
Message-Id: <20170824075547.29844-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] fragment.c: simplify boolean expression
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
Cc: Antonio Quartulli <a@...2181...>

!A || (A && B) is equivalent to the simpler !A || B
therefore it is preferable to use the second version as
it is simpler to parse while reading the code.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/fragment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 25ffc4cf..36588060 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -209,7 +209,7 @@ fragment_incoming(struct fragment_master *f, struct buffer *buf,
             }
 
             /* is this the first fragment for our sequence number? */
-            if (!frag->defined || (frag->defined && frag->max_frag_size != size))
+            if (!frag->defined || frag->max_frag_size != size)
             {
                 frag->defined = true;
                 frag->max_frag_size = size;
-- 
2.14.1


