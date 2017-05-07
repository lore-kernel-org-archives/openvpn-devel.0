References: <20170426160021.25122-1-davids@...515...>
	<29e6daf6-6423-5fb7-ff55-7710b528ddab@...1856...>
	<1349e743-76a0-b021-0e26-94bb7694e820@...2080...>
	<5E3AAEBC-4B0F-409B-9ADE-2DFFED3CF29E@...2181...>
	<338076EC-09A1-4CDA-9D12-A905FD846831@...2181...>
	<f7f3b9b7-f3ca-fb16-3972-aa6ea7c7991c@...1856...>
	<497C1C9D-DBB7-415E-8FEB-B68FAC3D2D35@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3ce9d9c3-fb19-39a5-d3c7-446a95bc5c6d@...2080...>
Date: Mon, 8 May 2017 00:05:05 +0200
MIME-Version: 1.0
In-Reply-To: <497C1C9D-DBB7-415E-8FEB-B68FAC3D2D35@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4Ia5xiwIkeJ4UmlPIpBPsSlJ2tP5BbEfn"
Subject: Re: [Openvpn-devel] [PATCH] crypto: Enable SHA256 fingerprint
 checking in --verify-hash
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4Ia5xiwIkeJ4UmlPIpBPsSlJ2tP5BbEfn
Content-Type: multipart/mixed; boundary="OMTRtA1GWUjfbc2TwksMiX9e2SQ5FAl3P";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Antonio Quartulli <a@...2181...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <3ce9d9c3-fb19-39a5-d3c7-446a95bc5c6d@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] crypto: Enable SHA256 fingerprint
	checking in --verify-hash
References: <20170426160021.25122-1-davids@...515...>
	<29e6daf6-6423-5fb7-ff55-7710b528ddab@...1856...>
	<1349e743-76a0-b021-0e26-94bb7694e820@...2080...>
	<5E3AAEBC-4B0F-409B-9ADE-2DFFED3CF29E@...2181...>
	<338076EC-09A1-4CDA-9D12-A905FD846831@...2181...>
	<f7f3b9b7-f3ca-fb16-3972-aa6ea7c7991c@...1856...>
	<497C1C9D-DBB7-415E-8FEB-B68FAC3D2D35@...2181...>
In-Reply-To: <497C1C9D-DBB7-415E-8FEB-B68FAC3D2D35@...2181...>

--OMTRtA1GWUjfbc2TwksMiX9e2SQ5FAl3P
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 07/05/17 14:17, Antonio Quartulli wrote:
>=20
>> On 7 May 2017, at 20:15, Steffan Karger <steffan@...1856...> wrote:
>>
>> Hi,
>>
>> On 07-05-17 14:03, Antonio Quartulli wrote:
>>>
[...snip...]
>>> I forgot: the good point of *not* having a default is that when you wil=
l add a new enum value for that
>>> particular enum type, the compiler will throw warnings for every switch=
 block you have, informing you
>>> that now they need to be updated. Having a default will leave you with =
manually check the various
>>> code spots.
>>
>> This only holds when compiling with -Wall, which we do not do by default
>> (because our current code would emit quite some warnings).

I actually do my local builds with -Wall, as well as the Fedora/Fedora
EPEL builds do that too.  It's not that terrifying as it once was.
Well, currently most of the errors are in ntlm.c; the rest are just a
few handful ones, where at least one of them already have a patch
awaiting review on the ML (lz4 API update).

>> If we would fix our code and compile with -Wall -Werror, I'd agree.  But
>> as long as we don't, I prefer a defensive code style where I can exclude
>> undefined behaviour just by looking at the code.
>>
>=20
> Agreed. This sounds like a call for a cleanup mission :]

I presume you meant this on a generic level, not this patch explicitly,
right?  If so, I don't need to worry about a v3, as the v2 of this patch
is already in this mail thread.



--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--OMTRtA1GWUjfbc2TwksMiX9e2SQ5FAl3P--

--4Ia5xiwIkeJ4UmlPIpBPsSlJ2tP5BbEfn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZD5oYAAoJEIbPlEyWcf3yGwQP/3X3kHnWBLkm1yF1egLKpOqF
5ZRa4/mCqmHzIQJ9mFuAHpiUbkEVLrtGwCzrKnqNDVj2c8t2zysI1D5xTGv8khYP
KuGb1I7QjFBBU/ArPAcywzToNPZDY2tUx8MfIOAePYAkIrNSWiI7Ygw33FARC5oQ
dMETnzTzrbRd487t4If2uttVJnQ+/e95XLaseJtNpI17B/uGAv9qebFYIW1DeqRp
z3cEZjgLG/lmeS7yhq/dF2qUUYAHas5x5YQTqn+zy2gIf3ku4YGqheRe5OhTaOTb
B/LnQN1ewvFB4y3flPDIetxaHGaebWOxgukHUCvTKzba+rgFIO8aWeRq3N7yhs1Q
Iu4I2jr2aThPuULV60BtvSVvIaU3yEuvmOY5HW/s16eB8NWgjOAqw6SxBm0VqfWs
O27YEwjRiWhvVxvXbT5iLgRO549vxLH8JOriXNv2MlFDyoARfhcBUA5LQ5VhLKdD
5+b0VLn8TjIF3yoMEjCEPn4n6uCFkd5dPbZfOMJiy7ljFHGVnvglMUms+LaIhbwf
cnB6sP2gMEAPzw4ye0efnR9SnGqi3b0blIMc4s3+cVqqh7UuFe4a1UAOWvvkr4c1
9ACGpblsVf+mWhvzuuTgEeJOh0YmAlk1BeH3niej0+h+459pI6LnIsbajMThymuZ
77uPrcMFd8vXXupRI9SI
=sVM2
-----END PGP SIGNATURE-----

--4Ia5xiwIkeJ4UmlPIpBPsSlJ2tP5BbEfn--

