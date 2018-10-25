References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1540208715-14044-6-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e4cff669-f962-f14f-0b41-7538af788597@...2181...>
Date: Thu, 25 Oct 2018 18:41:59 +0800
MIME-Version: 1.0
In-Reply-To: <1540208715-14044-6-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XRwhGM8HQL4FnUv643PyTt7qMe4KL32Gz"
Subject: Re: [Openvpn-devel] [PATCH v7 7/7] tls-crypt-v2: add script hook to
 verify metadata
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XRwhGM8HQL4FnUv643PyTt7qMe4KL32Gz
Content-Type: multipart/mixed; boundary="E33I8DVKX6J4wgyfHyJLGKtOLZLKHiSCY";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@...515...>
Message-ID: <e4cff669-f962-f14f-0b41-7538af788597@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v7 7/7] tls-crypt-v2: add script hook to
 verify metadata
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1540208715-14044-6-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1540208715-14044-6-git-send-email-steffan.karger@...1435...>

--E33I8DVKX6J4wgyfHyJLGKtOLZLKHiSCY
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 22/10/18 19:45, Steffan Karger wrote:
> To allow rejecting incoming connections very early in the handshake,
> add a --tls-crypt-v2-verify option that allows administators to
> run an external command to verify the metadata from the client key.
> See doc/tls-crypt-v2.txt for more details.
>=20
> Because of the extra dependencies, this requires adding a mock
> parse_line() to the tls-crypt unit tests.  Also, this turns tls_wrap_free
> into a static inline function, so that we don't need to compile in ssl.c
> (and all of it's dependencies) with the unit tests.
>=20
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

Acked-by: Antonio Quartulli <antonio@...515...>

--=20
Antonio Quartulli


--E33I8DVKX6J4wgyfHyJLGKtOLZLKHiSCY--

--XRwhGM8HQL4FnUv643PyTt7qMe4KL32Gz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlvRnfgACgkQ9FVsWUWD
Dm2jcRAAwEkRIJNJluh/MxWr8h0MrptaHUSjuEYSJ1T13pMPZ264AVGYcfcxNIDG
PvrRBroxcdPZ/SfoihQW5rtuHxIVjDPL1V7rIte77U68k2dnzSAQoFoGtl8XqNVv
8VAJQgAXQ/VMoPS1PaEvfvpxHl21ifS5bczgPZqCnUE53FW7NWEDoZPuzTfSLHKp
US8oymV+CsklpM/t4hE4mtIWXJ2xP/5xs0gZgXoNMLq5NMBpQEd2hEdcaQzsuC6r
W70m8jxojA8ahNoqjsk3Y1byQ8cLu5IN85y9i8n9k1F4OAE+eUOaKhfM2el1e1cM
WltQTopkR9ECcaH12sXGPBFe4kc9IpmYKOuYjMTbJLp80Lie++lxxjar4NrMURxU
ZHA08tHADZ62FjKuJRY8Gpb6krRXuKA2rIecRiLcFR9MwQctzyAdMB4o72KglvzY
2rj4cuF4KdskSN6jInfSLblLeWr741oeIViXNdE2n12y0k+pDYGa358Z7GI0Hrz7
x1dwHuNv1OiTEphfB542Ps0JRlv29BNCt5ggeZrRitZqfz1SO8Ed3Rrp2y7uerX2
UzvwdUJE022D9SlTUzH4FfEL+HX8lxk0pIECgr1VFVdapS6tA6ru3nTVJfOKIRD9
0FL1eUGEdNFVxBbSUlVBwGbLeudQXj5MmQEvsjjQtyVhCVW2n/Q=
=nYSK
-----END PGP SIGNATURE-----

--XRwhGM8HQL4FnUv643PyTt7qMe4KL32Gz--

