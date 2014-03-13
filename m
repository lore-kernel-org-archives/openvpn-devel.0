From: Abdullah Alshalan <aalshala@...1837...>
Message-Id: <20A288CF-1387-4616-B6C4-9DAEADAB02A7@...1837...>
Date: Thu, 13 Mar 2014 14:37:05 -0700
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: [Openvpn-devel] TLS (SSL) handshake upon reconnecting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,
I have a few questions about OpenVPN and I would appreciate if you can answ=
er whatever you can.

1- Does OpenVPN use a lightweight SSL handshake upon automatic reconnection=
?=20
2- If so, when does OpenVPN do a full handshake vs. lightweight (abbreviate=
d) handshake?=20
3- Does it renogotiate the master key upon reconnection?
4- In a mobile environment, would it be better to replace openssl with WTLS=
? what's your take on that?

Thank you,
Abdullah
