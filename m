Date: Thu, 9 Feb 2017 13:10:40 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170209051040.GE11922@...2182...>
References: <1486581944-29627-1-git-send-email-selva.nair@...277...>
	<20170209030138.GD11922@...2182...>
	<CAKuzo_goXcLY9u_ymRamQfXcAr3Cn7SV3Xv6xie5Xk=QVXFxvQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Content-Disposition: inline
In-Reply-To: <CAKuzo_goXcLY9u_ymRamQfXcAr3Cn7SV3Xv6xie5Xk=QVXFxvQ@...278...>
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

--ryJZkp9/svQ58syV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, Feb 08, 2017 at 11:58:32PM -0500, Selva Nair wrote:
> Hi,
>=20
> On Wed, Feb 8, 2017 at 10:01 PM, Antonio Quartulli <a@...2181...> wrote:
>=20
> > On Wed, Feb 08, 2017 at 02:25:44PM -0500, selva.nair@...277... wrote:
> > > From: Selva Nair <selva.nair@...277...>
> > >
> > > - Keep the username even if auth-nocache is specified so that
> > >   any auth_token pushed by the server could be utilized
> >
> > This means that even when using no auth-token the username will be cach=
ed.
> > Can this be a security concern?
> >
>=20
> I would consider username as not sensitive  material although not sure
> everyone would agree. Unfortunately there is no way to know in advance th=
at
> auth-token may get pushed so I can't think of a good way of avoiding this.
> A not so secure approach (I considered this first) would be to delay
> clearing the username/password to post pushed-options processing, but then
> one has to handle cases like what if the push reply never arrives and so
> on.. In general its always better to clear sensitive data at the earliest.
>=20
> The way out would be to do one more purge_user_pass(.., false) after push
> processing.. sigh..  will go there only if absolutely necessary.

Yesterday, while discussing the same issue on IRC, I came up with this patc=
h:

http://bpaste.net/show/153e8d51c02d

It does indeed wait for the push-reply to come back before making a decision
about wiping the user_pass object or not.
This way also the user is wiped when nocache remains true.

Not sure which approach is better though.

Cheers,

--=20
Antonio Quartulli

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYm/nNAAoJEJ6F1zG2JyOsCPYP/3ZfSilncb6oYMBpRulshtzp
1Tx1n34j6PzO0wuecYGqoQNiNyC1sHMPYNa4N2HsxI/RWub4F5QD1zhbw3ZMWFn4
mSGtYV5fHbwi+PRIfVmeACY0TqXB7Gd2vBDdZM5OJYzOROTBNKZFnp9BpE/0DQ4W
uI88LB+/acBBGRp26AIN1uy6+RILJYOIIAJbtygeQIy0brcxRj0SKmaSflwRdudh
v4mcAwEJ57A6SQ+ELD2+BpGy8+qANEU4llvtyoyLnJuhwfOQPNrhwqfuEZMA7E8F
3i1SLOIEpqgNxWf8IiyPLEyzEpM98sZTRXezAfeXzWga+ARErQwjyQx5KwWanO4L
f1wcToRXLU72f4FvgRBpoHKwAAgq7WgqFLC80iACT1Dxf7udHcP2SBGfEMJ1GNy7
vTUfkTYmp4DS9WTzjp509akD0Cv242WaE3qFQdst7/hhNEzQs+h3HeK8UzeUsAkg
hQkLI6qFJu2n5xsdCGRfotUhNMW5mzG5HFcedxHU0FZ0wyB5Sntw0HFE93wCnZpH
3cq6WNKlegQ0kmcGZ6gsULpPaLG56dK/3xjWx0nMXngKQEwowjZMSmY1giOJerwy
vPZAIsSnTptjL3yeeTYvHrBoTvB49UJlGVNBBWHcFMsxNsOQodWYO8LdM+tSXdTD
tmC1JPPUYCpWATmAToZq
=mYIm
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--

