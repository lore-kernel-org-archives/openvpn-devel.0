Date: Mon, 12 Feb 2024 13:53:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZcoU0nFXFAZzWLw6@...1296...>
References: <20240209155109.110542-1-juliusz@...2525...>
 <5a267442-43f6-423a-9112-24b53cb5ca2e@...1227...>
 <6dd9197d-36e6-4694-8b9d-2e5d403c5835@...2525...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2KP62/YOOpsaF262"
Content-Disposition: inline
In-Reply-To: <6dd9197d-36e6-4694-8b9d-2e5d403c5835@...2525...>
Subject: Re: [Openvpn-devel] [PATCH] wolfssl: include "ssl.h" by
 "src/openvpn/ssl.h"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--2KP62/YOOpsaF262
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 12, 2024 at 10:57:41AM +0100, Juliusz Sosinowicz wrote:
> commit 70b39f2bea9fd6e57f31e32b2041246731140cb2 has added the use of
> ACK_SIZE and RELIABLE_ACK_SIZE in test_ssl.c. These are defined in
> reliable.h which should be included through your ssl.h. Since our ssl.h is
> being picked up, these never get defined and make check results in the
> following error:

Seems the unit test compile flags could use a bit of shuffling to
have our local include first... and that should solve it (if nothing
else breaks, just test_ssl.c)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2KP62/YOOpsaF262
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlyhTSAAoJEB2Cnv7KVigSBEQL/2JZsQFKfCeVE1b59ULQ18Ci
dHchiXSH+ZmvtMKexDeIZ2yIBH8PncmAncHkhPSwjuoWsOpf38duByNrAlBoSWWR
Br7lhfNToOwRZ5Z7NY79sgbdPRA3m2iG56x0FWXyuu/kfSQ3I6aw0kNQeZRIgwuz
DRzijbqze/FU5tUW8qOXzcYyPktN6/EFr/teYiCQHr0RWheBp2g3V0im0i78ywvF
uZj4Vg/O7TtgqM95//0ZtRYcE6ZCqyD18Wu/sFbFFlhdutoa1uXX9OsvJzngJcke
IzFXQVYx9STN/OsJn8+ZWIDbQ4RZbFwbHNlYrgM9pjDvgcQ8PkRY7fHoNEe7LfeK
1js67icOh1CI5TGnLwVOmLY7Duiy6yhdjkGKbCXHJtlllRTm59T8tSIS0csc62LH
cOGhq1P+cOmQEWJg2D6C7qJRzd/U2EpCe6e0UWagw8wJqqHclawcporq88Uv8Mx+
zP3dzmI/R5lq0wsTi2syuQhmmRZebVH9AuBsGzSfnA==
=nUB+
-----END PGP SIGNATURE-----

--2KP62/YOOpsaF262--

