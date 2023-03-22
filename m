From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 22 Mar 2023 13:34:08 +0200
Message-Id: <20230322113408.2057-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix "--inactive <time> 0" behavior for DCO
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Make sure we exit if <bytes> is 0 (not set) and no traffic
was produced.

According to man page and non-DCO --inactive implementation,
we exit if amount of bytes produced is less than <bytes> specified.
DCO implementation will do off-by-ones, but we consider it as okay
since we don't want to complicate code to handle both bytes=0 and >0
cases.

Change-Id: I4c089e486728a43bfe42596787c00355838311da
Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/forward.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 28a96f94..b3e0ba5d 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -481,7 +481,7 @@ check_inactivity_timeout(struct context *c)
         int64_t tot_bytes = c->c2.tun_read_bytes + c->c2.tun_write_bytes;
         int64_t new_bytes = tot_bytes - c->c2.inactivity_bytes;
 
-        if (new_bytes >= c->options.inactivity_minimum_bytes)
+        if (new_bytes > c->options.inactivity_minimum_bytes)
         {
             c->c2.inactivity_bytes = tot_bytes;
             event_timeout_reset(&c->c2.inactivity_interval);
-- 
2.38.1.windows.1


