References: <20191109151306.18597-1-arne@...1227...>
 <20191109151306.18597-4-arne@...1227...>
 <904629c3-4bd4-a31e-30c7-70f100b26473@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5276b25b-5d47-54ec-69a7-514057f5b2de@...1227...>
Date: Wed, 15 Apr 2020 13:48:42 +0200
MIME-Version: 1.0
In-Reply-To: <904629c3-4bd4-a31e-30c7-70f100b26473@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VNd0YyP8QlU2VYpfB7in5DrNRXKgp3dgK"
Subject: Re: [Openvpn-devel] [PATCH v2 4/5] Implement sending SSO challenge
 to clients
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VNd0YyP8QlU2VYpfB7in5DrNRXKgp3dgK
Content-Type: multipart/mixed; boundary="reZrHKUUQZX1rT58tEkdnYynFySm1s24N"

--reZrHKUUQZX1rT58tEkdnYynFySm1s24N
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 27.03.20 um 22:09 schrieb David Sommerseth:
> On 09/11/2019 16:13, Arne Schwabe wrote:
>> This implements sending AUTH_PENDING and INFO_PRE messages to clients
>> that indicate that the clients should be continue authentication with
>> a second factor. This can currently be out of band (openurl) or a normal
>> challenge/response 2FA like TOTP (CR_TEXT).
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>  doc/management-notes.txt | 26 +++++++++++++++++++++++
>>  src/openvpn/manage.c     | 46 ++++++++++++++++++++++++++++++++++++++++
>>  src/openvpn/manage.h     |  3 +++
>>  src/openvpn/multi.c      | 19 +++++++++++++++++
>>  src/openvpn/push.c       | 24 +++++++++++++++++++++
>>  src/openvpn/push.h       |  2 ++
>>  6 files changed, 120 insertions(+)
>=20
> Code and management notes looks reasonable.  But again, it would be good =
to
> have a way to test this properly to avoid regressions later on.  Since th=
is is
> also a more advanced authentication method, having good test methods is e=
ven
> more critical.

Writing a complete framework to test management interface on the server
side is something that would a huge undertaking for this simple patch.

I think Access Server is basically the only software that I am aware of
that really uses the server side management interface.

So basically having this requirement right now of writing a testing
suite to get this into OpenVPN will mean that we will effectively fork
OpenVPN for AS.

Arne


--reZrHKUUQZX1rT58tEkdnYynFySm1s24N--

--VNd0YyP8QlU2VYpfB7in5DrNRXKgp3dgK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6W9JsACgkQFRhsZwKx
RFQPyg/9Ekb5gdTG8N1sWgKtk1gELCR6Y+9JpdOka+mU+1/JCVKf1BoM4CCvlMq3
zF+VLAlBwEuRXpGjsAtpNCn0MOuNSWujddpUyEdiTCfJddxZoEkkCwcFICC0NL5R
wHhTzwiVWvFFn18/21AkqJlg8svRaaxuuksBQcynK9c6/coC7K4EGwSmKJ4CAqi4
9EihUsK1hjlrb7twUODbPA+7Aq8ycEvPZL5NCuaa81gqAszPOgQt7Iz3g8DQpDeE
cxp0BQBxDx/z6syqYF/IbQnm7yhWMFSQ0kS+j5tm9ac8GodOsLhrodlbfMpUpTaM
T2AVfT3NQIE00JNoXpGKViREakHt/fY6Eo0jChpXlC9bV0vus7VIHW+yXqCtqASl
SbGIACBzbstMUUQ9rJI4d2lWKltMsC0jgQvWyFo4886Or8FONz7EaZScCBaphY3l
F7CVFxJRLuaRzHcijBJMz/R0UqFt9LVu4onXC9pcA6IwnuoHG7X1N0J8ovQN63rz
5L+G22wUG7+w4yVQWBmpBIwe/qu0rhL6F67HA7/LbjmqudDjNKWTwXA74ri1OxyV
7wltrE9d1k24wmvdbwZJD0hFeQLLbvPMI0PgpzIO8T3N2Z6jM+xuKjLS6+1mGMy9
KFbp9vECt4yeNkxm7W+dq36nUh/Kk60ldk++t5m82X1unTDBSaA=
=uTLN
-----END PGP SIGNATURE-----

--VNd0YyP8QlU2VYpfB7in5DrNRXKgp3dgK--

