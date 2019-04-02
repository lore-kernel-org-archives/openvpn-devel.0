Date: Tue, 2 Apr 2019 22:42:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190402204220.GU31008@...1296...>
References: <20190327120604.21101-1-davids@...515...>
 <20190402093714.8581-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6o78gXsyQHm68LY/"
Content-Disposition: inline
In-Reply-To: <20190402093714.8581-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH release/2.4] docs: Update INSTALL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--6o78gXsyQHm68LY/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 02, 2019 at 12:37:14PM +0300, David Sommerseth wrote:
>  OPTIONAL (but recommended):
> -  (1) OpenSSL library, necessary for encryption, version 0.9.8 or higher
> +  (1) OpenSSL library, necessary for encryption, version 1.0.1 or higher

This, in particular, does not look correct for 2.4

2.4 configure has lots of checks like this:

                OPENSSL_PKG_ERRORS=3D`$PKG_CONFIG --short-errors --print-er=
rors --
cflags --libs "libcrypto >=3D 0.9.8, libssl >=3D 0.9.8" 2>&1`

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6o78gXsyQHm68LY/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJco8krAAoJEB2Cnv7KVigS3ZgL/Rld9aX0juNdgannD6fiqfbt
kSWxuXWWlV5A9fTzIVCymr/KsKF41H35QNh9u47SyHu6js2TPdTOfi4YD7SWfAlq
sl10VHWvmxuo5TyZR/rZqyNMSBII9wf4WBKMisQo5Syu/cVbA8g0aNgHk+Iokmfp
uXlK51D8CknUpLAnsKyjtOscVI5oyGsOjiVeY2D0BGqNBO4RV3Kxo4wMBeRwUC6I
L4HIee+28Uhnvem1JbqC9CtPMr9lJLnzv80drUsfqXQCILKR524yuC1Bvp058EjM
Vr7qrxN+irPzK+jGzcas/EU1/Qir2OHFWBbJb+UsmTvGtOnZHWRtrS57djlBI1qt
Whqrjw9BhRhUce1oMRGStsRLgQLqLpTTIHyvf/bzGJ4rr9fpWg+bPThx1Oq5Qq2d
evSIyJVKjEfAzpTj/05/emios1pSDvyQ8CKvT70WoF5K2W/0oD3bSyCSK6Zw7gUT
Vc74jFhRBv2Si7oYzMoACVrz9BPVbrj+tuD9uVOugA==
=vvkM
-----END PGP SIGNATURE-----

--6o78gXsyQHm68LY/--

