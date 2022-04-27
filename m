Date: Wed, 27 Apr 2022 16:26:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YmlSrcvSYjvcc6pH@...1296...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-7-arne@...1227...>
 <408bf431-bbfa-16c9-0b3d-be8676e408b4@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AxYusI+fwkXAYgp+"
Content-Disposition: inline
In-Reply-To: <408bf431-bbfa-16c9-0b3d-be8676e408b4@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 16/28] Move CRL reload to key_state_init
 from S_START transition
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--AxYusI+fwkXAYgp+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 27, 2022 at 04:04:41PM +0200, Antonio Quartulli wrote:
> On 22/04/2022 16:29, Arne Schwabe wrote:
> > The current place that we reload is a bit more efficient since it only
> > triggers reload after a completed 3way handshake. On the other hand the
> > key_state_init is a much more logical place and with the upcoming
> > HMAC based UDP code and TCP code, the initialisation will only be done
> > after a 3way handshake.
>=20
> There is something strange. Upon client reconnection the CRL is not=20
> always reloaded. It feels as if "some stuff" are already initialized=20
> (because we have a session for this client floating around) so we skip=20
> that initialization and we also skip reloading the CRL.

Is that different from "without the patch"?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--AxYusI+fwkXAYgp+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiaVKtAAoJEB2Cnv7KVigSS8kMAK34WIxwoV+mmYHHJjXuKCLu
cnwNYgPbZdQlbGXU+YasUeDQLrcAB1F+Ba6/J91sOn81TC0arr12XxOCufZ/j0ZR
wHsGm7n2VczifYdgRFEkPsZS4PI7ETL0iFGwCk34BlN8epAb7npvNftHCAIuyALf
jztg/IE3YYXq+nrX7pYKUj4y9ClkrWmAx529QyKUPQ4a1Weh+JtLFAChnkWTKse8
MgF2B/R1kzkUVqU3KKRw7qmWQZZSq6roxs9F2mLj6Xk3DP6Qla9mPlmjrbg8d+q3
ioStMiJE93iq4KXJ5/7ccifFTzOwln4tZ0rZWGNKUdrJtdCgXTDqTbkcNAzHSTk0
in+dc8j7rvhU63bma/MGrTqx0HIBjTkumvV0Pr1W4KrL0POWpCrnXN2woNAKrP93
axlMY+0741QNDjTSyfhb0PFtQz628h1g1C3jH5IuY5w6yxB2Fmgrk17OWv1kx7Ha
sAujAgQfsrS1adnXjp7D//YGC11dkHEWOVKRV2GfOQ==
=/Vns
-----END PGP SIGNATURE-----

--AxYusI+fwkXAYgp+--

