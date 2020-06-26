References: <20200626142947.12776-1-tincanteksup@...277...>
 <edef7a28-bbd5-3db5-3229-0d3a525bb577@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9a59f49f-32c7-ec41-1318-7e20008b7e8b@...2080...>
Date: Fri, 26 Jun 2020 16:45:24 +0200
MIME-Version: 1.0
In-Reply-To: <edef7a28-bbd5-3db5-3229-0d3a525bb577@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Hbb0ci1UptmxcgqjFKAsy1b3EOD5XkK4h"
Subject: Re: [Openvpn-devel] [PATCH] New man page corrections -
 encryption-options.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hbb0ci1UptmxcgqjFKAsy1b3EOD5XkK4h
Content-Type: multipart/mixed; boundary="XKmCZze63JkrdjNd71mH5d1V0xEjjXOrf";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: tincanteksup <tincanteksup@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <9a59f49f-32c7-ec41-1318-7e20008b7e8b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] New man page corrections -
 encryption-options.rst
References: <20200626142947.12776-1-tincanteksup@...277...>
 <edef7a28-bbd5-3db5-3229-0d3a525bb577@...277...>
In-Reply-To: <edef7a28-bbd5-3db5-3229-0d3a525bb577@...277...>

--XKmCZze63JkrdjNd71mH5d1V0xEjjXOrf
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 26/06/2020 16:34, tincanteksup wrote:
> Comment inline:
>=20
> On 26/06/2020 15:29, Richard Bonhomme wrote:
>> Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
>> ---
>> =C2=A0 doc/man-sections/encryption-options.rst | 8 ++++----
>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/doc/man-sections/encryption-options.rst
>> b/doc/man-sections/encryption-options.rst
>> index 42c80eb8..076b5fd3 100644
>> --- a/doc/man-sections/encryption-options.rst
>> +++ b/doc/man-sections/encryption-options.rst
>> @@ -86,5 +86,5 @@ Generating key material
>> =C2=A0 =C2=A0=C2=A0=C2=A0 * Generating *TLS Crypt v2 Server key*
>> -=C2=A0=C2=A0=C2=A0 Generate a ``--tls-crypt-v2`` key tp be used by an O=
penVPN server.
>> +=C2=A0=C2=A0=C2=A0 Generate a ``--tls-crypt-v2`` key to be used by an O=
penVPN server.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The key is stored in ``keyfile``.
>> =C2=A0 @@ -127,7 +127,7 @@ Generating key material
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *Note:*
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This file should be kept secret to=
 the server as anyone that
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 access to this file will be to gen=
erate auth tokens that the OpenVPN
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 server will accept as valid.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This file should be kept secret to=
 the server as anyone that has
>=20
> I don't know if this is correct or if it should read:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This file should be kept secret from=
 the server ..

It wouldn't make sense to keep a (shared) private key used for encryption
"secret from the server"; that would make it a bit difficult to use :)

I think what was meant was:

   "This file should be kept secret *on* the server ..."


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--XKmCZze63JkrdjNd71mH5d1V0xEjjXOrf--

--Hbb0ci1UptmxcgqjFKAsy1b3EOD5XkK4h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJe9goEAAoJEIbPlEyWcf3yHtkP/0mKIAPyKhYeiGybJ/CjIhyn
Hj1tbp1FnxMJykcpsWf70mwmzZQS+1DDYNolRsz1+CRjesLMmdRCqV9NYRI17yl6
f5XQQkztk4mDGIonfjlaoG0zAvtmLGMJIpK6XbmIVAhWZ6oZbplNbtLPwVTC1Ace
J6KJF+WCebPjExwJ895dqOjmBLC9X5xkZNTfHIvoVp/OwmGDIkvywzznW0YuouDQ
8/6DHdDZS9IFW14XoYNOtfTUWRNyxrhuIZltrQOCJ4wqgOC8XoKEpqcT++V6FqHu
fk6+5JRYop8Qql5BM2Y+4vw0/VPy3bt3zUhiMtNU52uSLJda1kYQBBhqdyUmsrU5
NhEM9zZqJT8jLGKH37kORXCX4lLFypyodaYWoXrizfsXcSlXJ1QYf5TGAoplQLy5
9FB+Sysm1LSiHQ0lTattPqwizaH4oC7GqaKyicRP6UPEB95leU9P/sT0oHAcfKTd
5b0nClqsA0RWIL98gBGieB3t6TPHtspNsrK6rQy7uRa8kFmodxxgRpwppKxSJlBF
33Pk/r4Hs5xCYTL9+JhpWKSM+ZfGUFiIR9AzhWRcFiSFgdpJNqSsi/b9qyzs7/mP
3axR8bns0PIjBKi5LbQS8MiL0G8BMjIUbyhoIvjDZ1dTmxmbaQlcSNpkzvlMs4Li
Vlbo4cI8WFBYTHKpxQ+s
=pwTC
-----END PGP SIGNATURE-----

--Hbb0ci1UptmxcgqjFKAsy1b3EOD5XkK4h--

