References: <20180917134001.11666-1-arne@...1227...>
 <20181024100622.314-1-arne@...1227...>
 <dc5c81c1-7529-07a9-2e53-750fec37ed56@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <55f91f4f-fe40-2831-e0f8-1be424a9cc93@...2080...>
Date: Sun, 10 Nov 2019 10:55:09 +0100
MIME-Version: 1.0
In-Reply-To: <dc5c81c1-7529-07a9-2e53-750fec37ed56@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Y5CC6a3312NxCijXpU2apGMmUubaDZYn0"
Subject: Re: [Openvpn-devel] [PATCH v3] Make compression asymmetric by
 default and add warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y5CC6a3312NxCijXpU2apGMmUubaDZYn0
Content-Type: multipart/mixed; boundary="FkbJihldhjq8iUQQKr31ESKz5Gx6aUpQG";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <55f91f4f-fe40-2831-e0f8-1be424a9cc93@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v3] Make compression asymmetric by default
 and add warnings
References: <20180917134001.11666-1-arne@...1227...>
 <20181024100622.314-1-arne@...1227...>
 <dc5c81c1-7529-07a9-2e53-750fec37ed56@...1856...>
In-Reply-To: <dc5c81c1-7529-07a9-2e53-750fec37ed56@...1856...>

--FkbJihldhjq8iUQQKr31ESKz5Gx6aUpQG
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 09/11/2019 16:46, Steffan Karger wrote:
>>  static void
>>  add_option(struct options *options,
>> @@ -7322,29 +7339,78 @@ add_option(struct options *options,
>>      }
>>  #endif
>>  #if defined(USE_COMP)
>> +    else if (streq(p[0], "allow-compression") && p[1] && !p[2])
>> +    {
>> +        VERIFY_PERMISSION(OPT_P_GENERAL);
>> +
>> +        if (streq(p[1], "no"))
>> +        {
>> +            options->comp.flags =3D
>> +                COMP_F_ALLOW_STUB_ONLY|COMP_F_ADVERTISE_STUBS_ONLY;
>> +            if (comp_non_stub_enabled(&options->comp))
>> +            {
>> +                msg(msglevel, "'--allow-compression no' conflicts with "
>> +                    " enabling compression");
>> +            }
> Should this check not be moved to the postprocess checks? This will now
> only trigger is comp was first set, and allow-compression later in the
> config, not the other way around.

What about pushed options?  It's too long time since I looked at the option
parsing code paths last time, so I don't remember all the quirks here.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--FkbJihldhjq8iUQQKr31ESKz5Gx6aUpQG--

--Y5CC6a3312NxCijXpU2apGMmUubaDZYn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJdx96DAAoJEIbPlEyWcf3yQToQAJ7jJIawrogbIzuX/UP+MzYr
GkcYGixBtZhIBEN7Y7EC6AGlLvWgv+UHCl1TgrdYYi+BR0atOh/+jg2zWkowUfhm
jHIMZphZNcYohqnjT4jZke+CgzJ1e1bdahGD/UOA/JV+2RmnXT/VPtdBvlUboWGQ
JQUIn13/kpDAUvZ4aBwS/oPLkm75BX8Y5Khl0aW6TJXZYEx9P68hbERn9BjWsAhG
qfgAx5OVIDTDKefkeS1p2/efKAoyo+kxbjyxa+FgfNy9hQ0RB3s7txu6KYV4z5N6
l0qowDviXfU1BsUtnqgx1ltXuws7ZKDcbuVTxXZHhyKZiOG488yMpL3/VEsQQtEA
R1R4ELQaL6WfA/mPiqgNnXNKmm5w0Geu6T+se1YIHZqv64ykfPot8Sz6CHfhwp8h
GwYxdTNg4HDwtrkDi+i95K31P+EFPnVSSRIY0HRO2emhLl536eOCAi0ZdCdMuEHp
6hS2qnz1P3D46zRNOj6GSGKnCnyE95Hz7UhTFHR0DcaXQm64nrAqmNox4sr8/HFz
sRYMawbOMR7UQX7kI3NjOXUCrS8m+o3CyKMrB1T08v0nT0kSPnvdkaTLpggrwBUx
xTvk37SORXFayIGLFgbVeXCqPNDRPlEAYu5XV6zdae3mV6gPePoLBRkLeuWZT0CD
SxR7Bh+8b4J9uvNdtkNa
=V+uR
-----END PGP SIGNATURE-----

--Y5CC6a3312NxCijXpU2apGMmUubaDZYn0--

