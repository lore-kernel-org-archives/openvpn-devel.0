Message-ID: <4D34A90F.7080008@...1194...>
Date: Mon, 17 Jan 2011 12:39:43 -0800
From: Roman Vasilyev <roman@...1194...>
MIME-Version: 1.0
Subject: [Openvpn-devel] openvpn FreeBSD kqueue
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Openvpn-devel@lists.sourceforge.net

Hi,

I want to try FreeBSD with OpenVPN on high load, checked event.c =D1=84=D1=
=82=D0=B2=20
found that it can work only with epoll, just want to ask is it possible=20
to use kqueue in openvpn?
If not, what people thinking if I'll add this support there?

