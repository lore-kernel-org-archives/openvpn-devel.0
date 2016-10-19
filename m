References: <1476388771-16492-1-git-send-email-davids@...515...>
	<1476388771-16492-6-git-send-email-davids@...515...>
	<83c2c0fc-23e6-f03e-7151-198955416315@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1d788821-2cec-9201-f8b0-3f8a7c76333a@...2080...>
Date: Wed, 19 Oct 2016 23:12:40 +0200
MIME-Version: 1.0
In-Reply-To: <83c2c0fc-23e6-f03e-7151-198955416315@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="4VXi7q1ok1AIMdQW6GSAMAnruMg3LJlln"
Subject: Re: [Openvpn-devel] [PATCH 5/5] auth-gen-token: Authenticate
 generated auth-tokens when client re-authenticates
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4VXi7q1ok1AIMdQW6GSAMAnruMg3LJlln
Content-Type: multipart/mixed; boundary="O6ps463bmVJ03u6d4jwkAeRCDOPGa6DHm";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <1d788821-2cec-9201-f8b0-3f8a7c76333a@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 5/5] auth-gen-token: Authenticate
	generated auth-tokens when client re-authenticates
References: <1476388771-16492-1-git-send-email-davids@...515...>
	<1476388771-16492-6-git-send-email-davids@...515...>
	<83c2c0fc-23e6-f03e-7151-198955416315@...1856...>
In-Reply-To: <83c2c0fc-23e6-f03e-7151-198955416315@...1856...>

--O6ps463bmVJ03u6d4jwkAeRCDOPGa6DHm
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 19/10/16 22:12, Steffan Karger wrote:
> Hi,
>=20
> This feature looks very useful, and the code seems to work well.  Aside
> from some nitpicking, I do have some questions on the bigger picture:

Thanks a lot!

> On 13-10-16 21:59, David Sommerseth wrote:
>> On a server with --auth-gen-token enabled, the server will have created
>> a random token and pushed it to the client.  When the client needs to
>> renegotiate the connection or otherwise reconnect, it will at this point
>> use the auth-token as password.
>=20
> How does/should auth-token behave across the various restarts?  Should
> auth-token for example be cleared on a sigusr1?

This isn't really well defined, from the initial design.  This patch is
all based upon the --auth-token feature already present in OpenVPN 2.3,
and what is possible to do via the plug-in/script mechanisms available
today - which works even on v2.3 servers today.

So this feature I introduce here will currently only provide a similar
behaviour as if this the external authentication module had implemented
--auth-token support.  Plug-ins and --auth-user-pass-verify can only
return "success" and "fail", which is what this patch in essence does.

With that said, I am not too happy about this ambiguity.  But fixing
that should be done separately.  And we need to ensure we don't break
existing v2.3 clients, and I believe we need to update the client code a
bit too to achieve these goals.

>> Here we check if we have a token generated and that it has been pushed
>> to the client, if so, then we check if the token matches the locally
>> stored token.  If everything matches, we're done and the connection
>> is still authenticated.
>>
>> If the auth-token authentication fails, we delete our local copy of
>> the token and changes the connection to not being authenticated.  From
>> this moment of, the client needs to do a full reconnect providing
>> the users password again.
>=20
> How does the client know this?  This patch does not send an AUTH_FAILED
> (or something similar) to the client.  Testing seems to indicate that
> the server keeps refusing the token, and the client keeps resending it.

Sending AUTH_FAILED explicit would definitely be a good idea.  But it is
needed to verify that the OpenVPN is in a state where it can push and
that the client can accept the push.

But regardless of this, it this will not change the behaviour much at
all.  AFAICT, the client code today cannot separate authentication
failures based on passwords or tokens or get a reason why the
authentication failed.  (Unless there are something hidden inside IV_*
stuff or Peer-ID).

So what happens?  The server goes back to normal username/password
authentication, which fails as the token isn't valid as a password to
the authentication module.  The authentication module rejects and the
server sends an AUTH_FAILED, and the client disconnects.  At least
that's what happens in my testing environment.

If it is possible to send an AUTH_FAILED directly without going via the
authentication module, we can do that.  But going further than that will
most likely require some updates to the client code as well - which I
try to avoid in this round.

>> This token authentication also considers the token lifetime, if that
>> have been set via --auth-gen-token.  If the token have expired, the
>> client is rejected and needs to do a full reconnect with a new
>> authentication using the users password.
>=20
> Similar to the above, I don't see a way for the client to understand
> that the token has expired.  That results in the client sending its
> token indefinitely, like above.

Which would be optimal but equally hard as above, as we're currently
lacking a possibility to separate authentication failures.

