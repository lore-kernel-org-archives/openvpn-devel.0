References: <1482079255-15159-1-git-send-email-steffan@...1856...>
	<20161218212659.GY78624@...1296...>
	<965a4c27-5e16-59a8-db9c-930f1216f22c@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3417a8a7-f5d3-d860-9e58-40fc7bc6d528@...2080...>
Date: Mon, 26 Dec 2016 12:41:28 +0100
MIME-Version: 1.0
In-Reply-To: <965a4c27-5e16-59a8-db9c-930f1216f22c@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="TKEf8aUaTiGdfP0sC1mBUgHXEX4J8fAdi"
Subject: Re: [Openvpn-devel] [PATCH] Use SHA256 for the internal digest,
 instead of MD5
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TKEf8aUaTiGdfP0sC1mBUgHXEX4J8fAdi
Content-Type: multipart/mixed; boundary="81tk89qAPWA1LseFFxcc9bs9rFb6uNSqA";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <3417a8a7-f5d3-d860-9e58-40fc7bc6d528@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Use SHA256 for the internal digest,
	instead of MD5
References: <1482079255-15159-1-git-send-email-steffan@...1856...>
	<20161218212659.GY78624@...1296...>
	<965a4c27-5e16-59a8-db9c-930f1216f22c@...1856...>
In-Reply-To: <965a4c27-5e16-59a8-db9c-930f1216f22c@...1856...>

--81tk89qAPWA1LseFFxcc9bs9rFb6uNSqA
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 26/12/16 00:20, Steffan Karger wrote:
> Hi,
>=20
> On 18-12-16 22:26, Gert Doering wrote:
>> On Sun, Dec 18, 2016 at 05:40:55PM +0100, Steffan Karger wrote:
>>> Our internal options digest uses MD5 hashes to store the state, instead=
 of
>>> storing the full options string.  There's nothing wrong with that, but =
it
>>> would still be better to use SHA256 because:
>>>  * That makes it easier to make OpenVPN "FIPS-compliant" (forbids MD5)
>>>  * We don't have to explain anymore that MD5 is fine too
>>>
>>> The slightly less bytes for the digest (16 instead of 32) and operations
>>> per connection setup are not worth sticking to MD5.
>>
>> I can't find very clear information on "which versions of OpenSSL do
>> support sha256", but since we have a trac ticket about our windows
>> builds having issues with sha256 certificates we might take this
>> opportunity to revisit minimum OpenSSL versions supported in master
>> from now on...
>=20
> The oldest OpenSSL we support in release/2.4 and master is 0.9.8, and
> has SHA256 support (was introduced in 2004).  Also, the --tls-crypt
> feature already unconditionally requires SHA256 to be available.

Just to confirm this is fine.

$ cat /etc/redhat-release
CentOS release 5.11 (Final)
$ rpm -q openssl
openssl-0.9.8e-40.el5_11
$ echo "test" | openssl dgst -sha256
f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2
$ echo "test" | sha256sum
f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2  -

And from the earliest openssl RPM changelog entry where 0.9.8 is
mentioned, I see this:

* Wed Nov 09 2005 Tomas Mraz <tmraz(a)redhat.com> 0.9.8a-1
- new upstream version

AFAIR, we don't support any other OS or distributions with an older
OpenSSL library.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--81tk89qAPWA1LseFFxcc9bs9rFb6uNSqA--

--TKEf8aUaTiGdfP0sC1mBUgHXEX4J8fAdi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYYQHoAAoJEIbPlEyWcf3yobIP/RUKTpgpkxQHtMv+5oVWZvHg
sSFy0QgI+9Da8UZg9Pg+rhYIva/VTuXSU7xl61j/ZA12gVbHAXAt6GW0YRAp+gNm
3fBSE4dDYK8QWuX+sADDNOtSrQ0mWeHxjzXMEeFwkgwj0iQ+j3sPBajS6LIFgi7v
DEYht3qxoRuEE+KftlHhIDuVZ7reKXvCi4WSc0pA5icdnc9St0EoSnx0qCqFFIx2
1k0xpkVLAVaRyCMXi4D+dUasrtGBTwC27RnaV2/33ShLGgK/EMvy9caQyQ1v8HuJ
Y2hME9tCFTNftqN5HCNiqTDhf7x7WdeMeQ9eccoF59TEn0bmWtp2T3B6VgwRHajh
i0MuUwN2/OCvsjgnOLSiAi29PeZ+u0A9tq8BkxPwbmzi7li6vc5M6yWUCjhOou0i
AtxRVqmBUYLDilmLHi+DBc3xJDTXANcsDPBa04CaIv8ounSvMOyQ7HWthgUeLOPO
tk5U63kPKJU+1vDL7ax+4m0VY39k2obN8IEIIHFSovg3VEpW77wMyAIwN9aQynb0
sVBSNc2vPJM5N4XGuPclkMccMKcRyy4u/ckG3ShiSqGD0rw82lLKH2UGe5M852Fo
WU8qkiiblvUkQYpUuck3VApZqm3lnw1MttcHQRFA/pVhnycblFOqHznWd+gRsuKY
axQzlYcJRqxcdHU7XaoG
=xFcG
-----END PGP SIGNATURE-----

--TKEf8aUaTiGdfP0sC1mBUgHXEX4J8fAdi--

