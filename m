From: Olaf Fraczyk <olaf@...1271...>
Date: Thu, 29 Oct 2009 20:25:44 +0100
Message-Id: <1256844344.7529.43.camel@...1272...>
Mime-Version: 1.0
Subject: [Openvpn-devel] 2.1 rc20 and multiple interfaces problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello,

I have several interfaces, the problem is that if:

I open connection from client to server IP=3DY on interface ppp1 then I
get packets back from IP=3DX on interface ppp0

For connection to IP=3DX on interface ppp0 I get correctly packets from
IP=3DX on ppp0.

I have read that in 2.1 it should work, but it doesn't.

The OS is CentOS 5.4.

Best regards,

Olaf
--=20
Olaf Fr=C4=85czyk <olaf@...1271...>
NAVI
http://www.navi.pl
http://www.ntp.navi.pl