> Some more nagging below ;)
>=20
>> Signed-off-by: David Sommerseth <davids@...515...>
>> ---
>>  src/openvpn/ssl_verify.c | 50 +++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 50 insertions(+)
>>
>> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
>> index 24ec56e..aa982e4 100644
>> --- a/src/openvpn/ssl_verify.c
>> +++ b/src/openvpn/ssl_verify.c
>> @@ -1139,6 +1139,55 @@ verify_user_pass(struct user_pass *up, struct tls=
_multi *multi,
>>    string_mod_remap_name (up->username, COMMON_NAME_CHAR_CLASS);
>>    string_mod (up->password, CC_PRINT, CC_CRLF, '_');
>>=20=20
>> +  /* If server is configured with --auth-gen-token and we have an
>> +   * authentication token for this client, base this authentication rou=
nd
>> +   * based on this token instead.
>> +   */
>=20
> base ... based, typo?

Yeah ... that needs to be improved.  I'll fix that comment.

>> +  if (session->opt->auth_generate_token && multi->auth_token_sent && NU=
LL !=3D multi->auth_token)
>> +    {
>> +      /* Ensure that the username have not changed */
>=20
> has not changed

Eeek!

>> +      if (!tls_lock_username(multi, up->username))
>> +        {
>> +          ks->authenticated =3D false;
>> +          goto done;
>> +        }
>> +
>> +      /* If auth-token lifetime have been enabled, ensure the token is =
still valid */
>=20
> has been enabled

*grmbl*

>> +      if (session->opt->auth_token_lifetime > 0
>> +          && (multi->auth_token_tstamp + session->opt->auth_token_lifet=
ime) < now )
>> +        {
>> +          msg (D_HANDSHAKE, "Auth-token for client expired\n");
>> +          ks->authenticated =3D false;
>> +          goto done;
>> +        }
>=20
> As explained above, I think the client should somehow be notified of
> this expiration, such that it can take action.

Covered in the discussion above.

>> +      if (memcmp_constant_time(multi->auth_token, up->password,
>> +                 strlen(multi->auth_token)) !=3D 0)
>> +        {
>> +          memset (multi->auth_token, 0, AUTH_TOKEN_SIZE);
>> +          free (multi->auth_token);
>> +          multi->auth_token =3D NULL;
>> +          multi->auth_token_sent =3D false;
>> +          ks->authenticated =3D false;
>> +          tls_deauthenticate (multi);
>> +
>> +          msg (D_TLS_ERRORS, "TLS Auth Error: Auth token verification f=
ailed for username '%s' %s",
>> +               up->username,
>> +               (session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)=
 ? "[CN SET]" : "");
>> +        }
>=20
> As above.  What should the client do?

Also covered in discussion above.



--=20
kind regards,

David Sommerseth


--O6ps463bmVJ03u6d4jwkAeRCDOPGa6DHm--

--4VXi7q1ok1AIMdQW6GSAMAnruMg3LJlln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYB+HIAAoJEIbPlEyWcf3ysTMP/iFHkcBGtxTeWsb3t4lXzM8z
MRbhbY0d0rbO6mhvsvAz0F9y43RyquGQArBSaVfIxB4OzZpdB/4gYov4/KtgT7S7
7kMhI/SczedHOnH5cxhLy24qOO3xQi+YLtxGSx/D6qFEBRn4Azhzsr/8PGsyxRAd
OjTPbgrKr63kpYBDH7mwddRXPusNJ0RKDY8d5Ejtc+OEuV9UInw/ctPfjmgs2/pi
SyzjyDJrFJnm2lpW3iiBHm5vgtXQsmrQhFfpMO2EbZhzzoz85Pl1HYdTPhIRHapn
hYm//9xXyyk6LU9HyMrV1bkowA6PpeQbg4R94KtJIufnf7KGS7WjeStfZBO5X/0S
AviGVXbWDr2lQyS+7YK0aA/FLA/J6IOAx/roGTBXUIqIyY3OPfPjwVeF2VV/fJ7L
PAtG6iSIttlUgdNT9AEi23G+BdlqS59eYCGxE6mep/7asPlsMa+TkCjAySX/3IAL
wzwzFdG3/Iwy61PFqHhRe6/0tVtKto5Y3oa0AVc0UUMCPj5nKmm2D+RwkpKqSfIZ
kJHh6Y9jxnvQ+MNELUEeSCovcAOZqH6dNO6K7AmvxQ27yrrnK5K9okfSU1WPr4JI
mdqQ1tVpsP6UoAgKA28D9MRxwlp/VOjo7YBHiyPBCm9qKVfF5A8jHFSShKfxtVvO
X3WazNcu/82lcBHBe/ve
=CYQf
-----END PGP SIGNATURE-----

--4VXi7q1ok1AIMdQW6GSAMAnruMg3LJlln--

