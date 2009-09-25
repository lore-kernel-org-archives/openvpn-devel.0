MIME-Version: 1.0
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Fri, 25 Sep 2009 23:36:19 +0200
Message-ID: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...>
Subject: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

I'm(back) working on openvpn/ipv6 endpoint support, aka udp6/tcp6,
please refer to README.ipv6[1] and TODO.ipv6[2] for more details.

All snapshots are unittested for correct {udp,tcp}v{4,6} operation
under GNU/Linux and win32 (the latter x-compiled under the former ;).

You can find my current git repo[3], available under GPLv2, plus
patches and complete tarballs in downloads/ area.

Enjoy! ... and please send feedback :)

[1] http://github.com/jjo/openvpn-ipv6/blob/master/README.ipv6
[2]=A0http://github.com/jjo/openvpn-ipv6/blob/master/TODO.ipv6
[3] http://github.com/jjo/openvpn-ipv6

Cheers,
--
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

