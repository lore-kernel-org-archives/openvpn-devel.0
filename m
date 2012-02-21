Date: Tue, 21 Feb 2012 21:20:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120221202005.GD7024@...1296...>
References: <CAOazyz34oFXrQ8vh5qXcEFPC3wA8Qhn7ivzLKasB=B9mOCKyZQ@...278...>
	<4F43BEB5.6050404@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v6gilOcl2gU05R9Q"
Content-Disposition: inline
In-Reply-To: <4F43BEB5.6050404@...1114...>
Subject: Re: [Openvpn-devel] [RFC] openssl minimum supported version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--v6gilOcl2gU05R9Q
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 21, 2012 at 04:56:37PM +0100, David Sommerseth wrote:
> There might be similar restrictions related to autoconf/automake tools
> too.  As James has some automation for the Access Server builds for those
> supported platforms, we must be sure we don't break that for him.  From
> what I see, on a recent 5.7 box ...
[..]
> Otherwise, I presume most of the *BSD versions have more recent versions.

As Alon has already pointed out, to compile the tarball, you don't
need to have the autotools installed - and "configure" will work even on
older systems.

On the *BSD buildslaves, we can install whatever we need (and their
autotools versions are coming from ports/pkgsrc, and that's up-to-date=20
anyway :-) ).

Now we just need to see whether this causes problems for James' build
environment.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--v6gilOcl2gU05R9Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT0P8dakuBuNlUUl1AQJOpQQApKkNGYwB+K2S/+FQ+4tNBISYTt8xM67Z
xZmetJjRBngy1oxFRI4AxE3cO4j3ZCaMDyeZQd/vMcaNPhR1f68DXg/aR3e9Z04n
n34xafqf6O/RNN5+wIxQns9VezioB3axBeZ1sZdvH0FqUpS7dkv44Z5fsoWH64UQ
QweoRNENUcE=
=DP8r
-----END PGP SIGNATURE-----

--v6gilOcl2gU05R9Q--

