References: <20200908154157.13809-1-arne@...1227...>
 <f4128ade-e54c-00b4-0e16-c54e08ab0454@...2318...>
 <ea18a0ae-5512-ad24-ab13-48bfb8ef3a7b@...1227...>
 <a15ba93c-e908-7110-6b41-61b964ea436b@...2318...>
 <61cd03f5-5099-892a-5c08-13820275d978@...1227...>
 <97732182-f0dd-db05-257b-f59e0a0f6d43@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <22ba7745-caeb-5fca-804a-09e47da5601c@...1227...>
Date: Thu, 10 Sep 2020 10:38:32 +0200
MIME-Version: 1.0
In-Reply-To: <97732182-f0dd-db05-257b-f59e0a0f6d43@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yWKjS35X0G2p6nnya2Zsxgv9z6DhN5tes"
Subject: Re: [Openvpn-devel] [PATCH 0/4] Allow setting up OpenVPN in TLS
 mode without CA
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yWKjS35X0G2p6nnya2Zsxgv9z6DhN5tes
Content-Type: multipart/mixed; boundary="kkR29WTS4jfPZhsKjjmsWZtWTcBbnKyoI"

--kkR29WTS4jfPZhsKjjmsWZtWTcBbnKyoI
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 09.09.20 um 20:23 schrieb tincanteksup:
>=20
>=20
> On 09/09/2020 11:21, Arne Schwabe wrote:
>> Am 09.09.20 um 10:04 schrieb Fran=C3=A7ois Kooman:
>>> On 9/8/20 6:38 PM, Arne Schwabe wrote:
>>>> I really wonder which large deployment want to do that instead of a CA.
>>>> I really understand the need for small and simple deployments. But for
>>>> larger deployments a CA + CRL seems more useful for everything that I
>>>> can come up with.
>>>
>>> It would be more for the situation where you already have a "parallel
>>> trust", e.g. through an OAuth API where a CA would be redundant. Just
>>> having an API to register fingerprints (which would act as a CRL at the
>>> same time by simply removing fingerprints) is easier than having a
>>> complete CA with CRL.
>>>
>>> Of course, all of this can also be done by using a CA, and something can
>>> be said that if you operate on that scale you can also handle the extra
>>> "cost" of a CA...
>>
>> I am happy to review a patch that adds a allow_no_ca or similar flag to
>> the tls-verify option that allows this but I don't have a real
>> motivation to implement it myself.
>>
>> Just allowing ca not set with tls-verify script being set is a bit too
>> dangerous for my taste.
>>
>=20
> I too would like to see an external list of fingerprints be made availabl=
e.
> https://community.openvpn.net/openvpn/ticket/1323#ticket

Yes it would be nicer but this is for small setups and reconnects and
quick and cheap. I don't want this feature to evolve into a second PKI
infrastructure just worse.

Arne


--kkR29WTS4jfPZhsKjjmsWZtWTcBbnKyoI--

--yWKjS35X0G2p6nnya2Zsxgv9z6DhN5tes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9Z5ggACgkQFRhsZwKx
RFTA5A//R1bb6fkYBo3YLl6RQ+QiJhUFe6mHQyDKF7DqPasMBJXXwqveT324wk8k
R9YyYJ5k9Z9KN6W138PwTTcNEOGsHzHcMMg/cQg4D51IGrDFA6DlcCU+jjUarYf5
fshlzkznYzbZahK15+k/b65hs1qv6maOxZ3EJ4slMWsoXBGeJGOOohWJXPwc73Ev
C/TR2BFrgWRmau40bxRZDxmcFSE7wjrS2M6rpreA/PtkQeVEdFfR/Pp5NB/BzRIo
m0N04swHEpQIZovUNL+O7cEJLA51Ku+Nf4kiPiFDelrcLS8IE6AOqhW7Uni5nDsP
xwm+qioaDlUl4O+zMkla2WrTgYYGVrCAEtD6D+UXmKJ166ccMyQ6vBET9vgMrNYP
E05cA8JUjP7obm8RWMHc5WKypxh+/54kqP//PgSeUofKDNN+TdbIYuV2RU/lK229
rjR4Pf/W4pzFHyMCQ1mlCbErFlQnGGipU2TMWiBHWbpGJ+UD+pKGLvVvbXpcSLtN
/LSmwYx/j13mU9Y1Q/A9Qk2yCndrWMS+6O0kFSIrxp+EsgwKC2MW7wkROp9Ig9IO
zj2MT/Zaph+opWB0SfKmPwaSw1tHG9zEcfjF5HP11E6tdSVexKNLtX1Ox1eizqQA
lApFe/XoyS0Vy3AtR0PAsMDE/XKt8SCsD5xHDOD9YnSqLiuhGq0=
=yeA9
-----END PGP SIGNATURE-----

--yWKjS35X0G2p6nnya2Zsxgv9z6DhN5tes--

