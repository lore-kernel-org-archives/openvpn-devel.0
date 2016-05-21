Date: Sat, 21 May 2016 11:57:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160521095734.GR53051@...1296...>
References: <5DDE3F3A-A3CA-4A68-9F23-8C4F10835E22@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y7POr9vWFtFGh+o2"
Content-Disposition: inline
In-Reply-To: <5DDE3F3A-A3CA-4A68-9F23-8C4F10835E22@...2127...>
Subject: Re: [Openvpn-devel] Test documentation: What does t_cltsrv.sh do?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--y7POr9vWFtFGh+o2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, May 21, 2016 at 10:59:23AM +0200, Jens Neuhalfen wrote:
> * t_client.sh runs connect & ping tests against servers
> * t_lpback.sh runs the built-in crypto tests
> * Can anybody tell me what ???t_cltsrv.sh??? tests?

It's a basic TLS test that does not need external test infrastructure -
basically, it runs a test server and test client that talk to each other
via 127.0.0.1, eventually timeout and exit.

This is good to quickly see if we broke TLS handshaking (on some platform
or build combination) without having to setup a "proper" test server.

t_client.sh does full "see if ifconfig+route works, if everything is
properly cleaned up afterwards, and data transfer works" - but needs=20
root (or sudo) privileges to test that, and a properly set up test rig.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--y7POr9vWFtFGh+o2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV0AxDqkuBuNlUUl1AQIeCgQAi7jJgM1JqBw5/IVbnyU/nLSSvXNbr1ZB
yBALZjwaG2r/3bx3rf9G/s/Zcwkif4MhdBtg7IsWu9WE313HngvjL3y4GTGxQeqR
pj32nHmZSg1gKpPn9l4mfOX2+gzbZbbeCbKiVN5aB8MhXOO/cTtREFGJxdBHoOwQ
uMxFnw/dpHY=
=DANX
-----END PGP SIGNATURE-----

--y7POr9vWFtFGh+o2--

