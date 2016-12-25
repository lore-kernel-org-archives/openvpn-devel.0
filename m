References: <1482079255-15159-1-git-send-email-steffan@...1856...>
	<20161218212659.GY78624@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <965a4c27-5e16-59a8-db9c-930f1216f22c@...1856...>
Date: Mon, 26 Dec 2016 00:20:53 +0100
MIME-Version: 1.0
In-Reply-To: <20161218212659.GY78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5797WI43RuQHfghspCDheb2FIEMkqREPO"
Subject: Re: [Openvpn-devel] [PATCH] Use SHA256 for the internal digest,
 instead of MD5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5797WI43RuQHfghspCDheb2FIEMkqREPO
Content-Type: multipart/mixed; boundary="hGFBrDxcRgMN0bmDob690bf6Qs77c8XHh"
From: Steffan Karger <steffan@...1856...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <965a4c27-5e16-59a8-db9c-930f1216f22c@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Use SHA256 for the internal digest,
	instead of MD5
References: <1482079255-15159-1-git-send-email-steffan@...1856...>
	<20161218212659.GY78624@...1296...>
In-Reply-To: <20161218212659.GY78624@...1296...>

--hGFBrDxcRgMN0bmDob690bf6Qs77c8XHh
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 18-12-16 22:26, Gert Doering wrote:
> On Sun, Dec 18, 2016 at 05:40:55PM +0100, Steffan Karger wrote:
>> Our internal options digest uses MD5 hashes to store the state, instead =
of
>> storing the full options string.  There's nothing wrong with that, but it
>> would still be better to use SHA256 because:
>>  * That makes it easier to make OpenVPN "FIPS-compliant" (forbids MD5)
>>  * We don't have to explain anymore that MD5 is fine too
>>
>> The slightly less bytes for the digest (16 instead of 32) and operations
>> per connection setup are not worth sticking to MD5.
>=20
> I can't find very clear information on "which versions of OpenSSL do
> support sha256", but since we have a trac ticket about our windows
> builds having issues with sha256 certificates we might take this
> opportunity to revisit minimum OpenSSL versions supported in master
> from now on...

The oldest OpenSSL we support in release/2.4 and master is 0.9.8, and
has SHA256 support (was introduced in 2004).  Also, the --tls-crypt
feature already unconditionally requires SHA256 to be available.

-Steffan


--hGFBrDxcRgMN0bmDob690bf6Qs77c8XHh--

--5797WI43RuQHfghspCDheb2FIEMkqREPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYYFRaAAoJEJgCyj0AftKIVnIH/jhJLGget7UiqysNgzKdXx69
sbmggmcOM+WMyG9y8bTG74LziU8xjiay05ddWN/ScbLVnTnP7beSBWQSWrvgLlcj
YR46o0S+Qzri2yTIGwzafS1bx+kxnDa8tIowj2jstuQacxdfgdkH/jF4E2WYaWK+
PzqSS+XxSUhpIMmHkCDwHSHudSIdfeaq5OgjmCiyN+cq6oV/8W/5SkzES/1sUlZM
DgbI61Ji3+uxGJOkG8wnXfcDetxfEi86zvlTXVLFSzA7O6eKFPNtfR48aBmg3zaY
beaAfYE++77CIx0GcJVp4E5xWDZUJnozS2CXstgC093y7LzLXorhz8K9MBSC1u4=
=JyH5
-----END PGP SIGNATURE-----

--5797WI43RuQHfghspCDheb2FIEMkqREPO--

