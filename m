Date: Tue, 14 May 2019 10:18:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190514081848.GL1097@...1296...>
References: <20181219050118.6568-1-a@...2181...>
 <20190514081159.12192-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <20190514081159.12192-1-a@...2181...>
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

--+g7M9IMkV8truYOl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 14, 2019 at 10:11:59AM +0200, Antonio Quartulli wrote:
> +#ifdef ENABLE_SITNL
> +#include "networking_sitnl.h"
> +#elif ENABLE_IPROUTE
> +#include "networking_ip.h"
> +#else

NAK, this patch breaks compilation - there is no "networking_ip.h" in
our tree, and this patch isn't introducing it either.

If we need this together with 1/7 of the v3 series, maybe we really
need to make this into a joint "1/7 v4"... but every single patch needs
to compile (on mainstream platforms).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJc2nnoAAoJEB2Cnv7KVigS/xsL/3h/5vPwYwXdoQWiddpAYAz1
WEUk/sKR7Dee+uzn/CqWmi0T5UKUvdMgEeX6z8OKJEtL6ju16eZVwYUC+k3LTk0W
bo1jhOzwUrA+fPDbJHIcyqqciAMlv0qgUaGm/o30m8bAyP3+4NeRPszEZv0MfqOQ
B4uHbWri1W7W9ujX/g11DYnMlc63ph4BvYPodZT9TyZFBN2sheEVIXyiM4FA4xo3
kPIrMV3W7ow65/+FYOhsOxZtyHSv4Z1gEjQpYpRTxIP39p6Z2/jQkPvClw4H0TAd
oiUlbkwfdMXwUmlad60e9VYnpWIY10tuRWP1XGyc8KtG0UxBZS/FtiGgY+Qutr8g
/FmVSuuN1/DmxgEcDkldsAp3MWFLaqoE4EjPMZivLZPJLIvvAqHtH5M3RwYlzbiU
kcWONRqZWPsSTkBNegtF/WyTb0sBBulqoxjpji0lfXdRoU+WQTuV+KsBbCqyQqDA
rocQa8JzlTdOmT1i7oFJPN9dx2FRFZjUu62NwPoJjQ==
=9ALo
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--

