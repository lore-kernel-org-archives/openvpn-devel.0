References: <20171111161836.23356-1-a@...2181...>
 <20171111161836.23356-3-a@...2181...>
 <20171112202258.hat3hetjonkv2pxc@...2161...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <568bf2f3-2361-921d-6d03-cbe263e88eeb@...2181...>
Date: Mon, 13 Nov 2017 05:13:33 +0800
MIME-Version: 1.0
In-Reply-To: <20171112202258.hat3hetjonkv2pxc@...2161...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pQVnPgiok0KKmEVGHH4ATgNOOmVrkNnI9"
Subject: Re: [Openvpn-devel] [PATCH v5 3/3] ensure function declarations are
 compiled with their definitions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Ruderich <simon@...2161...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pQVnPgiok0KKmEVGHH4ATgNOOmVrkNnI9
Content-Type: multipart/mixed; boundary="x5oBU8KKJmojrdmSqECVsehNNxc7hSw26";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Simon Ruderich <simon@...2161...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <568bf2f3-2361-921d-6d03-cbe263e88eeb@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v5 3/3] ensure function declarations are
 compiled with their definitions
References: <20171111161836.23356-1-a@...2181...>
 <20171111161836.23356-3-a@...2181...>
 <20171112202258.hat3hetjonkv2pxc@...2161...>
In-Reply-To: <20171112202258.hat3hetjonkv2pxc@...2161...>

--x5oBU8KKJmojrdmSqECVsehNNxc7hSw26
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



On 13/11/17 04:22, Simon Ruderich wrote:
> On Sun, Nov 12, 2017 at 12:18:36AM +0800, Antonio Quartulli wrote:
>> --- a/src/openvpn/crypto.h
>> +++ b/src/openvpn/crypto.h
>> @@ -459,6 +459,9 @@ void prng_bytes(uint8_t *output, int len);
>>
>>  void prng_uninit(void);
>>
>> +/* an analogue to the random() function, but use prng_bytes */
>> +long int get_random(void);
>> +
>>  void test_crypto(struct crypto_options *co, struct frame *f);
>>
>>
>> @@ -514,5 +517,10 @@ key_ctx_bi_defined(const struct key_ctx_bi *key)
>>  }
>>
>>
>> +#else
>> +
>> +/* use plain random is no crypto support is compiled */
>=20
> Minor typo, "is" -> "if"
>=20


Thanks for spotting this! I hope the committer can fix this on the fly.

Cheers,


--=20
Antonio Quartulli


--x5oBU8KKJmojrdmSqECVsehNNxc7hSw26--

--pQVnPgiok0KKmEVGHH4ATgNOOmVrkNnI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloIuX0ACgkQB6U8WA7y
zXRi2A//VGwZmlCR3SaRYNS7yNpDfZwVvaQN9d/w+UnYKHaeN5Tfsh9zhGFUmvEt
1ZU8uZ7OyVsSn8SM4gNWByCNn0IAEBNmBB1UZHoM0Vhz/vDKYFYH3+zWWJPt/pDl
SvagIsfVaPiwC7Z12Pe1Y3pB9i9GBn2xeULvkL8+T6uP/Fm9e26ejZUS+aQmRqBY
v8v0La3+GKL7/bV/qDoI2oilNSQru8GINMWGe8+oZRpsAGFjRbf+d3PAzpUTqog9
mS/plaKsDH81BpAcPMZKBJr5FmWVqtdMeQmxZf2oiy1dUJBOF7iqxuIjXmMNrL78
owTuwvdz/FH/XDumGsrDDO6TTe9tvSTyJE+KMUmwAvpnD8Ixmc7u56xBCPmsbBhm
FD+kY+j74rAe+OUKOKQ6XuYEbpq0J3Q+iS+sVMX57mmd9JFdq3mv/vJKwkvtGunj
UJX2UJe50Vc0XTDpQG4vX8y7WBv0wjDFKdrMqi+rd/GDuu+uHlsovRDxm6lzZDcK
HfUwDmwRhADKBSgwzM9l19iELL3BwA8wI4KaiXga0x3hK/s4ixaBmnakS9b10ppd
mHBFVbTb5tvsrNZgWXovLqLDjYBQjdwZemxhP8UhQLdznlZxQju22SPHcaY2PnND
jkbsRg/hK3VosxU3iC+6UaUZqNMQ2cB13JyX0EJ8A7kFU+wm+QA=
=pgTs
-----END PGP SIGNATURE-----

--pQVnPgiok0KKmEVGHH4ATgNOOmVrkNnI9--

