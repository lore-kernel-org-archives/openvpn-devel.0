From: Antonio Quartulli <a@...2181...>
References: <20170716082207.23646-1-coroner@...2290...>
	<53e22340-d528-13b8-8ed2-2954bef71557@...2181...>
	<71634ec3-3179-a976-afb5-e41e1e076a55@...2290...>
	<18d68a41-9903-4118-182f-355e52f27149@...2181...>
Message-ID: <bda8bfa8-701a-99a1-4d02-676918cf1fe2@...2181...>
Date: Sun, 16 Jul 2017 17:26:54 +0800
MIME-Version: 1.0
In-Reply-To: <18d68a41-9903-4118-182f-355e52f27149@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MjhbmHOlTlHrNOJDulqe7ai7rKFSKr1SX"
Subject: Re: [Openvpn-devel] [PATCH] Support server cipher preference
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Szil=c3=a1rd_Pfeiffer?= <coroner@...2290...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MjhbmHOlTlHrNOJDulqe7ai7rKFSKr1SX
Content-Type: multipart/mixed; boundary="nWiu1kJafXEXBs8aHs1Lw4IObw62C4gIq";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: =?UTF-8?Q?Szil=c3=a1rd_Pfeiffer?= <coroner@...2290...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <bda8bfa8-701a-99a1-4d02-676918cf1fe2@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Support server cipher preference
References: <20170716082207.23646-1-coroner@...2290...>
 <53e22340-d528-13b8-8ed2-2954bef71557@...2181...>
 <71634ec3-3179-a976-afb5-e41e1e076a55@...2290...>
 <18d68a41-9903-4118-182f-355e52f27149@...2181...>
In-Reply-To: <18d68a41-9903-4118-182f-355e52f27149@...2181...>

--nWiu1kJafXEXBs8aHs1Lw4IObw62C4gIq
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 16/07/17 17:24, Antonio Quartulli wrote:
> (re-adding the ml: please keep it in the CC list)
>=20
> On 16/07/17 17:16, Szil=C3=A1rd Pfeiffer wrote:
>> On 2017-07-16 10:47, Antonio Quartulli wrote:
>>> Hi Szil=C3=A1rd,
>>>
>>>
>>> On 16/07/17 16:22, Szil=C3=A1rd Pfeiffer wrote:
>>>> ---
>>>>  doc/openvpn.8             |  4 ++++
>>>>  src/openvpn/options.c     | 17 +++++++++++++++++
>>>>  src/openvpn/ssl_common.h  |  7 ++++---
>>>>  src/openvpn/ssl_openssl.c |  6 ++++++
>>>>  4 files changed, 31 insertions(+), 3 deletions(-)
>>>>
>>> how about adding some text in the commit message explaining what the
>>> patch is doing and *why* it would be helpful? casual reader not into TLS
>>> (like me) may miss the benefit of this changes.
>> The option does what ssl_prefer_server_ciphers options does in NGINX, th=
e SSLHonorCipherOrder option does in Apache, ...
>>
>> http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_prefer_server=
_ciphers
>> https://httpd.apache.org/docs/current/mod/mod_ssl.html#sslhonorcipherord=
er
>>
>> The reason explained for example in the following blog post.
>>
>> https://tribut.de/blog/secure-your-services-using-sane-cipher-ordering/#=
what-cipher-ordering-is-all-about
>>>
>=20
> why not putting some of this information in the commit message as well?
>=20
>>> And why making it a compile time option?
>> What do you mean? It can be set from command line.
>>
>=20
> all your code is surrounded by "#ifdef SSL_OP_CIPHER_SERVER_PREFERENCE",
> hence I imagined you wanted your code to be included based on a compile
> time option. However, I don't see where SSL_OP_CIPHER_SERVER_PREFERENCE
> should be defined? Am I missing something or it was forgotten?
>=20

Sorry, but I realized just now that this is an OpenSSL specific
mechanism and that the define is coming from OpenSSL itself.

This is not my field, so I'll leave the review to somebody else, but
still, this should be explained in the commit message,

Cheers,



--=20
Antonio Quartulli


--nWiu1kJafXEXBs8aHs1Lw4IObw62C4gIq--

--MjhbmHOlTlHrNOJDulqe7ai7rKFSKr1SX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllrMV4ACgkQ0+HICM1s
oFAa/g/9EoVbAWX8wLQ16RpkoA7WuCypQo0cO+P830RrUmVcl+menpxSSsixa41X
7afl8j9P+2RjwtE6V6CZH31pc0P0KYjrEFOzdX2+3iBXdXfOU8gEKdL7oKHAvD7o
Uqcr3FC2kjuX+xY8gvnlbzpWE0l3tI9V3nEQXyxmgksg4YaSpNGj0F10woqU4fKX
0fqAGHiWXJoXbulLSEZwPH7QXXbG9Y49TBNjtKsc0yBgYuzrmZIOYSVidFHV7Dk5
vI2LRRkWVFyPh7Oqd00hdgboXFRLHvR9CVtAzyA2SRO3wVs1zsyowgLwXAghYhq9
cXENdw3Y0zd4OgZ7p4QaheTecim1k5UuDRxwy5J5+uA4hqheQ0SWFTbi0JWSRcxw
KRx8DjyHQOJtahObEUO2cj2xKZhgwPXsEJMNcDUm0QTtvOhUbQZKWdDgD6QrXTeF
Auud9zb13M8CLvhEF2TFfRPFl7SgcJCVNFYAk46NGuJERSEKoK16pxh8VIbz8Npl
XIcXXhhhv7NwjPoOD/PVyMHEh+f5r0glbCIEnYjXDmJDl8bBe4gHytXEQhEF4KYC
w5r0udO/bcIbSMiM2tMYEeoS5qSj/jWUpoULhERDOjJVUL+IE+cM4m8yiJR0albc
n609JER5xC+EjJWOQQciI34UuDcaHvWYIOqaxZHYdzoP9blGwqk=
=RvLv
-----END PGP SIGNATURE-----

--MjhbmHOlTlHrNOJDulqe7ai7rKFSKr1SX--

