References: <20170328191900.8488-1-davids@...515...>
	<cb195f68-3e49-e766-926f-61271e7c3ec2@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0a0813de-173e-bd6e-3e53-c0286b7ccc19@...2080...>
Date: Tue, 28 Mar 2017 23:03:07 +0200
MIME-Version: 1.0
In-Reply-To: <cb195f68-3e49-e766-926f-61271e7c3ec2@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F11eRqLkdtkvt8fsCClIV37j6LUmUKPxs"
Subject: Re: [Openvpn-devel] [PATCH] auth-token: Ensure tokens are always
 wiped on de-auth
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F11eRqLkdtkvt8fsCClIV37j6LUmUKPxs
Content-Type: multipart/mixed; boundary="Fe3SvpBUPaBACNSWVhVKNn4HPM0xaQXh2";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <0a0813de-173e-bd6e-3e53-c0286b7ccc19@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] auth-token: Ensure tokens are always
	wiped on de-auth
References: <20170328191900.8488-1-davids@...515...>
	<cb195f68-3e49-e766-926f-61271e7c3ec2@...1856...>
In-Reply-To: <cb195f68-3e49-e766-926f-61271e7c3ec2@...1856...>

--Fe3SvpBUPaBACNSWVhVKNn4HPM0xaQXh2
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/03/17 22:24, Steffan Karger wrote:
> Hi,
>=20
> On 28-03-17 21:19, David Sommerseth wrote:
>> If tls_deauthenticate() was called, it could in some scenarios leave the
>> authentication token for a session in memory.  This change just ensures
>> auth-tokens are always wiped as soon as a TLS session is considered
>> broken.
>>
>> Signed-off-by: David Sommerseth <davids@...515...>
>>
>> ---
>>
>> The wipe_auth_token() function is otherwise moved to be declared before
>> tls_deauthenticate() and the latter function is also slightly modified to
>> make use of the C99 feature of inline declaration - mostly to have a more
>> reasonable coding style when adding the wipe_auth_token() call.
>> ---
>>  src/openvpn/ssl_verify.c | 44 ++++++++++++++++++++++++-----------------=
---
>>  1 file changed, 24 insertions(+), 20 deletions(-)
>>
[...snip...]
>> +
>> +/**
>> + *  Wipes the authentication token out of the memory, frees and cleans =
up related buffers and flags
>> + *
>> + *  @param multi  Pointer to a multi object holding the auth_token vari=
ables
>> + */
>> +static void
>> +wipe_auth_token(struct tls_multi *multi)
>> +{
>> +    if( multi ) {
>> +	if (multi->auth_token ) {
>=20
> The spaces in theses lines look a bit odd.

Sigh ... seems my Emacs config have re-decided on tabs vs spaces :/  Fixed!

[...snip...]
>=20
> Shouldn't we also clear the token if the ccd authentication check in
> verify_final_auth_checks() fails?

Thanks!  I didn't consider that so much, as in my mind this check
happened before the user/password auth ... but it seems it actually
happens afterwards.  So you're right, as this is really happening after
we have generated a token, this should be wiped here too.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--Fe3SvpBUPaBACNSWVhVKNn4HPM0xaQXh2--

--F11eRqLkdtkvt8fsCClIV37j6LUmUKPxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY2s+LAAoJEIbPlEyWcf3yZAYQALIdv+jFd7qFqKxZtA6L4iHx
bazmfy4xuCwLp9xrLSWbNT0ZpAcZPaFFx8PRvt2G73kyDstvmYQaQODfxnkHjj1T
/arEyYrNuExFWPsdPf/S+zKKOABtQXN9UnmMbKUdpkE3u7+l9E3t9GgeK9XM895K
nBaIJceIOw+TmGeHkzMua4xs+s7QNy87MB9WVgbBavW+BF23VuU/4IZwEqN22h9E
SblbJZ/ujv59e7a9VtdZOSJF1Nx5scZpKaJIP8K3Rv665YQcENNK5hw/g5idgVdh
vQ2M1fAjPsOZlH+Q8bB/gUSVIKRCRvFNaUVzgffOww1cqgBc3Zyx6REi2OfrUM1V
/hog6RRaz/+7zthXIg/MkcWPVxkefv+SCvXuWVGdeeAc2sRdhrPSK2ShrzgG6pai
JRO8j2nMNIKW8XKIVBd/XbKGzaMPth9hWgugG+iprFTx40rz1KNRHCLqSETmuz7E
QSDub9ofB0fkFndOffOCSo3Xq2e9B3WSSDO0OuE7QExeOV0YyEv29v1w3pD3ZxCr
027fOHz1a2ZJP9WkuXwv2SnWq1s6DrRU7xLKYJ0qQZMg5cjOYsyOzGfEGe3fy9dd
zvcl5FOKdWbPzW51eEOflCShwM+Odh6l+T7eYWJDqa0oVwAiOX8t+cUgECA7Ndi5
8isqkMrELOzFkg1MO0NM
=kW10
-----END PGP SIGNATURE-----

--F11eRqLkdtkvt8fsCClIV37j6LUmUKPxs--

