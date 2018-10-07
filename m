Date: Mon, 8 Oct 2018 00:35:47 +0200
From: Samy Mahmoudi <samy.mahmoudi@...277...>
Message-ID: <20181007223544.GA2246@...2461...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] man: correct a --redirection-gateway option
 flag
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Replace "servers" with "peers" in the description
of the --redirection-gateway option flag local.
---
 doc/openvpn.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 084c5415..e94ab760 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1184,7 +1184,7 @@ Option flags:
 .B local \-\-
 Add the
 .B local
-flag if both OpenVPN servers are directly connected via a common subnet,
+flag if both OpenVPN peers are directly connected via a common subnet,
 such as with wireless.  The
 .B local
 flag will cause step
-- 
2.19.0


