References: <20180917134001.11666-1-arne@...1227...>
 <20181024100622.314-1-arne@...1227...>
 <dc5c81c1-7529-07a9-2e53-750fec37ed56@...1856...>
 <55f91f4f-fe40-2831-e0f8-1be424a9cc93@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3c363ea7-7a55-1562-4281-c4b508c6dceb@...1227...>
Date: Mon, 17 Feb 2020 13:02:10 +0100
MIME-Version: 1.0
In-Reply-To: <55f91f4f-fe40-2831-e0f8-1be424a9cc93@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UjFI5EX6SOxCU47U3Z1XkZwuEWHe0ZYY7"
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UjFI5EX6SOxCU47U3Z1XkZwuEWHe0ZYY7
Content-Type: multipart/mixed; boundary="obPOE6Pk9ypyMrHi7XqLlr5KQJetZo674"

--obPOE6Pk9ypyMrHi7XqLlr5KQJetZo674
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 10.11.19 um 10:55 schrieb David Sommerseth:
> On 09/11/2019 16:46, Steffan Karger wrote:
>>>  static void
>>>  add_option(struct options *options,
>>> @@ -7322,29 +7339,78 @@ add_option(struct options *options,
>>>      }
>>>  #endif
>>>  #if defined(USE_COMP)
>>> +    else if (streq(p[0], "allow-compression") && p[1] && !p[2])
>>> +    {
>>> +        VERIFY_PERMISSION(OPT_P_GENERAL);
>>> +
>>> +        if (streq(p[1], "no"))
>>> +        {
>>> +            options->comp.flags =3D
>>> +                COMP_F_ALLOW_STUB_ONLY|COMP_F_ADVERTISE_STUBS_ONLY;
>>> +            if (comp_non_stub_enabled(&options->comp))
>>> +            {
>>> +                msg(msglevel, "'--allow-compression no' conflicts with=
 "
>>> +                    " enabling compression");
>>> +            }
>> Should this check not be moved to the postprocess checks? This will now
>> only trigger is comp was first set, and allow-compression later in the
>> config, not the other way around.
>=20
> What about pushed options?  It's too long time since I looked at the opti=
on
> parsing code paths last time, so I don't remember all the quirks here.

For pushed options msglevel will be warning so you get a warning when
the server tries to enable compression but it will not error out. The
server pushing a compression when the client does not advertise the IV_
for that algorithm is an error in the server config.

Arne


--obPOE6Pk9ypyMrHi7XqLlr5KQJetZo674--

--UjFI5EX6SOxCU47U3Z1XkZwuEWHe0ZYY7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5KgMIACgkQFRhsZwKx
RFTDtQ//QNCSpFtGeqL9UbVpqappefurAy1rnxXrkNK9i8bSZ6Q+bUzEruzDBkom
fj1S0SX/IjL8LdUwbfkISWNU6eAaOAwGwhinXEa8slci3sGAkjHJAJnic9J8HNSt
+Hvu+Wp3TuNBYsARd1E2yjj8KbmsTh1m6tpICTk5xAgy50ldQeRQlNtxIFFF/B/8
miaOnJ8926OKHKerCR76lTc2Nyb7BMTvd9eNy3HXHyDIVn0BiKIw7hzAPCuJ5J3g
pBUENAsbADRd5Ck4Gs1KqQHotxnetcWiLnsUaQ8xmmUs8uu8xM64cEswVOBcdEqz
1GwZek6QF3gQNUnMdYOahjqkmukJDmSUFKAgktE9jqcsusBMPP+Rd3JL6xR6tbOi
Gf/U03M5CF+dfZiPcaLDvsSHSuCPZvXLjAFqwPpT3/e4hWaVPEJFw7Z6Gyksrght
deExyxk9XZ/yxVl9jVXLAbsjMJaSwMjgxZmzQx41av/e7PfyxXsZQqamsQ2exzfI
nOse1NUjurdEhrfu1csKgVHkZZ1hWr8UwiGoqsIMBwPPJ6U5QfPlYRh8FNoQOQ4M
LcZw2dIPHnHP0bt/hfVK9PFvDgpjv3ozSCB/7vPloQeeJnyNv9+qs6ykRgUsiBWb
JYgHKF+yPCR3jXfz6VMNEQMyqmdZMS82VDBtTvVRfnAr+dHtAds=
=39K2
-----END PGP SIGNATURE-----

--UjFI5EX6SOxCU47U3Z1XkZwuEWHe0ZYY7--

