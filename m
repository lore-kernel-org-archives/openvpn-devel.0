From: Kristof Provost <kprovost@...2661...>
Date: Wed, 13 Jul 2022 10:34:03 +0200
Message-Id: <20220713083404.13227-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH]: Handle exceeding max-clients
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This patch fixes a crash we've seen on server instances when one more
client than 'max-clients' connects.

I believe this affects both master and DCO branches, and I think it was
introduced with this commit:

	commit b364711486dc6371ad2659a5aa190941136f4f04
	Author: Arne Schwabe <arne@...1227...>
	Date:   Mon May 2 17:43:10 2022 +0200

	    Implement stateless HMAC-based sesssion-id three-way-handshake

Best regards,
Kristof



