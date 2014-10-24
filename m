Date: Fri, 24 Oct 2014 07:48:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141024054814.GX396@...1296...>
References: <CAAA5faEk-YSopL-9L=cWzpcfwk96r+utbWEWuO_=L0=jjvYzRg@...278...>
	<20141023192811.GU396@...1296...>
	<CAAA5faFxpQnb7pNd1tSZisVfkGdD4d0xzLBwzwt5acstNfRe0w@...278...>
	<20141023211259.GV396@...1296...>
	<CAAA5faFzhCkqxe4j24C25b8JaLSgj2HeD5s2i31Em-UQOPURAg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0fs/EiH13ppNklOL"
Content-Disposition: inline
In-Reply-To: <CAAA5faFzhCkqxe4j24C25b8JaLSgj2HeD5s2i31Em-UQOPURAg@...278...>
Subject: Re: [Openvpn-devel] man page and options.c contradict
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Reinoud Koornstra <reinoudkoornstra@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--0fs/EiH13ppNklOL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 23, 2014 at 03:42:54PM -0600, Reinoud Koornstra wrote:
> Ok, clear, to TCP cannot be used in point to point mode (p2p) then, becau=
se
> in case of tcp we must have a client and a server?

Please READ what I write, so I don't have to repeat it.

TCP imposes an imbalance between the peers (one has to be the listening
and one has to be the connecting instance), but the OpenVPN protocol *insid=
e*
the TCP session will still be "point to point mode (p2p)"

> Inside the tun or tap interface, can we specify the protocol and port
> number used for any communications inside the tun/tcp interface or do we
> allow any protocol/port for communication inside the tun/tap device?
> Thanks,

tun/tap is just a network interface, so do with it what you want - setup
ip addresses and routing, set up firewalling, set up policy routing, etc. -
OpenVPN won't care, and just transport packets entering the tun/tap=20
interface to the other side, and deliver to the remote tun/tap interface.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0fs/EiH13ppNklOL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVEnoHakuBuNlUUl1AQKwKAP9Gjq5p8/I9HPUee0VndlHj9YyQ0EzUzRK
okas9qzyOcStkLOCs1K+itncvmt5lkPGgcVUqh8vf0gNEd3wGHXF0+EviNcWqP3/
L6OG7UxXwfXI87mi4ZYIkWBJzYUiwFOrEP12joG9bLP9WtoFiHq4RC7HWSipqyul
Utm9RNwOWJU=
=RFQi
-----END PGP SIGNATURE-----

--0fs/EiH13ppNklOL--

