From: Hurukawa2121 <shujifurukawa1213@...277...>
Date: Sat, 16 Nov 2024 04:40:06 +0900
Message-Id: <20241115194005.38280-1-shujifurukawa1213@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Improve shuffling algorithm of connection
 list
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
Cc: Hurukawa2121 <shujifurukawa1213@...2831...>

From: Hurukawa2121 <shujifurukawa1213@...2831...>

---
 Improve shuffling algorithm of connection list

 This patch implements the Fisher-Yates shuffle algorithm to ensure that all permutations
 of the connection target list are generated with equal probability, eliminating
 biases present in the previous shuffling method.
 In the Fisher-Yates algorithm, there's only one way to obtain each permutation
 through these swaps, so all permutations occur with equal probability in theory.

 Signed-off-by: Hurukawa2121 <shujifurukawa1213@...2831...>

 src/openvpn/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9371024e..3b00b49d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -478,9 +478,9 @@ init_connection_list(struct context *c)
     if (c->options.remote_random)
     {
         int i;
-        for (i = 0; i < l->len; ++i)
+        for (i = l->len - 1; i > 0; --i)
         {
-            const int j = get_random() % l->len;
+            const int j = get_random() % (i + 1);
             if (i != j)
             {
                 struct connection_entry *tmp;
-- 
2.39.3 (Apple Git-146)


