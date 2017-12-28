From: Antonio Quartulli <a@...2181...>
References: <1498913642-32459-2-git-send-email-steffan.karger@...1435...>
 <1512992518-29910-1-git-send-email-steffan.karger@...1435...>
Message-ID: <d4afae6b-30f3-f5cd-3b66-8649aaa9bd65@...2181...>
Date: Fri, 29 Dec 2017 06:50:43 +0800
MIME-Version: 1.0
In-Reply-To: <1512992518-29910-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qSVZEtmPLNPxr8epxOdnrtyHwvqp7mZI7"
Subject: Re: [Openvpn-devel] [PATCH 2/5 v2]
 buffer_list_aggregate_separator(): update list size after aggregating
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qSVZEtmPLNPxr8epxOdnrtyHwvqp7mZI7
Content-Type: multipart/mixed; boundary="uurvmupXzIOiTFS55t9WE4L8R3G7a97qE";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d4afae6b-30f3-f5cd-3b66-8649aaa9bd65@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/5 v2] buffer_list_aggregate_separator():
 update list size after aggregating
References: <1498913642-32459-2-git-send-email-steffan.karger@...1435...>
 <1512992518-29910-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1512992518-29910-1-git-send-email-steffan.karger@...1435...>

--uurvmupXzIOiTFS55t9WE4L8R3G7a97qE
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

the patch looks good and finally gets rid of some FIXMEs in the buffer
unit-test.

However, the field fixed by this patch is not really used anywhere, thus
no real logic flaw is being corrected (Steffan, correct me if I am wrong).

For this reason, I think that backporting this patch to older releases
is entirely up to the maintainers.

On 11/12/17 19:41, Steffan Karger wrote:
> After aggregating a buffer_list, the size should be adjusted accordingly.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

Acked-by: Antonio Quartulli <a@...2181...>

except for a little style issue remarked below:

> ---
> v2: rebase on master
>=20
>  src/openvpn/buffer.c                   |  1 +
>  tests/unit_tests/openvpn/test_buffer.c | 15 +++++----------
>  2 files changed, 6 insertions(+), 10 deletions(-)
>=20
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index ecd3b17..28ac508 100644
> --- a/src/openvpn/buffer.c
> +++ b/src/openvpn/buffer.c
> @@ -1257,6 +1257,7 @@ buffer_list_aggregate_separator(struct buffer_list =
*bl, const size_t max, const
>                  e =3D next;
>              }
>              bl->head =3D f;
> +            bl->size -=3D count-1;

the '-' sign should be surrounded by spaces.

Cheers,

--=20
Antonio Quartulli



--uurvmupXzIOiTFS55t9WE4L8R3G7a97qE--

--qSVZEtmPLNPxr8epxOdnrtyHwvqp7mZI7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpFdUMACgkQB6U8WA7y
zXR/fg//QFQ9pjLt27kPmG7Zhmy6T9bNIT4VNg0fT7ruYN7O3IxpfNJ8+1VwoYcj
Zs1QaZM8sYfN3kqIJwkLbRNgtTsxeX+qXmzOed8lLEP5t5zv84z2WWhzt4VnTO3v
Fr+EE39Q9ZRuoLhT39oS31TvaFKfiUyOk6tKPdVosDO22/fWquJRn7r+QMTgB8y5
US9Q0gWUdFPlGWd4bdPaMRjXVRBhjxLxJNc6QxEfp9bisAxuauxMOANeX0mwZqsK
efF6ZztCeECtEzwz6n4eZQjl5kc8UGbkjJ1hw0BcvYSGhURrPTl8P6w5K0GIt9P8
8AsOnuFTYs5xLhDR3wn6K2m/ikho2mAwsCVwo89cy6gYDRaW/2TZtlxu/OtDqE1V
TgII9qcw9AD70H3KEePjn3QWrKtnNKBstQnAa3lJJsG9Z1sRJZWLCSypLQ1pWegm
/E5WXueAZmZyXvIG4RzEer6pWIdj0v2+l9OU3YuaOzo3oHQDEXLemmzhvRDkiz6d
XHRr53nFFxJXwGDWkam8xxPAX6LOr1ey6xynZzuBn6DnPujK/ljqN0l9AGuu+/qx
m7UcXDDJe4+gcveI8cUHA8Ut1zO5+ylppKC3CKpOjDX9hObS0wioc02dFxvpwhy6
EJrEzSJL2VMewsxkzS+9SoPN19YEARhTGF4dadn7Uz7pslp3UrY=
=B8G4
-----END PGP SIGNATURE-----

--qSVZEtmPLNPxr8epxOdnrtyHwvqp7mZI7--

