References: <20190122150333.1061-1-arne@...1227...>
 <20190122150333.1061-3-arne@...1227...>
 <fe2991e2-5860-8d05-de5c-751cf9e9fe30@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1cf56a63-2abf-c934-e462-22a16ebf1180@...1227...>
Date: Fri, 22 Feb 2019 11:35:10 +0100
MIME-Version: 1.0
In-Reply-To: <fe2991e2-5860-8d05-de5c-751cf9e9fe30@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="O3sORKPTCeCCLj959Xr6m9BiSPZ7xDNgs"
Subject: Re: [Openvpn-devel] [PATCH v2 3/6] Rewrite auth-token-gen to be
 based on HMAC based tokens
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O3sORKPTCeCCLj959Xr6m9BiSPZ7xDNgs
Content-Type: multipart/mixed; boundary="tXvABGGsd5sc0YCfq6Izlf5A2bCdWqSmy";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Eric Thorpe <eric@...1918...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <1cf56a63-2abf-c934-e462-22a16ebf1180@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/6] Rewrite auth-token-gen to be based
 on HMAC based tokens
References: <20190122150333.1061-1-arne@...1227...>
 <20190122150333.1061-3-arne@...1227...>
 <fe2991e2-5860-8d05-de5c-751cf9e9fe30@...1918...>
In-Reply-To: <fe2991e2-5860-8d05-de5c-751cf9e9fe30@...1918...>

--tXvABGGsd5sc0YCfq6Izlf5A2bCdWqSmy
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 22.02.19 um 03:42 schrieb Eric Thorpe:
> Thanks for doing this one Arne, this has been on my bucket list for a
> while. I've given this a reasonable test now and it's working as I'd
> expect. A few comments from my testing:
>=20
> On 23/01/2019 2:03 am, Arne Schwabe wrote:
>=20
>> +    /* Accept session tokens that not expired are in the acceptable ran=
ge
>> +     * for renogiations */
>> +    bool in_renog_time =3D now >=3D timestamp
>> +                         && now < timestamp + 2 * session->opt->renegot=
iate_seconds;
> I'd like to see the valid time of an auth-token have it's own value,
> however I understand why you've done this. I can't find a nice way to
> get through the last active time of a session through to auth without a
> reasonable refactor. I'd like to see the auth token have the option
> "--auth-gen-token [inactive timeout] [total timeout]" or something along
> those lines. So while this isn't an ideal solution, it's good enough.

I am not really sure what talking about. There are two lifetimes for
auth token.

- the total max lifetime of an auth-token session (also specified in the
config)
- the max lifetime of an individual auth-token.

The second one is dervived from renegotiate_seconds as setting this
lower than this time will break renogiation.

The reason that I did not do any refactoring is a client with auth-token
can switch to another server and that server needs to verify that
auth-token with the information from the client and its config alone.

>> +    /* We could still have a client that does not update
>> +     * its auth-token, so also allow the initial auth-token */
>> +    bool initialtoken =3D multi->auth_token_initial
>> +                        && memcmp_constant_time(up->password, multi->au=
th_token_initial,
>> +                                                strlen(multi->auth_toke=
n_initial)) =3D=3D 0;
> I don't agree with this being in place, only the most recently generated
> token should be valid imo.

The reality is that we don't want to exclude all the older OpenVPN3
clients that do not update their token. Without this special, after
2*renogiation time, the clinets will fail.

> When an auth-token is authenticated, the server log will print out:
>=20
>> TLS: Username/auth-token authentication succeeded for username is still =
displayed.
>> TLS: Username/Password authentication succeeded for username is still di=
splayed.
> The second line seems redundant and might cause some confusion. "if
> (skip_auth)" above this log line is probably enough I think?
>=20
> Finally, the patch won't build under MSVC without the following change:
>=20
>> +    struct push_list push_list =3D {};
> to
>=20
>> +    struct push_list push_list =3D {0};
>=20
> auth_token.c and auth_token.h will need to be added to the VS solution
> as well however I'm happy to submit that one myself once this gets acked
> to save you the trouble.

I will look into it.

Arne



--tXvABGGsd5sc0YCfq6Izlf5A2bCdWqSmy--

--O3sORKPTCeCCLj959Xr6m9BiSPZ7xDNgs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxv0HgACgkQFRhsZwKx
RFQo0BAAgUA86leMO2qC+tb8B7yjFlFGrqCuKaFYfJl5JUC/ujrINuhsH8pzaWUu
CvAbVyi0uE7qyj9wgWLZLxj+/JtElL2OtoSsC9Ze7kd3yLNK7SWIzvekYaSU/7Yp
3v2/1XCO5qrq8P36yOzVKmrWcwW20r3EjNvnxcvakZ3kT44dGoi/mf/JQui2CQL0
9hV5G1xSGKHPLQM73ra/LLYnb9ZPsk5tsWvJR4bFyWdqYHB+aSe/QLulaVHJVwUi
M+CLYBqpbYp43q+fbDiYOYREAaoW/Tg4ip9jLzMLimTcQw8y7LrJPyiV1vG8dKsP
yuxHL8bgWsYEx4lYK3hZHE5ounCrvqAlNKUx92WUm26CipR+pASTgixpfjFs6XBC
tvCdwvJPBJfskAwwxd2xRMs+NmqWHPnXvk2P+jRQaHMHexLSYTo2hAaU9Mvsav7G
jHWxVF8KSZj9yrxIWFP/GTe1irfkyCrtgoR4ZV/ggSRHJXESS6MKwXh0rmiTmotP
B5G4SVna0SHS9ufs7aRDVt2ZUNlHrFI6Ut9hEGXtdEyXftVtR7jaB7rsTdVlBl9U
+6Beeg4frbyel1xTMfogda17nSCf+5Kc0/VtzR84LtGsZIj3q52RElWYiYvRvfMM
2idw+LT9wH2dY2FClp2oiaq5dI5243MjX+Hqxc6SMvcX9Osaw8M=
=QGyO
-----END PGP SIGNATURE-----

--O3sORKPTCeCCLj959Xr6m9BiSPZ7xDNgs--

