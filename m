Date: Wed, 19 Jun 2013 22:04:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130619200450.GL20843@...1296...>
References: <CABT9mj_BMkwO9rZ9T847GBaYrGbXdwCB76zyPDqnNKNr0nk5Dw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dPU/T1tN7XLa/WIG"
Content-Disposition: inline
In-Reply-To: <CABT9mj_BMkwO9rZ9T847GBaYrGbXdwCB76zyPDqnNKNr0nk5Dw@...278...>
Subject: Re: [Openvpn-devel] push route-ipv6 and metric
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Athanasios Douitsis <aduitsis@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--dPU/T1tN7XLa/WIG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 19, 2013 at 06:00:27PM +0300, Athanasios Douitsis wrote:
> I noticed that issuing the following command in the server config:
>=20
> push "route-ipv6 ::/0 2001:648:2000:ffae::1 15"
>=20
> does indeed make a windows client install that route, but it ignores the
> metric:

True.  There is no metric support for IPv6 routes today - half of it is
"because most operating systems don't actually support route metrics"
and the other half is "because I'm lazy and haven't found a problem
that needed metrics, and couldn't be tackled in a more robust way".

> Fwiw, I was able to workaround this problem by pushing two /1 routes,
> exactly like def1 does for IPv4. Like this:
>=20
> push "route-ipv6 ::/1 2001:648:2000:ffae::1"
> push "route-ipv6 8000::/1 2001:648:2000:ffae::1"

routing 2000::/3 is usually sufficient, as all globally routable IPv6
space is in there.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dPU/T1tN7XLa/WIG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUcIO4qkuBuNlUUl1AQL+5QP+N5nQjGwZYCzPh5Gd+Wloi1+q0VkaCEos
qQKjGNthPFsAXZfAC3U2FXaHzPVT4L1X9KsBSXN2TLccN1uVnh9WQ6cOz5vS5a50
mu9zoYNAh1FAQBXkTtgzTlCGQXS8WEFSeZWQpVioUGWqXjG6W9oob4chdlFldTrl
dZo5jO+1PHE=
=8wIj
-----END PGP SIGNATURE-----

--dPU/T1tN7XLa/WIG--

