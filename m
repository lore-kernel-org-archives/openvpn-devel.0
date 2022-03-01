From: Lev Stipakov <lstipakov@...277...>
Date: Tue,  1 Mar 2022 15:50:54 +0200
Message-Id: <20220301135054.277-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Fix incorrect default mssfix value in
 server mode
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

When calculating default mssfix, we take into account
protocol overhead, which usually includes 3 bytes peer-id.

Peer-id usage is indicated by options->use_peer_id flag.
In client mode it is set when applying pushed options.
In server mode  it is not set and as a result mssfix value
is 3 bytes off.

Fix by setting this flag in multi.c when calculating
tunnel-specific options.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/multi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d8d44f96..ea19c539 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1772,6 +1772,7 @@ multi_client_set_protocol_options(struct context *c)
     if (proto & IV_PROTO_DATA_V2)
     {
         tls_multi->use_peer_id = true;
+        o->use_peer_id = true;
     }
     else if (dco_enabled(o))
     {
-- 
2.23.0.windows.1


