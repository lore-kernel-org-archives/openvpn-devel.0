Date: Sun, 1 Apr 2012 14:08:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120401120849.GB1359@...1296...>
References: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
	<1333012602-5419-3-git-send-email-alon.barlev@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4kf3ZaKr/mmDV0ZC"
Content-Disposition: inline
In-Reply-To: <1333012602-5419-3-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] cleanup: avoid using ~0 - ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

--4kf3ZaKr/mmDV0ZC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 29, 2012 at 11:16:40AM +0200, Alon Bar-Lev wrote:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  src/openvpn/route.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

ACK.  0xff is all that is needed, and makes it more obvious what is done -
"up to 8 bits are masked away".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4kf3ZaKr/mmDV0ZC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3hFUKkuBuNlUUl1AQJm0QP+Is+C7QeTuh5pikOAx3QzaVKmhB+Gtow/
tFN1W+GaGliUYDInVcjBvzBds+U3rWcWLR6Q+E6JfqhT3WY3Ea30FiC8Q1zzeYW/
a6PGOYlLTfLwUsAkuk9vLP5xeI7ztshWHQBb1WaPvNtHTgSdN8xTeDqFB7bRVknd
ER/L1+4RnRQ=
=YQdU
-----END PGP SIGNATURE-----

--4kf3ZaKr/mmDV0ZC--

