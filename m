Date: Thu, 26 Apr 2012 19:24:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120426172410.GT1359@...1296...>
References: <1335441085-18186-1-git-send-email-davids@...1347...>
	<CAOazyz3-f2YkXE_vV2Oum+p4exQTUis=Q9RTOrvZ7WC0WEZymg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JR9NRh6vPwO5rijN"
Content-Disposition: inline
In-Reply-To: <CAOazyz3-f2YkXE_vV2Oum+p4exQTUis=Q9RTOrvZ7WC0WEZymg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Presume that Linux is always IPv6
	capable at build time
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: David Sommerseth <davids@...1347...>, openvpn-devel@lists.sourceforge.net

--JR9NRh6vPwO5rijN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 26, 2012 at 07:03:40PM +0300, Alon Bar-Lev wrote:
> I plan to add --enable-ipv6/--disable-ipv6 to explicit support ipv6.

NAK.

We considered this, and this will add a shitload of #ifdefs which will
make maintenance of the code a lot harder.

(We actually *removed* all the #ifdefs of JJO's IPv6 transport code,
because it really hurt)

We're in the year 2012, there are no operating systems without IPv6
support anymore, and it does not make sense to have a VPN implementation
that has no IPv6 support.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JR9NRh6vPwO5rijN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT5mEuqkuBuNlUUl1AQIIfwP/S0OLcCjpqM0B08NwDYrPvyJqN8BSoizE
AI8vnEIfhA/P4NN0ElqYaMUUF8NSvng5r6Fux9YWslQk94BzvfFmFRx1jKra3Ae0
afYmw5jo4nudtHuNKoJ7S9RRNaMEf6kuOhMtotzzCsna91SxPdFiUCidyFT0tKcr
bDTtelDWOTs=
=dgJY
-----END PGP SIGNATURE-----

--JR9NRh6vPwO5rijN--

