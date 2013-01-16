Date: Wed, 16 Jan 2013 11:11:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130116101123.GU22465@...1296...>
References: <CABT9mj_oAJ6sRy0_TKrWBVdN5OeTBVwC+-GmAkHbUPmpi=j5HQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qqPCXMeM81mi5CoR"
Content-Disposition: inline
In-Reply-To: <CABT9mj_oAJ6sRy0_TKrWBVdN5OeTBVwC+-GmAkHbUPmpi=j5HQ@...278...>
Subject: Re: [Openvpn-devel] compiling with visual studio
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Athanasios Douitsis <aduitsis@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--qqPCXMeM81mi5CoR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 15, 2013 at 09:03:07PM +0200, Athanasios Douitsis wrote:
> Trying to compile 2.3 with visual studio 2010. I am getting the following
> error:
>=20
> init.c(186): error C2143: syntax error : missing ';' before 'type'
> [C:\openvpn4\openvpn-build\msvc\build.tmp\openvpn-2.3_master\src\openvpn\=
openvpn.vcxproj]
>=20
> (after that there are many many more errors, but you get the idea)

Oh well, we've done it again...

  if (management)
    {
      gc =3D gc_new ();
      struct buffer out =3D alloc_buf_gc (256, &gc);

... this is not allowed in visual studio (having a variable declaration
after "non-declaration" code), but gcc doesn't complain, so we usually
don't notice.

> Which puzzles me, because I thought that OpenVPN can actually be built wi=
th
> visual studio. Is there something I'm missing?

Visual Studio is a big pain, so we cross-compile using MinGW64 from Linux.

Samuli has a wiki page somewhere on community.openvpn.net that explains
how to build OpenVPN in a non-maddening way.

But thanks for the report.  I have a Win7 VM that should actually be
able to do a Visual Studio build - I'll try to find time to look at these
issues and send a patch.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qqPCXMeM81mi5CoR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUPZ8yqkuBuNlUUl1AQL1tAP9Hkg01hPZ6mZgBAIF9kfTrrlyoG7jmexk
BGIbatLtsc7ejVAO52l+PpxJMb/blcPXWvlwICArnkTRAXMxPaCHJWd06XxYsL16
C2cauyM8E3sb3fNJ7xH40O+GS4COQs6kW/MgHJbF8v+52hkdovkmMx985MAcmluv
iWlgp/Wq8iE=
=LeCB
-----END PGP SIGNATURE-----

--qqPCXMeM81mi5CoR--

