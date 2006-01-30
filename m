Message-ID: <10359.147.13.200.14.1138621694.squirrel@...531...>
From: "Roland Valtersson" <rolandva@...530...>
MIME-Version: 1.0
Subject: [Openvpn-devel] TAP does not accept packets > 1000 bytes
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Jan 30 03:49:12 2006
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,
I am trying to get the TAP driver work with an application i am
developing. However if I try to send a packet over ~1000 bytes, it's never
read from the TAP device. When using the TAP driver with OpenVPN,
everything works fine. Is there anything special setting you have to do?
Thanks in advance

/ Roland


