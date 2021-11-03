From: Richard T Bonhomme <stringvest88@...277...>
Date: Wed,  3 Nov 2021 20:20:14 +0000
Message-Id: <20211103202014.1121244-2-tincantech@...2282...>
In-Reply-To: <20211103202014.1121244-1-tincantech@...2282...>
References: <20211103202014.1121244-1-tincantech@...2282...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] doc link-options.rst: Use free open-source
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

Signed-off-by: Richard T Bonhomme <tincantech@...2282...>
---
 doc/man-sections/link-options.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index b8a72d7a..32e72a1b 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -213,7 +213,7 @@ the local and the remote host.
 
   This option is useful in cases where the remote peer has a dynamic IP
   address and a low-TTL DNS name is used to track the IP address using a
-  service such as http://dyndns.org/ + a dynamic DNS client such as
+  service such as https://www.nsupdate.info/ + a dynamic DNS client such as
   ``ddclient``.
 
   If the peer cannot be reached, a restart will be triggered, causing the
-- 
2.25.1


