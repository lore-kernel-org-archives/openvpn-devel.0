References: <20200908154157.13809-1-arne@...1227...>
 <f4128ade-e54c-00b4-0e16-c54e08ab0454@...2318...>
 <ea18a0ae-5512-ad24-ab13-48bfb8ef3a7b@...1227...>
 <a15ba93c-e908-7110-6b41-61b964ea436b@...2318...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <61cd03f5-5099-892a-5c08-13820275d978@...1227...>
Date: Wed, 9 Sep 2020 12:21:46 +0200
MIME-Version: 1.0
In-Reply-To: <a15ba93c-e908-7110-6b41-61b964ea436b@...2318...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WAhFDwljclwZxE00AdOZJCQt7jR1Muoff"
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
To: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WAhFDwljclwZxE00AdOZJCQt7jR1Muoff
Content-Type: multipart/mixed; boundary="5bd1D610sEBCxGYHEVP8OkUTUQg8MGYCo"

--5bd1D610sEBCxGYHEVP8OkUTUQg8MGYCo
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 09.09.20 um 10:04 schrieb Fran=C3=A7ois Kooman:
> On 9/8/20 6:38 PM, Arne Schwabe wrote:
>> I really wonder which large deployment want to do that instead of a CA.
>> I really understand the need for small and simple deployments. But for
>> larger deployments a CA + CRL seems more useful for everything that I
>> can come up with.
>=20
> It would be more for the situation where you already have a "parallel
> trust", e.g. through an OAuth API where a CA would be redundant. Just
> having an API to register fingerprints (which would act as a CRL at the
> same time by simply removing fingerprints) is easier than having a
> complete CA with CRL.
>=20
> Of course, all of this can also be done by using a CA, and something can
> be said that if you operate on that scale you can also handle the extra
> "cost" of a CA...

I am happy to review a patch that adds a allow_no_ca or similar flag to
the tls-verify option that allows this but I don't have a real
motivation to implement it myself.

Just allowing ca not set with tls-verify script being set is a bit too
dangerous for my taste.

Arne


--5bd1D610sEBCxGYHEVP8OkUTUQg8MGYCo--

--WAhFDwljclwZxE00AdOZJCQt7jR1Muoff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9YrLoACgkQFRhsZwKx
RFQ+Tw/+Nh6PjumjPvbi8XSedvTwzan3TA6XfFRTBqLPUMWpt1w2cqiSqxkbJUA/
9ggaLggEvxkKIpbqNP11RYsK9FJ0yxPrHlxuqfmm5sYISsA6Y3cs1hK2119Aoel4
dmV1VN34u9hVZiaStfCUbIt35hzRM4VkgUHI37eQ2PW/vivxYPQTGQpKMGML7ErE
tL9sZNVsr1f/9JWpVDSSHNDzkhr8FpO1OUJHTet/dXlY2CX70WvT0Kvk5NRTB5DV
RmHTe8ren/3iHqe5l0iUDttPbKVyVo6bg6Fw8glrnWZ5o0mKTl8b9+QwEb5uiOen
8N6YKjDSUsqdG+lvTdZ0TWD0GtA4pDSHl0c93nAsjE3R7bWNFLxixpZlLwSoksuw
p1do4Yu1nZKwxuGFg4yi09IByQZol2/yeD8T75p1AwWBZS2p8plWh6Ybny8c8g7L
dFaZdOLTF/EaFR9nY9Ym9Hm+9ths2vSE+iXbbl6uv4Bj6L5EIdh8M2wRq+Qomn6U
7X+LPbwtKKnFZpNnrRfYEldINvjDL8zYkJGjqdHGJfuJss9oDwUd8txSQWQWAsgW
LeW9LyVw9eGf+BrTKStw9gi8D5fPAHZ0javDJksjYdLqmTy/sEundNo2ECNzVc4e
fEMAE7Qrf6SxN2Yp4OOeac+7pSA2FaNdKBgp2/tQIUtQAQKNac0=
=SgvY
-----END PGP SIGNATURE-----

--WAhFDwljclwZxE00AdOZJCQt7jR1Muoff--

