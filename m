References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
 <20171101220342.14648-5-steffan@...1856...>
 <2bacffe7-e42b-9a33-b502-924ef38c628a@...2181...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <531fd06f-c0f4-9068-a6e6-58e52c8c32e3@...1435...>
Date: Thu, 9 Nov 2017 14:46:44 +0100
MIME-Version: 1.0
In-Reply-To: <2bacffe7-e42b-9a33-b502-924ef38c628a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="54H9qxDvVGVivijV0jBNwDf5JMQqiXcp2"
Subject: Re: [Openvpn-devel] [PATCH 4/4 v3] create_temp_file/gen_path:
 prevent memory leak if gc == NULL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--54H9qxDvVGVivijV0jBNwDf5JMQqiXcp2
Content-Type: multipart/mixed; boundary="WKPsw1Mq2k9Uo6fTE4kWSlDQWpO2QCUCd";
 protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <531fd06f-c0f4-9068-a6e6-58e52c8c32e3@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 4/4 v3] create_temp_file/gen_path: prevent
 memory leak if gc == NULL
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
 <20171101220342.14648-5-steffan@...1856...>
 <2bacffe7-e42b-9a33-b502-924ef38c628a@...2181...>
In-Reply-To: <2bacffe7-e42b-9a33-b502-924ef38c628a@...2181...>

--WKPsw1Mq2k9Uo6fTE4kWSlDQWpO2QCUCd
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 09-11-17 04:25, Antonio Quartulli wrote:
>> @@ -812,6 +816,12 @@ gen_path(const char *directory, const char *filenam=
e, struct gc_arena *gc)
>>  #else
>>      const int CC_PATH_RESERVED =3D CC_SLASH;
>>  #endif
>> +
>> +    if (!gc)
>> +    {
>> +        return NULL; /* Would leak memory otherwise */
>=20
> As far as I understood the ratio behind this change, we are basically
> saying that passing gc =3D=3D NULL is a real programming error and not a
> runtime problem. If so, wouldn't it be better to assert(gc) directly?
> I am saying so because we should make this failure louder, so that it
> can be recognized in an early test.
>=20
> Or can we have cases when this function is called with NULL because of a
> temporary failure (my understanding is that this should not be possible)?

I'm a bit in doubt here - if this parameter is NULL, that's a
programming error.  But we've seen before that programming errors
sometimes can be triggered by external input.  In this case, this
function can be called when a client connects.  It *should* never hit
this case, but if it somehow does, that becomes a DoS vuln.  So I think
I prefer 'graceful error handling' in paths that are exposed like this,
unless the error indicates a system integrity error such as an
out-of-bounds read or write.

-Steffan


--WKPsw1Mq2k9Uo6fTE4kWSlDQWpO2QCUCd--

--54H9qxDvVGVivijV0jBNwDf5JMQqiXcp2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJaBFxNAAoJEEEwndWOY1w5ELYH/jEWQVXrTwppxHTneysBk/5J
nCjoESgdlb4CeKGC3w/5L1MznYRd20qYQcQPuyr4+K0Bj3LgyDRWEam0nHJ7MDwO
4wKG3YFzshYhE/g6jJxu9kjWZ9f8wkgTYl4ymANknUYlzIRn29tq3di0LrxZVbKq
HZTVGLoB7vy5BjluZF+YEKcEF0oExzK//nnvOJfh6gEz/rhyHmZxfgkoqU9HEjsF
AcUk01V8gAwsEdOV5yfw+9TtPMancJHDsBIMnW6YwuIpvDTDM4v40VU+6XB8zYzi
ghl9F43qRrEslXz7NI6o9vMvTI3lnCypuhKNOtvafwC9ehb/yIr5bgDh7D6Z/Bk=
=YXHn
-----END PGP SIGNATURE-----

--54H9qxDvVGVivijV0jBNwDf5JMQqiXcp2--

