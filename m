From: Antonio Quartulli <a@...2181...>
Message-Id: <5E3AAEBC-4B0F-409B-9ADE-2DFFED3CF29E@...2181...>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_0CA56EDE-C030-4D9D-B5D9-B3F9B5C4E5F7";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Sun, 7 May 2017 19:56:27 +0800
In-Reply-To: <1349e743-76a0-b021-0e26-94bb7694e820@...2080...>
References: <20170426160021.25122-1-davids@...515...>
	<29e6daf6-6423-5fb7-ff55-7710b528ddab@...1856...>
	<1349e743-76a0-b021-0e26-94bb7694e820@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] crypto: Enable SHA256 fingerprint
 checking in --verify-hash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn@...2080...

--Apple-Mail=_0CA56EDE-C030-4D9D-B5D9-B3F9B5C4E5F7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>=20
> On 4 May 2017, at 06:57, David Sommerseth <openvpn@...2080...> wrote:
>=20
> On 03/05/17 22:15, Steffan Karger wrote:
>>> +        switch (opt->verify_hash_algo)
>>> +        {
>>> +        case MD_SHA1:
>>> +            ca_hash =3D x509_get_sha1_fingerprint(cert, &gc);
>>> +            break;
>>> +
>>> +        case MD_SHA256:
>>> +            ca_hash =3D x509_get_sha256_fingerprint(cert, &gc);
>>> +            break;
>>> +        }
>> This switch should have a default: case that fails, otherwise we might
>> be reading from uninitialized memory.  And you might want to consider
>> initializing ca_hash to "{ 0 }".  (But you still need to default: case,
>> otherwise you'll be doing a 0-length memcmp()).
>=20
> *grmbl*  I was sure the enumerated type would make the compiler
> complain, but I must have mixed this with some C++ stuff I read not too
> long ago.  But my stupid test allows assigning an enumerated type to any
> invalid value as well.
>=20

You are right.
The compiler would have complained if you had left out any value from the e=
num set.
But the enum set is made of those two values only, hence a default case is =
not plausible unless you
assign verify_hash_algo with a value out of the enum set (but then you shou=
ld have a compiler warning
on the assignment).

Cheers,

--Apple-Mail=_0CA56EDE-C030-4D9D-B5D9-B3F9B5C4E5F7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZDwtxAAoJENPhyAjNbKBQYOwP/ialzi+LbCuJbUFrCMgvJHsZ
H5rXKlYkFdEaaTHYN3qNqNfdvqQAB4siC9VcmfIov8AjG5qB7BST3PaaP30wuqcF
l0fA2SE9MyypmJFUFl25cFeSbgGrcA9NXo3swB/5fKYE7Sgq6UmUQ7tXCxYEV6dp
vsjDfWETP5RkrNV9/4F2YKk3ds58OQVnVDxA/qtC96hJCSHT0gWZ/+jfMdF7NWty
+CAC7tanwIsVXk0+wXy8b7x2lHadYKDDtDZjEk3V1zEWsg5fenZJ0s3HR/NoXx9X
90WvUMomQU4B0E1wFSs4c7dtUpdoFJOAhoZZ+P0XgcPY+8JN90vS57npLcDFso/l
zS58hLtxdnli6oZWxMZCxdtLDKvumzj9V8i5cj0rLSDBHKkbwN3Y7ClTI0SHcEzX
9E7r35jNG9xKoS7ze0d3lq0xFXS03apNr3MYov9eL3MxxZwYDyTUY/fxJsXRZdZw
fsSIGygl8Y14u8J+38tzR3mmz+ZIKs9igC57ETpywPgFOTweHeR2eM0Emv7x2C8V
EdzftYFzlYNN4sl9xVh52kOcD9px8kUzssTTEMUS3jgN4bX66YWp+zc3XdW6hEAa
Q56xWe9awTm5QDJ/uAtlET4GwlWtjyyt3HJBSOWjem3FT9bENW/HeqZCNAoO4Xif
8hh3C5pF2TxsQCaN51ZW
=otku
-----END PGP SIGNATURE-----

--Apple-Mail=_0CA56EDE-C030-4D9D-B5D9-B3F9B5C4E5F7--

