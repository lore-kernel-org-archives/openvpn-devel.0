Date: Wed, 10 Oct 2018 20:50:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181010185023.GD962@...1296...>
References: <CAGyAFMULV02g3gyCbvQ1+L+cMdE4UZMmzVfey-T1g4Y0NcmKeg@...278...>
 <1539174377-2678-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qgNrgGfFsws9WDdn"
Content-Disposition: inline
In-Reply-To: <1539174377-2678-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] options.c: fix broken unary minus
 usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--qgNrgGfFsws9WDdn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 10, 2018 at 03:26:17PM +0300, Lev Stipakov wrote:
>      crypto_overhead +=3D kt->hmac_length;
>=20=20
> -    frame_add_to_extra_frame(frame, crypto_overhead);
> +    frame_add_to_extra_frame(frame, (unsigned int) crypto_overhead);

Even if Arne already ACKed it, I have reservations about this.

Since crypto_overhead and crypto_max_overhead() are both size_t, and=20
frame_add_to_extra_frame() is declared to take an "unsigned int" now,=20
this cast should not be necessary.

Unnecessary casts hide bugs and hurt my eyes...

>  static inline void
> +frame_remove_from_extra_frame(struct frame *frame, const unsigned int in=
crement)
> +{
> +    frame->extra_frame -=3D increment;
> +}

Maybe call the negative increment a "decrement" instead?

> @@ -3509,7 +3509,7 @@ calc_options_string_link_mtu(const struct options *=
o, const struct frame *frame)
>          struct key_type fake_kt;
>          init_key_type(&fake_kt, o->ciphername, o->authname, o->keysize, =
true,
>                        false);
> -        frame_add_to_extra_frame(&fake_frame, -(crypto_max_overhead()));
> +        frame_remove_from_extra_frame(&fake_frame, (unsigned int) crypto=
_max_overhead());

Same here wrt (unsigned int) cast.

Otherwise indeed much clearer.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--qgNrgGfFsws9WDdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbvknuAAoJEB2Cnv7KVigScIYMAKexZbTIsE1fuQTdJNHJoHC0
j4W7FZ3+oNT0K92YxKB2C9HrxYCWk0G6iwIQWImN21za/WKg6JmAqO1uwl0w68VZ
VeQMIM5cJWjJyciktj06j25KNe637TTvijW7hf9/7TrkjL4fnj9EVlUdh1t9mlPV
1JUCptNsIV5iyXaK54sg/3ALYyH+ThI6/0ydUupBrdIeuwbIE6TsyMoRnozvMZ6W
xLu/mS+KFaeVrxQztEr5zRyUm+ogz/emj8YAu9G85XcCb4nrvRWJ3TDuF6HRgcjw
Wzffx5Orm6II6ByIF79qxC0rU5o8I/5C9PvarP92c0kd3V7XNL0LRCd8R3r02hdZ
RhoNsduaMZg2U0yS/EYD2JS5vN3wXD+CCOIrSqnYQvHkGZwyLW4KMYtHi0EGCYtW
jHPvmbviZYsOeYaTUW4goCZYl5pPtcURG1s8xqT9gX2MRKGh2+kT6fPH67z9VJfw
dqfEczIMKH917w6dAEWpqOI8Xn+E/pDTmHa879mMgw==
=2ezK
-----END PGP SIGNATURE-----

--qgNrgGfFsws9WDdn--

