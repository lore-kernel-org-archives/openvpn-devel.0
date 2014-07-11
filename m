Date: Fri, 11 Jul 2014 20:51:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140711185100.GL1118@...1296...>
References: <53BF9998.5020906@...1921...> <53BFA5AA.4070305@...1147...>
	<53BFA759.7060307@...1227...> <53BFA9A0.3020605@...1147...>
	<53BFACDE.9050609@...1227...> <53BFAF81.2080705@...1147...>
	<53BFC22C.5010601@...1227...> <53BFF9BE.1090204@...1147...>
	<20140711180758.GJ1118@...1296...> <53C02A4E.6040103@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zN1HJFR/B7wwTray"
Content-Disposition: inline
In-Reply-To: <53C02A4E.6040103@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server
	configuration file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--zN1HJFR/B7wwTray
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 11, 2014 at 08:17:50PM +0200, Jan Just Keijser wrote:
> On 11/07/14 20:07, Gert Doering wrote:
> >On Fri, Jul 11, 2014 at 04:50:38PM +0200, Jan Just Keijser wrote:
> >>the master branch (from openvpn-testing) currently does not build on
> >>either CentOS 5 and 6.
> >Install snappy(-dev) or run configure with --disable-snappy :-) - besides
> >that, it should build just fine.
>
> an
>   autoreconf -i
> did the trick on CentOS 6;=20

Yeah, you'll need that if you refresh the git tree and configure.ac=20
or Makefile.am has changed.  Sorry, we should display it more prominently :)

> on CentOS 5 I get
>=20
> checking for SSL_OP_NO_TICKET flag in OpenSSL... no
> configure: error: OpenVPN 2.4+ requires SSL_OP_NO_TICKET in OpenSSL
>=20
> which is logical as the "stock" openssl lib on CentOS 5 is openssl 0.9.8=
=20
> ; to me, this breaks CentOS 5 builds, as I have no option nor desire to=20
> build & install openssl 1.0 on them.

Mmmmh.  Steffann has already answered this - it "should" work with recent
versions of 0.9.8, but some of the distribution vendors have the nasty
habit of not bumping their versions but just backporting security fixes -
so your 0.9.8 might be "0.9.8d + security fixes", not "0.9.8-current"
(which would be 0.9.8za).

You could build using polarssl :-) - but that will require installation
of a separate ssl library as well, so, not much better than "build &
install openssl 1.0".  Hrmph.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--zN1HJFR/B7wwTray
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU8AyFKkuBuNlUUl1AQJEAgQAv7CJE3hYLexACfWyFWzd7ibK/WcKmAXf
K86hFjFGdj1VjJNEf7e+3JaM4SYb0+dx84D+wA8kOzBsQ8xDFEyomzJWqbTYO2eb
G7nf2V/WcFX/FOEy8saHXAr+KuxKxC7zNe17j95flaVwlqCh50UfsuwUnz9ouo0/
jWQoiJt8NE0=
=wz0u
-----END PGP SIGNATURE-----

--zN1HJFR/B7wwTray--

