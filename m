From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 13 Apr 2020 18:56:50 +0300
Message-Id: <20200413155650.114-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Fix illegal client float
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

There is a time frame between allocating peer-id and initializing data
channel key, which is performed on receiving push request.

If a "rogue" data channel packet arrives during that time frame from
another address and  with same peer-id, this would cause client to float
to that new address. This is because:

 - tls_pre_decrypt() sets buffer length to zero if
   data channel key has not been initialized, which leads to

 - openvpn_decrypt() returns true if buffer length is zero,
which leads to

 - process_incoming_link_part1() returns true, which
calls multi_process_float(), which commits float

Note that problem doesn't happen when data channel key
is initialized, since in this case openvpn_decrypt() returns false.

Fix illegal float by adding buffer length check before calling
multi_process_float().

This should fix Trac #1272.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/multi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index da0aeeba..58892a87 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2555,7 +2555,7 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
             orig_buf = c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
             {
-                if (floated)
+                if (floated && c->c2.buf.len > 0)
                 {
                     multi_process_float(m, m->pending);
                 }
-- 
2.17.1


