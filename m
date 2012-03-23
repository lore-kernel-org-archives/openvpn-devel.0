Date: Fri, 23 Mar 2012 15:44:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120323144417.GD1359@...1296...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-49-git-send-email-alon.barlev@...277...>
	<4F58B2E6.3090702@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DvpQYQy10PodzGf7"
Content-Disposition: inline
In-Reply-To: <4F58B2E6.3090702@...515...>
Subject: Re: [Openvpn-devel] [PATCH 48/52] cleanup: move console related
	function into its own module
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--DvpQYQy10PodzGf7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 08, 2012 at 03:23:50PM +0200, Samuli Sepp=E4nen wrote:
> Currently many files (42) include misc.h, which is a lot. Also, misc.c
> is among the biggest files in the codebase[1], so splitting it into
> smaller files with good names and well-defined functionality makes sense:
>=20
> "Oh, this include console.h, it must be using some console-related
> functions"
>=20
> Feature-vise I give this one an ACK. Somebody else might want to look at
> the actual changes.

ACK on the actual changes.

I verified that the code only moves, and is not changed.

Three exceptions from "code only moves":
  - getpass() disappears, because it's dead code anyway
  - the declaration of cmd[256] from get_console_input_systemd()=20
    disappears, because it's unused=20
  - a few 'static' declarations need to go away

but these are fine, so ACK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--DvpQYQy10PodzGf7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT2yMQakuBuNlUUl1AQKpmgQAgWxH+41NAz2MQ4k6FTPMrcnB6Oiw1TRU
Oq6z2EEjKklZoOEnE4vL1NbvfCuyHG38rIychUY/vazSZKKhgbmuy5CkA9ejZelE
Wya6bwsPqoEuKQaobj32hqaL6XOnvgPTgTnwyJvvfpj2s6y4KzUqF5r1RgtPa3eX
cku922x+whE=
=q+Df
-----END PGP SIGNATURE-----

--DvpQYQy10PodzGf7--

