Date: Mon, 20 Feb 2012 22:32:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120220213246.GV7024@...1296...>
References: <CAOazyz08kLGKyq-Wcd1KTQ9akdQCAYPP9b1aMVne-b9TArMKDQ@...278...>
	<1329749121-24501-1-git-send-email-alon.barlev@...277...>
	<4F426F81.6040201@...1114...>
	<CAOazyz1DhzxPf3GS1dqhYKXSkL5NeSDy03z340VYibKWBKxPRQ@...278...>
	<CAOazyz1uZY2Entpuq4tn0DdBbQEZk32iugtmbttOkCrdbjK7Jw@...278...>
	<20120220203913.GU7024@...1296...>
	<CAOazyz2w6mYjDAsRrgDawrEpb0QegHZVYnqp04TFZC5DgDyRTg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kD0q5DIPXzY/lIlp"
Content-Disposition: inline
In-Reply-To: <CAOazyz2w6mYjDAsRrgDawrEpb0QegHZVYnqp04TFZC5DgDyRTg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] windows: do not use X_OK as it is
	unsupported
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--kD0q5DIPXzY/lIlp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 20, 2012 at 10:44:31PM +0200, Alon Bar-Lev wrote:
> It still touches the same places...
>=20
> The difference is the usage:
> ---
> R_OK|PLATFORM_X_OK
> ---
> or:
> ---
> PLATFORM_MODE_MASK(R_OK | X_OK)
> ---

Nah, that's not the way it should be.

Given that we currently use X_OK only in options.c, and have MANY lines
of the form

    errs |=3D check_file_access (CHKACC_FILE, options->crl_file, R_OK|X_OK,
                               "--crl-verify directory");

and only a single place where it will actually call access()=20
(or _access()), anything that makes all these lines harder to read
is making the code harder to read.=20=20

This code doesn't want or need to know anything about system dependencies,=
=20
that belongs inside check_file_access() - and there you have only a few
access() calls that need to do PLATFORM_MODE_MASK().

Or even better, do it in the openvpn_access() wrapper, in the #ifdef WIN32
code block.  That is the place where the WIN32 pain is, and nobody else
needs to bother.

int
openvpn_access (const char *path, int mode)
{
#ifdef WIN32
  struct gc_arena gc =3D gc_new ();
  int ret =3D _waccess (wide_string (path, &gc), (mode & ~X_OK) );
  gc_free (&gc);
  return ret;
#else
  return access (path, mode);
#endif
}

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kD0q5DIPXzY/lIlp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT0K7/qkuBuNlUUl1AQJ3WwQAvWCCQ379I+9UlsNKIp56vXqA13geDVdz
K+XynyI73mHlRkrU2YigBzTDe+HcqLnLbW45RwvshN2FJIEng1FoOoX4LgBXLkmq
0cyRSoO4e9SdMzLsNci0LvRGwwl85UCrXicl5sKTMcXXlAoEc7+032HMLXGw/yot
uAPmNybO0xw=
=YKWk
-----END PGP SIGNATURE-----

--kD0q5DIPXzY/lIlp--

