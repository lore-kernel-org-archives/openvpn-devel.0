From: Antonio Quartulli <a@...2181...>
Date: Mon, 20 Mar 2023 20:58:20 +0100
Message-Id: <20230320195820.6675-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco-linux: remove M_ERRNO flag when
 printing netlink error message
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

Netlink has its own error space and reports errors via the return
value of its functions.

For this reason remove the M_ERRNO flag when printing its errors.
At the moment we get something like this:

netlink reports error (-7): Invalid input data or parameter: Interrupted system call (errno=4)

where the errno=4 (and its human readable representation) is a leftover
from the previous recv() interrupted by a signal and it is totally
unrelated to this netlink failure.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 98b2aae3..0e479beb 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -154,7 +154,7 @@ ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
         default:
             if (ret)
             {
-                msg(M_NONFATAL|M_ERRNO, "%s: netlink reports error (%d): %s", prefix, ret, nl_geterror(-ret));
+                msg(M_NONFATAL, "%s: netlink reports error (%d): %s", prefix, ret, nl_geterror(-ret));
             }
             break;
     }
-- 
2.39.2


