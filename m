References: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f831862a-8cde-7ff9-e2e8-9d8981873964@...2080...>
Date: Fri, 16 Sep 2016 18:29:10 +0200
MIME-Version: 1.0
In-Reply-To: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="B1uM5nKUnrNGufE6r6sv520w7sKF91Ucl"
Subject: Re: [Openvpn-devel] [RFC] - Enable 2FA to be used with
	renegotiations
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B1uM5nKUnrNGufE6r6sv520w7sKF91Ucl
Content-Type: multipart/mixed; boundary="squQeNOk17i83HcuWeDnjK0SmSOWIxlAX"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net
Cc: Selva Nair <selva.nair@...277...>
Message-ID: <f831862a-8cde-7ff9-e2e8-9d8981873964@...2080...>
Subject: Re: [Openvpn-devel] [RFC] - Enable 2FA to be used with renegotiations
References: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>
In-Reply-To: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>

--squQeNOk17i83HcuWeDnjK0SmSOWIxlAX
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 25/08/16 15:45, David Sommerseth wrote:
>=20
> Hi,
>=20
[...snip...]
>=20
> What the patch-set does is:
>=20
> - Add --auth-gen-token, and when used the following steps happens
>=20
> - After a successful normal user/password authentication, it will=20
> generate a random token for this tunnel and keep a local copy of
> it. This token is currently set to 256 bits (32 bytes).
>=20
> - It will push 'auth-token $RANDOM_TOKEN_VALUE'.  The=20
> $RANDOM_TOKEN_VALUE sent to the client is BASE64 encoded.
>=20
> - When a re-authentication happens, and the server sees it have a
> token and the token have been sent to the client, it does an=20
> authentication of the token alone.  Any --auth-user-pass-verify or=20
> --plugins enabling OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY will not be
> called at this point.  On successful token authentication,=20
> everything continues as before.  On failure the session is
> considered un-authenticated and a complete new authentication round
> is required.
>=20
> If --auth-gen-token is NOT used, OpenVPN will behave as before.
>=20
> The patch-set can be found here:=20
> <https://gitlab.com/dazo/openvpn/compare/master...dev%2Fauth-gen-token>
>
>  And the git tree can be found here:=20
> <https://gitlab.com/dazo/openvpn.git> (Check out the
> dev/auth-gen-token branch)

I've spent some time improving these patches with the input from
Selva, Jens, Steffan and Gert.

- The dev/auth-gen-token branch have been updated to latest master

- Properly clear the auth_token from memory before free()ing it
  Add memset() before clearing the token from memory

- Add additional check that the user name has not changed...
  Check with tls_lock_username() which verifies username is the same.

- Properly de-authenticate the TLS connection on auth-token failures
  Call tls_deauthenticate() on authentication failures.  This triggers
  connected client with failure to disconnect properly.

- Enhance option parsing for --auth-gen-token
  ~ Require OPT_P_GENERAL_FLAGS
  ~ Dump the auth_generate_token flag on --verb 4 and higher
  ~ Ensure --auth-gen-token cannot be used in any of the client modes

- Mask/hide generated tokens unless verbose/debug level is >=3D 7
  It was considered that this information is valuable during debugging,
  but otherwise it can be hidden.

- Implement optional auth token lifetime for generated token
  This allows an auth-token to only be valid for a certain time period

- man-page: Document the --auth-gen-token feature


Everything can be found here:
<https://gitlab.com/dazo/openvpn/commits/dev/auth-gen-token>
(in the dev/auth-gen-token branch)

Unless the feedback requires more work, I'll squash them a bit and
submitt them to the mailing list now.  General testing looks good so far.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


--squQeNOk17i83HcuWeDnjK0SmSOWIxlAX--

--B1uM5nKUnrNGufE6r6sv520w7sKF91Ucl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX3B3WAAoJEIbPlEyWcf3y8PUP/RCRr9w5KyoJbtxpAfoqPHW4
l3lT818dRjG9C7yFtMturuQTZ0S4lm2IrmPyS+tqHXDuVyLisPuHYmuiU2drpd6c
m/tlxfKr0sG4UhoFl6TKn93hh+8OWHjXJ9Zu2sopEVcvC67BUjwgw6cn7hArWAxt
gsrT9D0jY7WvfEqw656cetBCuh656vkhCrVfCDXTI2I8aRjXb88zpFT5wnx3hbOc
6uq3/59prZY3RguD2epBIXtw8/EX8eb9Mq397zHTSn5+U/CpTSEYio+SlSwCIm+q
ntwsJpoOHMlObamrHvSca3V9h3NvUtSiyxyFk3RqGWPe07GYSrGZiV0me8WcJNSh
51N2FjQpMr1eanj4sjfXkwr3WnmW/OnO8zxYvTp+FlfnYg+2WX7/R/PSHZNh2Si0
A7qbQRM/JUidGJ8kvTsA/U73SY9S+QMZvi+HPzZk96STnOJBhf/gpMQy/PkF3VLG
k7Mpyy4zdHS+Dpc15YUqD+r0DcYjBhjh+GqBGPBdI+BNmaOjkpw9Jz7apKI8/53G
Xb6gqBH22bVGF0fdWW9h9AREjxB0ShmDKEqgKdjfwh7pSVL3t1APs5lDYoxPcSlK
SyukCa1QSoFAyv3zDux/t66rVvoqzA4QC+LBlkBou/1k2Ft5kCuHbhm2MCkU1B3e
2f/uxyZMmHLwqpEflbND
=47hK
-----END PGP SIGNATURE-----

--B1uM5nKUnrNGufE6r6sv520w7sKF91Ucl--

