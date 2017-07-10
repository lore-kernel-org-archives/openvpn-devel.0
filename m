References: <20170221192737.24166-1-davids@...515...>
	<20170221192737.24166-4-davids@...515...>
	<24404f85-157d-6d20-9fb7-8b942360a50d@...2181...>
	<20170710063017.GE97029@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d8ac12f5-380f-4a1e-0fea-f96df50c1705@...2181...>
Date: Mon, 10 Jul 2017 14:33:43 +0800
MIME-Version: 1.0
In-Reply-To: <20170710063017.GE97029@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IoCIvttDKToc9jXjdAartaq7GsWXfLGFn"
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Replace deprecated LZ4 function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net, Christian Hesse <mail@...1798...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IoCIvttDKToc9jXjdAartaq7GsWXfLGFn
Content-Type: multipart/mixed; boundary="dmlDTxGiSNsqs8IaiUK1h3rglHLG70lu0";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: David Sommerseth <davids@...515...>,
 openvpn-devel@lists.sourceforge.net, Christian Hesse <mail@...1798...>
Message-ID: <d8ac12f5-380f-4a1e-0fea-f96df50c1705@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Replace deprecated LZ4 function
References: <20170221192737.24166-1-davids@...515...>
 <20170221192737.24166-4-davids@...515...>
 <24404f85-157d-6d20-9fb7-8b942360a50d@...2181...>
 <20170710063017.GE97029@...1296...>
In-Reply-To: <20170710063017.GE97029@...1296...>

--dmlDTxGiSNsqs8IaiUK1h3rglHLG70lu0
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 10/07/17 14:30, Gert Doering wrote:
> Hi,
>=20
> On Mon, Jul 10, 2017 at 12:31:31PM +0800, Antonio Quartulli wrote:
>> Instead of cluttering the code with these ifdefs directly in the main
>> codebase, how about doing it in compat.h, like this (it's a copy/paste -
>> code might be wrapper by the mail client):
>=20
> Better, but I wonder if we shouldn't fix this in configure.ac - "if the
> system lz4 is older than what we bundle(*), use our compat-lz4.c instead"
>=20
> (*) ... or older than what we need, functionality-wise

If we do this, then we jump into the can of worms that David S.
mentioned earlier, I think.

Generally speaking, why not just depending on "libX >=3D a.b.c." and error
out (at config time) if such lib is not available ?

I think many other programs do exactly the same.

If we still want, we could provide a configure switch that says "just
use the bundled lz4", this way people may use it without installing a
system-wide lib.


Cheers,

--=20
Antonio Quartulli


--dmlDTxGiSNsqs8IaiUK1h3rglHLG70lu0--

--IoCIvttDKToc9jXjdAartaq7GsWXfLGFn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlljH8cACgkQ0+HICM1s
oFA8Aw/4mr9AHk7qULsnvzdHSU+Nw/z4QVPrFJmgojIeucxkqjUp8hVgM0OXa28e
qktYCRrrlBCnC7Fd4V6UsQfT8IYff+VB9ON/ohm4gQhL2h+2zug7T5eYhdG+51at
1znwetICVjW9pal9YhKbNebF0kxc21ce5yKbrlZVPgtTsmXQfuf5SV3a6RG/i68q
aWkOVP1hG2TRl81ZIXExB8/cDUc5cPyFx25a5M+ugVCev7K1MVu/Hv+C34jY2UuX
v1XwNDQm+GhlZgIDup5U6i/E6Ooqr8KKGcN0PqcXEaKYN+nTApSh/caymS3sSY4m
Z/PMH3qsP4r44NLLx5K2wDsDHMg0YeryZ+Wp13Kevl11HIXb4IfrV0JAZj9prRYC
TV5vMUVVksNF8wylLtUMQ6PxZYADHxfk5dhLozzwEtbtBV0nD3cjfpjnLMU9OmTz
ogif43Q86yV81h409/w+uPMfcSnnrO0/3X1/Qwl0ZlMCEL0ZiUE5qVPjyF1FpD1M
84rpyjeX4k8gJiI/lOCRwtZ430GaBq01LDjZtwp4H649kbC1hL9kKgaNN75xobBh
MLpvhy8PoSXsXhm65FgsuPasWVPri9R9xb8nINLBV+xnqi51eX2Xsc4B2XmqoOtg
KM88LBem6tSXpyeoJNrIDed7qqB6r2O4O8nmwiK6fjAvoKaMlA==
=RrBq
-----END PGP SIGNATURE-----

--IoCIvttDKToc9jXjdAartaq7GsWXfLGFn--

