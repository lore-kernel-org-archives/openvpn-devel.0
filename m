References: <20191103053148.18059-1-tom.ty89@...277...>
 <20191103182443.GC40538@...1296...>
 <20191103183351.GD40538@...1296...>
 <CAGnHSEn0jaM3u9LCXxArhQkL9ddZQ9UROOZ8+PXPf+oAwTyswg@...278...>
 <20191103204613.GE40538@...1296...>
 <CAGnHSE=LcwX6hxHM2sdpWRP6cKyQiuhtc4ZUG2H1rdu-CNHOqQ@...278...>
 <20191110180755.GQ40538@...1296...>
 <CAGnHSEkL5UY+q9p3j-UoOrBPcrhoNPyzSbEAMA4+x72jH46HGQ@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5dbf208f-3a4d-7732-e09b-36b1b2466a67@...1227...>
Date: Mon, 11 Nov 2019 19:02:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAGnHSEkL5UY+q9p3j-UoOrBPcrhoNPyzSbEAMA4+x72jH46HGQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iI96yWiXYyirXJl9kdWdXFPF56ZQrWEPU"
Subject: Re: [Openvpn-devel] [PATCH] tun/iproute2: support 31-bit ipv4
 prefix (RFC 3021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom Yan <tom.ty89@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <a@...2181...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iI96yWiXYyirXJl9kdWdXFPF56ZQrWEPU
Content-Type: multipart/mixed; boundary="6WFSiZz7YqAfJwF9CEUcbIe6d7zoejM3S"

--6WFSiZz7YqAfJwF9CEUcbIe6d7zoejM3S
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 11.11.19 um 16:12 schrieb Tom Yan:
> Yes both iproute2 and sitnl works perfectly as expected. Will the fix
> be backported to the 2.4 branch?
>=20
> P.S. For the record, if the client is ics-openvpn with openvpn3,
> somehow you need push route (either host or subnet will do) anyway.

I am not aware of this issue. Could you go more into detail?

> This is not necessary with ics-openvpn with openvpn2 or OpenVPN
> Connect (AFAIK its core is openvpn3 as well, albeit different
> snapshot). The problem/behaviour is not specific to /31 subnet though,
> apparently. I guess the main route table is ignored/masked.

ics-openvpn is a) OpenVPN master b) uses a completely different logic to
handle network config (in OpenVPNService.java). So this patch does not
affect ics-openvpn in any way.

Arne




--6WFSiZz7YqAfJwF9CEUcbIe6d7zoejM3S--

--iI96yWiXYyirXJl9kdWdXFPF56ZQrWEPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3JoigACgkQFRhsZwKx
RFQCaw//cSIAUY1XiuprpgLlXPOAc+7ZiKUiGJ7LE/kq1fg8lG4fhbITfemnk2L/
tSxvEqLANOkQq/KBOB9k/9YsrXj/xOLLRnrQSp31JZ0BN17GwYPjvWdcwR/C5Lpf
Y5HnAaOAThOycJxwa4A0tC/R+S3ofaWD4eEBqkvskbTEbifKoi6+8//kgOWdRCE7
1zvfKZcJa1eHCewne3akW23Mf5qjLBPMqGzDpS8xivGpCQuqdjcv/Te8w5Uj2M9c
YKREJDDvn1kvz4ZUI8BW0Hy/0gNoX5pgHR1P6C5//j/demkD20GR8nL5dkA4tzFK
x71cYXF+OBDr3tfRKUp4eR0PG/MpKf8ThL7lDAl7/c3D00wR00ZwvqfBt4AivUQb
Yg1Rh81vdeWf/p+o0xIs/LZiZO3A9HId3e7NKoWAPy0NII67UPlnKAn/BANTD5kO
RV4CMnijL8wTd9HjTvsuf84qspok2nuG/LWX/PUGsb+SZbAWixcfTfzM9ecd7aqb
3OhD5Qf2h3AInWqA5ysDC8Z9d5kkfdGA+JxjtjtsTXyh+fdV/87183vk/VgtKvM2
rQ2sFfvUucDkoNpaWQ+D6weMJrKlwgbTHuwKTYx3oXf34vk2bcZU4hlWXd9x3G8+
UfZlnvi8sQypmPUTZEVOOsNkPnUVUmULCaZwy41825MOaVSx6io=
=KINC
-----END PGP SIGNATURE-----

--iI96yWiXYyirXJl9kdWdXFPF56ZQrWEPU--

