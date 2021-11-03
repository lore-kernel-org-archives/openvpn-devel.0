From: Richard T Bonhomme <stringvest88@...277...>
Date: Wed,  3 Nov 2021 21:18:20 +0000
Message-Id: <20211103211820.1147661-1-tincantech@...2282...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] doc openvpn.8: Use free open-source
 dynamic-DNS provider URL
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

Branch: release/2.4

Signed-off-by: Richard T Bonhomme <tincantech@...2282...>
---
 doc/openvpn.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index a694e187..598d5fce 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1571,7 +1571,7 @@ This option is useful in cases
 where the remote peer has a dynamic IP address and
 a low\-TTL DNS name is used to track the IP address using
 a service such as
-.I http://dyndns.org/
+.I https://www.nsupdate.info/
 + a dynamic DNS client such
 as
 .B ddclient.
-- 
2.25.1


