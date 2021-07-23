Date: Fri, 23 Jul 2021 11:41:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YPqOztWeN5lIxEDB@...1296...>
References: <20210722162409.231265-1-arne@...1227...>
 <YPpkRcqhj/QAjfyi@...1296...>
 <b131dec2-5736-0ef0-5bb4-c65d461ff405@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="r8gsRWJ1gO0lY8j4"
Content-Disposition: inline
In-Reply-To: <b131dec2-5736-0ef0-5bb4-c65d461ff405@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix OpenVPN querying user/password if
 auth-token with user expires
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--r8gsRWJ1gO0lY8j4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 23, 2021 at 11:37:37AM +0200, Arne Schwabe wrote:
> Am 23.07.21 um 08:40 schrieb Gert Doering:
> > On Thu, Jul 22, 2021 at 06:24:09PM +0200, Arne Schwabe wrote:
> >> @@ -3116,6 +3117,7 @@ do_init_crypto_tls(struct context *c, const unsi=
gned int flags)
> >>      to.auth_token_generate =3D options->auth_token_generate;
> >>      to.auth_token_lifetime =3D options->auth_token_lifetime;
> >>      to.auth_token_call_auth =3D options->auth_token_call_auth;
> >> +    to.auth_token_user_common_name =3D options->auth_token_user_commo=
n_name;
> >>      to.auth_token_key =3D c->c1.ks.auth_token_key;
> >>=20=20
> >>      to.x509_track =3D options->x509_track;
> >=20
> > That hunk looks unrelated...?
> >=20
> Oops :/
>=20
> Is there anything wrong or should I send a v2 just with that change?

Well, current master does not have an "auth_token_user_common_name" structu=
re
element anyway, so the introduction of it should not be part of this bugfix
(and it wouldn't compile) :-)

So, "v2, *without* that change" sounds like a plan.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--r8gsRWJ1gO0lY8j4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJg+o7OAAoJEB2Cnv7KVigSj7oL/3NKRICO7CGub9fG4d9LlCDQ
xT9MR7/f+hMzi373K92D43v9PRWyygTZtd0j2vU1jtFBM9nhw2bwsr/S4V7bB9XP
qcuBXlLSfGPI1HcqJd75SVH7qs4TxJDAyd6xT6Fr0mpOmfJftjk5TAtEqAAIa9VO
0NZm1lj7hO0W3E9+xllf9BTzdlwVcDGJFZAUnUAsknGOhI9VUsZJv6MipRH0ixO0
BjWNn6rj+zoY+XTqNOQTjCLXZZSIHWkYdBS90afduwkD0oZwbyMhgSWGHZ1JRnKR
bS2rPyA2QpEX3vCHfnkDFKYWE2U1UtQhvR5ZkvbJMx3b0m8GT4KI63ELS7R4f4Mi
5edaCNycxTmEpJ6U2hr/siL9n7rjHwLwfqM3UczMoU187ItBk8lreWZaMiF1lS4L
hA7J/TX1KjnzLmZsVL1LFRUXgWVVWJQr6zdkbLPnFpApJ6OAjomCzSaFXm+UMdVy
xqFRM662+iJls6kLHSX/Du2EZxDkplbeg2Xz2nFbKQ==
=5jbd
-----END PGP SIGNATURE-----

--r8gsRWJ1gO0lY8j4--

