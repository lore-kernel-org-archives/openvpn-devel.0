From: =?UTF-8?Q?booyakasha?= <booyakasha@...1309...>
Mime-Version: 1.0
Message-ID: <6c75f86b.6552e8f7.4b8bad61.2e7bd@...1309...>
Date: Mon, 01 Mar 2010 13:04:49 +0100
Subject: [Openvpn-devel] =?utf-8?q?Openvpn_2=2E1=2E1_bad_tcp_performance_b?=
	=?utf-8?q?ut_good_ping_when_-l_1472_=28with_packet_size_=3D_MTU=29?=
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
there are so many complains about openvpn performance in proto tcp mode
that it is almost unbelievable that nobody took care of it. I am using two =
20/20 MB connections and openvpn
tunnel in tcp mode. without vpn my ping is about 10ms but with vpn it jumps=
 to 520ms. What is most interesting when i use ping -l 1472 which is maximu=
m packet size for MTU 1500 ping is OK and about 13ms. Any other size than 1=
472 (which means 1500 =3D 1472 + 28 overhead) causes ping to take values ab=
out 500-600ms.  And it is not acceptable to use UDP for me because of my co=
mpany policy. I think that it is very common problem and not yet answered. =
I am taking wild guess that everything works OK with proper packet size =3D=
 MTU but when packet is smaller or larger (with fragmentation) it causes la=
gs. Looking forward to your answers.

Best Regards
Ucho

