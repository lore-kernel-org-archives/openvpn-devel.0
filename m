From: Russell Morris <openvpn@...1315...>
Date: Wed, 29 Jun 2011 18:22:15 -0500
Message-id: <1309389735487848500@...1315...>
MIME-version: 1.0
Subject: [Openvpn-devel] Sporadic Long Ping Times
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-disposition: inline
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Hi,

I have been measuring data throughput and RTT on my OpenVPN link (client to=
 server), and while data throughput has been quite consistent (in the 25-30=
 Mb/s range), RTT (ping) has shown a strange artifact.

If I run ping continuously (1 second interval), I may see 10 or 20 very con=
sisten runs, at ~ 10 ms ... but then a single point at 200-250 ms. If I let=
 it keep running this keeps happening - not with a consistent pattern, but =
about this rate.

Has anyone else seen a similar artifact?

Thanks,
... Russell


