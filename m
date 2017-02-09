Date: Thu, 9 Feb 2017 15:14:48 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170209071448.GF11922@...2182...>
References: <1486581944-29627-1-git-send-email-selva.nair@...277...>
	<20170209030138.GD11922@...2182...>
	<CAKuzo_goXcLY9u_ymRamQfXcAr3Cn7SV3Xv6xie5Xk=QVXFxvQ@...278...>
	<20170209051040.GE11922@...2182...>
	<CAKuzo_jA4_WGxxmUUKcdqsnbC9yWgPznHc4-u3csp+3KtveRtw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jA4_WGxxmUUKcdqsnbC9yWgPznHc4-u3csp+3KtveRtw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Make auth-nocache cooperate with
 auth-token
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, Feb 09, 2017 at 12:47:16AM -0500, Selva Nair wrote:
> Hi,
>=20
> On Thu, Feb 9, 2017 at 12:10 AM, Antonio Quartulli <a@...2181...> wrote:
>=20
> >
> > > I would consider username as not sensitive  material although not sure
> > > everyone would agree. Unfortunately there is no way to know in advance
> > that
> > > auth-token may get pushed so I can't think of a good way of avoiding
> > this.
> > > A not so secure approach (I considered this first) would be to delay
> > > clearing the username/password to post pushed-options processing, but
> > then
> > > one has to handle cases like what if the push reply never arrives and=
 so
> > > on.. In general its always better to clear sensitive data at the
> > earliest.
> > >
> > > The way out would be to do one more purge_user_pass(.., false) after =
push
> > > processing.. sigh..  will go there only if absolutely necessary.
> >
> > Yesterday, while discussing the same issue on IRC, I came up with this
> > patch:
> >
> > http://bpaste.net/show/153e8d51c02d
> >
> > It does indeed wait for the push-reply to come back before making a
> > decision
> > about wiping the user_pass object or not.
> > This way also the user is wiped when nocache remains true.
>=20
>=20
> Very interesting! I know, all that complexity can't be helped when purged
> from push.c. That apart, imo, delaying purge_user_pass() until push
> processing is not a good idea as I wrote above. What if push reply does n=
ot
> arrive? It does happen and then the password will never get securely wiped
> from memory.

Yeah, good point. I thought that openvpn would just exit/fail if no push re=
ply is
provided, that is why I did not consider this case.

Then, the purge could be hooked at a later stage, i.e. when the interface h=
as
been setup.

Postponing the purge still sounds less hackish to me, but I am not the one
deciding :)

Cheers,

--=20
Antonio Quartulli

--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYnBblAAoJEJ6F1zG2JyOshukP/2xKEulDaJBxBzc9zJcNZlWP
vqTu2vLEL2W2q1P9cp7NDHsqn60Z+aIaiYl85yq7eFv33lAKA6t/ZqY0GMCZ8xEN
PrPZzs7GP+KLu+hF15CY91p8KL2qPSqQCRVTLtk/SvQMYwiYOoBJ+TiOflZ6l6Cw
ygZ6QmMrlFbkh5ZU0Rj0xasPaWYORpA4MwaNHqgHKdB0EmL9Lg03YBbJtsQelEU9
uTV+uVa/m10P4B6OfvKKAt/20Hh5+a1N1lwl3qY8hwEfp87EX4G2EhNj1uBQ19Mq
jZ8H/1nJyNLHoYcQHhV99lon7GeiIVYMj094tcdin019zoFT2svowufJ49VnKelZ
f7/6hn1JrX4hQl59ty5AL51EmKIKN9pI5clfz636UtF1+q69SA59jKljomcGGlg6
hADnXJaLeE2QDFVEBd6644xt5tY3snSUt18qSYytwpVL9LURmoVdvQcgprsvlykJ
ujagNUZ0TAObn4QoIG75cyp9Go2NexvS4BCgFgdBIVPgEXza2e28XU/Kf25t6w7G
mH0aPlmREuipjq9ffua2nm7R0qlbztE3XlDC//XOsLWGTIa9j3/dXHQ/KBO3R018
/KzuD7frZSKvzkcY1qanNtdrloSaMpWbSkqVI1zcbRf/hRJUm9xRBJXPxdLpJTK6
nEb6cLs4VW/KB0E0eMlm
=HJLs
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--

