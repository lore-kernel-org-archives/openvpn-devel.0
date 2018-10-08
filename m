References: <20181008181618.8976-1-arne@...1227...>
 <20181008181618.8976-2-arne@...1227...>
 <20181008183739.GW962@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <7fb77391-e087-ee4a-338c-12135400d22c@...1227...>
Date: Mon, 8 Oct 2018 23:31:38 +0300
MIME-Version: 1.0
In-Reply-To: <20181008183739.GW962@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="207MD4OJpX0xMYcA5tDlB4aTxcyc0HysL"
Subject: Re: [Openvpn-devel] [PATCH 2/4] Remove AUTO_USERID feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--207MD4OJpX0xMYcA5tDlB4aTxcyc0HysL
Content-Type: multipart/mixed; boundary="qAPPOWerHWunWmfAJxPl0Ql1vFxntidyy";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <7fb77391-e087-ee4a-338c-12135400d22c@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] Remove AUTO_USERID feature
References: <20181008181618.8976-1-arne@...1227...>
 <20181008181618.8976-2-arne@...1227...>
 <20181008183739.GW962@...1296...>
In-Reply-To: <20181008183739.GW962@...1296...>

--qAPPOWerHWunWmfAJxPl0Ql1vFxntidyy
Content-Language: de-DE
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 08.10.18 um 21:37 schrieb Gert Doering:
> Hi,
>=20
> On Mon, Oct 08, 2018 at 08:16:16PM +0200, Arne Schwabe wrote:
>> There is no user facing way to enable this feature and way that feature
>> works (username build from MAC of primary net device) is questionable.
>>
>> It also does not compile anymore.
>=20
> Feature-ACK, but the patch itself puzzles me.
>=20
>> @@ -455,51 +455,6 @@ get_auth_challenge(const char *auth_challenge, stru=
ct gc_arena *gc)
>>=20=20
>>  #endif /* ifdef ENABLE_MANAGEMENT */
>>=20=20
>> -#if AUTO_USERID
> [..]
>> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
>> index 0a947c6e..5a136d69 100644
>> --- a/src/openvpn/ssl.c
>> +++ b/src/openvpn/ssl.c
>> @@ -410,9 +410,6 @@ auth_user_pass_setup(const char *auth_file, const st=
ruct static_challenge_info *
>>      auth_user_pass_enabled =3D true;
>>      if (!auth_user_pass.defined && !auth_token.defined)
>>      {
>> -#if AUTO_USERID
>> -        get_user_pass_auto_userid(&auth_user_pass, auth_file);
>> -#else
>>  #ifdef ENABLE_MANAGEMENT
>=20
> These hunks have "ENABLE_MANAGEMENT" in the context, while all my branches
> (2.3, 2.4, master) have "ENABLE_CLIENT_CR" here.
>=20
> This is not really needed to remove the (questionable) feature - and I can
> just adjust the patch on the fly - but I wonder where these are coming=20
> from in your tree, and whether I missed (or messed up) something...
>=20

You are missing patch 1/4:

[PATCH 1/4] Remove MANAGMENT_EXTERNAL_KEY, MANAGMENT_IN_EXTRA,
ENABLE_CLIENT_CR

Is being held until the list moderator can review it for approval.

The reason it is being held:

    Message body is too big: 309191 bytes with a limit of 256 KB

But since it now does not apply anymore since 2/4 got in first, I will
resend that mail and canceld the message request.

Arne


--qAPPOWerHWunWmfAJxPl0Ql1vFxntidyy--

--207MD4OJpX0xMYcA5tDlB4aTxcyc0HysL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQReA6r9qqhQzJnD/WZ7z5ww1LjNFwUCW7u+qwAKCRB7z5ww1LjN
F6cOAJ41vFOVeIpikLlLfHhdgcNpq8y9pgCglKFyTebe95W+Rz+eDAdItyzZwj4=
=JIxD
-----END PGP SIGNATURE-----

--207MD4OJpX0xMYcA5tDlB4aTxcyc0HysL--

