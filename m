Date: Tue, 23 Aug 2016 15:49:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160823134955.GF78279@...1296...>
References: <1451908945-12244-1-git-send-email-lstipakov@...277...>
	<1451911424-12970-1-git-send-email-lstipakov@...277...>
	<20160822191828.GT78279@...1296...>
	<20160823134336.GE78279@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U3jK8g368jZ6I4TC"
Content-Disposition: inline
In-Reply-To: <20160823134336.GE78279@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Drop recursively routed packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--U3jK8g368jZ6I4TC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 23, 2016 at 03:43:36PM +0200, Gert Doering wrote:
> ... which looks like "the IP header ends up where the ethernet header
> should be" (every ping packet shows up as "new source address" on the
> openvpn server).
>=20
> I have no idea what this could be, but since we want 2.3.12 out *today*,
> we'll need to back it out of 2.3 for the time being.
>=20
> Lev, do you have time to investigate?

is_ipv_X() in proto.c is to blame here, as it breaks the buffer=20
for tap mode...

...
  /* IP version is stored in the same bits for IPv4 or IPv6 header */
  if (OPENVPN_IPH_GET_VER (ih->version_len) =3D=3D ip_ver)
    return buf_advance (buf, offset);
...

... and "offset" is only set !=3D 0 in tap mode - so in tun mode, it works,
and the code itself looks totally reasonable.

David, please revert both release/2.3 and master, and we'll need to=20
rethink this, not using "is_ipv4()"...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--U3jK8g368jZ6I4TC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV7xUgqkuBuNlUUl1AQJXqgP7BWYd6LRGvdOKp5yKme9QiMUEcIrQBwQ0
atqmaNLb9DGACqjs3RrmRe38g2IhpOF6stDGKe8ArPPDlWphD3+WA8TmkchiiHyG
TjdMtwaasip92fDABx+LdrjLA4nKhVodnIbnVUH/J+cSiyGlrVbZWUdX+FweO2pk
h8Esjtrd1Uw=
=534b
-----END PGP SIGNATURE-----

--U3jK8g368jZ6I4TC--

