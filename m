From: Franchoze Eric <franchoze@...1411...>
MIME-Version: 1.0
Message-Id: <215071285623597@...1412...>
Date: Tue, 28 Sep 2010 01:39:57 +0400
Subject: [Openvpn-devel] encrypted tls handshake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello everybody, what do you think about making tls handshake encrypted? This will allow to secure transfer shared ssl certificate. To make it difficult to detect that openvpn tries to setup client server connection. Logically it should be possible to encrypt tls init things with pre shared key.

