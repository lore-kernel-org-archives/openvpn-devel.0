Date: Thu, 22 Oct 2015 15:26:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151022132635.GF22054@...1296...>
References: <1445519360-24866-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rl8hGLns1effw9Fk"
Content-Disposition: inline
In-Reply-To: <1445519360-24866-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Use adapter index instead of name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Olli Mannisto <olmannisto@...277...>, openvpn-devel@lists.sourceforge.net

--rl8hGLns1effw9Fk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 22, 2015 at 04:09:20PM +0300, Lev Stipakov wrote:
> From: Olli Mannisto <olmannisto@...277...>
>=20
> Some windows machines get weird issues with netsh when using
> adapter name on "netsh.exe interface ipv6 set address" command.
>=20
> Changed logic to get adapter index and use it instead of adapter
> name for netsh set address command. if unable to get adapter index,
> try with adapter name.

NAK on that - it's extra code, another "two branches that need testing"
addition, and I have not seen any mention of these "weird issues" yet -
so please explain the problem scenario better.

(I might be happy to go for "use adapter index, always!", but I really=20
*really* do not want "try this, fall back to that!" unless it's well=20
understood why this is needed).

Also, I wonder why this is not needed for route addition if it's needed
for ip address setting..

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--rl8hGLns1effw9Fk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVijkCakuBuNlUUl1AQKBogQAsb6jECoXuJMis2JIUx9CWerHpjgBBhWi
o0AuOvm4vAINS0jXMCieceWga/v4IVpvOgmdNIXwAvYgp+2ZBHlEJBlrImk3A5LR
6O4gpUuT9N5X6Ie9yIlFdh2dJVc41++ueOb7e5W4kyMyw2j+O6KC99kyOTU/DeUx
sn6LPpogFmY=
=MhTI
-----END PGP SIGNATURE-----

--rl8hGLns1effw9Fk--

