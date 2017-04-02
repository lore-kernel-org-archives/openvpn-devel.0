References: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
	<CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
	<0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <95c70c5e-22ac-81ab-0fca-b9195f426f7a@...1856...>
Date: Sun, 2 Apr 2017 09:57:18 +0200
MIME-Version: 1.0
In-Reply-To: <0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oiXrW5owb7323lxu7sfqWWVGFxqr8LTfK"
Subject: Re: [Openvpn-devel] Upgrading EasyRSA 2's defaults
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oiXrW5owb7323lxu7sfqWWVGFxqr8LTfK
Content-Type: multipart/mixed; boundary="B6JhcUIn5wIviTgaMWuEUvbJRGhg7Btur"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <95c70c5e-22ac-81ab-0fca-b9195f426f7a@...1856...>
Subject: Re: [Openvpn-devel] Upgrading EasyRSA 2's defaults
References: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
	<CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
	<0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>
In-Reply-To: <0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>

--B6JhcUIn5wIviTgaMWuEUvbJRGhg7Btur
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 31-03-17 22:34, David Sommerseth wrote:
> On 31/03/17 10:56, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>> 2017-03-31 13:26 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
>> <mailto:samuli@...515...>>:
>>
>>     Hi,
>>
>>     We still bundle EasyRSA 2 with our Windows installers and it is
>>     prominently advertised on our widely linked to HOWTO:
>>
>>     <https://openvpn.net/index.php/open-source/documentation/howto.html
>>     <https://openvpn.net/index.php/open-source/documentation/howto.html>>
>>
>>     As such, EasyRSA 2 is used by many/most OpenVPN server admins.
>>
>>     However, the default values for EasyRSA 2 such as MD5 hashing algori=
thm
>>     and 1024-bit keysize seem totally inadequate for today's standards:
>>
>>     <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/va=
rs#L53
>>     <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/va=
rs#L53>>
>>     <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/op=
enssl-1.0.0.cnf#L57
>>     <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/op=
enssl-1.0.0.cnf#L57>>
>>
>>     I think we should upgrade these to something more recent. What would
>>     more modern reasonable defaults be?
>>
>>
>>
>> someday we decided to use DSA (instead of default RSA)
>> it worked ... until we started to use OpenVPN Connect for iOS.
>> next, we had to change back to RSA
>>
>>
>> the conclusion would be "test all available platforms and take a
>> decision", probably even set up special test server and ask people on
>> openvpn-users mailing list
>=20
> Always a good idea to test as many platforms as possible.  But we can
> also leverage all the testing which have been done indirectly by others
> as well.
>=20
> The suggestion from Samuli is to update the default key size and hashing
> algorithm.  MD5 is broken.  MD5 have been broken for years.  SHA1 have
> the recent SHAttering panic, which have its own set of challenges - and
> should not be used for certificates any longer (if I have understood the
> crypto-gurus correctly).
>=20
> Also considering that the "world in general" have been moving towards
> stronger keys *and* have moved towards SHA256 hashing in certificates,
> updating EasyRSA is more than reasonable.
>=20
> So, I would highly recommend using SHA256.  I have used that for my
> OpenVPN setups for several years already.  That works fine for me, and I
> know others have done the same.  This is actually the most challenging
> move, from a technical point of view - using a new algorithm.  But this
> algorithm is well supported by all OpenSSL and mbed TLS implementations
> OpenVPN can be built against.
>=20
> Secondly, updating the key length from 1024 bits to at least 2048 should
> not cause any issues at all.  Many users (myself included) often use
> 4096 bits keys without any issues.
>=20
> Swapping RSA for DSA is an issue of a completely different league. And
> DSA is by OpenSSH considered too weak; IIRC it was even removed in
> OpenSSH v7.0.

Yes, upgrading would be good if we still ship it.  I can echo David's
SHA256 / RSA2048+ recommendation.  Enough security margin, and very good
interop (not only crypto libs, but also smart cards, OS key stores,
...).  To not dramatically slow down connection setup on low-cpu-power
devices (e.g. home routers), don't go beyond RSA4096 though.

DSA is _not_ a preferred choice.  The original 1024-bit DSA is too weak
nowadays, and the 'larger' DSA variants are not even close to the wide
support that RSA has.

-Steffan


--B6JhcUIn5wIviTgaMWuEUvbJRGhg7Btur--

--oiXrW5owb7323lxu7sfqWWVGFxqr8LTfK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY4K7eAAoJEJgCyj0AftKIdksH/2pm7DPI7vV9mDA5zB0zvlOk
pW7KS/z7n+kgYkJVQJRMptZHl/daDOYDzZI/T6aL9SDBgVPn0Z0jaIWTGifDAEor
cZ7QP+xhfoF/0fArhLDoLvQxs1Yfu5k4Kk19cTyHPxFx0IwLihEhQGnhuU9xttUl
HXtGMRqp52i6DuOuIH908l4/JKEZO5NTrsxNnR46KWu6GPBfvRtD6FoiQqmXyfgI
6DIqOH7mAYl3pgMfTkv3ijxBJzbCIgUehcD9TL1y6hx3Bk3lYRdeQcUY+e56AkuV
2y7EG2kz0OithVRkfB5jCAXiGZbYYaewhh8wNB68hgLTwQP4E6BzYio5zOOrLYw=
=SmJ3
-----END PGP SIGNATURE-----

--oiXrW5owb7323lxu7sfqWWVGFxqr8LTfK--

