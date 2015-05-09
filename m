Date: Sat, 9 May 2015 12:17:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150509101724.GQ382@...1296...>
References: <1430518805.21119.82.camel@...1866...>
	<CAOazyz0KoSiUn=DA_0QBf3JXU=eQ1NJGQgtRw0z7DCo+E066Kw@...278...>
	<1430523426.21119.113.camel@...1866...>
	<554D4B33.4060401@...1114...>
	<2a24fe1d092410bcd9082565e92c78b2.squirrel@...2027...>
	<e8658b8ccffc58c2499f792462893012.squirrel@...2027...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKaPnVNVpyX08bAX"
Content-Disposition: inline
In-Reply-To: <e8658b8ccffc58c2499f792462893012.squirrel@...2027...>
Subject: Re: [Openvpn-devel] [PATCH] Use vfork() in openvpn_execve() instead
	of fork()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

--gKaPnVNVpyX08bAX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, May 09, 2015 at 07:55:56AM -0000, David Woodhouse wrote:
> A better approach would probably be to disable the atfork handlers in
> OpenVPN entirely since I believe we don't need them.

With the patch to #480 which moves the only "real fork()" (daemon()) to
"before any crypto stuff happens", we should never do any fork() now which
will cause crypto operations in the child - so, if these handlers can be
disabled (or turned into "assume there will be no crypto in the child, so
just plain FAIL if any is attempted"), this could be a possible avenue=20
out of this mess...

I'm not sharing David S.'s concern about vfork() being deprecated, but
if it is not actually fixing all aspects of the problem, it's not the
right solution anyway - so, no need to really decide about that :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gKaPnVNVpyX08bAX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVU3etKkuBuNlUUl1AQIf+wP/ZjazfMG4Jt/o+ADTOoYzcq5D4C2Ht78U
opaf21gqljKDdUJR/Ur5eyrJDUMho9P9KlOoLGypexFLIry4DVPBUJcsmQwNHjNa
y+c5uG47lv9EzLfHCV08/Dz2idhir0qLpMlvF9zkw+A4c/d2EbjrgJ8ubDS8Ilk1
5PEeXqrXVW0=
=fWXe
-----END PGP SIGNATURE-----

--gKaPnVNVpyX08bAX--

