Date: Thu, 23 Oct 2014 23:12:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141023211259.GV396@...1296...>
References: <CAAA5faEk-YSopL-9L=cWzpcfwk96r+utbWEWuO_=L0=jjvYzRg@...278...>
	<20141023192811.GU396@...1296...>
	<CAAA5faFxpQnb7pNd1tSZisVfkGdD4d0xzLBwzwt5acstNfRe0w@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YMf7pJGz0wcApMUv"
Content-Disposition: inline
In-Reply-To: <CAAA5faFxpQnb7pNd1tSZisVfkGdD4d0xzLBwzwt5acstNfRe0w@...278...>
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

--YMf7pJGz0wcApMUv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 23, 2014 at 02:04:10PM -0600, Reinoud Koornstra wrote:
> In my understanding, there is no client or server in p2p mode.=20

True, as far as the OpenVPN protocol is concerned.

False, as far as TCP is concerned, because you MUST have a client and a
server in TCP - it's not a symmetric protocol (unlike UDP).

So, OpenVPN in peer-to-peer mode will need --tcp-client on one side and
--tcp-server on the other (it doesn't matter which one is which, as
as soon as the TCP connection is up, it's "peer to peer" inside)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--YMf7pJGz0wcApMUv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVElvW6kuBuNlUUl1AQJd2gQAtJnTkHR5ak2+pItFsRdS1FRec3dSLTUe
RlqvKKLqGqL8foYOD7DnAo+A7PzKGOmqtuTzq1pOtNzSSFqo7iVOWroEfGVvxeij
SDT7/tshRkaKm7kOqQ4RThH52U572XppaJ+HqT7b0G1RYGAA9AfZ/cMSSdFYOlK0
u8Uf62GlkUo=
=4kfp
-----END PGP SIGNATURE-----

--YMf7pJGz0wcApMUv--

