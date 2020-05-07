References: <20200429145132.28424-1-juliusz@...2525...>
 <41fef456-3ced-7cb3-7888-46a3522080b2@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <adff39d0-a071-0522-9869-a7cc1893b26f@...1227...>
Date: Thu, 7 May 2020 12:35:14 +0200
MIME-Version: 1.0
In-Reply-To: <41fef456-3ced-7cb3-7888-46a3522080b2@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="a7UyJzkMjjVmkQCcMHkFyrg1GYYm34eCO"
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a7UyJzkMjjVmkQCcMHkFyrg1GYYm34eCO
Content-Type: multipart/mixed; boundary="6NeUVTFg6pXCxTvxzdS9NIDz8RZmGqB42"

--6NeUVTFg6pXCxTvxzdS9NIDz8RZmGqB42
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 07.05.20 um 12:28 schrieb Antonio Quartulli:
> Thu May  7 12:16:12 2020 library versions: 4.4.0, LZO 2.10

Additionally it seems the OpenSSL_version(OPENSSL_VERSION) function does
not include the library name. OpenSSL reports itself here:

 library versions: OpenSSL 1.1.1g  21 Apr 2020

also other library will say LibreSSL or BoringSSL in place of OpenSSL
here. It would be nice to have here wolfSSL or OpenSSL (wolfSSL compat
layer) or something that indicates wolfSSL in the
OpenSSL_version(OPENSSL_VERSION) result.

Arne


--6NeUVTFg6pXCxTvxzdS9NIDz8RZmGqB42--

--a7UyJzkMjjVmkQCcMHkFyrg1GYYm34eCO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6z5GIACgkQFRhsZwKx
RFSGsA//cxIMISNkv2h9nTHSbyFTBB+t20RTN7FERPBwSlQrSS0koYUGHlmjWTnP
bHq1sUzdNw0Q3ItQQGJdGPuTvqIzjfs/URjXlV84fnnp5yjb8f4WjFGPGnFBJGPl
9WCV23dDPH3V3VowEsuYG06P5HJ5jEQ/CJXhTP5vRqShSq7rNCOIZPs02qZ1b9FF
30/9ETYFUK3wJyQZK4modnA6BU6/LqmbmGNVa04cI6ezIdPYxHADUGD7NiQZtNKa
2JZjGgOOl9l9sF41vxoSkw+0j2ujyJl9yxJRLYANxZNU7bGFHV/EzElgMRS2lJ57
4yBmbx3+BbRQetUqWY07z1wahnlAntZr1cHZyBgqnUwiuinDEkU1fZKaDY7zEXPP
B/nixNh2eN+iHUSZNHrg1wtq9u8KuXeCUy0Is2CoXsnDE/RXu/ALGJEP+YXqfVDH
NCcJpgbsPs5sZXR+jn3f4cjEoDvPrAabyGGoUv3arRZ9yuEwlDkw8euypsu03zl8
vro2ceUb6cnleym9g9KJ+r+TJjbDR8MiOC4jZ29HZRc4vE6V711lLcDT3rylyzuj
S+AtxuiY+QwAEAtlxmPxJjxeebewoT8hRauwuux2YGMTI7yka6sUguSFiwGNWRpT
PyGxacJ2mks+/UqD25LqOH1P52+YRl7dxVL7F6jZHJ1QxmoOsfs=
=LKkP
-----END PGP SIGNATURE-----

--a7UyJzkMjjVmkQCcMHkFyrg1GYYm34eCO--

