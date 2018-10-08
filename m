References: <20181008175044.8289-1-arne@...1227...>
 <20181008175630.GT962@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <cf320ce1-150c-ef13-f6e7-d8ea14ae796e@...1227...>
Date: Mon, 8 Oct 2018 20:59:52 +0300
MIME-Version: 1.0
In-Reply-To: <20181008175630.GT962@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2xlYzVJ0YtCCbxvZCrs3lFVFveIbga0z0"
Subject: Re: [Openvpn-devel] [PATCH] Fix building with --disable-management
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
--2xlYzVJ0YtCCbxvZCrs3lFVFveIbga0z0
Content-Type: multipart/mixed; boundary="Cu6hrJ0wzvN8R4IQPu9FTeJ81T04wdyRx";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <cf320ce1-150c-ef13-f6e7-d8ea14ae796e@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with --disable-management
References: <20181008175044.8289-1-arne@...1227...>
 <20181008175630.GT962@...1296...>
In-Reply-To: <20181008175630.GT962@...1296...>

--Cu6hrJ0wzvN8R4IQPu9FTeJ81T04wdyRx
Content-Language: de-DE
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 08.10.18 um 20:56 schrieb Gert Doering:
> Hi,
>=20
> On Mon, Oct 08, 2018 at 07:50:44PM +0200, Arne Schwabe wrote:
>>  src/openvpn/push.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
>> index 9075d63b..af6d44f7 100644
>> --- a/src/openvpn/push.c
>> +++ b/src/openvpn/push.c
>> @@ -177,7 +177,6 @@ server_pushed_signal(struct context *c, const struct=
 buffer *buffer, const bool
>>=20=20
>>  void server_pushed_info(struct context *c, const struct buffer *buffer,=
 const int adv)
>>  {
>> -  struct gc_arena gc;
>>    const char *m =3D "";
>>    struct buffer buf =3D *buffer;
>=20
> Not sure which branch this is coming from...
>=20
> $ git branch -v
> * master      674b1664 build: Fix build warnings related to get_random()
> $ git grep server_pushed_info
> $ git checkout -=20=20
> Switched to branch 'release/2.4'
> Your branch is up to date with 'stable/release/2.4'.
> $ git grep server_pushed_info
> $=20
>=20
> ... but it does not seem to be anything official...?
>=20

Sorry. I will resend the right patch.

Arne


--Cu6hrJ0wzvN8R4IQPu9FTeJ81T04wdyRx--

--2xlYzVJ0YtCCbxvZCrs3lFVFveIbga0z0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQReA6r9qqhQzJnD/WZ7z5ww1LjNFwUCW7ubGAAKCRB7z5ww1LjN
F5LnAKDVaakv2NvkA69YwSWFAxq3ts2MkQCgnPK3jQcuxQwcjBIikQt6xI7IQb8=
=PbkA
-----END PGP SIGNATURE-----

--2xlYzVJ0YtCCbxvZCrs3lFVFveIbga0z0--

