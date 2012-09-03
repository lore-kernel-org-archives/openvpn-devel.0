Date: Mon, 3 Sep 2012 09:09:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120903070957.GL18296@...1296...>
References: <1343837470-3923-5-git-send-email-arne@...1227...>
	<1346654982-25059-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bd2KlmcTHfsQFEJ+"
Content-Disposition: inline
In-Reply-To: <1346654982-25059-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Simplify print_sockaddr_ex function,
	merge duplicate ipv4/ipv6 logic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--Bd2KlmcTHfsQFEJ+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 03, 2012 at 08:49:42AM +0200, Arne Schwabe wrote:
> Some BSD need the right salen, max(sizeof(v4),sizeof(v6)) does not work. =
Since sa_len is not a member in sockaddr for Linux and Windows and SA_LEN i=
s no available on Darwin, NetBSD explicitly set salem

"Something sneaked into your keyboard"...

> +		getnameinfo(&addr->addr.sa, sizeof (struct sockaddr_in6),
> +					buf, sizeof (buf), NULL, 0, NI_NUMERICHOST);

... this very much looks like v1 of the patch...? :-)

Anyway, what about defining an openvpn_sa_len() macro that will either
use SA_LEN() if it exists, or fall back to=20

  #define openvpn_sa_len(addr) ( addr->sa.sa_family =3D=3D AF_INET? sizeof(=
struct sockaddr_in) : sizeof(struct sockaddr_in6) )

this will, of course, bite us when we implement IPv8, but should be fine
for 2.3...

(Is there something magic in Autoconf to solve this?  Must be a standard
problem...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Bd2KlmcTHfsQFEJ+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUERXxakuBuNlUUl1AQJi3wP/Zd0uVNXh4CwNWzuQ3oDJAfEJp6tJH6Kv
9RXHNOj7aac+DPjn6ToDP85R/hJb9ZN3O8uCynpoDLTMpvSneuz1FLvjfrKTazW1
U2yJsopGVHeax8tCjSdmfEE8HlLeNMGa9xgXSFNvSF4bjdTao75fVoaF4r0QZy7O
k3+CmM89DHY=
=t7O0
-----END PGP SIGNATURE-----

--Bd2KlmcTHfsQFEJ+--

