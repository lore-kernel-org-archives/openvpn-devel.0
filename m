Date: Tue, 13 Apr 2021 08:01:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210413060124.GZ976@...1296...>
References: <E1lW0eX-00012w-9n@...2487...>
 <202104130557.13D5v3dv030280@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uoAX74GlikxzDom9"
Content-Disposition: inline
In-Reply-To: <202104130557.13D5v3dv030280@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix build with mbedtls w/o
 SSL renegotiation support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

--uoAX74GlikxzDom9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 13, 2021 at 07:57:03AM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> commit e4bd17c86e01aaf6f809d9ea355419c86c4defdc
> Author: Max Fillinger
> Date:   Mon Apr 12 19:46:17 2021 +0200
>=20
>      Fix build with mbedtls w/o SSL renegotiation support
>=20
>      Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
>      Acked-by: Antonio Quartulli <antonio@...515...>
>      Message-Id: <E1lW0eX-00012w-9n@...2487...>

As a side note - because we had this with Steffan occasionally in the
past.  I'm not sure if Mails "from foxcrypto" come with proper Message-IDs,
because it seems that the Sourceforge list server felt the need to create
one (or create a new one).

Unfortunately, that "feature" in SF seems to be quite broken, because
mails to different receipients end up having *different* message-IDs -=20
the "9n@" is what I saw here, but patchwork saw something with "8S@",
and mail-archive saw something yet again (so the URL search failed).

Worth investigating on the next patch...  what did "git send-email"
put in there, what ended up on the list, where was it massacred.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--uoAX74GlikxzDom9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgdTO0AAoJEB2Cnv7KVigSNdUL/jJJySDk+fL6VNVLg8Hz/WGc
igikVKGvcdaF5exA4UnAdk8zZAqt31NyczfLKir0MniO9mMTK/8vQ9WrGABQSeJZ
m9OlazQMnb5RaAW85/i0gmf73oZf4D59NiKn/scEdYb0yPH9orPO25C6HFQYgC20
b54jVi0DeuzVsx7/zGSKRTrTUmKFYaL5gdozuDAtn1leKawhgFafOpu3yQJjTRgl
niKD/np5oED2wLLv5KPA80UX1ejlLqfMu3LYNRs5jY1rebUubYNWQn+94QqMokY9
hSxk4ypI+65k53w8LDvJiu5ObEX633YmhzzMfLuZ6Jm2cN9cNxaIFTeUvW//2A/K
BZyui6LRGtxAFb8ZPKQXr4kCklsrcpwKZlBhy8ZhAuhij1dFlGE41ahicjUvpR/Q
T9Y6T4zpxS6ORQfACvKo3SJq43uF3j8r6uu1IWCF1zFpNn1No36dc5EZsb//TCBQ
BMIA+BsRLXM1W1UyTI8viAjD31QiqoywOawwG08tZA==
=gUZU
-----END PGP SIGNATURE-----

--uoAX74GlikxzDom9--

