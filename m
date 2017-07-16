References: <20170716082207.23646-1-coroner@...2290...>
	<53e22340-d528-13b8-8ed2-2954bef71557@...2181...>
	<71634ec3-3179-a976-afb5-e41e1e076a55@...2290...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <18d68a41-9903-4118-182f-355e52f27149@...2181...>
Date: Sun, 16 Jul 2017 17:24:26 +0800
MIME-Version: 1.0
In-Reply-To: <71634ec3-3179-a976-afb5-e41e1e076a55@...2290...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UdkQAUlxgSvnGmcRtQjkTT74DI6WnxmCV"
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
--UdkQAUlxgSvnGmcRtQjkTT74DI6WnxmCV
Content-Type: multipart/mixed; boundary="jv3igmAs6rsS4T14sbkrCnvRwsAFFnBDa";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: =?UTF-8?Q?Szil=c3=a1rd_Pfeiffer?= <coroner@...2290...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <18d68a41-9903-4118-182f-355e52f27149@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Support server cipher preference
References: <20170716082207.23646-1-coroner@...2290...>
 <53e22340-d528-13b8-8ed2-2954bef71557@...2181...>
 <71634ec3-3179-a976-afb5-e41e1e076a55@...2290...>
In-Reply-To: <71634ec3-3179-a976-afb5-e41e1e076a55@...2290...>

--jv3igmAs6rsS4T14sbkrCnvRwsAFFnBDa
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

(re-adding the ml: please keep it in the CC list)

On 16/07/17 17:16, Szil=C3=A1rd Pfeiffer wrote:
> On 2017-07-16 10:47, Antonio Quartulli wrote:
>> Hi Szil=C3=A1rd,
>>
>>
>> On 16/07/17 16:22, Szil=C3=A1rd Pfeiffer wrote:
>>> ---
>>>  doc/openvpn.8             |  4 ++++
>>>  src/openvpn/options.c     | 17 +++++++++++++++++
>>>  src/openvpn/ssl_common.h  |  7 ++++---
>>>  src/openvpn/ssl_openssl.c |  6 ++++++
>>>  4 files changed, 31 insertions(+), 3 deletions(-)
>>>
>> how about adding some text in the commit message explaining what the
>> patch is doing and *why* it would be helpful? casual reader not into TLS
>> (like me) may miss the benefit of this changes.
> The option does what ssl_prefer_server_ciphers options does in NGINX, the=
 SSLHonorCipherOrder option does in Apache, ...
>=20
> http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_prefer_server_=
ciphers
> https://httpd.apache.org/docs/current/mod/mod_ssl.html#sslhonorcipherorder
>=20
> The reason explained for example in the following blog post.
>=20
> https://tribut.de/blog/secure-your-services-using-sane-cipher-ordering/#w=
hat-cipher-ordering-is-all-about
>>

why not putting some of this information in the commit message as well?

>> And why making it a compile time option?
> What do you mean? It can be set from command line.
>=20

all your code is surrounded by "#ifdef SSL_OP_CIPHER_SERVER_PREFERENCE",
hence I imagined you wanted your code to be included based on a compile
time option. However, I don't see where SSL_OP_CIPHER_SERVER_PREFERENCE
should be defined? Am I missing something or it was forgotten?

>> Another question: may this option lead the client to an incompatible
>> configuration?
> No, it is not. Only the cipher choosen by the server may change if the op=
tion is on.
>=20

Cheers,

--=20
Antonio Quartulli


--jv3igmAs6rsS4T14sbkrCnvRwsAFFnBDa--

--UdkQAUlxgSvnGmcRtQjkTT74DI6WnxmCV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllrMMoACgkQ0+HICM1s
oFAT/A/9EeYtkNHcXffA/k81cH7Z3V8+5zs5VAHmgNQhTqsYAikjK3/SgDbL7B2X
g73IpeORxMLNlvV7gi8eTP6CWFlEBX3QH0/yEb/z8yzIcJcSqv+UBjlkxrMeX0N8
A9Hg8RNJxCFvEXWWplPC8wPTqtjAOanlwfNIxwmWPZ7NqIGYtBEnJWmjq6cE8lfH
6Nsja1eTHXw2CvIXGMV3vSCMtnyr7chEfJyMWZeuT2CcRZf9P30dwF9iY48w5UTd
rWkCPkDmjr6RdtyQ0FjARG4USxbxAO2eptEhQcP7nHYOyn8Z4qXnFW5V2HZZc19e
nXjRn5p0wuD53K97cmmUR4I/A/zko9bGtqeS0RQVQDakmlhRRfF0xF9wQoZ3QIVJ
zsbyER7k7/r5UuGZqUoKY2SKafMf6caEBY5WPU+WYg7s0HyIsZeGt+eqRdApYevz
+ZREl6zYKnJ7xNqaCIo19RxEdI4h/+ad354j4sa6gA2CGD3OZsotZkwqCV+EWr8X
lpDGzWVuzK2ClbAvER7BK4T9b5MBjSGwvgMf1+nFP0bkPuIoeCmQd0rF7MguFgKF
HkgJFEk8BJMm0PJqzvuI7+NkoNU/iUOW7w/62naYK6F1Mzffpfl4hhTNNFVoO7Wz
m/GOZnOPybFkZCBko43VpVUSKAZ4qoPNg7Jxuuw5c6fUfkl3fEY=
=qblN
-----END PGP SIGNATURE-----

--UdkQAUlxgSvnGmcRtQjkTT74DI6WnxmCV--

