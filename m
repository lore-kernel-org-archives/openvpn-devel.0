References: <20191128080631.117-1-lstipakov@...277...>
 <E1iaLck-0000Aj-5c@...2508...>
 <CAKuzo_jR6WYsM9QZhdyp8sW6avFGhDnFzx_dNN63JD4iiSmFag@...278...>
 <20191128194320.GM40538@...1296...>
 <2aa50cbc-cc17-81d5-ec9a-98fd5e8ba503@...2080...>
 <20191129105207.GU40538@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f9930229-0e7c-a03d-3050-dae11e59b2c6@...2080...>
Date: Fri, 29 Nov 2019 12:25:13 +0100
MIME-Version: 1.0
In-Reply-To: <20191129105207.GU40538@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WP9KCVozbP0XU63c4dqR8gSkfWdhrdg5F"
Subject: Re: [Openvpn-devel] [PATCH] fix clang warning about missing braces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WP9KCVozbP0XU63c4dqR8gSkfWdhrdg5F
Content-Type: multipart/mixed; boundary="YdiNQpUMsMXcICMqW6OdmVVj2Rw5dqui7";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <f9930229-0e7c-a03d-3050-dae11e59b2c6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] fix clang warning about missing braces
References: <20191128080631.117-1-lstipakov@...277...>
 <E1iaLck-0000Aj-5c@...2508...>
 <CAKuzo_jR6WYsM9QZhdyp8sW6avFGhDnFzx_dNN63JD4iiSmFag@...278...>
 <20191128194320.GM40538@...1296...>
 <2aa50cbc-cc17-81d5-ec9a-98fd5e8ba503@...2080...>
 <20191129105207.GU40538@...1296...>
In-Reply-To: <20191129105207.GU40538@...1296...>

--YdiNQpUMsMXcICMqW6OdmVVj2Rw5dqui7
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 29/11/2019 11:52, Gert Doering wrote:
> Hi,
>=20
> On Fri, Nov 29, 2019 at 11:47:02AM +0100, David Sommerseth wrote:
>> With GCC-4.3.8, I see this warning:
>=20
> This is about as old as you :-) - do we care about suppressing warnings
> in old gcc versions that might suppress a *relevant* warning when
> compiling with a current gcc version?

This is the default compiler on stock RHEL-7 ... which goes EOL August 2024.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--YdiNQpUMsMXcICMqW6OdmVVj2Rw5dqui7--

--WP9KCVozbP0XU63c4dqR8gSkfWdhrdg5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJd4QAZAAoJEIbPlEyWcf3yvz0QAIIlca/smnk9MlckHtRbzrTA
mZ051mo25Fxo+G1dh//x/Hh7xarQ9S55QHLc7o/w3DUUdaCDhjOyacquoB4aFwha
nUGudJoMlbJhpKrzLj5nELiS1ZoSP35bi2uXhm2nieMD4GnFuY4WrvBD0bGQ88wQ
vLUYdTtMWYCwGd3PHa1Pgqq7z8OcH4A3KH9wpMVVINjycFH0e0QSBOxlTs2Wh4yz
XpMwzO+Q6KI07y/yAdZ46nZQsUiltHB6ft8PnKTbaFtLVCjQpbfeml+rjtcm7DzC
7ke+IMta/lBj3IzuT6Ul07zJnafEU0E2OVzq54CVD4uF0CxksVa6CgypXGoXpWBl
5/yL9pL9cV/vayvhIkz0dL5sDf7b1x/T6X6HJaVPe7fqUgRNcbNCM/omWUCaKzZC
EHsYUQ96HmrV5Gz4yjM9n5sRVu1KzOZZbvUJFMW45Nxf6RBuc/11cNLF1X7Pxx1y
Z7cmT2gquij8yYYtgdvV3Q2p9wbfdeOqxA24K6EqMXszwBOqeWSloxRxFyVR0XZL
e6Cb/MaRiaeNR8RrrTh41wNt812qb6+BbPtkXGruckWdn2qc5FgFxzfQ6+fUV0Mb
aOuW1X61vR7/dVI+RUWxmGaXm0K1ck2jTK/jJckDIBU7BH5P61UjonGTIwUysWXO
SNsQvNnlBNsKaaygEBt/
=RAyU
-----END PGP SIGNATURE-----

--WP9KCVozbP0XU63c4dqR8gSkfWdhrdg5F--

