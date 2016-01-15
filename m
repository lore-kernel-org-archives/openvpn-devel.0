Date: Fri, 15 Jan 2016 20:10:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160115191024.GA24952@...1296...>
References: <56936C78.3020505@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6NZ5wE66EeS4ZZd"
Content-Disposition: inline
In-Reply-To: <56936C78.3020505@...515...>
Subject: Re: [Openvpn-devel] Disabling auth_pam plugin by default in
 openvpn-build?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--z6NZ5wE66EeS4ZZd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 11, 2016 at 10:48:56AM +0200, Samuli Sepp=E4nen wrote:
> There is a pull request in GitHub to openvpn-build, which disables=20
> auth_pam plugin by default:
>=20
> <https://github.com/OpenVPN/openvpn-build/pull/10/files>
>=20
> For Windows this makes sense, as PAM is not present. However,=20
> openvpn-build can also be used to cross-compile for the ARM=20
> architecture, in which case PAM might be useful.
>=20
> Does the pull request makes sense, or should we just fix this with=20
> better documentation, e.g.
>=20
> "If you're cross-compiling for ARM, make sure you add=20
> --disable-plugin-auth-pam to EXTRA_OPENVPN_CONFIG"
>=20
> Thoughts?

What happens if you run openvpn-build "as is" for windows?  Will it=20
abort (because there is no PAM) or just print out a warning and compile
fine without requiring --disable-plugin-auth-pam?

I tend to "leave everything as it is", and (if needed) document for
which platforms the switch is needed, and where to put it.

(Removing --disable-snappy would be a good idea, though, as there is no=20
such option...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--z6NZ5wE66EeS4ZZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVplEHqkuBuNlUUl1AQK5UQQAn0QI0e0LBQ3ZkFiFW+lx43uN+x21fii+
1MQ/jd7am5mOVQl+f7OGTvh7XdbJKncn8aJm/tCTQ3a9JO+fxwQPPvridZRmxoXw
8FHD0PnycdtFHobf1ar82LwpCp/ny0rnzASbf8xWdlZuCMRIblFsHxR4RIZZyD06
20LNjRZ/NOA=
=NOru
-----END PGP SIGNATURE-----

--z6NZ5wE66EeS4ZZd--

