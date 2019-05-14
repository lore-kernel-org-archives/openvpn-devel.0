Date: Tue, 14 May 2019 10:20:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190514082030.GM1097@...1296...>
References: <20181219050118.6568-1-a@...2181...>
 <20190514081159.12192-1-a@...2181...>
 <20190514081848.GL1097@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <20190514081848.GL1097@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3 -1/7] implement platform generic
 networking API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 14, 2019 at 10:18:48AM +0200, Gert Doering wrote:
> On Tue, May 14, 2019 at 10:11:59AM +0200, Antonio Quartulli wrote:
> > +#ifdef ENABLE_SITNL
> > +#include "networking_sitnl.h"
> > +#elif ENABLE_IPROUTE
> > +#include "networking_ip.h"
> > +#else
>=20
> NAK, this patch breaks compilation - there is no "networking_ip.h" in
> our tree, and this patch isn't introducing it either.

Oh well.  It doesn't break compilation, as networking.h is not yet
included anywhere.  And "1/7 v3" fixes the include.

So while this is a slightly confusing commit, it won't *break* anything
and I'll merge it ASAP.

Acked-By: gert@...1296... (Gert Doering)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJc2npNAAoJEB2Cnv7KVigS4C0MAIFxJrVadHwHREFsNl8+EwuF
j5pPDVzYNjCTA4Lfn5jmVCxgA62K3TF56zLxOH2Sjsw6+s0C2wnTz8cfpl8cKT8X
z/BUAs9VwYohkuzCnptGpd1p8auWFE7WjXrVYh++XLas8d9kjaICmiU017GIkB3M
RkvXjPFs5XzLxBRWg8vTM0Z3w25wLxMOIBVCjKSfw0ZY+osP6E8hC4KgjfAegNKK
1hiDuFnWnKHfLLDJlHC68M/2f1uq5KBqHfb5w96TjKrbdMiu7Iu9GMMw9CJYCRSX
mKTIN+Vko4ujd+at/dAz87eDgQZaGZDRSpL+QkUcxN1h8HPDrSYDAS8M489joevY
svJHzpLdX/Knw215TR0aOxwRsYSpgXlLscApsF79JoBxCaP7FegHFV9EnKi9kpbX
s94Rg1bPpQSI0T7d8vmKeVKwRdFV+OgabRHYyBATL6P/5RtakG8mJmS5p6M4DvmE
+ja7TcVYDyf8BwUGKxnuFbdZMe+RLROoqhC1PJiqog==
=cX73
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--

