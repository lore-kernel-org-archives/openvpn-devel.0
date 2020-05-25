References: <20200524203322.15885-1-James.Bottomley@...2316...>
 <20200524203322.15885-3-James.Bottomley@...2316...>
 <20200525060415.GY1431@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1c51551c-0038-9577-ceb5-7f5fd298e088@...1227...>
Date: Mon, 25 May 2020 14:52:00 +0200
MIME-Version: 1.0
In-Reply-To: <20200525060415.GY1431@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wg5aJ1whX4MqzZcMCB7qWjqjOKGgnIf5T"
Subject: Re: [Openvpn-devel] [PATCH v5 2/2] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, James Bottomley <James.Bottomley@...2317...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wg5aJ1whX4MqzZcMCB7qWjqjOKGgnIf5T
Content-Type: multipart/mixed; boundary="4iTBbKvIznJp7fp1Q7UKTMmdivpfXbstD"

--4iTBbKvIznJp7fp1Q7UKTMmdivpfXbstD
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 25.05.20 um 08:04 schrieb Gert Doering:
> Hi,
>=20
> I see the granularity of your patch set as "not right":
>=20
> On Sun, May 24, 2020 at 01:33:22PM -0700, James Bottomley wrote:
>> Testing engines is problematic, so one of the prerequisites built for
>> the tests is a simple openssl engine that reads a non-standard PEM
>> guarded key.  The test is simply can we run a client/server
>> configuration with the usual sample key replaced by an engine key.
>> The trivial engine prints out some operations and we check for these
>> in the log to make sure the engine was used to load the key and that
>> it correctly got the password.
>=20
> This patch says "add unit tests", but it contains changes to configure.ac
> and OpenVPN code
>=20
>>  configure.ac                                  |   5 +
>>  src/openvpn/crypto_openssl.c                  |   1 +
>=20
> These two hunks should go to the first patch.
>=20
> Every patch should be fully testable on its own - so if I apply only
> the first hunk, I should be able to use and test engine keys, without
> having to apply the "add a unit test" patch set.
>=20
>> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
>> index a7569623..34637ebf 100644
>> --- a/src/openvpn/crypto_openssl.c
>> +++ b/src/openvpn/crypto_openssl.c
>> @@ -92,6 +92,7 @@ setup_engine(const char *engine)
>>  {
>>      ENGINE *e =3D NULL;
>>=20=20
>> +    OPENSSL_config(NULL);
>>      ENGINE_load_builtin_engines();
>>=20=20
>>      if (engine)
>=20
> For that change, I wonder what side effects it might have on existing
> setups.  Arne, can you help?  Is this "safe"?
>=20

For OpenSSL 1.1 this is actually a NACK since it is depreacted API and
we want to wrap those into ifdefs to be able to remove them when we drop
support for older version.

For OpenSSL 1.1 this is a deprecated function to contrary to other
depreacted function like OpenSSL_init() not a noop.

But this command even though it does not have a return value or reports
erro, can still put errors on the error stack.

Reading the general openssl.cnf at engine_setup also feels a bit like
the wrong place but since this code is only executed when --engine is
present in the config and we will remove that OPENSSL_config in the
future anyway (with the ifdef) it a low risk to put it here instead of a
more proper place, so I am fine to do here.

As a side note, engines are deprecated in OpenSSL 3.0.0 and are replaced
by providers. But that will probably take a long time until that is
really depreacted and removed, so adding/fixing this for now is okay.

Arne


--4iTBbKvIznJp7fp1Q7UKTMmdivpfXbstD--

--wg5aJ1whX4MqzZcMCB7qWjqjOKGgnIf5T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7Lv3AACgkQFRhsZwKx
RFTT5Q//Rog5fbRB1gflSoeXVFS1u4V7cHhVUbPp32WSJsdyXBdxfi5lWmOzpJVt
N4gcPMRTJzAG81mv+fik3MboZRKYNe8+4JPGZ4jImMy7RrSY1XExEqNUdpicd4NP
Lxr+fYu2FPsmJfE5FeRugHQxZKRLIZdAslq4wTYBQUtrs8h1djBxwbOQIsyEifP9
l7u2Scn1CW8t38do2ZMAHnYXFsn+177AQ2FrzhvyvXmJwy+m0Z7yR4SCehrdv5UP
t9Frt7GMSOonFQZ4vSHiMyLwAHYq1FTe4EpWbDgifJYEcGanKCujrIXyH/am4ym5
JYpnu1hgBpRDrdrC4E/tqT9vXhkVZmFpz/dpgMeIre4XxHCBjBIfVv3LzO2yCnMF
VPESi+yoinrRipJZkkJ58hrrTEGA9BAO6nSIgnRAMqWjELMDMki4IvPREsyrHFom
uSH8sCRSQimtQW6OPWFYGLDIjmz5Si/hFqaCcZBydL1zuc5CQztyI2NOMLepCR9+
kod4Yh+9twYfvsrWwAMrCsIwbeC+LmPVFYM8uH3FuClz8iCj1S3dsxYRV5R2kPBO
Gxbbo+GPwAJas7t7R0UNNT1N7hxh5LB2VyfCXQkMxX7enoPmHfhDDPYtrbDJa0NS
dYtMDRn9eohgQAJzvZ/hWQhEtNyF38p1a9QExNrnlywWRVg6IbY=
=RVSW
-----END PGP SIGNATURE-----

--wg5aJ1whX4MqzZcMCB7qWjqjOKGgnIf5T--

