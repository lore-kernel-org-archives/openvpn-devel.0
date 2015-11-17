Date: Tue, 17 Nov 2015 15:16:54 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151117141653.GP24952@...1296...>
References: <CAN-X3HSXj9a1kiKGBJ1eHgoTeA97WmpqQJPCYf5esKYQa8fLjA@...278...>
	<20151117130353.GO24952@...1296...>
	<CAN-X3HQ4Rf7RaCY27cLkdPo1kLtAHmXtXeM1jh=j=mPgQGeR6A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oHxSCaSS3y4TqjY8"
Content-Disposition: inline
In-Reply-To: <CAN-X3HQ4Rf7RaCY27cLkdPo1kLtAHmXtXeM1jh=j=mPgQGeR6A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix info.af == AF_UNSPEC case after
 commit 2bed089d31a12c2d0277e36a64964ebab6640f75
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Pellegrin <chripell@...410...>
Cc: openvpn-devel@lists.sourceforge.net

--oHxSCaSS3y4TqjY8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 17, 2015 at 01:43:50PM +0000, Christian Pellegrin wrote:
> I also see: "Could not determine IPv4/IPv6 protocol. Using AF_INET" in
> the logs (which points in an quite explicative conditional in
> socket.c). The configuration entries that might affect this and that
> are present in my configuration are:
>=20
> local [IPv4 address]
> lport 443
> mode server
> proto udp
> server [IPv4 subnet]
> topology subnet

I had the suspicion that this happens for the server side - "proto udp"
is the giveaway, as it will pass AF_UNSPEC to getaddrinfo() to get=20
"what is needed for dual-stack"  (which does not always work, but that's
a different story).  So, starting out with AF_UNSPEC is good, but the
actual socket later on isn't (it is what getaddrinfo() returns)...

The client side should be sorted out quite nicely now, but seems the
server side could need some more polishing - so thanks for your patch,
and since it already got an ACK by our master of socket.c, I'll merge=20
it ASAP.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oHxSCaSS3y4TqjY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVks21KkuBuNlUUl1AQJZFgQAlC2fQ71QQHaXoDh8fqWwgasCMOVhqsDL
YPdH+48IZP+rVcffB6OL276hnQlWp4zaLv2FxyxgAyl4zJ7XyWi9Ta7Q4mfC3vxx
3HWtNrjIXVk0Z08tlBVCtrmxJkhNd5jt2ALWeLNhdxGIbLlgASwheQwSrE44Rm4H
huNQKp07iao=
=ySfe
-----END PGP SIGNATURE-----

--oHxSCaSS3y4TqjY8--

