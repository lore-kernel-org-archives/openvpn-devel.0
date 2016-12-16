References: <1481728374-7196-1-git-send-email-davids@...515...>
	<1481804534-26913-1-git-send-email-davids@...515...>
	<CAA1Abx+LM1Z5O3wVwZ=i1cRqdbHr_KL8Hpg4GmAbdjgyfUs8bw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9cf26722-cb54-282f-2afd-5c5776a8700e@...2080...>
Date: Fri, 16 Dec 2016 01:09:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAA1Abx+LM1Z5O3wVwZ=i1cRqdbHr_KL8Hpg4GmAbdjgyfUs8bw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="B3uExc0Jo8CLCwDXDrc8SF8H2QcBsCKvU"
Subject: Re: [Openvpn-devel] [PATCH v2] auth-gen-token: Hardening memory
 cleanup on auth-token failuers
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B3uExc0Jo8CLCwDXDrc8SF8H2QcBsCKvU
Content-Type: multipart/mixed; boundary="86WBhjLhQVoSigFSJv1wTsWGCrXnE3avi";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <9cf26722-cb54-282f-2afd-5c5776a8700e@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] auth-gen-token: Hardening memory
	cleanup on auth-token failuers
References: <1481728374-7196-1-git-send-email-davids@...515...>
	<1481804534-26913-1-git-send-email-davids@...515...>
	<CAA1Abx+LM1Z5O3wVwZ=i1cRqdbHr_KL8Hpg4GmAbdjgyfUs8bw@...278...>
In-Reply-To: <CAA1Abx+LM1Z5O3wVwZ=i1cRqdbHr_KL8Hpg4GmAbdjgyfUs8bw@...278...>

--86WBhjLhQVoSigFSJv1wTsWGCrXnE3avi
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

[lets try unencrypted this time.]

On 15/12/16 22:52, Steffan Karger wrote:
> Hi,
>=20
> On 15 December 2016 at 13:22, David Sommerseth <davids@...515...> wrote:
>> Further improve the memory management when a clients --auth-token
>> fails the server side token authentication enabled via --auth-gen-token.
>>
>> v2 - Add ASSERT() if base64 encoding of token fails
>=20
> This will need rebasing because of the reformatting.
>=20
>> @@ -1255,24 +1269,11 @@ verify_user_pass(struct user_pass *up, struct tl=
s_multi *multi,
>>           /* The token should be longer than the input when
>>             * being base64 encoded
>>             */
>> -         if( openvpn_base64_encode(tok, AUTH_TOKEN_SIZE,
>> -                                    &multi->auth_token) < AUTH_TOKEN_SI=
ZE)
>> -           {
>> -             msg(D_TLS_ERRORS, "BASE64 encoding of token failed. "
>> -                  "No auth-token will be activated now");
>> [...]
>> +          ASSERT(openvpn_base64_encode(tok, AUTH_TOKEN_SIZE,
>> +                                       &multi->auth_token) < AUTH_TOKEN=
_SIZE);
>=20
> Uhm, I think the < should be a > now?
>=20

*facepalm*

I was completely sure I had tested it.  I really did run tests.  I just
ran the server and client on the opposite hosts.  So the VM which had
not been updated which should run the client ran the server mode instead
... thus no issues :/

I'll send a v3 patch now.

--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--86WBhjLhQVoSigFSJv1wTsWGCrXnE3avi--

--B3uExc0Jo8CLCwDXDrc8SF8H2QcBsCKvU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYUzCqAAoJEIbPlEyWcf3yX/wP/3155AFMYpqPqaOwQmNNZx/T
9zF4WE07NFxAomhsIsfKGq0zBxQaM1WiymHqgf8qlUTYzMkCweCi9avCMl3SPXef
B+iVA5kQRXu0r8iuzgA/yNpQwFShN9ZYht4qTpjRZI3BjIHEXJaQbtn4mvlFt+F2
OCxxumwLis/+GSDAPy3FehU/l2Cf16Hw8RSEab4+P5NjK/fE8mxzRE4HAOX4E4cJ
ayZyN8byYNoSRBBm8zd/6v7gm0GerLHZ2KmZU2FxDto6z+cc80PUdZ2t1ra7E64A
TpNkHEXLteslCxiynG1uiBaBYXLuOr437pfwPTnw5emDhMh+Kf6psKa/u6o4eHOI
cBv6Vc5BxwGb8N0YbDbZnGEDHxpAbXfJ58+5vKy26t1SZblsJlLTBNuwghycVemg
eEzHStjjt248I9f8mANgKZUDNSXMD+KQbr6H5Lt8ziVg4q8v6pT08M2uHy8WH0Kf
TRsC6oXFXiRJly+g2P20vtfv46k2ifvXNLwBeGgv/B9Ah0PrR1KdkQJbxF74XT45
pYDjBmZLHkDAIt95OM4wZOpYcytNOYYta2JxsbefeKsTq/TNJu4VKy3C0vqqh8bz
3ABN1MyrX8ELo6X93oD3nyCsqA2mzHX7OV1XwMyC4ZsXt9qvWVxokmK0Jp3kJl2d
MnFHbAn4oNmJlrATdps2
=TrF+
-----END PGP SIGNATURE-----

--B3uExc0Jo8CLCwDXDrc8SF8H2QcBsCKvU--

