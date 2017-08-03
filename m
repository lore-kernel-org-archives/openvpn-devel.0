Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170802181435.14549-1-ch@...2291...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d4481d5c-319c-c888-bfec-e74fc557527e@...2080...>
Date: Thu, 3 Aug 2017 22:54:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170802181435.14549-1-ch@...2291...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Sd9DB9WBsRXoXgULDq71sArKb8mekaEqu"
Subject: Re: [Openvpn-devel] [PATCH 0/2] Improve usability of non-privileged
 operation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Conrad Hoffmann <ch@...2291...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sd9DB9WBsRXoXgULDq71sArKb8mekaEqu
Content-Type: multipart/mixed; boundary="A2tfg9jUDEd0pRQ8KpRbRqKFHC68Tg22k";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Conrad Hoffmann <ch@...2291...>, openvpn-devel@lists.sourceforge.net
Message-ID: <d4481d5c-319c-c888-bfec-e74fc557527e@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 0/2] Improve usability of non-privileged
 operation
References: <20170802181435.14549-1-ch@...2291...>
In-Reply-To: <20170802181435.14549-1-ch@...2291...>

--A2tfg9jUDEd0pRQ8KpRbRqKFHC68Tg22k
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 02/08/17 20:14, Conrad Hoffmann wrote:
> Ohai!
>=20
> I recently undertook the project of not having my VPN client run as root
> anymore. I noticed there are a lot of questions about this on the interne=
t, and
> I think one reason that this is more difficult then necessary is that the
> "official" client.down script doesn't work when used in the conjunction w=
ith
> the down-root plugin.
>=20
> I noticed that both the up and the down script get a lot of information t=
hrough
> environment variables, and the up script relies on that already anyways. =
So I
> figured doing the same in the down script would be a reasonable thing to =
do
> (it's also what the most commonly referred to external up/down scripts do=
).
>=20
> With this change, the down script can actually be used with the down-root
> plugin just like this:
>=20
>   plugin openvpn-plugin-down-root.so "/etc/openvpn/client.down"
>=20
> Hope this makes sense,
> Conrad

Hi Conrad,

Nice catch!  And thanks for your patches!  As you're a new contributor,
I just wanted to let you know your patch is in the pipe now and will be
reviewed and tested as soon as some of us are ready to process it.

And based on a 10 seconds look, this does look correct - we just need to
need to do a little test run first.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--A2tfg9jUDEd0pRQ8KpRbRqKFHC68Tg22k--

--Sd9DB9WBsRXoXgULDq71sArKb8mekaEqu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZg42FAAoJEIbPlEyWcf3yTUYQALmeq0oj4ZdyU4cpch4vwMRb
ipt6HtrnT2FN7NDHtALY2qUXNbxrbQQ6oT1TEpRd3YI5r9aQSNVq8vHMstITTICA
BENyJLoc3jE7P6aXsuVDYRxIpmTNkkGy0FS7kU7Gude4QVEeurD3lgHFW/oyVFri
QujvCDhfFCi4hfX8HvdRY8Hn4TIUPra98PAUB0MhMt1pj8yVqkBlMzuqpGDTBJAa
VxXb19OFQcg60fSbeapPIN3UBGMXtdI9utFvoDme1+QQ1W6nRFzOZVDb+Ten1jK+
2Byy+yU1hgd09+nVQ+1l8luSCaQo/QpDdaA/Tueg/qcpIKqRektMiDl+gh4YhZS+
TV52wEjTfcsfshpvyGhzYgOG89mIhHjzD7bIX99sp8yU0rBNeZLvNTcOas1mKfLe
/ysrSO7A1pZb2Qk6MYbZfs9k65doIReevTELp0g8E/G03y+6U8jTWsPXBmHQvkPS
G1hyiybDt0X3RRk3Hsef87OKloKzZ16AnD09IdT7kIeWCGk6VHvv3W05Yaq121Sl
SAr6iG6ik8HxWlnDhq98b9ILJPAIWkP9HbPSOVpWXxaw4PLKakyuHHumW6qQh4YN
eeRZwyUGOP7TRTpwOSRwOHK5uLrd2NwkWyDn/8MtYz/2iJTG1aFBu9W/VT9z7rt/
6V4VWFmAVWK45ka4Yp9O
=SGmS
-----END PGP SIGNATURE-----

--Sd9DB9WBsRXoXgULDq71sArKb8mekaEqu--

