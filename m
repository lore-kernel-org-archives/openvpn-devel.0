From: Antonio Quartulli <a@...2181...>
Message-Id: <338076EC-09A1-4CDA-9D12-A905FD846831@...2181...>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_62BCDEFF-D865-4ED3-8D95-7CD236ADCE33";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Sun, 7 May 2017 20:03:05 +0800
In-Reply-To: <5E3AAEBC-4B0F-409B-9ADE-2DFFED3CF29E@...2181...>
References: <20170426160021.25122-1-davids@...515...>
	<29e6daf6-6423-5fb7-ff55-7710b528ddab@...1856...>
	<1349e743-76a0-b021-0e26-94bb7694e820@...2080...>
	<5E3AAEBC-4B0F-409B-9ADE-2DFFED3CF29E@...2181...>
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

--Apple-Mail=_62BCDEFF-D865-4ED3-8D95-7CD236ADCE33
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


> On 7 May 2017, at 19:56, Antonio Quartulli <a@...2181...> wrote:
>=20
>>=20
>> On 4 May 2017, at 06:57, David Sommerseth <openvpn@...2080...> wrote:
>>=20
>> On 03/05/17 22:15, Steffan Karger wrote:
>>>> +        switch (opt->verify_hash_algo)
>>>> +        {
>>>> +        case MD_SHA1:
>>>> +            ca_hash =3D x509_get_sha1_fingerprint(cert, &gc);
>>>> +            break;
>>>> +
>>>> +        case MD_SHA256:
>>>> +            ca_hash =3D x509_get_sha256_fingerprint(cert, &gc);
>>>> +            break;
>>>> +        }
>>> This switch should have a default: case that fails, otherwise we might
>>> be reading from uninitialized memory.  And you might want to consider
>>> initializing ca_hash to "{ 0 }".  (But you still need to default: case,
>>> otherwise you'll be doing a 0-length memcmp()).
>>=20
>> *grmbl*  I was sure the enumerated type would make the compiler
>> complain, but I must have mixed this with some C++ stuff I read not too
>> long ago.  But my stupid test allows assigning an enumerated type to any
>> invalid value as well.
>>=20
>=20
> You are right.
> The compiler would have complained if you had left out any value from the=
 enum set.
> But the enum set is made of those two values only, hence a default case i=
s not plausible unless you
> assign verify_hash_algo with a value out of the enum set (but then you sh=
ould have a compiler warning
> on the assignment).
>=20

I forgot: the good point of *not* having a default is that when you will ad=
d a new enum value for that
particular enum type, the compiler will throw warnings for every switch blo=
ck you have, informing you
that now they need to be updated. Having a default will leave you with manu=
ally check the various
code spots.

Cheers,

--
Antonio Quartulli


--Apple-Mail=_62BCDEFF-D865-4ED3-8D95-7CD236ADCE33
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZDwz5AAoJENPhyAjNbKBQchAP/2PfZYsHw51lUghuDpoY/IyU
xOGlvbJsuSVUc6AwaGJ/B7E4I2Lez4TyAIo8rYZhef/T1lDInuNRwGBwNAcGGGcc
+tCM+gmy29h0vYeP44iuU7v5qsvlvZ9oFg02BR8CSR2XIkEnh0qIA8wqFshrqVf8
GGL8KVXaKFG2ltXr+Ra4ljUuePUCUF3yTX0oThIwSaaxajTYXfz0z7bdH8xkDZNO
xQXAwzFan3NoMDnRywPXkILYZWEZtzbLKZxIMwOvFAGqI7aGXqALMmfskqZaLZtd
fEtTnVfmGqN+1GTExOqAL7NVWg/so1+OezTLpvFFM9kCGbZt0VEm0Ty6YRwEjSNg
79oq9ks/XCHXlZsF/wypkFqdHqJarkiTeowWz0vsFtTn0KWJgnAX3DKEcz6pJ8nf
v8l6unttiYie6F+2xdutQySh0gfrDmZgtCtQ+1EZKx73xAFnyR3C3eWCDvmpkgsA
ohe4u67GIFbpZZR+sD8zNqZSyTfZDJh6p7piwrlIsTyJO/5J/Z+aZPQsGLJEcam+
DGqhwZzE5VcHmAotxBEA+4Sjp2z7vZHwHXQ1w6qRo3DKv5SszD1BEI1clMqeyknM
GJZHLVtFYxpszN22MLsN5E1iwczs1POm4cjDLgLT8L1U16qwPoMaLx3vV0J+yl3r
sLA8tV+KnrmY4NoAKqps
=4keo
-----END PGP SIGNATURE-----

--Apple-Mail=_62BCDEFF-D865-4ED3-8D95-7CD236ADCE33--

