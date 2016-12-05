Date: Mon, 5 Dec 2016 21:05:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161205200504.GV78624@...1296...>
References: <20161121091013.imxgfilt3byyqu7u@...30...>
	<1479896418-16190-1-git-send-email-gert@...1296...>
	<20161123184321.GA28918@...1296...>
	<20161205190114.skhklwwhrqtz6hci@...30...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3SAtXwgGp429mN7"
Content-Disposition: inline
In-Reply-To: <20161205190114.skhklwwhrqtz6hci@...30...>
Subject: Re: [Openvpn-devel] [PATCH] Refactor setting close-on-exec for
 socket FDs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--R3SAtXwgGp429mN7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 05, 2016 at 08:01:14PM +0100, Alberto Gonzalez Iniesta wrote:
> The patch, after being adjusted to the new source, is not working anymore:
>=20
> Mon Dec  5 19:39:34 2016 Set FD_CLOEXEC flag on file descriptor failed: B=
ad file descriptor (errno=3D9)
> Mon Dec  5 19:39:34 2016 Set FD_CLOEXEC flag on file descriptor failed: B=
ad file descriptor (errno=3D9)

This is with "the debian patch", or with my alternate suggestion?

(I'm not sure if my patch is actually good enough as I think it's not
fixing TCP "after accept" sockets yet - but some sort of initial feedback
would be good :) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--R3SAtXwgGp429mN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYRchvAAoJEB2Cnv7KVigS9sQL/3TBOl3zc3VaTx3HDMFBSlQS
yQLux96WOhU+chM0K/GxIWmrt4a/XKR6AjqqWttX4kuyW1QrGOo3ky/onpNgpOcF
EfwHPoEp+mvsGOjkUl5xzdGJuz9b+pzjmnO6gG0e+A4nkFfr0wIXoP7zm9yXXYrL
wWdBKux6Tr3NV9+1hKw9x169WOSCEqtU7AJCZqCTX+u1ddowEcJiUEVAb5u1tUXe
c7Uma6OdZttxyPY+v51M6kHQLE5YVVaBHS91vbo05HTHTplgTKwNRgoIReSH2xKO
qHiZDTdZUd1ytce+3E1trqDBPYeU7VGnGw3RrqZj9NsXDAHmXbH/ziervCgdHAbP
8arpOJ5u0lQ7pe4CnoRo1Rg2xqdT6LLlgl8ZwEkkWsag5hJ1ebavvTXONeO3TQ5F
ipx3iSIaVW2SLxOJFfdHfvx1wzH6/6SQggbAf0fH3MEXrO2GVd5wzEY0wN7Ki92R
iTT63/+CRcHH23SBtxavPWpAs0sr0IAJqN7LjfbSEA==
=yAfK
-----END PGP SIGNATURE-----

--R3SAtXwgGp429mN7--

