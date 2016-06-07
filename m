From: Selva Nair <selva.nair@...277...>
Date: Tue,  7 Jun 2016 00:44:19 -0400
Message-Id: <1465274660-11009-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 0/1] Another take on preserving SIGTERM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

Here is an alternative to my previous patch addressing the same point:
 
"Save exit-notify timer during a restart" 
(http://article.gmane.org/gmane.network.openvpn.devel/11807)

This one (patch in next email) may be a more palatable approach.

Selva

Selva Nair (1):
  Ignore SIGUSR1/SIGHUP during exit notification

 src/openvpn/sig.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

-- 
1.7.10.4


