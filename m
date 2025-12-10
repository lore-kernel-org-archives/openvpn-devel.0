Date: Wed, 10 Dec 2025 11:31:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aTlMDx6K__4yQenl@...1296...>
References: <CAM8w-qEE6vHj=yUOpTFbM7DqPKzUV0NupvEG4rUefY=kNB2DxQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+VKNHYM/6GbA3hdu"
Content-Disposition: inline
In-Reply-To: <CAM8w-qEE6vHj=yUOpTFbM7DqPKzUV0NupvEG4rUefY=kNB2DxQ@...278...>
Subject: Re: [Openvpn-devel] [Bugfix v2]: PUSH_UPDATE: fix option reset
 logic in continuation messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Moritz Fain <moritz-openvpn@...2969...>
Cc: openvpn-devel@lists.sourceforge.net

--+VKNHYM/6GbA3hdu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

so, I wanted to merge this into 2.7_rc4 ("it has an ACK, it has unit tests")
but there is one hunk I do not understand...

On Mon, Dec 01, 2025 at 03:04:18PM +0100, Moritz Fain wrote:
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 7852d360..898d1585 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -540,11 +540,15 @@ incoming_push_message(struct context *c, const
> struct buffer *buffer)
>              }
>              else
>              {
> -                if (!option_types_found)
> +                /* Clear push_update_options_found for next
> PUSH_UPDATE sequence */
> +                c->options.push_update_options_found =3D 0;
> +
> +                /* Use accumulated option_types_found for the entire
> PUSH_UPDATE sequence */
> +                if (!c->options.push_option_types_found)
>                  {

so... "we set push_update_options_found =3D 0, and then we check if
it might be non-0"?

This looks wrong :-)


(Also, that hunk displays a problem of the sending mail client - it=20
wraps all long lines, so I had to manually unwrap ~30 lines, which is
stupid work that should be left to machines... so if at all possible,
please send patches with "git send-email" - this is magic, and succeeds
almost always in making patches arrive intact)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+VKNHYM/6GbA3hdu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmk5TA0ACgkQHYKe/spW
KBJtewwAjmiimPwRKOribl6ooEqWbSowssQ0B7P9lEqoO60vSvvKDzbZSbN9SOl2
Xqeh3OfgUOdo6HS/gns6qyVZ6ACLtFrKfnKSWB6CowHsEH+iqE3s/Rhsn0AvOoVc
XVvSjt1OsulmnTzi5l52yoRBwnO9SJVJD94bvVjE6oVaq+2Y/WhV6zIwSXa7EXHs
rIDcRaJqkLMFh6BotzpDYRaaigIeCv6hbb0jfFOhqR8eSnafZw8vzAiZ+nmXvqqT
61J+8XY37jbTNuxNsDpquRp8jQtf4SKksP7+yERrwTqcv9a7cCTUCcCWSDp49Akw
4VRU+LdUjl5WDMYdQj6hmR0CaXv/9st+WmwqWW7R/NoAl2063UgmFg8gpaYjYv5E
q6BWTaKj5X79H11C1DGAKH/gvVQi9+xQKeP3FhybAP6SaSG567CMqAj3OrqhNPOQ
9PVCw13XGIHqeYd0leK+lHsQDlr3kdW1bUuM7wffbg15tbMb1LYTlNstdaqdsDBo
j+kdr56P
=6MZU
-----END PGP SIGNATURE-----

--+VKNHYM/6GbA3hdu--

