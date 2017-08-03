From: debbie10t@...277...
Date: Thu,  3 Aug 2017 17:03:04 +0100
Message-Id: <20170803160304.35518-1-debbie10t@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] doc/openvpn.8: Correct --verify-x509-name
 *type* example
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: Richard Bonhomme <fragmentux@...277...>

From: Richard Bonhomme <fragmentux@...277...>

Signed-off-by: Richard Bonhomme <fragmentux@...277...>
---
 doc/openvpn.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 20bdd91..fdd5dde 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5340,7 +5340,7 @@ subject DN "C=KG, ST=NA, L=Bishkek, CN=Server-1" would be matched by:
 and
 .B \-\-verify\-x509\-name Server\-1 name
 or you could use
-.B \-\-verify\-x509\-name Server -name-prefix
+.B \-\-verify\-x509\-name Server\- name\-prefix
 if you want a client to only accept connections to "Server-1", "Server-2", etc.
 
 .B \-\-verify\-x509\-name
-- 
2.10.2


