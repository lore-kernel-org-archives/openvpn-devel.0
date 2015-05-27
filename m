Date: Wed, 27 May 2015 20:41:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150527184124.GT382@...1296...>
References: <20150524193011.GK382@...1296...>
	<5565B65A.1000501@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1nWzwthe/g5xaf/W"
Content-Disposition: inline
In-Reply-To: <5565B65A.1000501@...1114...>
Subject: Re: [Openvpn-devel] rfd: 'serial-tests' automake option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--1nWzwthe/g5xaf/W
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 27, 2015 at 02:19:38PM +0200, David Sommerseth wrote:
> This makes a lot of sense to me.  Our project doesn't really benefit in
> general of running our tests parallel.
>=20
> This gets an ACK from me.  I just tested your change locally, and it
> seems to work very well.=20=20

Thanks :-)  (and of *course* I tested this before posting...  sometimes I
actually remember to run "make test" before pushing out broken commits...
*ahem*)

> And from what I can grasp from the automake
> documentation [1], this seems safe for us to do.
>=20
> [1]
> <https://www.gnu.org/software/automake/manual/html_node/Serial-Test-Harne=
ss.html>

Thanks for this pointer - while the server seems to be down right now, I've
included the URL in the commit.

commit fc03ca9d13e35c40bdf1c3c676db2adf48c60223 (master)
commit c196ea922755bb25f9837080d562ef4d3495999f (release/2.3)

Author: Gert Doering <gert@...1296...>
Date:   Wed May 27 20:31:38 2015 +0200

    Enforce "serial-tests" behaviour for tests/Makefile

    Signed-off-by: Gert Doering <gert@...1296...>
    Message-ID: <20150524193011.GK382@...1296...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/9738
    Acked-by: David Sommerseth <openvpn.list@...1114...>



--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1nWzwthe/g5xaf/W
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVWYP1KkuBuNlUUl1AQL6pQP9GCnA084PWEib2CIZyi8Ja8U2LFbPFduV
NuLkhNviGuQ58YcZR1tEBsp5zyY7gT6F1wuaNjOiodphAPzFyhBPNKlnMR07Zp0y
u6r8GjQzaG6uEVPQdwaxXHlt7m6rAwd39eE9AjrISgmTeGLTOeVMj/VJIFyboeWP
4PaPHHQXm1k=
=6HGd
-----END PGP SIGNATURE-----

--1nWzwthe/g5xaf/W--

