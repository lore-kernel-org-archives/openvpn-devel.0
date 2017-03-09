References: <11de8219-d64d-a9d0-4fa7-a8c63a8d17ff@...1435...>
	<1489068043-25668-1-git-send-email-steffan.karger@...1435...>
	<20170309142024.GA476@...2253...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <57b1aa33-3468-7713-08c5-3b7d5d504207@...1435...>
Date: Thu, 9 Mar 2017 15:26:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170309142024.GA476@...2253...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p5j0vR1f4C5SV0dNdxOtXECL7g7iaxP57"
Subject: Re: [Openvpn-devel] [PATCH v2] Fix windows-build format specifiers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--p5j0vR1f4C5SV0dNdxOtXECL7g7iaxP57
Content-Type: multipart/mixed; boundary="11NLdVfpiDFN3DQ28RLlcshfCFLBXrbVq";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <57b1aa33-3468-7713-08c5-3b7d5d504207@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix windows-build format specifiers
References: <11de8219-d64d-a9d0-4fa7-a8c63a8d17ff@...1435...>
	<1489068043-25668-1-git-send-email-steffan.karger@...1435...>
	<20170309142024.GA476@...2253...>
In-Reply-To: <20170309142024.GA476@...2253...>

--11NLdVfpiDFN3DQ28RLlcshfCFLBXrbVq
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 09-03-17 15:20, Antonio Quartulli wrote:
> On Thu, Mar 09, 2017 at 03:00:43PM +0100, Steffan Karger wrote:
>> A number of printf-like functions used incorrect format specifiers for
>> Windows builds, which could potentially lead to incorrect values being
>> printed / used when calling executables.
>>
>> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>> ---
>> v2: add OVPN_PRI_SKT define to print socket type across platforms
>>
>>  src/openvpn/init.c    |  2 +-
>>  src/openvpn/route.c   | 12 ++++++------
>>  src/openvpn/socket.c  |  7 ++++---
>>  src/openvpn/syshead.h |  2 ++
>>  src/openvpn/tun.c     |  4 ++--
>>  5 files changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index 033318d..2a9a398 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -1585,7 +1585,7 @@ do_open_tun(struct context *c)
>>  #ifdef _WIN32
>>      /* store (hide) interactive service handle in tuntap_options */
>>      c->c1.tuntap->options.msg_channel =3D c->options.msg_channel;
>> -    msg(D_ROUTE, "interactive service msg_channel=3D%u", (unsigned int)=
 c->options.msg_channel);
>> +    msg(D_ROUTE, "interactive service msg_channel=3D%"PRIuPTR, (uintptr=
_t) c->options.msg_channel);
>=20
> A little comment about the style (codestyle maniac here!).
> Should this:
>=20
> msg_channel=3D%"PRIuPTR
>=20
> be:
>=20
> msg_channel=3D%" PRIuPTR
>=20
> ?
>=20
> the " is closing the const char and therefore a space would be needed bet=
ween it and the
> next constant.
>=20
> This appears several times in the patch and therefore I thought it was wo=
rth
> mentioning it.

I don't have a strong preference about this.  I tend to not add spaces
for these preprocessor-format-specifiers, because I view them as part of
the string.  But I get your view too.  So I'd be perfectly fine with
adding spaces if that's the general preference.

-Steffan



--11NLdVfpiDFN3DQ28RLlcshfCFLBXrbVq--

--p5j0vR1f4C5SV0dNdxOtXECL7g7iaxP57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYwWYdAAoJEEEwndWOY1w5r5kIAJSd5jNvYhRBy8KzCa1D5FoZ
kjIvp0FX/9x8rlep8xG6RUAqiNcf/p+yrcmr9ADp6wgpreVxn4PKjWkpBBw4k07Z
rj3A6KbFZwtx7pRNcIbuoGTxgEZbQiLEPXDVsseI4x+lMsCG5NHJEHo6Ou1ciAt3
5ST4J8zccishjtwdYFXCdH+LHhrmne9CyM3HyexYrcneBxpC2Ag+RyhEvrfkm8xU
r/h82O6DNAH5rPDuZtlodQTnGteh0B74tO+7NrbXjQtYywnPEZsF5ixbSg/NeAJs
b26cg1HrCjrfYNGYUrapsE+JVCYLKCbBrf/EwR7lFEsJmN9FF7hoOHdLDWA9Qj0=
=bx/F
-----END PGP SIGNATURE-----

--p5j0vR1f4C5SV0dNdxOtXECL7g7iaxP57--

