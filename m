Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170619130507.13892-1-davids@...515...>
	<20170619131630.GK97029@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <17910477-83a7-9ca7-c388-3f164759e36b@...2080...>
Date: Mon, 19 Jun 2017 15:22:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170619131630.GK97029@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="romQEmhoU9QFc2jCpSgl2lO1WNjovbqEe"
Subject: Re: [Openvpn-devel] [PATCH] auth-token with auth-nocache fix broke
 --disable-crypto builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--romQEmhoU9QFc2jCpSgl2lO1WNjovbqEe
Content-Type: multipart/mixed; boundary="3VGdu6gACAxMjfbHc6rvT4UbNLwosmH5i";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <17910477-83a7-9ca7-c388-3f164759e36b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] auth-token with auth-nocache fix broke
 --disable-crypto builds
References: <20170619130507.13892-1-davids@...515...>
 <20170619131630.GK97029@...1296...>
In-Reply-To: <20170619131630.GK97029@...1296...>

--3VGdu6gACAxMjfbHc6rvT4UbNLwosmH5i
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 19/06/17 15:16, Gert Doering wrote:
> HI,
>=20
> On Mon, Jun 19, 2017 at 03:05:07PM +0200, David Sommerseth wrote:
>> After adding commit 571165360db0392fa83e, it broke builds where
>> the --disable-crypto was used with ./configure.  This was due to
>> the delayed_auth_pass_purge() which requires the crypto code paths
>> being called from init.c without the proper #ifdef encapsulation.
>>
>> Signed-off-by: David Sommerseth <davids@...515...>
>> ---
>>  src/openvpn/init.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index 0832f1d1..a54307ad 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -1382,6 +1382,8 @@ initialization_sequence_completed(struct context *=
c, const unsigned int flags)
>>      /* If we delayed UID/GID downgrade or chroot, do it now */
>>      do_uid_gid_chroot(c, true);
>>=20=20
>> +
>> +#ifdef ENABLE_CRYPTO
>>      /*
>>       * In some cases (i.e. when receiving auth-token via
>>       * push-reply) the auth-nocache option configured on the
>> @@ -1393,6 +1395,7 @@ initialization_sequence_completed(struct context *=
c, const unsigned int flags)
>>      {
>>          delayed_auth_pass_purge();
>>      }
>> +#endif /* ENABLE_CRYPTO */
>>=20=20
>>      /* Test if errors */
>>      if (flags & ISC_ERRORS)
>=20
> ACK.
>=20
> Somewhat ugly (is there no existing #ifdef ENABLE_CRYPTO block nearby
> that we could hide this in?) but I need a clean tree tonight, and this
> will fix things.  So, will to go with it.

There are no other ENABLE_CRYPTO blocks in
initialization_sequence_completed() [init.c:1375].  The alternative
could be to put this #ifdef inside the delayed_auth_pass_purge() and
make that function be "empty" without ENABLE_CRYPTO.  But as init.c is
the only place this is called outside the ENABLE_CRYPTO scope, this is
where my dice rolled.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--3VGdu6gACAxMjfbHc6rvT4UbNLwosmH5i--

--romQEmhoU9QFc2jCpSgl2lO1WNjovbqEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZR9AmAAoJEIbPlEyWcf3yd2UP/jZuApHRk3nZdPhVgFaw+QbH
emo27zzn8Os5DItoBBAPhcFUqfh6W/7pGllLO/BZBc5WPGDr/x0Ssdwl05JKzX1v
QJqVoNSJT93jqWLNfKQEUtKt+mCg85/aorIxbDd8h59r5qr/l3EPg/izVGDWyWzh
HZtbJETmb5BelKAD6frtiSa73cPDPuc2UoV1XI9jGqfh8pmlUieWiGiFjzKj6Hlv
yKFLqOrJpyo/Cuz6IOENCBBAfDFuN4UamaJdSelkbOvRVSGOmusfvvOISt5ti9Wi
E/2xMnYPmZ4Z582pffkR7eUj8MV2RAF1wuCLdHuO9naU9x6mGj4JqDZbuUC4v1/F
pO66kZjvk858zjnjx1xMqAvP8/MLMI/fypSlIQGU3nHzUktf7JxjfLtvrdRPlEjw
xU0lZB5oZ6KTJOREfjwFNB9VCwM542kNCv8VzmN6nu1baEuVwZRwWwPluoSRsY+n
yImAtektBGhgYGe1s2n2j/216GQwj9H0eT/qLws8nBXKIpQ2WNIG9+bITDyBgcgA
MN2SKUwSw4ais6eAzXlhWytsCZdLbj2qEkWVpgTVG3dVqZQxTM/TbcexxDKOS85d
GcHyMg09c72wZAxTxrfp2ia7G2HjQpNP7+xwCPk0hbb8EvvO8EVl/OIfu2HkoCd3
9Mq3O7893GkQrxXA1OCP
=FZVd
-----END PGP SIGNATURE-----

--romQEmhoU9QFc2jCpSgl2lO1WNjovbqEe--

