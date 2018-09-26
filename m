References: <20180925124819.4005-1-arne@...1227...>
 <f5264ad9-f28c-cd7a-2b79-6a5536d0130e@...2080...>
 <75f44ec4-eb46-0bc4-a7ad-f1b87fd2b9b8@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <248d75ef-2c76-1c84-25b3-8748b0afc35f@...2181...>
Date: Wed, 26 Sep 2018 14:52:00 +0800
MIME-Version: 1.0
In-Reply-To: <75f44ec4-eb46-0bc4-a7ad-f1b87fd2b9b8@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NJLUUV2pj8l0IXjbG6gGsvhiXDYMgQrQU"
Subject: Re: [Openvpn-devel] [PATCH] Add message explaining early TLS client
 hello failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NJLUUV2pj8l0IXjbG6gGsvhiXDYMgQrQU
Content-Type: multipart/mixed; boundary="9hIEAfZOK52C6nIrew2cX9TyybWPRPgAv";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <248d75ef-2c76-1c84-25b3-8748b0afc35f@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Add message explaining early TLS client
 hello failure
References: <20180925124819.4005-1-arne@...1227...>
 <f5264ad9-f28c-cd7a-2b79-6a5536d0130e@...2080...>
 <75f44ec4-eb46-0bc4-a7ad-f1b87fd2b9b8@...1227...>
In-Reply-To: <75f44ec4-eb46-0bc4-a7ad-f1b87fd2b9b8@...1227...>

--9hIEAfZOK52C6nIrew2cX9TyybWPRPgAv
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 26/09/18 06:19, Arne Schwabe wrote:
> Am 25.09.18 um 16:31 schrieb David Sommerseth:
>> On 25/09/18 14:48, Arne Schwabe wrote:
>>> In my tests an OpenSSL 1.1.1 server does not accept TLS 1.0 only clients
>>> anymore. Unfortunately, Debian 8 still has OpenVPN 2.3.4, which is
>>> TLS 1.0 only without setting tls-version-min.
>>>
>>> We currently log only
>>> OpenSSL: error:14209102:SSL routines:tls_early_post_process_client_hell=
o:unsupported protocol
>>> which indicates the right technical error but is not very helpful to a
>>> person without deep knowledge in SSL/TLS and OpenVPN's TLS version
>>> history.
>>>
>>> This commit adds a hopefully helpful message and also tells users how
>>> to fix the old Debian 8 clients.
>>> ---
>>>  src/openvpn/crypto_openssl.c | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
>>> index 9ec2048d..3360bb19 100644
>>> --- a/src/openvpn/crypto_openssl.c
>>> +++ b/src/openvpn/crypto_openssl.c
>>> @@ -199,7 +199,15 @@ crypto_print_openssl_errors(const unsigned int fla=
gs)
>>>                  "in common with the client. Your --tls-cipher setting =
might be "
>>>                  "too restrictive.");
>>>          }
>>> -
>>> +        else if (ERR_GET_REASON(err) =3D=3D SSL_R_UNSUPPORTED_PROTOCOL)
>>> +        {
>>> +            msg(D_CRYPT_ERRORS, "TLS error: Unsupported protocol. This=
 typically "
>>> +                 "indicates that client and server have no common TLS =
version enabled. "
>>> +                 "This can be caused mismatched tls-version-min and tl=
s-version-max options "
>>> +                 "on client and server. "
>>> +                 "If your client is 2.3.6 or older  consider adding tl=
s-version 1.1"
>>> +                 "to the the configuration to use TLS 1.1+ instead of =
TLS 1.0 only");
>>
>>
>> Good advice in the log.  But should this be added in the local or remote
>> configuration?  It is the 2.3.6 reference which makes it confusing for m=
e,
>> otherwise I would have interpreted this as the local side where this war=
ning
>> occurs.  So this could be clearer.
>=20
> 2.3.7 is the first version of OpenVPN which enables TLS 1.0+ instead TLS
> 1.0 only by default. See this commit by Steffan:
>=20
> https://github.com/OpenVPN/openvpn/commit/8dc6ed28941cb9b9167e0b466e96b5f=
11359eb59
>=20

I think the problem is: we apply this patch to the latest 2.3.x release,
so it will never appear on "2.3.6 or older" clients.
Hence, does it really make sense to print that particular sentence?


Cheers,

--=20
Antonio Quartulli


--9hIEAfZOK52C6nIrew2cX9TyybWPRPgAv--

--NJLUUV2pj8l0IXjbG6gGsvhiXDYMgQrQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlurLJAACgkQ9FVsWUWD
Dm2nuw/+N6d6V8k3S0KhUUNFvZTWYCNw0KD2tmimopTj6WPt8Yo3YaoTLNX+XSz4
bkEgYERzFniVo9Ybz/jWRkndXYEvb+uHKfMaiBY8dGkygSPTqS/kC3sF1/ulCYRn
fVDryqxl+QY/wMa1fWSEoa4zh0g/HNydVG90WkCM1TnuBfpS8w0LdLOSz+cdiT2m
a4cGNcEmNQnzKQ+NE0333pxkG8W09LLOyFNPLHoBYSbjW3z5Jk+BZbK85PaDqCN8
rmcQq9AFulDz95eq9dfc31qnJ4ELiBfpicn1Mfg6ZHJ3DL/GIteKB1tXlWfbdnaE
Z5GIIMhDRrAZfTfJ9oNQT5LeOvrcJILtz9PqaeH3259Ku8eartjOoI0dmpb8BZIT
Ca37K+vGao/DjkdtEkJeXGo0VWPNLh7bRWwcfIgtGVA5YaKZ3tgHebjvi9LTUyy0
3Z8G4v35W8u5jfgC25YxidWOeXJMw0ivdi9rshPDPP64098TOWocCHbrF5VGxVtm
baRy1XRVIW/D7eHcMEXsWS84TqCKGvq9h5BfAIM8L3ZZyRwbmDWMfj2N1/ZNawyz
1CE1Vg7Jjqt8URE7UvcQTlYqOtPIsIEiEioIGy1tHAr5RsKCr6wu+d/9Vzrrr2qF
rpjfXuWrJ9Ib9d2zIzLZL08zZvC0SOggU8Yo9rBkonUZAPXsVgI=
=c4j2
-----END PGP SIGNATURE-----

--NJLUUV2pj8l0IXjbG6gGsvhiXDYMgQrQU--

